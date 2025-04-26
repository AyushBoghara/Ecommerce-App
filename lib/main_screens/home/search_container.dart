import 'package:flutter/material.dart';
import 'package:onboarding/utils/constants/colors.dart';
import 'package:onboarding/utils/constants/sizes.dart';
import 'package:onboarding/utils/device/device_utility.dart';
import 'package:onboarding/utils/helpers/helper_functions.dart';
import 'package:iconsax/iconsax.dart';

class TSearchContainer extends StatelessWidget {
  const TSearchContainer({
    super.key,
    required this.text,
    this.icon = Iconsax.search_normal,
    this.showBackground = true,
    this.showBorder = true,
    this.onTap,
    this.controller,
    this.onChanged,
  });

  final String text;
  final IconData? icon;
  final bool showBackground, showBorder;
  final VoidCallback? onTap;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace),
        child: TextField(
          controller: controller,
          onChanged: onChanged,
          decoration: InputDecoration(
            prefixIcon: Icon(icon, color: TColors.darkerGrey),
            hintText: text,
            filled: showBackground,
            fillColor: showBackground
                ? dark
                    ? Colors.black
                    : TColors.light
                : Colors.transparent,
            border: showBorder
                ? OutlineInputBorder(
                    borderRadius: BorderRadius.circular(TSizes.cardRadiusLg),
                    borderSide: BorderSide(color: TColors.grey),
                  )
                : InputBorder.none,
            contentPadding: const EdgeInsets.all(TSizes.md),
          ),
        ),
      ),
    );
  }
}