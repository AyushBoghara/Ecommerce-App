import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onboarding/loaders.dart';
import 'package:onboarding/product/product_repository.dart';
import 'package:onboarding/product/product_model.dart';
import 'package:onboarding/utils/constants/enums.dart';

class ProductController extends GetxController {
  static ProductController get instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final isLoading = false.obs;
  final productRepository = Get.put(ProductRepository());

  final TextEditingController searchController = TextEditingController();
  RxList<ProductModel> filteredProducts =
      <ProductModel>[].obs; // Holds search results

  RxList<ProductModel> featuredProducts = <ProductModel>[].obs;
  RxList<ProductModel> categoryProducts =
      <ProductModel>[].obs; // Added for category products

  @override
  void onInit() {
    fetchFeaturedProducts();
    super.onInit();
  }

  // Fetch Featured Products
  void fetchFeaturedProducts() async {
    try {
      isLoading.value = true;
      final products = await productRepository.getFeaturedProducts();
      featuredProducts.assignAll(products);
      filteredProducts.assignAll(products); // Update filteredProducts
    } catch (e) {
      TLoaders.errorSnackBar(title: "Oh Snap!", message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  void searchProducts(String query) {
    if (query.isEmpty) {
      filteredProducts.assignAll(
          featuredProducts); // Reset to all products if query is empty
    } else {
      filteredProducts.assignAll(
        featuredProducts
            .where((product) =>
                product.title!.toLowerCase().contains(query.toLowerCase()))
            .toList(),
      );
    }
  }

  // Fetch All Featured Products
 Future<List<ProductModel>> fetchAllFeaturedProducts() async {
  try {
    final products = await productRepository.getallFeaturedProducts();
    featuredProducts.assignAll(products); // Update the list
    filteredProducts.assignAll(products); // Ensure filtered products are updated
    return products;
  } catch (e) {
    TLoaders.errorSnackBar(title: "Oh Snap!", message: e.toString());
    return [];
  }
}


  // Fetch Products by Category (and store in categoryProducts)
  Future<void> fetchProductsByCategory(String categoryId) async {
    try {
      isLoading.value = true;
      final products =
          await productRepository.getProductsByCategory(categoryId);
      categoryProducts.assignAll(products); // Corrected
    } catch (e) {
      TLoaders.errorSnackBar(title: "Oh Snap!", message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  // Fetch Products by Category (return as Future List)
  Future<List<ProductModel>> getProductsByCategory(String categoryId) async {
    print("Fetching products for categoryId: $categoryId");

    final querySnapshot = await FirebaseFirestore.instance
        .collection('Products')
        .where('CategoryId', isEqualTo: categoryId)
        .get();

    final products = querySnapshot.docs
        .map((doc) => ProductModel.fromSnapShot(doc))
        .toList();

    print("Products fetched: ${products.length}");
    return products;
  }

  // Get Product Price
  String getProductPrice(ProductModel product) {
    double smallestPrice = double.infinity;
    double largestPrice = 0.0;

    if (product.productType == ProductType.single.toString()) {
      return (product.salePrice > 0 ? product.salePrice : product.price)
          .toString();
    } else {
      for (var variation in product.productVariations!) {
        double priceToConsider =
            variation.salePrice > 0.0 ? variation.salePrice : variation.price;

        if (priceToConsider < smallestPrice) {
          smallestPrice = priceToConsider;
        }
        if (priceToConsider > largestPrice) {
          largestPrice = priceToConsider;
        }
      }
      if (smallestPrice == largestPrice) {
        return " $largestPrice";
      } else {
        return " $smallestPrice - $largestPrice";
      }
    }
  }

  // Calculate Sale Percentage
  String? calculateSalePercentage(double originalPrice, double? salePrice) {
    if (salePrice == null || originalPrice <= 0) return null;
    double percentage = ((originalPrice - salePrice) / originalPrice) * 100;
    return percentage.toStringAsFixed(0);
  }

  // Get Product Stock Status
  String getProductStockStatus(int stock) {
    return stock > 0 ? "In stock" : "Out of stock";
  }
}
