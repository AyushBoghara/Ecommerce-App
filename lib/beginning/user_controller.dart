import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:onboarding/beginning/full_screen_loader.dart';
import 'package:onboarding/beginning/log/login.dart';
import 'package:onboarding/cloudinary_service.dart';
import 'package:onboarding/loaders.dart';
import 'package:onboarding/network_manager.dart';
import 'package:onboarding/re_authenticate_user_login_form.dart';
import 'package:onboarding/repositories/authentication_repository.dart';
import 'package:onboarding/user/user_repository.dart';
import 'package:onboarding/utils/constants/images_file.dart';
import 'package:onboarding/utils/constants/sizes.dart';

import '../userModel.dart';

class UserController extends GetxController {
  static UserController get instance => Get.find();

  final userRepository = Get.put(UserRepository());
  Rx<UserModel> user = UserModel.empty().obs;
  final imageUploading = false.obs;
  final profileLoading = false.obs;
  final hidePassword = false.obs;
  final verifyPassword = TextEditingController();
  final verifyEmail = TextEditingController();
  GlobalKey<FormState> reAuthFormKey = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();
    fetchUserRecord();
  }

  Future<void> fetchUserRecord() async {
    try {
      profileLoading.value = true;
      final userData = await userRepository.fetchUserDetails();
      user(userData);
    } catch (e) {
      user(UserModel.empty());
    } finally {
      profileLoading.value = false;
    }
  }

  Future<void> saveUserRecord(UserCredential? userCredentials) async {
    try {
      if (userCredentials != null) {
        final nameParts =
            UserModel.nameParts(userCredentials.user!.displayName ?? 'Unknown');
        final username = UserModel.generateUsername(
            userCredentials.user!.displayName ?? 'Unknown');

        final user = UserModel(
          id: userCredentials.user!.uid,
          firstName: nameParts[0],
          lastName: nameParts.length > 1 ? nameParts.sublist(1).join(" ") : '',
          username: username,
          email: userCredentials.user!.email ?? '',
          phoneNumber: userCredentials.user!.phoneNumber ?? '',
          profilePicture: userCredentials.user!.photoURL ?? '',
        );

        await userRepository.saveUserRecord(user);
      }
    } catch (e) {
      TLoaders.warningSnackBar(
          title: "Data Not Saved",
          message:
              "Something went wrong while saving your information.You can re save your data in your profile.");
    }
  }

  void deleteAccountWarningPopup() {
    Get.defaultDialog(
      contentPadding: const EdgeInsets.all(TSizes.md),
      title: 'Delete Account',
      middleText:
          'Are you want to delete your account permanently? This action is not reversible and all of your data will be removed permanently.',
      confirm: ElevatedButton(
        onPressed: () async => deleteUserAccount(),
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            side: const BorderSide(color: Colors.red)),
        child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: TSizes.lg),
            child: Text('Delete')),
      ),
      cancel: OutlinedButton(
        child: const Text('Cancel'),
        onPressed: () => Navigator.of(Get.overlayContext!).pop(),
      ),
    );
  }

  void deleteUserAccount() async {
    try {
      TFullScreenLoader.openLoadingDialog('Processing', TImages.loading);
      final auth = AuthenticationRepository.instance;
      final provider =
          auth.authUser.providerData.map((e) => e.providerId).first;

      if (provider.isNotEmpty) {
        if (provider == 'google.com') {
          await auth.signInWithGoogle();
          await auth.deleteAccount();
          TFullScreenLoader.stopLoading();
          Get.offAll(() => const LoginScreen());
        } else if (provider == 'password') {
          TFullScreenLoader.stopLoading();
          Get.to(() => const ReAuthLoginForm());
        }
      }
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.warningSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }

  Future<void> reAuthenticateEmailAndPasswordUser() async {
    try {
      TFullScreenLoader.openLoadingDialog('Processing', TImages.loading);

      final isConnected = await NetworkManager.instance.isConnected();

      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }
      if (!reAuthFormKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }
      await AuthenticationRepository.instance.reAuthenticateEmailAndPassword(
          verifyEmail.text.trim(), verifyPassword.text.trim());

      await AuthenticationRepository.instance.deleteAccount();
      TFullScreenLoader.stopLoading();
      Get.offAll(() => const LoginScreen());
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.warningSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }

  uploadUserProfilePicture() async {
    try {
      final image = await ImagePicker().pickImage(
          source: ImageSource.gallery,
          imageQuality: 70,
          maxHeight: 512,
          maxWidth: 512);

      if (image != null) {
        imageUploading.value = true;

        final cloudinary = CloudinaryService();
        String imageUrl = await cloudinary.uploadImage("Users/Images", image);
        String latestImageUrl = "$imageUrl?timestamp=${DateTime.now().millisecondsSinceEpoch}";

        Map<String, dynamic> json = {'ProfilePicture': latestImageUrl};
        await userRepository.updateSingleField(json);

        user.value.profilePicture = latestImageUrl;
        // Fetch updated user details
        await fetchUserRecord();
        user.refresh();

        TLoaders.successSnackBar(
            title: 'Congratulations',
            message: 'Your Profile Image has been updated!');
      }
    } catch (e) {
      TLoaders.errorSnackBar(
          title: 'Oh Snap!', message: 'Something went wrong: $e');
    } finally {
      imageUploading.value = false;
    }
  }
}
