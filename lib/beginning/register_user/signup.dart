import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:iconsax/iconsax.dart';
import 'package:onboarding/beginning/log/loginDivider.dart';
import 'package:onboarding/beginning/log/loginIcons.dart';
import 'package:onboarding/beginning/log/verify_email.dart';
import 'package:onboarding/beginning/register_user/signup_form.dart';
import 'package:onboarding/utils/constants/colors.dart';
import 'package:onboarding/utils/constants/sizes.dart';
import 'package:onboarding/utils/constants/text_strings.dart';
import 'package:onboarding/utils/helpers/helper_functions.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                TTexts.signUpTitle,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              SizedBox(
                height: TSizes.spaceBtwSections,
              ),
              TSignupForm(dark: dark),
            ],
          ),
        ),
      ),
    );
  }
}
