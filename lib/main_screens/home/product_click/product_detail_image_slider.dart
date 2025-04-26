// ignore_for_file: unnecessary_null_comparison

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/utils.dart';
import 'package:iconsax/iconsax.dart';
import 'package:onboarding/common/images/t_rounded_images.dart';
import 'package:onboarding/appbar/appbar.dart';
import 'package:onboarding/cmn_files/curved_edges_widgets.dart';
import 'package:onboarding/cmn_files/t_circular_icon.dart';
import 'package:onboarding/main_screens/home/navigation_menu.dart';
import 'package:onboarding/main_screens/store/favourite_icon/favourite_icon.dart';
import 'package:onboarding/product/product_model.dart';
import 'package:onboarding/product_detail/images_controller.dart';
import 'package:onboarding/utils/constants/colors.dart';
import 'package:onboarding/utils/constants/images_file.dart';
import 'package:onboarding/utils/constants/sizes.dart';
import 'package:onboarding/utils/helpers/helper_functions.dart';

class TProductImageSlider extends StatelessWidget {
  const TProductImageSlider({
    super.key,
    required this.product,
  });

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    final controller = Get.put(ImagesController());
    final images = controller.getAllProductImages(product);

    return TCurvedEdgeWidget(
      child: Container(
        color: dark ? const Color.fromARGB(255, 149, 146, 146) : TColors.light,
        child: Stack(
          children: [
            SizedBox(
              height: 400,
              child: Padding(
                padding: EdgeInsets.all(TSizes.productImageRadius * 2),
                child: Center(
                  child: Obx(
                    () {
                      final image = controller.selectedProductImage.value;

                      return GestureDetector(
                        onTap: () => controller.showEnlargedImage(image),
                        child: CachedNetworkImage(
                          imageUrl: image,
                          progressIndicatorBuilder: (_, __, downloadProgress) =>
                              CircularProgressIndicator(
                                  value: downloadProgress.progress,
                                  color: TColors.primary),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
            Positioned(
              right: 0,
              bottom: 30,
              left: TSizes.defaultSpace,
              child: SizedBox(
                height: 80,
                child: ListView.separated(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  physics: AlwaysScrollableScrollPhysics(),
                  separatorBuilder: (_, __) => SizedBox(
                    width: TSizes.spaceBtwItems,
                  ),
                  itemCount: images.length,
                  itemBuilder: (_, index) => Obx(
                    () {
                      final imageSelected =
                          controller.selectedProductImage.value ==
                              images[index];
                      return TRoundedImage(
                        width: 80,
                        isNetworkImage: true,
                        backgroundColor: dark ? TColors.dark : TColors.white,
                        padding: EdgeInsets.all(TSizes.sm),
                        imageUrl: images[index],
                        // onPressed: () => controller.selectedProductImage.value =
                        //     images[index],
                        border: Border.all(
                            color: imageSelected
                                ? TColors.primary
                                : Colors.transparent),
                      );
                    },
                  ),
                ),
              ),
            ),
            TAppBar(
              backArrowButtonColor: Colors.black,
              showBackArrow: true,
              onClickEvent: () => Get.offAll(() => const NavigationMenu()),
              actions: [
                FavouriteIcon(
                  productId: product.id,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
