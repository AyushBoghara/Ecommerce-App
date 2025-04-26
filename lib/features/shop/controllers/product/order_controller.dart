import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onboarding/beginning/full_screen_loader.dart';
import 'package:onboarding/beginning/log/success_screen.dart';
import 'package:onboarding/checkout/setting_repository.dart';
import 'package:onboarding/features/shop/controllers/product/checkout_controller.dart';
import 'package:onboarding/loaders.dart';
import 'package:onboarding/main_screens/home/cart/cart_controller.dart';
import 'package:onboarding/main_screens/home/cart/cart_item_model.dart';
import 'package:onboarding/main_screens/home/navigation_menu.dart';
import 'package:onboarding/main_screens/profile/account_settings/my_addresses/address_controller.dart';
import 'package:onboarding/order_model.dart';
import 'package:onboarding/order_repository.dart';
import 'package:onboarding/product/product_variation_model.dart';
import 'package:onboarding/repositories/authentication_repository.dart';
import 'package:onboarding/utils/constants/enums.dart';
import 'package:onboarding/utils/constants/images_file.dart';

class OrderController extends GetxController {
  static OrderController get instance => Get.find();
  final cartController = CartController.instance;
  final addressControtter = AddressController.instance;
  final checkoutController = CheckoutController.instance;
  var orderStatusText = ''.obs; // Ensure it is reactive

  final orderRepository = Get.put(OrderRepository());

  Future<List<OrderModel>> fetchUserOrders() async {
    try {
      final userOrders = await orderRepository.fetchUserOrders();
      return userOrders;
    } catch (e) {
      TLoaders.warningSnackBar(title: "Oh Snap in fetching");
      return [];
    }
  }

  void processOrder(double totalAmount) async {
    try {
      TFullScreenLoader.openLoadingDialog(
          "Processing your Order", TImages.cartAnimation);

      final userId = AuthenticationRepository.instance.authUser.uid;
      if (userId.isEmpty) throw Exception("User ID is empty");

      final orderItems = cartController.cartItems.toList();

      if (orderItems.isEmpty) throw Exception("Cart is empty");

      // Calculate subtotal
      final double subtotal = cartController.totalCartPrice.value;

      // Fetch global settings (e.g., taxRate and shippingCost)
      final settingsRepository = Get.find<SettingsRepository>();
      final settings = settingsRepository.globalSettings.value;

      // Calculate taxCost and ceil it to the nearest integer
      final double taxCost =
          (subtotal * (settings.taxRate / 100)).ceilToDouble();

      // Calculate shippingCost
      final double shippingCost = subtotal >= settings.freeShippingThreshold
          ? 0.0
          : settings.shippingCost;

      // Debug logs to verify calculations
      print("Subtotal: $subtotal");
      print("Tax Rate: ${settings.taxRate}");
      print("Tax Cost (Ceiled): $taxCost");
      print("Shipping Cost: $shippingCost");

      // Create the order
      final order = OrderModel(
        id: UniqueKey().toString(),
        userId: userId,
        totalAmount: totalAmount,
        shippingCost: shippingCost, // Pass shippingCost
        taxCost: taxCost, // Pass ceiled taxCost
        status: OrderStatus.pending,
        orderDate: DateTime.now(),
        paymentMethod: checkoutController.selectedPaymentMethod.value.name,
        address: addressControtter.selectedAddress.value,
        deliveryDate: DateTime.now(),
        items: orderItems,
      );

      // Debug log to verify order object
      print("Order Object: ${order.toJson()}");

      await orderRepository.saveOrder(order, userId);

      print("Order saved successfully, updating stock...");

      await _updateStockAndSold(orderItems);

      print("Stock updated successfully");

      cartController.clearCart();

      Get.off(
        () => SuccessScreen(
          image: TImages.orderSuccess,
          title: "Order Success!",
          subTitle: "Your item will be shipped soon!",
          onPressed: () => Get.offAll(() => NavigationMenu()),
        ),
      );
    } catch (e, stackTrace) {
      print("❌ Error processing order: $e");
      print("StackTrace: $stackTrace");
      TLoaders.errorSnackBar(title: "Error processing order");
    }
  }

  Future<void> _updateStockAndSold(List<CartItemModel> orderItems) async {
    final firestore = FirebaseFirestore.instance;

    for (var item in orderItems) {
      final productRef = firestore.collection('Products').doc(item.productId);

      try {
        await firestore.runTransaction((transaction) async {
          final snapshot = await transaction.get(productRef);

          if (!snapshot.exists) {
            throw Exception(
                "Product ${item.productId} does not exist in Firestore.");
          }

          final data = snapshot.data()!;
          final productType = data['ProductType'];
          final List<dynamic> variations = data['ProductVariations'] ?? [];

          print(
              "Updating stock for product: ${item.productId}, Type: $productType");

          if (productType == 'ProductType.variable') {
            if (variations.isEmpty) {
              throw Exception(
                  "Product ${item.productId} has no variations, but ProductType is variable.");
            }

            bool variationFound = false;

            for (var variationData in variations) {
              final variation = variationData as Map<String, dynamic>;
              final variationId = variation['Id']?.toString() ?? '';

              if (variationId == item.variationId) {
                variationFound = true;

                final int currentStock = variation['Stock'] ?? 0;
                final int currentSoldQuantity = variation['SoldQuantity'] ?? 0;

                print(
                    "Matched variation: ID: $variationId, Stock: $currentStock, Sold Quantity: $currentSoldQuantity");

                final updatedStock = currentStock - item.quantity;
                if (updatedStock < 0) {
                  throw Exception(
                      "Not enough stock for variation $variationId.");
                }

                // Update the variation in the array
                final updatedVariation = {
                  ...variation,
                  'Stock': updatedStock,
                  'SoldQuantity': currentSoldQuantity + item.quantity,
                };

                final updatedVariations = variations.map((v) {
                  final vId = v['Id']?.toString() ?? '';
                  return vId == variationId ? updatedVariation : v;
                }).toList();

                // Update the product document with the updated variations array
                transaction.update(productRef, {
                  'ProductVariations': updatedVariations,
                });

                break;
              }
            }

            if (!variationFound) {
              throw Exception(
                  "Variation for product ${item.productId} with ID ${item.variationId} not found.");
            }
          } else {
            final int currentStock = data['Stock'] ?? -1;
            final int currentSoldQuantity = data['SoldQuantity'] ?? 0;

            if (currentStock == -1) {
              throw Exception(
                  "Stock field is missing for product ${item.productId}.");
            }

            final updatedStock = currentStock - item.quantity;
            if (updatedStock < 0) {
              throw Exception(
                  "Not enough stock for product ${item.productId}.");
            }

            transaction.update(productRef, {
              'Stock': updatedStock,
              'SoldQuantity': currentSoldQuantity + item.quantity,
            });
          }
        });

        print(
            "✅ Stock and sold quantity updated successfully for product ${item.productId}");
      } catch (e) {
        print("❌ Error updating stock for product ${item.productId}: $e");
        TLoaders.errorSnackBar(
            title: "Error updating stock for ${item.productId}");
      }
    }
  }
}
