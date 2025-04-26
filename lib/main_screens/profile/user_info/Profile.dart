import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:onboarding/beginning/user_controller.dart';
import 'package:onboarding/main_screens/profile/user_info/Profile_menu.dart';
import 'package:onboarding/appbar/appbar.dart';
import 'package:onboarding/cmn_files/section_heading.dart';
import 'package:onboarding/cmn_files/t_circular_image.dart';
import 'package:onboarding/main_screens/profile/user_info/change_name.dart';
import 'package:onboarding/main_screens/profile/user_info/change_username.dart';
import 'package:onboarding/utils/constants/images_file.dart';
import 'package:onboarding/utils/constants/sizes.dart';

import '../../../shimmer.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    return Scaffold(
      appBar: TAppBar(
          showBackArrow: true,
          title: Text('Profile'),
          onClickEvent: () {
            Get.back();
          }),

      /// -- Body
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              /// Profile Picture
              SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    Obx(() {
                      final networkImage = controller.user.value.profilePicture;
                      final image =
                          networkImage.isNotEmpty ? networkImage : TImages.user;

                      return controller.imageUploading.value
                          ? const TShimmerEffect(
                              width: 80, height: 80, radius: 80)
                          : TCircularImage(
                              image: image,
                              width: 80,
                              height: 80,
                              isNetworkImage: networkImage.isNotEmpty);
                    }),
                    TextButton(
                        onPressed: () => controller.uploadUserProfilePicture(),
                        child: const Text('Change Profile Picture')),
                  ],
                ),
              ),

              /// Details
              const SizedBox(height: TSizes.spaceBtwItems / 2),
              const Divider(),
              const SizedBox(height: TSizes.spaceBtwItems),

              ///Heading Profile Info
              const TSectionHeading(
                  title: 'Profile Information', showActionButton: false),
              const SizedBox(height: TSizes.spaceBtwItems),

              TProfileMenu(
                  title: 'Name',
                  value: controller.user.value.fullName,
                  onPressed: () => Get.to(() => const ChangeName())),
              TProfileMenu(
                  title: 'Username',
                  value: controller.user.value.username,
                  onPressed: () => Get.to(() => const ChangeProfileName())),

              const SizedBox(height: TSizes.spaceBtwItems),
              const Divider(),
              const SizedBox(height: TSizes.spaceBtwItems),

              ///Heading Personal Info
              const TSectionHeading(
                  title: 'Personal Information', showActionButton: false),
              const SizedBox(height: TSizes.spaceBtwItems),

              TProfileMenu(
                title: 'User ID',
                value: controller.user.value.id,
                icon: Iconsax.copy,
                onPressed: () {
                  Clipboard.setData(
                      ClipboardData(text: controller.user.value.id));
                  Get.snackbar('Copied', 'User ID copied to clipboard');
                },
              ),
              TProfileMenu(
                title: 'E-mail',
                value: controller.user.value.email,
                icon: Iconsax.copy,
                onPressed: () {
                  Clipboard.setData(
                      ClipboardData(text: controller.user.value.email));
                  Get.snackbar('Copied', 'Email copied to clipboard');
                },
              ),
              TProfileMenu(
                title: 'Phone Number',
                value: controller.user.value.phoneNumber,
                icon: Iconsax.copy,
                onPressed: () {
                  Clipboard.setData(
                      ClipboardData(text: controller.user.value.phoneNumber));
                  Get.snackbar('Copied', 'Phone number copied to clipboard');
                },
              ),

              const Divider(),
              const SizedBox(height: TSizes.spaceBtwItems),

              Center(
                child: TextButton(
                  onPressed: () => _showDeleteAccountConfirmationDialog(
                      context), // Show confirmation dialog
                  child: const Text(
                    'Delete Account',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _showDeleteAccountConfirmationDialog(
      BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // User must tap a button to close the dialog
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Account Deletion'),
          content: const Text(
              'Are you sure you want to delete your account? This action cannot be undone.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                _deleteAccount(context); // Perform account deletion
              },
              child: const Text(
                'Delete',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> _deleteAccount(BuildContext context) async {
    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      try {
        // Step 1: Delete user data from Firestore (or your database)
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .delete();

        // Step 2: Delete user authentication from Firebase
        await user.delete();

        // Step 3: Navigate to the login screen
        Navigator.of(context).pushReplacementNamed('/login');

        // Show a success message
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Account deleted successfully.')),
        );
      } catch (e) {
        // Handle errors
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to delete account: $e')),
        );
      }
    } else {
      // Handle case where the user is not logged in
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No user is currently logged in.')),
      );
    }
  }
}
