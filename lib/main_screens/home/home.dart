// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:onboarding/cmn_files/grid_layout.dart';
import 'package:onboarding/common/images/t_rounded_images.dart';
import 'package:onboarding/appbar/appbar.dart';
import 'package:onboarding/appbar/home_appbar.dart';
import 'package:onboarding/cmn_files/circular_container.dart';
import 'package:onboarding/home/appBar/all_products.dart';
import 'package:onboarding/main_screens/home/home_categories.dart';
import 'package:onboarding/main_screens/home/primary_header_container.dart';
import 'package:onboarding/main_screens/home/product_card_vertical.dart';
import 'package:onboarding/main_screens/home/promo_slider.dart';
import 'package:onboarding/main_screens/home/search_container.dart';
import 'package:onboarding/cmn_files/section_heading.dart';
import 'package:onboarding/main_screens/home/vertical_image_text.dart';
import 'package:onboarding/product/product_controller.dart';
import 'package:onboarding/product/vertical_product_shimmer.dart';
import 'package:onboarding/utils/constants/colors.dart';
import 'package:onboarding/utils/constants/images_file.dart';
import 'package:onboarding/utils/constants/sizes.dart';
import 'package:onboarding/utils/constants/text_strings.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProductController());
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            /// Header Tutorial {Section # 3, Video # 2]
            TPrimaryHeaderContainer(
              child: Column(
                children: [
                  THomeAppBar(),
                  const SizedBox(height: TSizes.spaceBtwSections),
                  TSearchContainer(
                    text: "Search in Store",
                    controller: controller.searchController, // Add a controller
                    onChanged: (query) => controller.searchProducts(query), // Call search function
                  ),
                  const SizedBox(height: TSizes.spaceBtwSections),
                  Padding(
                    padding: EdgeInsets.only(left: TSizes.defaultSpace),
                    child: Column(
                      children: [
                        TSectionHeading(
                          title: 'Popular Categories',
                          showActionButton: false,
                          textColor: Colors.white,
                        ),
                        SizedBox(height: TSizes.spaceBtwItems),
                        THomeCategories(),
                      ],
                    ),
                  ),
                  SizedBox(height: TSizes.spaceBtwSections),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(TSizes.defaultSpace),
              child: Column(
                children: [
                  TPromoSlider(),
                  SizedBox(
                    height: TSizes.spaceBtwSections,
                  ),
                  TSectionHeading(
                    showActionButton: true,
                    title: "Popular Products",
                    onPressed: () => Get.to(
                      () => AllProducts(
                        title: "Popular Products",
                        futureMethod: controller.fetchAllFeaturedProducts(),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: TSizes.spaceBtwSections,
                  ),
                  Obx(() {
                    if (controller.isLoading.value)
                      return TVerticalProductShimmer();
                    if (controller.filteredProducts.isEmpty) {
                      return Center(
                        child: Text(
                          'No products found',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      );
                    }
                    return TGridLayout(
                      itemCount: controller.filteredProducts.length,
                      itemBuilder: (_, index) => TProductCardVertical(
                        product: controller.filteredProducts[index],
                      ),
                    );
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
