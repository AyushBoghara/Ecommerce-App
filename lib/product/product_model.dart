import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:onboarding/product/brand_model.dart';
import 'package:onboarding/product/product_attribute_model.dart';
import 'package:onboarding/product/product_variation_model.dart';

import '../reviewAndRating/review_model.dart';

class ProductModel {
  String id;
  int stock;
  String? sku;
  double price;
  String? title;
  DateTime? date;
  double salePrice;
  String thumbnail;
  bool? isFeatured;
  // BrandModel? brand;
  String? description;
  String? categoryId;
  int soldQuantity;
  List<String>? images;
  String productType;
  List<ProductAttributeModel>? productAttributes;
  List<ProductVariationModel>? productVariations;
  double rating; // New field for average rating
  List<ReviewModel>? reviews; // New list for reviews

  ProductModel({
    required this.id,
    required this.title,
    required this.price,
    required this.stock,
    required this.thumbnail,
    required this.productType,
    this.sku,
    this.date,
    this.soldQuantity = 0,
    this.images,
    this.salePrice = 0.0,
    this.isFeatured,
    //  this.brand,
    this.description,
    this.categoryId,
    this.productAttributes,
    this.productVariations,
    this.rating = 0.0, // Default rating
    this.reviews,
  });

  static ProductModel empty() => ProductModel(
      id: '', title: '', price: 0, stock: 0, thumbnail: '', productType: '');

  toJson() {
    return {
      //   'id': id,
      'Stock': stock,
      'SKU': sku,
      'Price': price,
      'Title': title,
      //'date': date,
      'SalePrice': salePrice,
      'SoldQuantity': soldQuantity,
      'Thumbnail': thumbnail,
      'IsFeatured': isFeatured,
      //   'Brand': brand!.toJson(),
      'Description': description,
      'CategoryId': categoryId,
      'Images': images ?? [],
      'ProductType': productType,
      'ProductAttributes': productAttributes != null
          ? productAttributes!.map((e) => e.toJson()).toList()
          : [],
      'ProductVariations': productVariations != null
          ? productAttributes!.map((e) => e.toJson()).toList()
          : [],
      'Rating': rating, // Save rating in Firestore
      'Reviews': reviews != null
          ? reviews!.map((e) => e.toJson()).toList()
          : [], // Save reviews as list
    };
  }

  factory ProductModel.fromSnapShot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() == null) return ProductModel.empty();
    final data = document.data()!;
    return ProductModel(
      id: document.id,
      sku: data['SKU'],
      title: data['Title'],
      stock: data['Stock'] ?? 0,
      isFeatured: data['IsFeatured'] ?? false,
      price: double.parse((data['Price'] ?? 0.0).toString()),
      salePrice: double.parse((data['SalePrice'] ?? 0.0).toString()),
      thumbnail: data['Thumbnail'] ?? '',
      categoryId: data['CategoryId'] ?? '',
      soldQuantity: data['SoldQuantity'] ?? 0,
      description: data['Description'] ?? '',
      productType: data['ProductType'] ?? '',
      //    brand: BrandModel.fromJson(data['Brand']),
      images: data['Images'] != null ? List<String>.from(data['Images']) : [],
      productAttributes: (data['ProductAttributes'] as List<dynamic>)
          .map((e) => ProductAttributeModel.fromJson(e))
          .toList(),
      productVariations: (data['ProductVariations'] as List<dynamic>)
          .map((e) => ProductVariationModel.fromJson(e))
          .toList(),
      rating: double.parse((data['Rating'] ?? 0.0).toString()),
      reviews: (data['Reviews'] as List<dynamic>?)
          ?.map((e) => ReviewModel.fromJson(e))
          .toList(),
    );
  }
  factory ProductModel.fromQuerySnapShot(
      QueryDocumentSnapshot<Object?> document) {
    final data = document.data() as Map<String, dynamic>;
    return ProductModel(
      id: document.id,
      sku: data['SKU'] ?? '',
      title: data['Title'] ?? '',
      stock: data['Stock'] ?? 0,
      isFeatured: data['IsFeatured'] ?? false,
      price: double.parse((data['Price'] ?? 0.0).toString()),
      salePrice: double.parse((data['SalePrice'] ?? 0.0).toString()),
      thumbnail: data['Thumbnail'] ?? '',
      categoryId: data['CategoryId'] ?? '',
      description: data['Description'] ?? '',
      productType: data['ProductType'] ?? '',
      //     brand: BrandModel.fromJson(data['Brand']),
      images: data['Images'] != null ? List<String>.from(data['Images']) : [],
      productAttributes: (data['ProductAttributes'] as List<dynamic>)
          .map((e) => ProductAttributeModel.fromJson(e))
          .toList(),
      productVariations: (data['ProductVariations'] as List<dynamic>)
          .map((e) => ProductVariationModel.fromJson(e))
          .toList(),
    );
  }
}
