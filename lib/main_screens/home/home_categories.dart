import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onboarding/category/category_controller.dart';
import 'package:onboarding/category/category_shimmer.dart';
import 'package:onboarding/main_screens/home/vertical_image_text.dart';
import 'package:onboarding/main_screens/store/category/category_products.dart';
import 'package:onboarding/utils/constants/images_file.dart';

class THomeCategories extends StatelessWidget {
  const THomeCategories({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final categoryController = Get.put(CategoryController());

    return Obx(
      () {
        if (categoryController.isLoading.value) return TCategoryShimmer();

        if (categoryController.featuredCategories.isEmpty) {
          return Center(
            child: Text(
              "No data found!",
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .apply(color: Colors.white),
            ),
          );
        }
        return SizedBox(
          height: 80,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: categoryController.featuredCategories.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (_, index) {
              final category = categoryController.featuredCategories[index];
              return TVerticalImageText(
                image: category.image,
                title: category.name,
                onTap: () => Get.to(() => CategoryProducts(category: category)),
           //    isNetworkImage: true,
              );
            },
          ),
        );
      },
    );
  }
}
