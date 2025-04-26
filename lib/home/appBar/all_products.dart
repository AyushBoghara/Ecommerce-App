import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onboarding/appbar/appbar.dart';
import 'package:onboarding/home/appBar/sortable_products.dart';
import 'package:onboarding/product/all_products_controller.dart';
import 'package:onboarding/product/product_model.dart';
import 'package:onboarding/product/vertical_product_shimmer.dart';
import 'package:onboarding/utils/constants/sizes.dart';
import 'package:onboarding/utils/helpers/cloud_helper_functions.dart';

class AllProducts extends StatelessWidget {
  const AllProducts(
      {super.key, required this.title, this.query, this.futureMethod});

  final String title;
  final Query? query;
  final Future<List<ProductModel>>? futureMethod;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AllProductsController());
    return Scaffold(
      /// AppBar
      appBar:
          const TAppBar(title: Text('Popular Products'), showBackArrow: true),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: FutureBuilder(
            future: futureMethod ?? controller.fetchProductsByQuery(query),
            builder: (context, snapshot) {
              const loader = TVerticalProductShimmer();

              final widget = TCloudHelperFunctions.checkMultipleRecordState(
                  snapshot: snapshot, loader: loader);

              if (widget != null) return widget;
              
              final products = snapshot.data!;
              return TSortableProducts(
                products: products,
              );
            },
          ),
        ),
      ),
    );
  }
}
