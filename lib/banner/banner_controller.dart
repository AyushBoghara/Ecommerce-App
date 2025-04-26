// ignore_for_file: unnecessary_this

import 'package:get/get.dart';
import 'package:onboarding/banner/banner_model.dart';
import 'package:onboarding/banner/banner_repository.dart';
import 'package:onboarding/loaders.dart';
class BannerController extends GetxController {

  final isLoading = false.obs;
  final carousalCurrentIndex = 0.obs;
  final RxList<BannerModel> banners = <BannerModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchBanners();
  }

  void updatePageIndicator(index) {
    carousalCurrentIndex.value = index;
  }
  
  Future<void> fetchBanners() async {
    try {
      isLoading.value = true;

      final bannerRepo = Get.put(BannerRepository());
      final banner = await bannerRepo.fetchBanners();

     this.banners.assignAll(banner);

    } catch (e) {
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}