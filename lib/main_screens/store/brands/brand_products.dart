import 'package:flutter/material.dart';
import 'package:onboarding/main_screens/store/brands/All_brands.dart';
import 'package:onboarding/appbar/appbar.dart';
import 'package:onboarding/home/appBar/brand_card.dart';
import 'package:onboarding/home/appBar/sortable_products.dart';
import 'package:onboarding/main_screens/store/brands/brand_controller.dart';
import 'package:onboarding/product/brand_model.dart';
import 'package:onboarding/product/vertical_product_shimmer.dart';
import 'package:onboarding/utils/constants/sizes.dart';
import 'package:onboarding/utils/helpers/cloud_helper_functions.dart';

class BrandProducts extends StatelessWidget {
  const BrandProducts({super.key, required this.brand});

  final BrandModel brand;

  @override
  Widget build(BuildContext context) {
    final controller = BrandController.instance;
    return Scaffold(
      appBar: TAppBar(title: Text('Brands')),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              /// Brand Detail
              TBrandCard(
                showBorder: true,
                brand: brand,
              ),
              SizedBox(height: TSizes.spaceBtwSections),
              FutureBuilder(
                  future: controller.getBrandsProducts(brand.id),
                  builder: (context, snapshot) {
                    const loader = TVerticalProductShimmer();
                    final widget = TCloudHelperFunctions.checkMultipleRecordState(
                        snapshot: snapshot, loader: loader);
                    if (widget != null) return widget;

                    final brandProducts = snapshot.data!;

                    return TSortableProducts(products: brandProducts);
                  }),
              // AllBrandsScreen(),
              SizedBox(height: TSizes.spaceBtwSections),
            ],
          ),
        ),
      ),
    );
  }
}
