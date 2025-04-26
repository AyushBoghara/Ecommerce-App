import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:onboarding/main_screens/home/navigation_menu.dart';
import 'package:onboarding/utils/constants/colors.dart';
import 'package:onboarding/utils/constants/sizes.dart';
import 'package:onboarding/utils/device/device_utility.dart';
import 'package:onboarding/utils/helpers/helper_functions.dart';

class TAppBar extends StatelessWidget implements PreferredSizeWidget {
  const TAppBar({
    super.key,
    this.title,
    this.actions,
    this.leadinglcon,
    this.leadingOnPressed,
    this.showBackArrow = true,
    this.onClickEvent, // New parameter for dynamic action
    this.backArrowButtonColor, // New optional parameter for back arrow color
  });

  final Widget? title;
  final bool showBackArrow;
  final IconData? leadinglcon;
  final List<Widget>? actions;
  final VoidCallback? leadingOnPressed;
  final VoidCallback? onClickEvent; // Function to handle dynamic actions
  final Color? backArrowButtonColor; // Optional color for the back arrow button

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: TSizes.md),
      child: AppBar(
        automaticallyImplyLeading: false,
        leading: showBackArrow
            ? IconButton(
                onPressed: onClickEvent ??
                    () => Get.back(), // Default action
                icon: Icon(
                  Iconsax.arrow_left,
                  color: backArrowButtonColor ?? // Use the provided color or default
                      (dark ? TColors.white : TColors.dark),
                ),
              )
            : leadinglcon != null
                ? IconButton(
                    onPressed: leadingOnPressed,
                    icon: Icon(leadinglcon),
                  )
                : null,
        title: title,
        actions: actions,
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(TDeviceUtils.getAppBarHeight());
}