import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:onboarding/appbar/appbar.dart';
import 'package:onboarding/beginning/animation_loader.dart';
import 'package:onboarding/cmn_files/grid_layout.dart';
import 'package:onboarding/main_screens/home/navigation_menu.dart';
import 'package:onboarding/main_screens/home/product_card_vertical.dart';
import 'package:onboarding/main_screens/store/favourite_icon/favourite_controller.dart';
import 'package:onboarding/product/vertical_product_shimmer.dart';
import 'package:onboarding/utils/constants/images_file.dart';
import 'package:onboarding/utils/constants/sizes.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FavouriteController());

    return Scaffold(
      appBar: TAppBar(
        title:
            Text('Wishlist', style: Theme.of(context).textTheme.headlineMedium),
        showBackArrow: true,onClickEvent: () => Get.offAll(
          () => const NavigationMenu(),
        ),
        leadingOnPressed: () => Get.offAll(
          () => const NavigationMenu(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: FutureBuilder(
          future: controller.favoriteProducts(),
          builder: (context, snapshot) {
            /// **Loader when fetching data**
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const TVerticalProductShimmer(itemCount: 6);
            }

           
            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return TAnimationLoaderWidget(
                text: 'Whoops! Wishlist is Empty...',
                animation: TImages.pencilAnimation,
                showAction: true,
                actionText: "Let's add some",
                onActionPressed: () => Get.offAll(() => const NavigationMenu()),
              );
            }

            /// **Display Wishlist Products**
            final products = snapshot.data!;
            return TGridLayout(
              itemCount: products.length,
              itemBuilder: (_, index) => TProductCardVertical(
                product: products[index],
              ),
            );
          },
        ),
      ),
    );
  }
}
