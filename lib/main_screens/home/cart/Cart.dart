import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onboarding/beginning/animation_loader.dart';
import 'package:onboarding/main_screens/home/cart/cart_controller.dart';
import 'package:onboarding/main_screens/home/navigation_menu.dart';
import 'package:onboarding/utils/constants/images_file.dart';

import '../../../appbar/appbar.dart';
import '../../../checkout/Cart_items.dart';
import '../../../checkout/checkout.dart';
import '../../../utils/constants/sizes.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = CartController.instance;
    return Scaffold(
      appBar: TAppBar(
        showBackArrow: true,
        title: Text('Cart', style: Theme.of(context).textTheme.headlineSmall),
      ),
      body: Obx(() {
        final emptyWidget = TAnimationLoaderWidget(
          text: 'Whoops! Cart is Empty',
          animation: TImages.cartAnimation,
          showAction: true,
          actionText: 'Let\'s fill it',
          onActionPressed: () => Get.off(() => const NavigationMenu()),
        );

        if (controller.cartItems.isEmpty) {
          return emptyWidget;
        } else {
          return SingleChildScrollView(
            child: const Padding(
              padding: EdgeInsets.all(TSizes.defaultSpace),
              child: TCartItems(),
            ),
          );
        }
      }),
      bottomNavigationBar: controller.cartItems.isEmpty
          ? const SizedBox()
          : Padding(
              padding: const EdgeInsets.all(TSizes.defaultSpace),
              child: ElevatedButton(
                  onPressed: () => Get.to(() => const CheckoutScreen()),
                  child: Obx(() =>
                      Text('Checkout   \u20B9${controller.totalCartPrice.value}'))),
            ),
    );
  }
}
