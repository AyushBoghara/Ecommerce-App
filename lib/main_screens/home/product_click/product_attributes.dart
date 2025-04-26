import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:get/utils.dart';
import 'package:get_storage/get_storage.dart';
import 'package:onboarding/cmn_files/choice_chip.dart';
import 'package:onboarding/cmn_files/product_price_text.dart';
import 'package:onboarding/cmn_files/product_title_text.dart';
import 'package:onboarding/cmn_files/rounded_container.dart';
import 'package:onboarding/cmn_files/section_heading.dart';
import 'package:onboarding/main_screens/home/product_click/variation_controller.dart';
import 'package:onboarding/product/product_model.dart';
import 'package:onboarding/utils/constants/colors.dart';
import 'package:onboarding/utils/constants/sizes.dart';
import 'package:onboarding/utils/helpers/helper_functions.dart';

class TProductAttributes extends StatelessWidget {
  const TProductAttributes({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(VariationController());
    controller.resetSelectedAttributes();
    
    final dark = THelperFunctions.isDarkMode(context);

    return Obx(
      () => Column(
        children: [
          if (controller.selectedVariation.value.id.isNotEmpty)
            TRoundedContainer(
              padding: EdgeInsets.all(TSizes.md),
              backgroundColor: dark ? TColors.darkerGrey : TColors.grey,
              child: Column(
                children: [
                  Row(
                    children: [
                      TSectionHeading(
                          title: "Variation", showActionButton: false),
                      SizedBox(width: TSizes.spaceBtwItems),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              TProductTitleText(
                                  title: "Price : ", smallSize: true),
                              if (controller.selectedVariation.value.salePrice >
                                  0)
                                Text(
                                  "\u20B9${controller.selectedVariation.value.price}",
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall!
                                      .apply(
                                          decoration:
                                              TextDecoration.lineThrough),
                                ),
                              SizedBox(width: TSizes.spaceBtwItems),
                              TProductTextPrice(
                                  price: controller.getVariationPrice()),
                            ],
                          ),
                          Row(
                            children: [
                              TProductTitleText(
                                  title: "Stock : ", smallSize: true),
                              SizedBox(width: TSizes.spaceBtwItems),
                              Text(controller.variationStockStatus.value,
                                  style:
                                      Theme.of(context).textTheme.titleMedium),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  TProductTitleText(
                    title: controller.selectedVariation.value.description ?? '',
                    smallSize: true,
                    maxLines: 4,
                  ),
                ],
              ),
            ),
          SizedBox(height: TSizes.spaceBtwItems),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: product.productAttributes!
                .map(
                  (attribute) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TSectionHeading(
                        title: attribute.name ?? '',
                        showActionButton: false,
                      ),
                      SizedBox(height: TSizes.spaceBtwItems / 2),
                      Obx(
                        () => Wrap(
                          spacing: 8,
                          children: attribute.values!.map((attributeValue) {
                            final isSelected =
                                controller.selectedAttributes[attribute.name] ==
                                    attributeValue;
                            final available = controller
                                .getAttributesAvailabilityInVariation(
                                    product.productVariations!, attribute.name!)
                                .contains(attributeValue);

                            return TChoiceChip(
                              text: attributeValue,
                              selected: isSelected,
                              onSelected: available
                                  ? (selected) {
                                      if (selected) {
                                        controller.onAttributeSelected(product,
                                            attribute.name!, attributeValue);
                                      }
                                    }
                                  : null,
                            );
                          }).toList(),

                        ),
                      ),
                    ],
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}
