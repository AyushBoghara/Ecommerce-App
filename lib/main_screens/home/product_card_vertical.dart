import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:onboarding/cmn_files/t_brand_title_with_verified_icon.dart';
import 'package:onboarding/common/images/t_rounded_images.dart';
import 'package:onboarding/main_screens/home/cart/add_to_cart_button.dart';
import 'package:onboarding/main_screens/home/product_click/product_detail.dart';
import 'package:onboarding/cmn_files/product_price_text.dart';
import 'package:onboarding/cmn_files/product_title_text.dart';
import 'package:onboarding/cmn_files/rounded_container.dart';
import 'package:onboarding/cmn_files/t_circular_icon.dart';
import 'package:onboarding/main_screens/store/favourite_icon/favourite_icon.dart';
import 'package:onboarding/product/product_controller.dart';
import 'package:onboarding/product/product_model.dart';
import 'package:onboarding/utils/constants/colors.dart';
import 'package:onboarding/utils/constants/enums.dart';
import 'package:onboarding/utils/constants/images_file.dart';
import 'package:onboarding/utils/constants/shadows.dart';
import 'package:onboarding/utils/constants/sizes.dart';
import 'package:onboarding/utils/helpers/helper_functions.dart';

class TProductCardVertical extends StatelessWidget {
  const TProductCardVertical({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final controller = ProductController.instance;
    final salePercentage =
        controller.calculateSalePercentage(product.price, product.salePrice);
    final dark = THelperFunctions.isDarkMode(context);

    return GestureDetector(
      onTap: () => Get.to(() => ProductDetailScreen(product: product)),
      child: Container(
        width: 180,
        height: 400,
       padding: EdgeInsets.only(top: 2,right: 1,left: 1),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(TSizes.productImageRadius),
          color: dark ? const Color.fromARGB(255, 69, 68, 68) : const Color.fromARGB(255, 233, 232, 232),
        ),
        child: Column(
          children: [
            TRoundedContainer(
              height: 180,
              padding: EdgeInsets.only(bottom: TSizes.sm/2),
              backgroundColor: dark ? TColors.dark : TColors.light,
              child: Stack(
                children: [
                  Center(
                    child: TRoundedImage(
                      imageUrl: product.thumbnail,
                      applyImageRadius: true,
                      isNetworkImage: true,
                    ),
                  ),
                  if (salePercentage != null)
                    Positioned(
                      top: 12,
                      child: TRoundedContainer(
                        radius: TSizes.sm,
                        backgroundColor: TColors.secondary.withOpacity(0.7),
                        padding: EdgeInsets.symmetric(
                          horizontal: TSizes.sm,
                          vertical: TSizes.xs,
                        ),
                        child: Text(
                          '$salePercentage%',
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge!
                              .apply(color: TColors.black),
                        ),
                      ),
                    ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: FavouriteIcon(productId: product.id),
                  ),
                ],
              ),
            ),
            SizedBox(height: TSizes.spaceBtwItems / 2),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: TSizes.sm),
              child: SizedBox(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TProductTitleText(
                      title: product.title!,
                      smallSize: true,
                    ),
                    SizedBox(height: TSizes.spaceBtwItems / 2),
                  ],
                ),
              ),
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Column(
                    children: [
                      TProductTextPrice(
                        price: controller.getProductPrice(product),maxLines: 2, 
                      ),
                    ],
                  ),
                ),
                ProductCartAddToCartButton(product: product),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
