import 'package:get/get.dart';

class HomeController extends GetxController {
  static HomeController get instance => Get.find();

  final carousalCurrentIndex = 0.obs;
  final products = [].obs;  // Stores fetched products
  final banners = [].obs;   // Stores fetched banners

  @override
  void onInit() {
    fetchHomeData(); // Fetch data when HomeController is initialized
    super.onInit();
  }

  void updatePageIndicator(int index) {
    carousalCurrentIndex.value = index;
  }

  /// **Fetch latest home screen data from Firestore or API**
  Future<void> fetchHomeData() async {
    try {
      // Simulating API call (Replace this with actual Firestore call)
      await Future.delayed(Duration(seconds: 1)); 
      
      final fetchedProducts = ["Product 1", "Product 2", "Product 3"];
      final fetchedBanners = ["Banner 1", "Banner 2"];

      products.assignAll(fetchedProducts);
      banners.assignAll(fetchedBanners);
      
    } catch (e) {
      print("Error fetching home data: $e");
    }
  }
}
