import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onboarding/appbar/appbar.dart';
import 'package:onboarding/utils/constants/sizes.dart';
import 'package:onboarding/utils/constants/colors.dart';

class PrivacyPolicyTermsScreen extends StatelessWidget {
  const PrivacyPolicyTermsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppBar(
        showBackArrow: true,
        onClickEvent: () {
          Get.back();
        },
        title: Text(
          'Privacy Policy & Terms',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Privacy Policy Section
            Text(
              'Privacy Policy',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: TSizes.spaceBtwItems),
            Text(
              'Last updated: [12/03/2024]',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: TSizes.spaceBtwItems),
            Text(
              'Your privacy is important to us. This Privacy Policy explains how we collect, use, and protect your personal information when you use our app. By using our app, you agree to the terms of this Privacy Policy.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: TSizes.spaceBtwItems),
            Text(
              '**1. Information We Collect**:',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            Text(
              '- Personal information (e.g., name, email, phone number)\n'
              '- Payment information (e.g., credit card details)\n'
              '- Delivery address\n'
              '- Usage data (e.g., browsing history, preferences)',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: TSizes.spaceBtwItems),
            Text(
              '**2. How We Use Your Information**:',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            Text(
              '- To process and deliver your orders\n'
              '- To communicate with you about your account and orders\n'
              '- To improve our app and services\n'
              '- To send promotional offers (with your consent)',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: TSizes.spaceBtwSections),

            /// Delivery Policy Section
            Text(
              'Delivery Policy',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: TSizes.spaceBtwItems),
            Text(
              '**1. Delivery Timeframe**:',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            Text(
              '- Standard delivery: 3-5 business days\n'
              '- Express delivery: 1-2 business days (additional charges may apply)',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: TSizes.spaceBtwItems),
            Text(
              '**2. Delivery Areas**:',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            Text(
              '- We deliver to all major cities and regions. Check your area during checkout.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: TSizes.spaceBtwItems),
            Text(
              '**3. Tracking Your Order**:',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            Text(
              '- You can track your order in real-time through the app.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: TSizes.spaceBtwSections),

            /// Terms of Service Section
            Text(
              'Terms of Service',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: TSizes.spaceBtwItems),
            Text(
              'Last updated: [15/03/2025]',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: TSizes.spaceBtwItems),
            Text(
              'By using our app, you agree to these Terms of Service. Please read them carefully. If you do not agree to these terms, do not use our app.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: TSizes.spaceBtwItems),
            Text(
              '**1. Account Responsibility**:',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            Text(
              '- You are responsible for maintaining the security of your account and for all activities that occur under your account.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: TSizes.spaceBtwItems),
            Text(
              '**2. Prohibited Activities**:',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            Text(
              '- You may not use our app for any illegal or unauthorized purpose.\n'
              '- You may not attempt to gain unauthorized access to our systems or data.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: TSizes.spaceBtwItems),
            Text(
              '**3. Termination**:',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            Text(
              '- We reserve the right to terminate or suspend your account at any time for any reason.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: TSizes.spaceBtwItems),
            Text(
              '**4. Returns and Refunds**:',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            Text(
              '- You may return products within 30 days of delivery for a full refund.\n'
              '- Items must be in their original condition and packaging.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: TSizes.spaceBtwSections),

            /// Contact Information Section
           
          ],
        ),
      ),
    );
  }
}