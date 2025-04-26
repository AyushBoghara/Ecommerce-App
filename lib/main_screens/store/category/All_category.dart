import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onboarding/category/category_controller.dart';
import 'package:onboarding/cmn_files/grid_layout.dart';
import 'package:onboarding/main_screens/home/navigation_menu.dart';
import 'package:onboarding/main_screens/home/search_container.dart';
import 'package:onboarding/main_screens/store/category/category_card.dart';
import 'package:onboarding/main_screens/store/category/category_products.dart';
import 'package:onboarding/utils/constants/sizes.dart';
import 'package:onboarding/appbar/appbar.dart';
import '../../../category/category_shimmer.dart';

class AllCategoryScreen extends StatefulWidget {
  const AllCategoryScreen({super.key});

  @override
  _AllCategoryScreenState createState() => _AllCategoryScreenState();
}

class _AllCategoryScreenState extends State<AllCategoryScreen> {
  final categoryController = Get.find<CategoryController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppBar(
        title: const Text('Category'),
        showBackArrow: true,
        onClickEvent: () => Get.offAll(() => NavigationMenu()),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              /// Search Container
              TSearchContainer(
                text: "Search categories...",
                controller: categoryController.searchController,
                onChanged: (query) {
                  categoryController.updateSearchQuery(query); // Update search query
                },
              ),
              const SizedBox(height: TSizes.spaceBtwSections * 1.5),

              /// Display Categories
              Obx(() {
                if (categoryController.isLoading.value) {
                  return const TCategoryShimmer(itemCount: 0);
                }
                if (categoryController.filteredCategories.isEmpty) {
                  return Center(
                    child: Text(
                      'No Data Found!',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .apply(color: Colors.white),
                    ),
                  );
                }
                return TGridLayout(
                  itemCount: categoryController.filteredCategories.length,
                  crossAxisCount: 1,
                  mainAxisExtent: 80,
                  itemBuilder: (_, index) {
                    final category = categoryController.filteredCategories[index];
                    return TCategoryCard(
                        showBorder: true,
                        category: category,
                        onTap: () {
                          categoryController.clearSearchAndRefresh(); // Clear search and refresh categories
                          Get.to(() => CategoryProducts(category: category));
                        });
                  },
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
