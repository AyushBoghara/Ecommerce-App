import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onboarding/appbar/appbar.dart';
import 'package:onboarding/utils/constants/sizes.dart';
import 'package:onboarding/utils/constants/colors.dart';

class HelpSupportScreen extends StatelessWidget {
  const HelpSupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppBar(
        showBackArrow: true,
        onClickEvent: () {
          Get.back();
        },
        title: Text(
          'Help & Support',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          children: [
            /// FAQs Section
            Text(
              'Frequently Asked Questions',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: TSizes.spaceBtwSections),

            /// List of FAQs
            ExpansionTile(
              title: Text(
                'Where is my order?',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              children: [
                Padding(
                  padding: const EdgeInsets.all(TSizes.md),
                  child: Text(
                    'You can track your order by going to the "My Orders" section in the app. If you have further questions, please contact our support team.',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
              ],
            ),
            const Divider(),

            ExpansionTile(
              title: Text(
                'How can I return a product?',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              children: [
                Padding(
                  padding: const EdgeInsets.all(TSizes.md),
                  child: Text(
                    'To return a product, go to the "My Orders" section, select the order, and follow the return instructions. Make sure the product is in its original condition.',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
              ],
            ),
            const Divider(),

            ExpansionTile(
              title: Text(
                'What is your refund policy?',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              children: [
                Padding(
                  padding: const EdgeInsets.all(TSizes.md),
                  child: Text(
                    'We offer a 30-day refund policy. If you are not satisfied with your purchase, you can return the product within 30 days for a full refund.',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
              ],
            ),
            const Divider(),

            ExpansionTile(
              title: Text(
                'How do I contact customer support?',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              children: [
                Padding(
                  padding: const EdgeInsets.all(TSizes.md),
                  child: Text(
                    'You can contact our customer support team by emailing stylezone@india.com or calling +91 799 010 4774.',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
              ],
            ),
            const Divider(),

            ExpansionTile(
              title: Text(
                'What payment methods do you accept?',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              children: [
                Padding(
                  padding: const EdgeInsets.all(TSizes.md),
                  child: Text(
                    'We accept credit/debit cards, PayPal, and other popular payment methods. You can view all available options during checkout.',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
              ],
            ),
            const Divider(),

            ExpansionTile(
              title: Text(
                'How do I change my delivery address?',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              children: [
                Padding(
                  padding: const EdgeInsets.all(TSizes.md),
                  child: Text(
                    'You can update your delivery address in the "My Addresses" section of your account. Make sure to save the changes before placing an order.',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
              ],
            ),
            const Divider(),
          ],
        ),
      ),
    );
  }
}