import 'package:get/get.dart';
import 'package:onboarding/features/shop/controllers/product/checkout_controller.dart';
import 'package:onboarding/main_screens/home/product_click/variation_controller.dart';
import 'package:onboarding/main_screens/profile/account_settings/my_addresses/address_controller.dart';
import 'package:onboarding/main_screens/store/brands/brand_Repository.dart';
import 'package:onboarding/main_screens/store/brands/brand_controller.dart';
import 'package:onboarding/network_manager.dart';

class GeneralBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(NetworkManager());
    Get.put(VariationController());
    Get.put(AddressController());
    Get.put(CheckoutController());
    //   Get.put(BrandRepository());
    //  Get.put(BrandController());
  }
}
