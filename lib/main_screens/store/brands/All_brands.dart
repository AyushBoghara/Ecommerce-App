import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onboarding/cmn_files/grid_layout.dart';
import 'package:onboarding/main_screens/store/brands/brand_controller.dart';
import 'package:onboarding/appbar/appbar.dart';
import 'package:onboarding/home/appBar/brand_card.dart';
import 'package:onboarding/cmn_files/section_heading.dart';
import 'package:onboarding/product/brand_model.dart';
import 'package:onboarding/utils/constants/sizes.dart';

import 'brand_products.dart';
import 'brand_shimmer.dart';

class AllBrandsScreen extends StatelessWidget {
  const AllBrandsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final brandController =
        Get.find<BrandController>(); // Correct way to get controller

    return Scaffold(
      appBar: const TAppBar(title: Text('Brands'), showBackArrow: true),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(TSizes.defaultSpace),
          child: Obx(() {
            if (brandController.isLoading.value) {
              return const TBrandShimmer(itemCount: 0);
            }
            if (brandController.featuredBrands.isEmpty) {
              return Center(
                child: Text('No Data Found!',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .apply(color: Colors.white)),
              );
            }
            return TGridLayout(
                itemCount: brandController.featuredBrands.length,
                mainAxisExtent: 80,
                itemBuilder: (_, index) {
                  final brand = brandController.featuredBrands[index];
                  return TBrandCard(
                    showBorder: true,
                    brand: brand,
                    onTap: () => Get.to(() => BrandProducts(brand: brand)),
                  );
                });
          }),
        ),
      ),
    );
  }
}
