import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onboarding/beginning/user_controller.dart';
import 'package:onboarding/appbar/appbar.dart';
import 'package:onboarding/main_screens/profile/account_settings/my_cart/cart_menu_icon.dart';
import 'package:onboarding/main_screens/store/wishlist/wishlist.dart';
import 'package:onboarding/shimmer.dart';
import 'package:onboarding/utils/constants/colors.dart';
import 'package:onboarding/utils/constants/text_strings.dart';

class THomeAppBar extends StatelessWidget {
  const THomeAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UserController());
    return TAppBar(
      showBackArrow: false,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(TTexts.homeAppbarTitle,
              style: Theme.of(context)
                  .textTheme
                  .labelMedium!
                  .apply(color: TColors.grey)),
          Obx(
            () {
              if (controller.profileLoading.value) {
                return const TShimmerEffect(width: 80, height: 15);
              } else {
                return Text(controller.user.value.fullName,
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall!
                        .apply(color: TColors.white));
              }
            },
          ),
        ],
      ),
      actions: [
        TCartCounterIcon(
          iconColor: TColors.white,
        )
      ],
    );
  }
}
