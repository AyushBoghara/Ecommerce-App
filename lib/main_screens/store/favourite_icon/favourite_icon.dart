import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:onboarding/cmn_files/t_circular_icon.dart';
import 'package:onboarding/main_screens/store/favourite_icon/favourite_controller.dart';
import 'package:onboarding/utils/constants/colors.dart';

class FavouriteIcon extends StatelessWidget {
  const FavouriteIcon({super.key, required this.productId});

  final String productId;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FavouriteController());

    return Obx(
      () => TCircularIcon(
          size: 20,
          width: 40,
          height: 40,
          icon: controller.isFavourite(productId)
              ? Iconsax.heart5
              : Iconsax.heart,
          color: controller.isFavourite(productId) ? TColors.error : null,
          onPressed: () {
            controller.toggleFaveouriteProduct(productId);
          }),
    );
  }
}
