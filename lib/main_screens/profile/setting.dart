import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:iconsax/iconsax.dart';
import 'package:onboarding/beginning/log/login.dart';
import 'package:onboarding/main_screens/home/cart/Cart.dart';
import 'package:onboarding/main_screens/profile/account_settings/my_orders/Order.dart';
import 'package:onboarding/main_screens/profile/contact_info.dart';
import 'package:onboarding/main_screens/profile/contact_us.dart';
import 'package:onboarding/main_screens/profile/help_screen%20.dart';
import 'package:onboarding/main_screens/profile/user_info/Profile.dart';
import 'package:onboarding/main_screens/profile/account_settings/my_addresses/address.dart';
import 'package:onboarding/appbar/appbar.dart';
import 'package:onboarding/main_screens/home/primary_header_container.dart';
import 'package:onboarding/cmn_files/section_heading.dart';
import 'package:onboarding/main_screens/profile/settings_menu_tile.dart';
import 'package:onboarding/main_screens/profile/user_info/privacy_policy.dart';
import 'package:onboarding/main_screens/profile/user_info/user_profile_tile.dart';
import 'package:onboarding/main_screens/store/wishlist/wishlist.dart';
import 'package:onboarding/utils/constants/colors.dart';
import 'package:onboarding/utils/constants/sizes.dart';
import 'package:permission_handler/permission_handler.dart'; // Add this package for permission handling

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _isNotificationEnabled = false;

  

  // Check if notification permission is granted


  void _logout(BuildContext context) async {
    await GoogleSignIn().signOut();
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            /// --Header
            TPrimaryHeaderContainer(
              child: Column(
                children: [
                  /// AppBar
                  TAppBar(
                      showBackArrow: false,
                      title: Text('Account',
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium!
                              .apply(color: TColors.white))),

                  /// User Profile Card
                  TUserProfileTile(
                      onPressed: () => Get.to(() => ProfileScreen())),
                  const SizedBox(height: TSizes.spaceBtwSections),
                ],
              ),
            ),

            /// --Body
            Padding(
              padding: const EdgeInsets.all(TSizes.defaultSpace),
              child: Column(
                children: [
                  /// -- Account Settings
                  const TSectionHeading(
                      title: 'Account Settings', showActionButton: false),
                  const SizedBox(height: TSizes.spaceBtwItems),

                  TSettingsMenuTile(
                    icon: Iconsax.safe_home,
                    title: 'My Addresses',
                    subTitle: 'Set shopping delivery address',
                    onTap: () => Get.to(() => UserAddressScreen()),
                  ),
                  TSettingsMenuTile(
                    icon: Iconsax.shopping_cart,
                    title: 'My Cart',
                    subTitle: 'Add, remove products and move to checkout',
                    onTap: () => Get.to(() => CartScreen()),
                  ),
                  TSettingsMenuTile(
                    icon: Iconsax.bag_tick,
                    title: 'My Orders',
                    subTitle: 'In-progress and Completed Orders',
                    onTap: () => Get.to(() => OrderScreen()),
                  ),
                  TSettingsMenuTile(
                    icon: Iconsax.heart,
                    title: 'Wishlist',
                    subTitle: 'View your saved items',
                    onTap: () => Get.to(() => FavouriteScreen()),
                  ),
                  TSettingsMenuTile(
                    icon: Iconsax.support,
                    title: 'Help & Support',
                    subTitle: 'FAQs, contact support, and report issues',
                    onTap: () => Get.to(() => HelpSupportScreen()),
                  ),

                  SizedBox(height: TSizes.spaceBtwSections),

                  /// -- App Settings
                  const TSectionHeading(
                      title: 'App Settings', showActionButton: false),
                  const SizedBox(height: TSizes.spaceBtwItems),

                  TSettingsMenuTile(
                    icon: Iconsax.document,
                    title: 'Privacy Policy & Terms',
                    subTitle: 'Read our policies and terms',
                    onTap: () => Get.to(() => const PrivacyPolicyTermsScreen()),
                  ),
                  TSettingsMenuTile(
                    icon: Iconsax.call,
                    title: 'Contact Us',
                    subTitle: 'Reach out to us for support',
                    onTap: () {
                      final contactInfo = ContactInfo(
                        email: 'stylezone@india.com',
                        phoneNumber: '+91 799 010 4774',
                        address: 'Gujarat, India',
                      );
                      Get.to(() => ContactUsScreen(contactInfo: contactInfo));
                    },
                  ),

                  SizedBox(height: TSizes.spaceBtwSections),

                  /// -- App Version
                  Text(
                    'Version 1.0.0',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),

                  SizedBox(height: TSizes.spaceBtwSections),

                  /// -- Logout Button
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () => _showLogoutConfirmationDialog(
                          context), // Show confirmation dialog
                      child: const Text("Logout"),
                    ),
                  ),
                  SizedBox(height: TSizes.spaceBtwSections * 2.5),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showLogoutConfirmationDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // User must tap a button to close the dialog
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Logout'),
          content: const Text('Are you sure you want to logout?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('No'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                _logout(context); // Perform logout
              },
              child: const Text('Yes'),
            ),
          ],
        );
      },
    );
  }
}
