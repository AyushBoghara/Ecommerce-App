// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onboarding/banner/banner_controller.dart';
import 'package:onboarding/common/images/t_rounded_images.dart';
import 'package:onboarding/cmn_files/circular_container.dart';
import 'package:onboarding/cmn_files/home_controller.dart';
import 'package:onboarding/shimmer.dart';
import 'package:onboarding/utils/constants/colors.dart';
import 'package:onboarding/utils/constants/images_file.dart';
import 'package:onboarding/utils/constants/sizes.dart';

class TPromoSlider extends StatelessWidget {
  const TPromoSlider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BannerController());
    return Obx(
      () {
        if (controller.isLoading.value)
          return TShimmerEffect(width: double.infinity, height: 190);
        return Column(
          children: [
            CarouselSlider(
              options: CarouselOptions(
                  viewportFraction: 1,
                  onPageChanged: (index, _) =>
                      controller.updatePageIndicator(index)),
              items: controller.banners
                  .map(
                    (banner) => TRoundedImage(fit: BoxFit.fill,
                      height: double.infinity,
                      width: double.infinity,
                      imageUrl: banner.imageUrl,
                      isNetworkImage: true,
                     // onPressed: (){},
                      // onPressed: () => Get.toNamed(banner.targetScreen),
                    ),
                  )
                  .toList(),
            ),
            SizedBox(
              height: TSizes.spaceBtwItems,
            ),
            Center(
              child: Obx(
                () => Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    for (int i = 0; i < controller.banners.length; i++)
                      TCircularContainer(
                        width: 20,
                        height: 4,
                        margin: EdgeInsets.only(right: 10),
                        backgroundColor:
                            controller.carousalCurrentIndex.value == i
                                ? TColors.primary
                                : TColors.grey,
                      ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
