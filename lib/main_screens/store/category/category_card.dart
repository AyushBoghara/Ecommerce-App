import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:onboarding/category/category_model.dart';
import 'package:onboarding/cmn_files/rounded_container.dart';
import 'package:onboarding/cmn_files/t_circular_image.dart';
import 'package:onboarding/utils/constants/colors.dart';
import 'package:onboarding/utils/constants/sizes.dart';
import 'package:onboarding/utils/helpers/helper_functions.dart';

class TCategoryCard extends StatelessWidget {
  const TCategoryCard({
    super.key,
    this.onTap,
    required this.showBorder,
    required this.category,
  });

  final CategoryModel category;
  final bool showBorder;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunctions.isDarkMode(context);

    return GestureDetector(
      onTap: onTap,
      child: TRoundedContainer(
        showBorder: showBorder,
        backgroundColor: Colors.transparent,
        padding: const EdgeInsets.all(TSizes.sm),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween, // Pushes items apart
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            /// Category Image & Name
            Expanded(
              child: Row(
                children: [
                  /// Category Image
                  TCircularImage(
                    isNetworkImage: true,
                    image: category.image,
                    backgroundColor: Colors.transparent,
                    overlayColor: isDark ? TColors.white : TColors.black,
                  ),
                  const SizedBox(width: TSizes.spaceBtwItems * 2),

                  /// Category Name
                  Expanded(
                    child: Text(
                      category.name,
                      style: Theme.of(context).textTheme.titleMedium,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),

            /// Featured Icon with right padding
            if (category.isFeatured)
              Padding(
                padding: const EdgeInsets.only(right: TSizes.sm), // Adds right space
                child: Icon(
                  Iconsax.verify5,
                  color: TColors.primary,
                  size: TSizes.iconMd,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
