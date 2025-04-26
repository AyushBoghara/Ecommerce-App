import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onboarding/appbar/appbar.dart';
import 'package:onboarding/checkout/Cart_items.dart';
import 'package:onboarding/checkout/billing_address_section.dart';
import 'package:onboarding/checkout/billing_amount_section.dart';
import 'package:onboarding/checkout/billing_payment_section.dart';
import 'package:onboarding/checkout/coupon_widget.dart';
import 'package:onboarding/checkout/setting_repository.dart';
import 'package:onboarding/cmn_files/rounded_container.dart';
import 'package:onboarding/features/shop/controllers/product/order_controller.dart';
import 'package:onboarding/loaders.dart';
import 'package:onboarding/main_screens/home/cart/cart_controller.dart';
import 'package:onboarding/main_screens/profile/account_settings/my_addresses/address_controller.dart';
import 'package:onboarding/utils/constants/colors.dart';
import 'package:onboarding/utils/constants/sizes.dart';
import 'package:onboarding/utils/helpers/helper_functions.dart';
import 'package:onboarding/features/shop/controllers/product/checkout_controller.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    final cartController = Get.put(CartController());
    final orderController = Get.put(OrderController());
    final checkoutController = Get.put(CheckoutController());
    final settingsRepository = Get.put(SettingsRepository());

    final subTotal = cartController.totalCartPrice.value;
    final settings = settingsRepository.globalSettings.value;

    final double freeShippingThreshold = settings.freeShippingThreshold;
    final double shippingCost =
        subTotal >= freeShippingThreshold ? 0.0 : settings.shippingCost;
    final double taxCost = (subTotal * (settings.taxRate / 100)).ceilToDouble();
    final double totalAmount = subTotal + shippingCost + taxCost;

    /// Calculate remaining amount to get Free Shipping
    final double remainingAmount =
        (freeShippingThreshold - subTotal).clamp(0, double.infinity);

    return Scaffold(
      appBar: TAppBar(
        showBackArrow: true,
        title: Text(
          'Order Review',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        onClickEvent: Get.back,
      ),
      body: ListView(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        children: [
          /// 🛒 Cart Items
          const TCartItems(showAddRemoveButton: false),
          const SizedBox(height: TSizes.spaceBtwSections),

          /// 🎁 Coupon Code Section
          TCouponCode(),
          const SizedBox(height: TSizes.spaceBtwSections),

          /// 🚛 Free Shipping Threshold Section
          /// 🚛 Free Shipping Threshold Section
          Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            elevation: 4,
            color: dark ? TColors.black : Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(TSizes.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Display Free Shipping Threshold Amount in Rupees (₹)
                  Text(
                    "🚛 Free Shipping on orders above ₹${freeShippingThreshold.toStringAsFixed(2)}",
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.blueGrey,
                    ),
                  ),
                  const SizedBox(height: 10),

                  /// Message based on Cart Total
                  Text(
                    subTotal >= freeShippingThreshold
                        ? "🎉 You have unlocked Free Shipping!"
                        : "🚛 Spend ₹${remainingAmount.toStringAsFixed(2)} more for Free Shipping!",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: subTotal >= freeShippingThreshold
                          ? Colors.green
                          : Colors.orange,
                    ),
                  ),
                  const SizedBox(height: 10),

                  /// Progress Bar
                  LinearProgressIndicator(
                    value: (subTotal / freeShippingThreshold).clamp(0, 1),
                    backgroundColor: Colors.grey.shade300,
                    valueColor: AlwaysStoppedAnimation(
                      subTotal >= freeShippingThreshold
                          ? Colors.green
                          : Colors.orange,
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: TSizes.spaceBtwSections),

          /// 📦 Billing Details Card
          Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            elevation: 5,
            color: dark ? TColors.black : TColors.white,
            child: Padding(
              padding: const EdgeInsets.all(TSizes.md),
              child: Column(
                children: [
                  /// 🏷️ Pricing Details
                  TBillingAmountSection(
                    subTotal: subTotal,
                    shippingCost: shippingCost,
                    taxCost: taxCost,
                    totalAmount: totalAmount,
                  ),
                  const Divider(),
                  const SizedBox(height: TSizes.spaceBtwItems),

                  /// 💳 Payment Methods with Icons
                  TBillingPaymentSection(),
                  const SizedBox(height: TSizes.spaceBtwItems),

                  /// 📍 Address Section with Icon
                  TBillingAddressSection(),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        decoration: BoxDecoration(
          color: dark ? TColors.black : Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10,
              spreadRadius: 2,
            ),
          ],
        ),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 15),
            textStyle:
                const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          onPressed: () {
            if (cartController.totalCartPrice.value <= 0) {
              TLoaders.warningSnackBar(
                title: 'Empty Cart',
                message: "Add items in the cart to proceed",
              );
              return;
            }

            if (AddressController.instance.selectedAddress.value.id.isEmpty) {
              TLoaders.warningSnackBar(
                title: 'No Address Selected',
                message: "Please select a shipping address before proceeding.",
              );
              return;
            }

            checkoutController.totalAmount.value = totalAmount;

            if (checkoutController.selectedPaymentMethod.value.name ==
                'Cash On Delivery') {
              orderController.processOrder(totalAmount);
            } else {
              checkoutController.openRazorpayPayment();
            }
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.shopping_cart_checkout, size: 22),
              const SizedBox(width: 10),
              Text('Checkout \u20B9$totalAmount'),
            ],
          ),
        ),
      ),
    );
  }
}
