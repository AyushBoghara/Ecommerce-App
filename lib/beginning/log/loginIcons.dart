import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onboarding/beginning/log/login_controller.dart';
import 'package:onboarding/utils/constants/colors.dart';
import 'package:onboarding/utils/constants/images_file.dart';
import 'package:onboarding/utils/constants/sizes.dart';

class loginIcons extends StatelessWidget {
  const loginIcons({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.5, // Responsive width
          height: 50, // Fixed height
          child: TextButton(
            onPressed: () => controller.googleSignIn(),
            style: TextButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: const BorderSide(color: TColors.grey),
              ),
              backgroundColor: Colors.white, // Optional background
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  TImages.google,
                  width: TSizes.iconMd,
                  height: TSizes.iconMd,
                ),
                const SizedBox(width: 8),
                Flexible( // Prevents text from overflowing
                  child: Text(
                    "Sign in with Google",
                    style: TextStyle(color: Colors.black),
                    overflow: TextOverflow.ellipsis, // Handles overflow
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
