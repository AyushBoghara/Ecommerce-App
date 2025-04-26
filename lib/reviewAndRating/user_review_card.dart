import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onboarding/reviewAndRating/product_rating_and_review_controller.dart';
import 'package:onboarding/reviewAndRating/rating_indicator.dart';
import 'package:onboarding/utils/constants/colors.dart';
import 'package:onboarding/utils/helpers/helper_functions.dart';
import 'package:readmore/readmore.dart';

import '../../../utils/constants/images_file.dart';
import '../../../utils/constants/sizes.dart';

class UserReviewCard extends StatelessWidget {
  const UserReviewCard({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final controller = Get.put(ProductRatingAndReviewController());
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: controller.reviews.isNotEmpty && controller.reviews.first.userImage.isNotEmpty
                      ? NetworkImage(controller.reviews.first.userImage) as ImageProvider
                      : AssetImage(TImages.user) as ImageProvider,
                ),
                const SizedBox(height: TSizes.spaceBtwItems),
                Text(
                  controller.reviews.isNotEmpty
                      ? controller.reviews.first.username
                      : 'Anonymous',
                  style: Theme.of(context).textTheme.titleLarge,
                )
              ],
            ),
            IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert)),
          ],
        ),
        const SizedBox(height: TSizes.spaceBtwItems),
        Row(
          children: [
            TRatingBarIndicator(rating: 4),
            const SizedBox(height: TSizes.spaceBtwItems),
            Text(controller.reviews.first.date.toIso8601String(),
                style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
        const SizedBox(height: TSizes.spaceBtwItems),
        ReadMoreText(
          controller.reviews.first.comment,
          trimLines: 1,
          trimMode: TrimMode.Line,
          trimExpandedText: 'show less',
          trimCollapsedText: 'show more',
          moreStyle: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: TColors.primary),
          lessStyle: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: TColors.primary),
        ),
        Divider(),
        const SizedBox(height: TSizes.spaceBtwItems),
        // TRoundedContainer(
        //   backgroundColor: dark ? TColors.darkerGrey : TColors.grey,
        //   child: Padding(
        //     padding: EdgeInsets.all(TSizes.md),
        //     child: Column(
        //       children: [
        //         Row(
        //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //           children: [
        //             Text("T's Store",
        //                 style: Theme.of(context).textTheme.titleMedium),
        //             Text('20 Nov, 2023',
        //                 style: Theme.of(context).textTheme.bodyMedium),
        //           ],
        //         ),
        //         const SizedBox(height: TSizes.spaceBtwItems),
        //         ReadMoreText(
        //           'The User interface of the app is quite intuitive.I was able to navigate and make purchases seamlessly. Great job!',
        //           trimLines: 1,
        //           trimMode: TrimMode.Line,
        //           trimExpandedText: 'show less',
        //           trimCollapsedText: 'show more',
        //           moreStyle: const TextStyle(
        //               fontSize: 14,
        //               fontWeight: FontWeight.bold,
        //               color: TColors.primary),
        //           lessStyle: const TextStyle(
        //               fontSize: 14,
        //               fontWeight: FontWeight.bold,
        //               color: TColors.primary),
        //         ),
        //       ],
        //     ),
        //   ),
        // ),
        // const SizedBox(height: TSizes.spaceBtwSections),
      ],
    );
  }
}
