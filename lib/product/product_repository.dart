// ignore_for_file: avoid_print

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:onboarding/cloudinary_storage_service.dart';
import 'package:onboarding/exceptions/firebase_exceptions.dart';
import 'package:onboarding/exceptions/platform_exceptions.dart';
import 'package:onboarding/product/product_model.dart';
import 'package:onboarding/utils/constants/images_file.dart';

class ProductRepository extends GetxController {
  static ProductRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  /// Fetch Featured Products from Firestore
  Future<List<ProductModel>> getFeaturedProducts() async {
    try {
      final snapshot = await _db
          .collection('Products')
          .where('IsFeatured', isEqualTo: true)
          .limit(6)
          .get();
      return snapshot.docs.map((e) => ProductModel.fromSnapShot(e)).toList();
    } on FirebaseException catch (e) {
      print("❌ Firestore Error: ${e.message}");
      throw e.message!;
    } on SocketException catch (e) {
      print("❌ Network Error: ${e.message}");
      throw e.message;
    } on PlatformException catch (e) {
      print("❌ Platform Error: ${e.message}");
      throw e.message!;
    } catch (e) {
      print("❌ Unexpected Error: $e");
      throw e.toString();
    }
  }

  Future<List<ProductModel>> getallFeaturedProducts() async {
    try {
      final snapshot = await _db
          .collection('Products')
          .where('IsFeatured', isEqualTo: true)
          .get();

      return snapshot.docs.map((e) => ProductModel.fromSnapShot(e)).toList();
    } on FirebaseException catch (e) {
      print("❌ Firestore Error: ${e.message}");
      throw e.message!;
    } on SocketException catch (e) {
      print("❌ Network Error: ${e.message}");
      throw e.message;
    } on PlatformException catch (e) {
      print("❌ Platform Error: ${e.message}");
      throw e.message!;
    } catch (e) {
      print("❌ Unexpected Error: $e");
      throw e.toString();
    }
  }

  Future<List<ProductModel>> fetchProductsByQuery(Query query) async {
    try {
      final querySnapshot = await query.get();
      final List<ProductModel> productList = querySnapshot.docs
          .map((doc) => ProductModel.fromQuerySnapShot(doc))
          .toList();
      return productList;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw "Something went wrong";
    }
  }

  Future<List<ProductModel>> getProductForBrand(
      {required String brandId, int limit = -1}) async {
    try {
      final querySnapshot = limit == -1
          ? await _db
              .collection('Products')
              .where('Brand.Id', isEqualTo: brandId)
              .get()
          : await _db
              .collection('Products')
              .where('Brand.Id', isEqualTo: brandId)
              .limit(limit)
              .get();
      final products = querySnapshot.docs
          .map((doc) => ProductModel.fromSnapShot(doc))
          .toList();
      return products;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw "Something went wrong";
    }
  }

  /// Upload Dummy Product Data to Firestore
  Future<void> uploadDummyData(List<ProductModel> products) async {
    try {
      final storage = Get.put(TCloudinaryStorageService());

      for (var product in products) {
        print("🚀 Uploading product: ${product.title} (ID: ${product.id})");

        // Upload Thumbnail to Cloudinary
        final thumbnailData = await rootBundle
            .load(product.thumbnail)
            .then((byteData) => byteData.buffer.asUint8List());
        final thumbnailUrl = await storage.uploadImageData(
            thumbnailData, "product_thumbnail.jpg");
        print("✅ Thumbnail Uploaded: $thumbnailUrl");
        product.thumbnail = thumbnailUrl;

        // Upload Product Gallery Images to Cloudinary
        if (product.images != null && product.images!.isNotEmpty) {
          List<String> imageUrls = [];
          for (var image in product.images!) {
            final imageData = await rootBundle
                .load(image)
                .then((byteData) => byteData.buffer.asUint8List());
            final imageUrl =
                await storage.uploadImageData(imageData, TImages.product);
            print("✅ Image Uploaded: $imageUrl");
            imageUrls.add(imageUrl);
          }
          product.images!.clear();
          product.images!.addAll(imageUrls);
        }

        // Upload Product Variations (if applicable)
        if (product.productType == "ProductType.variable") {
          for (var variation in product.productVariations!) {
            final variationImageData = await rootBundle
                .load(variation.image)
                .then((byteData) => byteData.buffer.asUint8List());
            final variationImageUrl = await storage.uploadImageData(
                variationImageData, TImages.product);
            print("✅ Variation Image Uploaded: $variationImageUrl");
            variation.image = variationImageUrl;
          }
        }

        // Save product details (with Cloudinary image URLs) to Firestore
        await _db.collection('Products').doc(product.id).set(product.toJson());
        print(
            "✅ Product Inserted in Firestore: ${product.title} (ID: ${product.id})");
      }

      print("🎉 All products uploaded successfully!");
    } on FirebaseException catch (e) {
      print("❌ Firestore Error: ${e.message}");
      throw e.message!;
    } on SocketException catch (e) {
      print("❌ Network Error: ${e.message}");
      throw e.message;
    } on PlatformException catch (e) {
      print("❌ Platform Error: ${e.message}");
      throw e.message!;
    } catch (e) {
      print("❌ Unexpected Error: $e");
      throw e.toString();
    }
  }

  Future<List<ProductModel>> getProductsByCategory(String categoryId) async {
    try {
      final snapshot = await _db
          .collection('Products')
          .where('CategoryId', isEqualTo: categoryId)
          .get();

      return snapshot.docs
          .map((doc) => ProductModel.fromQuerySnapShot(doc))
          .toList();
    } catch (e) {
      throw "Failed to fetch products: $e";
    }
  }

  Future<List<ProductModel>> getFavouriteProducts(
      List<String> productIds) async {
    try {
      final snapshot = await _db
          .collection('Products')
          .where(FieldPath.documentId, whereIn: productIds)
          .get();
      return snapshot.docs
          .map((querySnapshot) => ProductModel.fromSnapShot(querySnapshot))
          .toList();
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw "Something went wrong";
    }
  }
}
