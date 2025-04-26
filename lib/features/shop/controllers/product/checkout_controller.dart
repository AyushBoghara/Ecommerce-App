import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onboarding/cmn_files/section_heading.dart';
import 'package:onboarding/features/shop/controllers/product/order_controller.dart';
import 'package:onboarding/features/shop/controllers/product/payment_method_model.dart';
import 'package:onboarding/payment_tile.dart';
import 'package:onboarding/utils/constants/colors.dart';
import 'package:onboarding/utils/constants/images_file.dart';
import 'package:onboarding/utils/constants/sizes.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class CheckoutController extends GetxController {
  static CheckoutController get instance => Get.find();

  final Rx<PaymentMethodModel> selectedPaymentMethod =
      PaymentMethodModel.empty().obs;
  final Razorpay _razorpay = Razorpay();
  final RxDouble totalAmount = 0.0.obs; // Store total amount

  @override
  void onInit() {
    selectedPaymentMethod.value =
        PaymentMethodModel(name: 'Cash On Delivery', image: TImages.cash);
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    super.onInit();
  }

  @override
  void onClose() {
    _razorpay.clear();
    super.onClose();
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    Get.snackbar('Payment Successful', 'Payment ID: ${response.paymentId}',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: TColors.success,
        colorText: TColors.white);

    // Call processOrder with stored totalAmount
    final orderController = Get.find<OrderController>();
    orderController.processOrder(totalAmount.value);
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Get.snackbar('Payment Failed', 'Error: ${response.message}',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: TColors.error,
        colorText: TColors.white);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    Get.snackbar('External Wallet Selected', 'Wallet: ${response.walletName}',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: TColors.warning,
        colorText: TColors.white);
  }

  void openRazorpayPayment() {
    var options = {
      'key': 'rzp_test_XI2zoR0FohQJ3G',
      'amount': (totalAmount.value * 100).toInt(), // Use stored totalAmount
      'name': 'Style Zone',
      'description': 'Payment for Order',
      'prefill': {'contact': '7990104774', 'email': 'stylezone@india.com'},
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint('Error: $e');
    }
  }

  Future<dynamic> selectPaymentMethod(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      builder: (_) => SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Section Heading
              TSectionHeading(
                title: 'Select Payment Method',
                showActionButton: false,
              ),
              const SizedBox(height: TSizes.spaceBtwSections),

              /// Cash on Delivery
              TPaymentTile(
                paymentMethod: PaymentMethodModel(
                  name: 'Cash On Delivery',
                  image: TImages.cash,
                ),
              ),
              const SizedBox(height: TSizes.spaceBtwItems / 2),

              /// Pay Now (UPI, Net Banking, etc.)
              TPaymentTile(
                paymentMethod: PaymentMethodModel(
                  name: 'Pay Now (Net Banking, UPI, Wallets, etc.)',
                  image: TImages.rpay,
                ),
              ),
              const SizedBox(height: TSizes.spaceBtwSections),
            ],
          ),
        ),
      ),
    );
  }
}
