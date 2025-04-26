import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:onboarding/main_screens/profile/account_settings/my_addresses/address_model.dart';
import 'package:onboarding/repositories/authentication_repository.dart';

class AddressRepository extends GetxController {
  static AddressRepository get instance => Get.find();
  final _db = FirebaseFirestore.instance;

  Future<List<AddressModel>> fetchUserAddress() async {
    try {
      final userId = AuthenticationRepository.instance.authUser.uid;
      if (userId.isEmpty) {
        throw 'Unable to find user information. Try again in a few minutes.';
      }

      final result = await _db
          .collection('Users')
          .doc(userId)
          .collection('Addresses')
          .get();

      return result.docs
          .map((documentSnapshot) =>
              AddressModel.formDocumentSnapshot(documentSnapshot))
          .toList();
    } catch (e) {
      throw 'Something went wrong while fetching Address Information. Try again later.';
    }
  }

  Future<void> updateSelectedAddressField(String addressId, bool selected) async {
    try {
      final userId = AuthenticationRepository.instance.authUser.uid;

      await _db
          .collection('Users')
          .doc(userId)
          .collection('Addresses')
          .doc(addressId)
          .update({'selectedAddress': selected});
    } catch (e) {
      throw 'Unable to update your address selection. Try again later.';
    }
  }

  Future<String> addAddress(AddressModel address) async {
    try {
      final userId = AuthenticationRepository.instance.authUser.uid;
      final currentAddress = await _db
          .collection('Users')
          .doc(userId)
          .collection('Addresses')
          .add(address.toJson());
      return currentAddress.id;
    } catch (e) {
      throw 'Something went wrong while saving Address Information. Try again later.';
    }
  }

  /// **EDIT Address**
  Future<void> updateAddress(String addressId, AddressModel updatedAddress) async {
    try {
      final userId = AuthenticationRepository.instance.authUser.uid;
      await _db
          .collection('Users')
          .doc(userId)
          .collection('Addresses')
          .doc(addressId)
          .update(updatedAddress.toJson());
    } catch (e) {
      throw 'Something went wrong while updating Address Information. Try again later.';
    }
  }

  /// **DELETE Address**
  Future<void> deleteAddress(String addressId) async {
    try {
      final userId = AuthenticationRepository.instance.authUser.uid;

      await _db
          .collection('Users')
          .doc(userId)
          .collection('Addresses')
          .doc(addressId)
          .delete();
    } catch (e) {
      throw 'Something went wrong while deleting Address Information. Try again later.';
    }
  }
}