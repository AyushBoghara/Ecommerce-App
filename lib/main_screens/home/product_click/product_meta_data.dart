import 'package:flutter/material.dart';
import 'package:onboarding/cmn_files/product_price_text.dart';
import 'package:onboarding/cmn_files/product_title_text.dart';
import 'package:onboarding/cmn_files/rounded_container.dart';
import 'package:onboarding/cmn_files/t_brand_title_with_verified_icon.dart';
import 'package:onboarding/cmn_files/t_circular_image.dart';
import 'package:onboarding/product/product_controller.dart';
import 'package:onboarding/product/product_model.dart';
import 'package:onboarding/utils/constants/colors.dart';
import 'package:onboarding/utils/constants/enums.dart';
import 'package:onboarding/utils/constants/images_file.dart';
import 'package:onboarding/utils/constants/sizes.dart';
import 'package:onboarding/utils/helpers/helper_functions.dart';

class TProductMetaData extends StatelessWidget {
  const TProductMetaData({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final controller = ProductController.instance;
    final salePercentage =
        controller.calculateSalePercentage(product.price, product.salePrice);
    final darkMode = THelperFunctions.isDarkMode(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
          
            
            if (product.productType == ProductType.single.toString() &&
                product.salePrice > 0)
              Text(
                '\u20B9${product.price}',
                style: Theme.of(context)
                    .textTheme
                    .titleSmall!
                    .apply(decoration: TextDecoration.lineThrough),
              ),
            if (product.productType == ProductType.single.toString() &&
                product.salePrice > 0)
              SizedBox(
                width: TSizes.spaceBtwItems,
              ),
            TProductTextPrice(
              price: controller.getProductPrice(product),
              isLarge: true,
            ),
            SizedBox(
              width: TSizes.spaceBtwItems * 2.7,
            ),
            if (product.productType == ProductType.single.toString() ) 
              TRoundedContainer(
              radius: TSizes.sm,
              backgroundColor: TColors.secondary.withOpacity(0.8),
              padding: EdgeInsets.symmetric(
                  horizontal: TSizes.sm, vertical: TSizes.xs),
              child: Text(
                '$salePercentage%',
                style: Theme.of(context)
                    .textTheme
                    .labelLarge!
                    .apply(color: TColors.black),
              ),
            ), 
          ],
        ),
        SizedBox(height: TSizes.spaceBtwItems * 1.5),
      //  Text("Title :",style: Theme.of(context).textTheme.headlineMedium,),
        TProductTitleText(title: product.title!),
        SizedBox(height: TSizes.sm * 4),
        if (product.productType == ProductType.single.toString())
          Row(
            children: [
              TProductTitleText(title: "Status : "),
              SizedBox(
                width: TSizes.sm,
              ),
              Text(
                controller.getProductStockStatus(product.stock),
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ],
          ),
        SizedBox(height: TSizes.spaceBtwItems * 1.5),
      ],
    );
  }
}
