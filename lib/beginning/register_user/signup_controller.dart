// ignore_for_file: non_constant_identifier_names
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onboarding/beginning/full_screen_loader.dart';
import 'package:onboarding/beginning/log/verify_email.dart';
import 'package:onboarding/beginning/user_controller.dart';
import 'package:onboarding/loaders.dart';
import 'package:onboarding/network_manager.dart';
import 'package:onboarding/repositories/authentication_repository.dart';
import 'package:onboarding/user/user_repository.dart';
import 'package:onboarding/userModel.dart';
import 'package:onboarding/utils/constants/images_file.dart';

class SignupController extends GetxController {
  static SignupController get instance => Get.find();
  final hidePassword = true.obs;
  final privacyPloicy = true.obs;
  final email = TextEditingController();
  final lastName = TextEditingController();
  final username = TextEditingController();
  final password = TextEditingController();
  final firstName = TextEditingController();
  final phoneNumber = TextEditingController();
  GlobalKey<FormState> signupFormKey = GlobalKey<FormState>();

  void signup() async {
    try {
      //   error in code
      TFullScreenLoader.openLoadingDialog(
          "We are processing your information...", TImages.loading);

      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }

      if (!signupFormKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }

      if (!privacyPloicy.value) {
        TLoaders.warningSnackBar(
            title: "Accept Privacy Policy",
            message:
                "In order to create account, Please accept the privacy policy to continue");
        TFullScreenLoader.stopLoading();
        return;
      }

      final userCredential = await AuthenticationRepository.instance
          .registerWithEmailAndPassword(
              email.text.trim(), password.text.trim());

      final newUser = UserModel(
        id: userCredential.user!.uid,
        firstName: firstName.text.trim(),
        lastName: lastName.text.trim(),
        username: username.text.trim(),
        email: email.text.trim(),
        phoneNumber: phoneNumber.text.trim(),
        profilePicture: '',
      );

      final userRepository = Get.put(UserRepository());
      userRepository.saveUserRecord(newUser);
      await UserController.instance.fetchUserRecord();

      TFullScreenLoader.stopLoading();

      TLoaders.successSnackBar(
        title: "Congratulations",
        message: "Your account has been created! Verify email to continue.",
      );

      Get.to(
        () => VerifyEmailScreen(
          email: email.text.trim(),
        ),
      );
    } catch (e) {
      TLoaders.errorSnackBar(title: "Oh Snap!", message: e.toString());
    } finally {
      //     TFullScreenLoader.stopLoading();
    }
  }
}
