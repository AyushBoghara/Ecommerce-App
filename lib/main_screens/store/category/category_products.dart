import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/utils.dart';
import 'package:onboarding/category/category_model.dart';
import 'package:onboarding/main_screens/home/navigation_menu.dart';
import 'package:onboarding/main_screens/home/product_card_vertical.dart';
import 'package:onboarding/main_screens/store/category/category_card.dart';
import 'package:onboarding/product/product_controller.dart';
import 'package:onboarding/utils/constants/sizes.dart';
import 'package:onboarding/utils/helpers/cloud_helper_functions.dart';

import '../../../appbar/appbar.dart';
import '../../../home/appBar/sortable_products.dart';
import '../../../product/vertical_product_shimmer.dart';
import '../../../shimmer.dart';

class CategoryProducts extends StatelessWidget {
  const CategoryProducts({super.key, required this.category});

  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    final productController = ProductController.instance;
    productController.fetchProductsByCategory(category.id);

    return Scaffold(
      appBar: TAppBar(title: Text('Category'), showBackArrow: true,onClickEvent: () =>
            Get.back()),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Category Card
              TCategoryCard(
                showBorder: true,
                category: category,
              ),
              const SizedBox(height: TSizes.spaceBtwSections),
              /// Products from FutureBuilder
              FutureBuilder(
                future: productController.getProductsByCategory(category.id),
                builder: (context, snapshot) {
                  const loader = TVerticalProductShimmer();
                  final widget = TCloudHelperFunctions.checkMultipleRecordState(
                    snapshot: snapshot,
                    loader: loader,
                  );
                  if (widget != null) return widget;

                  final products = snapshot.data!;
                  return TSortableProducts(products: products);
                },
              ),

              // const SizedBox(height: TSizes.spaceBtwSections),
              /// Product Grid
              // Obx(() {
              //   if (productController.isLoading.value) {
              //     return const TShimmerEffect(
              //         width: double.infinity, height: 100);
              //   }
              //
              //   if (productController.featuredProducts.isEmpty) {
              //     return const Center(child: Text('No products found!'));
              //   }
              //
              //   return GridView.builder(
              //     shrinkWrap: true,
              //     physics: const NeverScrollableScrollPhysics(),
              //     itemCount: productController.featuredProducts.length,
              //     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              //       crossAxisCount: 2,
              //       crossAxisSpacing: TSizes.spaceBtwItems,
              //       mainAxisSpacing: TSizes.spaceBtwItems,
              //       mainAxisExtent: 280,
              //     ),
              //     itemBuilder: (context, index) {
              //       final product = productController.featuredProducts[index];
              //       return TProductCardVertical(product: product);
              //     },
              //   );
              // }),
            ],
          ),
        ),
      ),
    );
  }
}
