import 'package:flutter/material.dart';
import 'package:onboarding/cmn_files/grid_layout.dart';
import 'package:onboarding/shimmer.dart';
import 'package:onboarding/utils/constants/sizes.dart';

class TVerticalProductShimmer extends StatelessWidget {
  const TVerticalProductShimmer({super.key, this.itemCount = 4});

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return TGridLayout(
        itemCount: itemCount,
        itemBuilder: (_, __) => SizedBox(
              width: 180,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TShimmerEffect(width: 180, height: 180),
                  SizedBox(height: TSizes.spaceBtwItems),
                  TShimmerEffect(width: 160, height: 15),
                  SizedBox(height: TSizes.spaceBtwItems / 2),
                  TShimmerEffect(width: 110, height: 15),
                ],
              ),
            ));
  }
}
