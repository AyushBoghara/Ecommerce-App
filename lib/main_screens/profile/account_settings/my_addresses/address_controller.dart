import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onboarding/beginning/full_screen_loader.dart';
import 'package:onboarding/cmn_files/section_heading.dart';
import 'package:onboarding/loaders.dart';
import 'package:onboarding/main_screens/profile/account_settings/my_addresses/Add_new_address.dart';
import 'package:onboarding/main_screens/profile/account_settings/my_addresses/Single_address.dart';
import 'package:onboarding/main_screens/profile/account_settings/my_addresses/address.dart';
import 'package:onboarding/main_screens/profile/account_settings/my_addresses/address_model.dart';
import 'package:onboarding/main_screens/profile/account_settings/my_addresses/address_repository.dart';
import 'package:onboarding/network_manager.dart';
import 'package:onboarding/utils/constants/images_file.dart';
import 'package:onboarding/utils/constants/sizes.dart';
import 'package:onboarding/utils/helpers/cloud_helper_functions.dart';

class AddressController extends GetxController {
  static AddressController get instance => Get.find();

  final name = TextEditingController();
  final phoneNumber = TextEditingController();
  final street = TextEditingController();
  final postalCode = TextEditingController();
  final city = TextEditingController();
  final state = TextEditingController();
  final country = TextEditingController();

  GlobalKey<FormState> addressFormKey = GlobalKey<FormState>();

  RxBool refreshDate = true.obs;

  final Rx<AddressModel> selectedAddress = AddressModel.empty().obs;
  final addressRepository = Get.put(AddressRepository());

  Future<List<AddressModel>> getAllUserAddresses() async {
    try {
      final addresses = await addressRepository.fetchUserAddress();
      if (selectedAddress.value.id.isEmpty) {
        selectedAddress.value = addresses.firstWhere(
          (element) => element.selectedAddress,
          orElse: () => AddressModel.empty(),
        );
      }
      return addresses;
    } catch (e) {
      TLoaders.errorSnackBar(
          title: 'Address not found!', message: e.toString());
      return [];
    }
  }

  Future selectAddress(AddressModel newSelectedAddress) async {
    try {
      if (selectedAddress.value.id.isNotEmpty) {
        await addressRepository.updateSelectedAddressField(
            selectedAddress.value.id, false);
      }
      newSelectedAddress.selectedAddress = true;
      selectedAddress.value = newSelectedAddress;
      await addressRepository.updateSelectedAddressField(
          selectedAddress.value.id, true);
    } catch (e) {
      TLoaders.errorSnackBar(
          title: 'Error in Selection', message: e.toString());
    }
  }

  Future addNewAddress() async {
    try {
      TFullScreenLoader.openLoadingDialog(
          'Storing Address...', TImages.loading);

      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }
      if (!addressFormKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }

      final address = AddressModel(
        id: '',
        name: name.text.trim(),
        phoneNumber: phoneNumber.text.trim(),
        city: city.text.trim(),
        street: street.text.trim(),
        state: state.text.trim(),
        postalCode: postalCode.text.trim(),
        country: country.text.trim(),
      );

      final id = await addressRepository.addAddress(address);
      address.id = id;
      selectedAddress(address);

      TFullScreenLoader.stopLoading();
      TLoaders.successSnackBar(
        title: 'Congratulations',
        message: 'Your Address has been saved successfully.',
      );

      refreshDate.toggle();
      resetFormFields();
      Navigator.of(Get.context!).pop();
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(
          title: 'Error Saving Address', message: e.toString());
    }
  }

  /// **EDIT Address**
  Future editAddress(String addressId) async {
    try {
      TFullScreenLoader.openLoadingDialog(
          'Updating Address...', TImages.loading);

      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }
      if (!addressFormKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }

      final updatedAddress = AddressModel(
        id: addressId,
        name: name.text.trim(),
        phoneNumber: phoneNumber.text.trim(),
        city: city.text.trim(),
        street: street.text.trim(),
        state: state.text.trim(),
        postalCode: postalCode.text.trim(),
        country: country.text.trim(),
      );

      await addressRepository.updateAddress(addressId, updatedAddress);
      selectedAddress(updatedAddress);

      TFullScreenLoader.stopLoading();
      TLoaders.successSnackBar(
          title: 'Success', message: 'Address Updated Successfully.');

      refreshDate.toggle();
      resetFormFields();
      Navigator.of(Get.context!).pop();
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(
          title: 'Error Updating Address', message: e.toString());
    }
  }

  /// **DELETE Address**
  Future<void> deleteAddress(String addressId) async {
    try {
      print("Deleting address: $addressId"); // Debugging
      TFullScreenLoader.openLoadingDialog(
          'Deleting Address...', TImages.loading);

      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        print("No internet connection"); // Debugging
        TFullScreenLoader.stopLoading();
        return;
      }

      // Delete the address from Firestore
      await addressRepository.deleteAddress(addressId);
      print("Address deleted from Firestore"); // Debugging

      // If the deleted address was the selected address, reset the selected address
      if (selectedAddress.value.id == addressId) {
        selectedAddress.value = AddressModel.empty();
        print("Selected address reset"); // Debugging
      }

      TFullScreenLoader.stopLoading();
      TLoaders.successSnackBar(
          title: 'Deleted', message: 'Address Deleted Successfully.');

      // Refresh the UI
      refreshDate.toggle();
      print("UI refreshed after address deletion");
      Get.off(UserAddressScreen()); // Debugging
    } catch (e) {
      print("Error deleting address: $e"); // Debugging
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(
          title: 'Error Deleting Address', message: e.toString());
    }
  }

  /// **POPULATE FORM WHEN EDITING**
  void populateAddressForm(AddressModel address) {
    name.text = address.name;
    phoneNumber.text = address.phoneNumber;
    street.text = address.street;
    postalCode.text = address.postalCode;
    city.text = address.city;
    state.text = address.state;
    country.text = address.country;
  }

  Future<dynamic> selectNewAddressPopup(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      builder: (_) => SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(TSizes.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TSectionHeading(title: "Select Address", showActionButton: false),
              SizedBox(height: TSizes.spaceBtwInputFields),
              FutureBuilder(
                future: getAllUserAddresses(),
                builder: (_, snapshot) {
                  final response =
                      TCloudHelperFunctions.checkMultipleRecordState(
                          snapshot: snapshot);
                  if (response != null) return response;

                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (_, index) => TSingleAddress(
                      address: snapshot.data![index],
                      onTap: () async {
                        await selectAddress(snapshot.data![index]);
                        Get.back();
                      },
                    ),
                  );
                },
              ),
              SizedBox(height: TSizes.defaultSpace),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Get.to(() => AddNewAddressScreen()),
                  child: Text("Add new address"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void resetFormFields() {
    name.clear();
    phoneNumber.clear();
    street.clear();
    postalCode.clear();
    city.clear();
    state.clear();
    country.clear();
    addressFormKey.currentState?.reset();
  }
}
