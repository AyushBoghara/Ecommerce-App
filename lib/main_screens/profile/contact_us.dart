import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onboarding/appbar/appbar.dart';
import 'package:onboarding/main_screens/profile/contact_info.dart';
import 'package:onboarding/utils/constants/sizes.dart';
import 'package:onboarding/utils/constants/colors.dart';

class ContactUsScreen extends StatelessWidget {
  final ContactInfo contactInfo;

  const ContactUsScreen({super.key, required this.contactInfo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppBar(
        showBackArrow: true,
        onClickEvent: () {
          Get.back();
        },
        title: Text(
          'Contact Us',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Contact Information
            Text(
              'Contact Information',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: TSizes.spaceBtwItems),
            Text(
              'If you have any questions or need assistance, please feel free to reach out to us using the information below:',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: TSizes.spaceBtwSections),

            /// Email
            Text(
              'Email:',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            Text(
              contactInfo.email,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: TSizes.spaceBtwItems),

            /// Phone Number
            Text(
              'Phone Number:',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            Text(
              contactInfo.phoneNumber,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: TSizes.spaceBtwItems),

            /// Address
            Text(
              'Address:',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            Text(
              contactInfo.address,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: TSizes.spaceBtwSections),

            /// Additional Information
            Text(
              'We are available 24/7 to assist you with any queries or concerns. Thank you for choosing our app!',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}