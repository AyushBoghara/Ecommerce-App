
import 'package:get/get.dart';
import 'package:onboarding/loaders.dart';
import 'package:onboarding/product/brand_model.dart';
import 'package:onboarding/product/product_model.dart';
import 'package:onboarding/product/product_repository.dart';

import 'brand_Repository.dart';

class BrandController extends  GetxController{
  static BrandController get instance => Get.find();

  RxBool isLoading = true.obs;
  final RxList<BrandModel> allBrands = <BrandModel>[].obs;
  final RxList<BrandModel> featuredBrands = <BrandModel>[].obs;

  final BrandRepository brandRepository = Get.find();

  @override
  void onInit() {
    super.onInit();
    getFeaturedBrands();
  }
  Future<void> getFeaturedBrands() async {
    try {
      isLoading.value = true;
      final brands = await brandRepository.getAllBrands();
      allBrands.assignAll(brands);
      featuredBrands.assignAll(brands.where((brand) => brand.isFeatured ?? false).toList());

    } catch (e) {
      TLoaders.errorSnackBar(title: 'Oh Snap !', message: e.toString());
    }finally{
      isLoading.value = false;
    }
  }
  Future<List<ProductModel>> getBrandsProducts(String brandId) async {
    try {
     final products = await ProductRepository.instance.getProductForBrand(brandId: brandId);
     return products;
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Oh Snap !', message: e.toString());
      return [];
    }
  }
}