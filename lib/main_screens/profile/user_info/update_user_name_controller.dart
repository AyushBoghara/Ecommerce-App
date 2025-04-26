import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onboarding/beginning/full_screen_loader.dart';
import 'package:onboarding/beginning/user_controller.dart';
import 'package:onboarding/loaders.dart';
import 'package:onboarding/main_screens/profile/user_info/Profile.dart';
import 'package:onboarding/network_manager.dart';
import 'package:onboarding/user/user_repository.dart';
import 'package:onboarding/utils/constants/images_file.dart';

class UpdateUserNameController extends GetxController {
  final username = TextEditingController();
  final userController = UserController.instance;
  final userRepository = Get.put(UserRepository());
  GlobalKey<FormState> updateUserNameFormKey = GlobalKey<FormState>();

  var isLoading = false.obs;

  @override
  void onInit() {
    initializeNames;
    super.onInit();
  }

  Future<void> initializeNames() async {
    username.text = userController.user.value.username;
  }

  Future<void> updateUserName(String newUserName) async {
    try {
      isLoading.value = true;
      TFullScreenLoader.openLoadingDialog(
          'We are updating your information...', TImages.docerAnimation);

      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }

      if (!updateUserNameFormKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }

      Map<String, dynamic> name = {
        'Username': username.text.trim(),
      };
      await userRepository.updateSingleField(name);

      userController.user.value.username = username.text.trim();

      TFullScreenLoader.stopLoading();
      TLoaders.successSnackBar(
          title: 'Congratulations', message: 'Your UserName has been updated.');

      Get.off(() => const ProfileScreen());
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Oh snap!', message: e.toString());
    }
  }
}
