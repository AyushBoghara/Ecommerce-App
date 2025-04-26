import 'package:flutter/material.dart';
import 'package:onboarding/main_screens/home/cart/cart_controller.dart';
import 'package:onboarding/utils/helpers/pricing_calculator.dart';
import 'package:onboarding/utils/constants/sizes.dart';

class TBillingAmountSection extends StatelessWidget {
  final double subTotal;
  final double shippingCost;
  final double taxCost; // This will already be ceiled
  final double totalAmount;

  const TBillingAmountSection({
    super.key,
    required this.subTotal,
    required this.shippingCost,
    required this.taxCost,
    required this.totalAmount,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Subtotal
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Subtotal', style: Theme.of(context).textTheme.bodyMedium),
            Text('\u20B9$subTotal', style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
        const SizedBox(height: TSizes.spaceBtwItems / 2),

        // Shipping Fee
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Shipping Fee', style: Theme.of(context).textTheme.bodyMedium),
            Text('\u20B9$shippingCost', style: Theme.of(context).textTheme.labelLarge),
          ],
        ),
        const SizedBox(height: TSizes.spaceBtwItems / 2),

        // Tax Fee
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Tax Fee', style: Theme.of(context).textTheme.bodyMedium),
            Text('\u20B9$taxCost', style: Theme.of(context).textTheme.labelLarge),
          ],
        ),
        const SizedBox(height: TSizes.spaceBtwItems / 2),

        // Order Total
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Order Total', style: Theme.of(context).textTheme.bodyMedium),
            Text('\u20B9$totalAmount', style: Theme.of(context).textTheme.titleMedium),
          ],
        ),
      ],
    );
  }
}