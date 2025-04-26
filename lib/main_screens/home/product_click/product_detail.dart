import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:onboarding/cmn_files/section_heading.dart';
import 'package:onboarding/main_screens/home/cart/Cart.dart';
import 'package:onboarding/main_screens/home/product_click/bottom_add_to_cart_widget.dart';
import 'package:onboarding/main_screens/home/product_click/product_attributes.dart';
import 'package:onboarding/main_screens/home/product_click/product_detail_image_slider.dart';
import 'package:onboarding/main_screens/home/product_click/product_meta_data.dart';
// Import necessary packages
import 'package:onboarding/product/product_controller.dart';
import 'package:onboarding/product/product_model.dart';
import 'package:onboarding/utils/constants/colors.dart';
import 'package:onboarding/utils/constants/enums.dart';
import 'package:onboarding/utils/constants/sizes.dart';
import 'package:readmore/readmore.dart';

import '../../../reviewAndRating/product_rating_and_review_controller.dart';
import '../../../reviewAndRating/product_reviews.dart';
import '../../../reviewAndRating/rating_indicator.dart';
import '../../../reviewAndRating/rating_progress_indicator.dart';
import '../../../reviewAndRating/user_review_card.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    print("Building ProductDetailScreen for: ${product.title}");
    final productController = Get.find<ProductController>(); // Optimized
    // final controller = Get.put(ProductRatingAndReviewController());

    return Scaffold(
      bottomNavigationBar: TBottomAddToCart(product: product),
      body: SingleChildScrollView(
        child: Column(
          children: [
            TProductImageSlider(product: product),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: TSizes.defaultSpace),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TProductMetaData(product: product),
                  if (product.productType == ProductType.variable.toString())
                    TProductAttributes(product: product),

                  SizedBox(height: TSizes.spaceBtwSections),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => Get.to(() => CartScreen()),
                      child: Text("Checkout"),
                    ),
                  ),

                  SizedBox(height: TSizes.spaceBtwSections),

                  TSectionHeading(
                      title: "Description", showActionButton: false),
                  SizedBox(height: TSizes.spaceBtwItems),

                  ReadMoreText(
                    product.description ?? '',
                    trimMode: TrimMode.Line,
                    trimLines: 2,
                    trimCollapsedText: " Show more",
                    trimExpandedText: " Less",
                    moreStyle:
                        TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
                    lessStyle:
                        TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
                  ),

                  Divider(),
                  SizedBox(height: TSizes.spaceBtwItems),

                  // Delivery Details Section
                  ExpansionTile(
                    title: Text("Delivery Details",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    leading: Icon(Icons.local_shipping, color: TColors.primary),
                    childrenPadding:
                        EdgeInsets.symmetric(horizontal: TSizes.defaultSpace),
                    children: [
                      ListTile(
                        leading: Icon(Icons.check_circle, color: Colors.green),
                        title: Text("Express shipping in India"),
                      ),
                      ListTile(
                        leading: Icon(Icons.check_circle, color: Colors.green),
                        title: Text("No Returns accepted once order placed"),
                      ),
                      ListTile(
                        leading: Icon(Icons.check_circle, color: Colors.green),
                        title: Text("6-month warranty on all products"),
                      ),
                      ListTile(
                        leading: Icon(Iconsax.ship, color: Colors.blue),
                        title: Text("Ships internationally to 20+ countries"),
                      ),
                      ListTile(
                        leading: Icon(Icons.store, color: Colors.blue),
                        title: Text(
                            "Brand owned & marketed by: Style Zone India Pvt. Ltd."),
                      ),
                      ListTile(
                        leading:
                            Icon(Icons.calendar_today, color: Colors.orange),
                        title: Text("Estimated delivery: 3-5 business days"),
                      ),
                      ListTile(
                        leading:
                            Icon(Icons.support_agent, color: Colors.purple),
                        title: Text(
                            "Need help? Contact support at stylezone@india.com"),
                      ),
                    ],
                  ),

                  SizedBox(height: TSizes.spaceBtwSections * 1.2),

                  // Buyer Protection
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.lock, color: Colors.green),
                          SizedBox(width: 8),
                          Text("100% Secure Payment",
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ],
                      ),
                      SizedBox(height: 8), // Space between rows
                      Row(
                        children: [
                          Icon(Icons.verified_user, color: Colors.blue),
                          SizedBox(width: 8),
                          Text("Buyer Protection",
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ],
                  ),

                  SizedBox(height: TSizes.spaceBtwSections * 1.3),

                  // // Similar Products Section
                  //   SimilarProductsSection(
                  //       product: product), // Use the new widget
                  //
                  // SizedBox(height: TSizes.spaceBtwSections * 1.3),
                  // Divider(),
                  // SizedBox(height: TSizes.spaceBtwSections),
                  //
                  // Column(
                  //   crossAxisAlignment: CrossAxisAlignment.start,
                  //   children: [
                  //     // Ratings & Reviews Section Heading
                  //     TSectionHeading(
                  //         title: "Ratings & Reviews", showActionButton: false),
                  //     SizedBox(height: TSizes.spaceBtwItems),
                  //
                  //     // Star Rating Indicator
                  //     TOverallProductRating(),
                  //     // Rating Stars
                  //     TRatingBarIndicator(rating:4.8),
                  //     SizedBox(height: TSizes.spaceBtwItems),
                  //
                  //     // UserReviewCard(),
                  //     // UserReviewCard(),
                  //
                  //     SizedBox(height: TSizes.spaceBtwItems),
                  //     // View More Button
                  //     Align(
                  //       alignment: Alignment.center,
                  //       child: TextButton(
                  //         onPressed: () => Get.to(() => ProductReviewsScreen()),
                  //         child: Text(
                  //           "View All",
                  //           style: TextStyle(
                  //               fontSize: 16, fontWeight: FontWeight.bold),
                  //         ),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
