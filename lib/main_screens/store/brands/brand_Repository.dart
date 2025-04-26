import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:onboarding/exceptions/firebase_auth_exceptions.dart';
import 'package:onboarding/exceptions/firebase_exceptions.dart';
import 'package:onboarding/exceptions/format_exceptions.dart';
import 'package:onboarding/exceptions/platform_exceptions.dart';
import 'package:onboarding/product/brand_model.dart';

class BrandRepository extends GetxController  {
  static BrandRepository get instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Get all Brands
  Future<List<BrandModel>> getAllBrands() async {
    try {
      final sanpshot = await _db.collection('Brands').get();
      final result = sanpshot.docs.map((e) => BrandModel.fromSnapshot(e)).toList();
      return result;
    }on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw "Something went wrong. Please try again";
    }
  }
}