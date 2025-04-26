import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onboarding/cmn_files/product_price_text.dart';
import 'package:onboarding/main_screens/home/cart/Cart_item.dart';
import 'package:onboarding/main_screens/home/cart/cart_controller.dart';
import 'package:onboarding/main_screens/profile/account_settings/my_cart/add_remove_button.dart';
import 'package:onboarding/utils/constants/sizes.dart';

class TCartItems extends StatelessWidget {
  const TCartItems({
    super.key,
    this.showAddRemoveButton = true,
  });

  final bool showAddRemoveButton;

  @override
  Widget build(BuildContext context) {
    final cartController = CartController.instance;

    return Obx(
      () => ListView.separated(
        shrinkWrap: true,
        itemCount: cartController.cartItems.length,
        separatorBuilder: (_, __) =>
            const SizedBox(height: TSizes.spaceBtwSections),
        itemBuilder: (_, index) => Obx(() {
          final item = cartController.cartItems[index];

          return Column(
            children: [
              TCartItem(cartItem: item),
              if (showAddRemoveButton)
                const SizedBox(height: TSizes.spaceBtwItems),
              if (showAddRemoveButton)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        /// Extra Space
                        SizedBox(width: 70),

                        /// Add Remove Buttons
                        TProductQuantityWithAddRemoveButton(
                          quantity: item.quantity,
                          add: () => cartController.addOneToCart(item),
                          remove: () => cartController.removeOneFromCart(item),
                        ),
                      ],
                    ),
                    TProductTextPrice(
                        price: (item.price * item.quantity).toStringAsFixed(1)),
                  ],
                ),
              SizedBox(
                height: 10,
              )
            ],
          );
        }),
      ),
    );
  }
}
