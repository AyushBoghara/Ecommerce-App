import 'package:flutter/material.dart';
import 'package:onboarding/cmn_files/grid_layout.dart';
import 'package:onboarding/shimmer.dart';

class TBrandShimmer extends StatelessWidget {
  const TBrandShimmer({super.key, required this.itemCount});
  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return TGridLayout(
        mainAxisExtent: 80,
        itemCount: itemCount,
        itemBuilder: (_, __) => const TShimmerEffect(width: 380, height: 80));
  }
}
