import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:onboarding/reviewAndRating/review_model.dart';

class ProductRatingReviewRepository extends GetxController {
  static ProductRatingReviewRepository get instance => Get.find();
  final _db = FirebaseFirestore.instance;

  /// Fetch Featured Products from Firestore
  Future<List<ReviewModel>> getProductReview(String productId) async {
    try {
      final snapshot = await _db
          .collection('Products')
          .doc(productId)
          .collection('Reviews')
          .get();
      return snapshot.docs.map((e) => ReviewModel.fromSnapShot(e)).toList();
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

  Future<void> addReview(String productId, ReviewModel review) async {
    try {
      final reviewRef = await _db
          .collection('Products')
          .doc(productId)
          .collection('Reviews')
          .doc();
      ReviewModel newReview = ReviewModel(
        userId: reviewRef.id,
        username: review.username,
        rating: review.rating,
        comment: review.comment,
        date: review.date,
        userImage: review.userImage,
      );
      await reviewRef.set(newReview.toJson());

      /// Update the average rating for the product
      await _updateProductRating(productId);
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

  /// Update the Product's Average Rating
  Future<void> _updateProductRating(String productId) async {
    try {
      final reviewsSnapshot = await _db
          .collection('Products')
          .doc(productId)
          .collection('Reviews')
          .get();

      if (reviewsSnapshot.docs.isEmpty) return;

      double totalRating = 0;
      for (var doc in reviewsSnapshot.docs) {
        totalRating += (doc.data()['Rating'] ?? 0.0).toDouble();
      }

      double averageRating = totalRating / reviewsSnapshot.docs.length;

      await _db
          .collection('Products')
          .doc(productId)
          .update({'Rating': averageRating});
    } catch (e) {
      throw Exception("Error updating product rating: $e");
    }
  }
}
