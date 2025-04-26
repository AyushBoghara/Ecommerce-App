import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:onboarding/cmn_files/t_circular_icon.dart';
import 'package:onboarding/main_screens/home/cart/cart_controller.dart';
import 'package:onboarding/product/product_model.dart';
import 'package:onboarding/utils/constants/colors.dart';
import 'package:onboarding/utils/constants/sizes.dart';
import 'package:onboarding/utils/helpers/helper_functions.dart';

class TBottomAddToCart extends StatelessWidget {
  const TBottomAddToCart({super.key, required this.product});

  final ProductModel product;
  @override
  Widget build(BuildContext context) {
    final controller = CartController.instance;
    controller.updateAlreadyAddedProductCount(product);

    final dark = THelperFunctions.isDarkMode(context);

    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: TSizes.defaultSpace, vertical: TSizes.defaultSpace / 2),
      decoration: BoxDecoration(
        color: dark ? TColors.darkerGrey : const Color.fromARGB(255, 213, 209, 209),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(TSizes.cardRadiusLg),
          topRight: Radius.circular(TSizes.cardRadiusLg),
        ),
      ),
      child: Obx(
        () => Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                TCircularIcon(
                  icon: Iconsax.minus,
                  backgroundColor: TColors.darkGrey,
                  width: 40,
                  height: 40,
                  color: TColors.white,
                  onPressed: () => controller.productQuantityInCart.value < 1
                      ? null
                      : controller.productQuantityInCart.value -= 1,
                ),
                SizedBox(width: TSizes.spaceBtwItems),
                Text(controller.productQuantityInCart.value.toString(),
                    style: Theme.of(context).textTheme.titleSmall),
                SizedBox(width: TSizes.spaceBtwItems),
                TCircularIcon(
                  icon: Iconsax.add,
                  backgroundColor: TColors.black,
                  width: 40,
                  height: 40,
                  color: TColors.white,
                  onPressed: () => controller.productQuantityInCart.value += 1,
                ),
              ],
            ),
            ElevatedButton(
              onPressed: controller.productQuantityInCart.value < 1
                  ? null
                  : () => controller.addToCart(product),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.all(TSizes.md),
                backgroundColor: controller.productQuantityInCart.value < 1
                    ? TColors.darkGrey
                    : const Color.fromARGB(255, 63, 120, 245),
                side: BorderSide(
                  color: controller.productQuantityInCart.value < 1
                      ? TColors.darkGrey
                      : Color.fromARGB(255, 63, 120, 245),
                ),
              ),
              child: Text(
                "Add to Cart",
                style: TextStyle(
                  color: controller.productQuantityInCart.value < 1
                      ? TColors.white
                      : Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
