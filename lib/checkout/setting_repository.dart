import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:onboarding/checkout/setting_model.dart';

class SettingsRepository extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final Rx<SettingsModel> globalSettings = SettingsModel(
    appName: 'My App',
    freeShippingThreshold: 0.0,
    shippingCost: 0.0,
    taxRate: 0.0,
  ).obs;

  @override
  void onInit() {
    super.onInit();
    fetchGlobalSettings();
  }

  Future<void> fetchGlobalSettings() async {
    try {
      final doc =
          await _firestore.collection('Settings').doc('GLOBAL_SETTINGS').get();
      if (doc.exists) {
        globalSettings.value = SettingsModel.fromMap(doc.data()!);
      } else {
        throw Exception('GLOBAL_SETTINGS document not found');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch global settings: $e');
    }
  }
}
