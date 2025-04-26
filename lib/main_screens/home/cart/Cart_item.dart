import 'package:flutter/material.dart';
import 'package:onboarding/cmn_files/t_brand_title_with_verified_icon.dart';
import 'package:onboarding/common/images/t_rounded_images.dart';
import 'package:onboarding/cmn_files/product_title_text.dart';
import 'package:onboarding/main_screens/home/cart/cart_item_model.dart';
import 'package:onboarding/utils/constants/colors.dart';
import 'package:onboarding/utils/constants/images_file.dart';
import 'package:onboarding/utils/constants/sizes.dart';
import 'package:onboarding/utils/helpers/helper_functions.dart';

class TCartItem extends StatelessWidget {
  const TCartItem({
    super.key,
    required this.cartItem,
  });

  final CartItemModel cartItem;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ///Image
        TRoundedImage(
          imageUrl: cartItem.image ?? '',
          width: 60,
          height: 60,
          isNetworkImage: true,
          // padding: const EdgeInsets.all(1),
          backgroundColor: THelperFunctions.isDarkMode(context)
              ? TColors.darkerGrey
              : TColors.light,
        ),
        const SizedBox(width: TSizes.spaceBtwItems),

        ///Title, Price, & Size
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //           TBrandTitleWithVerifiedIcon(title: cartItem.title ?? ''),
              //TBrandTitleWithVerifiedIcon(title: cartItem.brandName ?? ''),
              Flexible(
                child:
                    TProductTitleText(title: cartItem.title ?? '', maxLines: 1),
              ),

              /// Attributes
              Text.rich(
                TextSpan(
                  // if (cartItem.selectedVariation?.isNotEmpty ?? false)
                  children: cartItem.selectedVariation?.entries
                      .map(
                        (e) => TextSpan(children: [
                          TextSpan(
                              text: '${e.key}: ',
                              style: Theme.of(context).textTheme.bodySmall),
                          TextSpan(
                              text: '${e.value}     ',
                              style: Theme.of(context).textTheme.bodyLarge),
                        ]),
                      )
                      .toList(),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
