import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:onboarding/cmn_files/brand_title.dart';
import 'package:onboarding/utils/constants/colors.dart';
import 'package:onboarding/utils/constants/enums.dart';
import 'package:onboarding/utils/constants/sizes.dart';

class TBrandTitleWithVerifiedIcon extends StatelessWidget {
  const TBrandTitleWithVerifiedIcon({
    super.key,
    required this.title,
    this.maxLines = 1,
    this.textColor,
    this.iconColor = TColors.primary,
    this.textAlign = TextAlign.center,
    this.brandTextSize = TextSizes.small,
  });

  final String title;
  final int maxLines;
  final Color? textColor, iconColor;
  final TextAlign? textAlign;
  final TextSizes brandTextSize;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          child: TBrandTitleText(
            title: title,
            color: textColor,
            maxLines: maxLines,
            textAlign: textAlign,
            brandTextSize: brandTextSize,
          ),
        ),
        const SizedBox(width: TSizes.xs),
        const Icon(Iconsax.verify5,
            color: TColors.primary, size: TSizes.iconXs),
      ],
    );
  }
}
