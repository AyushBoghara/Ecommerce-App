import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:onboarding/beginning/full_screen_loader.dart';
import 'package:onboarding/beginning/user_controller.dart';
import 'package:onboarding/loaders.dart';
import 'package:onboarding/network_manager.dart';
import 'package:onboarding/repositories/authentication_repository.dart';
import 'package:onboarding/utils/constants/images_file.dart';

class LoginController extends GetxController {
  final rememberMe = false.obs;
  final hidePassword = true.obs;
  final email = TextEditingController();
  final password = TextEditingController();
  final localStorage = GetStorage();
  final userController = Get.put(UserController());
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  @override
  void onInit() {
    email.text = localStorage.read("REMEMBER_ME_EMAIL") ?? '';
    password.text = localStorage.read("REMEMBER_ME_PASSWORD") ?? '';
    super.onInit();
  }

  Future<void> emailAndPasswordSignIn() async {
    try {
      TFullScreenLoader.openLoadingDialog("Logging you in...", TImages.loading);

      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }

      if (!loginFormKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }

      if (rememberMe.value) {
        localStorage.write('REMEMBER_ME_EMAIL', email.text.trim());
        localStorage.write('REMEMBER_ME_PASSWORD', password.text.trim());
      }

      final userCredentials = await AuthenticationRepository.instance
          .loginWithEmailAndPassword(email.text.trim(), password.text.trim());

      TFullScreenLoader.stopLoading();

      AuthenticationRepository.instance.screenRedirect();
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: "Oh Snap!", message: e.toString());
    }
  }

 Future<void> googleSignIn() async {
  try {
    TFullScreenLoader.openLoadingDialog("Logging you in...", TImages.loading);

    final isConnected = await NetworkManager.instance.isConnected();
    if (!isConnected) {
      TFullScreenLoader.stopLoading();
      return;
    }

    // Perform Google Sign-In
    final userCredentials = await AuthenticationRepository.instance.signInWithGoogle();

    // Wait for user data to be saved
    await userController.saveUserRecord(userCredentials);

    // Fetch updated user data before navigating
    await userController.fetchUserRecord();

    TFullScreenLoader.stopLoading();

    // Now navigate since user data is available
    AuthenticationRepository.instance.screenRedirect();
    
  } catch (e) {
    TFullScreenLoader.stopLoading();
    TLoaders.errorSnackBar(title: "Oh Snap!", message: e.toString());
  }
}

}
