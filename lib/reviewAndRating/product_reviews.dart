import 'package:flutter/material.dart';

import 'package:onboarding/appbar/appbar.dart';
import 'package:onboarding/reviewAndRating/rating_indicator.dart';
import 'package:onboarding/reviewAndRating/rating_progress_indicator.dart';
import 'package:onboarding/reviewAndRating/user_review_card.dart';
import 'package:onboarding/utils/constants/sizes.dart';

class ProductReviewsScreen extends StatelessWidget {
  const ProductReviewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppBar(
        title: Text('Reviews & Ratings'),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                  'Ratings and reviews are verified and are from people who use the same type of device that you use.'),
              const SizedBox(height: TSizes.spaceBtwItems),
              TOverallProductRating(),
              TRatingBarIndicator(rating: 3.5),
              Text("12,611", style: Theme.of(context).textTheme.bodySmall),
              const SizedBox(height: TSizes.spaceBtwSections),
              UserReviewCard(),
            ],
          ),
        ),
      ),
    );
  }
}
