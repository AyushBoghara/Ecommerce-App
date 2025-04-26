import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:onboarding/category/category_model.dart';
import 'package:onboarding/cloudinary_service.dart';
import 'package:onboarding/exceptions/firebase_auth_exceptions.dart';
import 'package:onboarding/exceptions/firebase_exceptions.dart';
import 'package:onboarding/exceptions/format_exceptions.dart';

import '../exceptions/platform_exceptions.dart';

class CategoryRepository extends GetxController {
  static CategoryRepository get instance => Get.find();

  /// variable
  final _db = FirebaseFirestore.instance;

  /// Get all Categories

  Future<List<CategoryModel>> getAllCategories() async {
    try {
      final snapshot = await _db.collection('Categories').get();
      final list = snapshot.docs
          .map((document) => CategoryModel.fromSnapshot(document))
          .toList();
      return list;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw "Something went wrong. Please try again";
    }
  }

  /// Get Sub Categories

  // Upload Categories to the Cloud Firebase

  Future<File> getImageFileFromAssets(String assetPath) async {
  final byteData = await rootBundle.load(assetPath);
  final tempDir = await getTemporaryDirectory();
  final file = File('${tempDir.path}/${assetPath.split('/').last}');
  await file.writeAsBytes(byteData.buffer.asUint8List());
  return file;
}

  // Future<void> uploadDummyData(List<CategoryModel> categories) async {
  //   try {
  //     final storage = Get.put(TFirebaseStorageService());

  //     for (var category in categories) {
  //       final file = await storage.getImageDataFromAssets(category.image);
  //       final url =
  //           await storage.uploadImageData('Categories', file, category.name);
        
  //       category.image = url;

  //       await _db
  //           .collection('Categories')
  //           .doc(category.id)
  //           .set(category.toJson());
  //     }
  //   } on FirebaseException catch (e) {
  //     throw TFirebaseException(e.code).message;
  //   } on PlatformException catch (e) {
  //     throw TPlatformException(e.code).message;
  //   } catch (e) {
  //     throw "Something went wrong. Please try again";
  //   }
  // }

  Future<void> uploadDummyData(List<CategoryModel> categories) async {
  try {
    final cloudinary = CloudinaryService();

    for (var category in categories) {
      /// Convert asset image to a temporary file
      final file = await getImageFileFromAssets(category.image);
      final xFile = XFile(file.path);

      /// Upload to Cloudinary
      final url =
          await cloudinary.uploadImage("Categories", xFile);

      /// Update image URL in category model
      category.image = url;

      /// Save updated category to Firestore
      await _db
          .collection('Categories')
          .doc(category.id)
          .set(category.toJson());
    }
  } on FirebaseException catch (e) {
    throw TFirebaseException(e.code).message;
  } on PlatformException catch (e) {
    throw TPlatformException(e.code).message;
  } catch (e) {
    throw "Something went wrong. Please try again";
  }
}

}
