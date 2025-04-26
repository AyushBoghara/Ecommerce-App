import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onboarding/main_screens/home/product_click/product_detail.dart';
import 'package:onboarding/product/product_model.dart';
import 'package:onboarding/product/product_controller.dart';
import 'package:onboarding/utils/constants/sizes.dart';
import 'package:onboarding/cmn_files/section_heading.dart';

class SimilarProductsSection extends StatelessWidget {
  const SimilarProductsSection({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final productController = Get.find<ProductController>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TSectionHeading(title: "Similar Products", showActionButton: false),
        SizedBox(height: TSizes.spaceBtwItems),
        FutureBuilder<List<ProductModel>>(
          future: productController.getProductsByCategory(product.categoryId!),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Center(child: Text("Failed to load similar products."));
            }

            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text("No similar products found."));
            }

            final similarProducts = snapshot.data!;

            return SizedBox(
              height: 180,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: similarProducts.length,
                itemBuilder: (context, index) {
                  final similarProduct = similarProducts[index];

                  return GestureDetector(
                    onTap: () {
                      if (similarProduct != null) {
                        print("Product tapped: ${similarProduct.title}");
                        Get.to(() => ProductDetailScreen(product: similarProduct));
                      } else {
                        print("Error: Similar product is null");
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                              similarProduct.images != null &&
                                      similarProduct.images!.isNotEmpty
                                  ? similarProduct.images!.first
                                  : 'https://via.placeholder.com/120',
                              height: 120,
                              width: 120,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            similarProduct.title ?? "Unknown",
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text("\u20B9${similarProduct.price}",
                              style: TextStyle(color: Colors.green)),
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ],
    );
  }
}