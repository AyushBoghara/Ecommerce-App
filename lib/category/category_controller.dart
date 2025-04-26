import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onboarding/category/category_model.dart';
import 'package:onboarding/category/category_repository.dart';
import 'package:onboarding/loaders.dart';

class CategoryController extends GetxController {
  static CategoryController get instance => Get.find();

  final isLoading = false.obs;
  final _categoryRepository = Get.put(CategoryRepository());
  RxList<CategoryModel> allCategories = <CategoryModel>[].obs;
  RxList<CategoryModel> featuredCategories = <CategoryModel>[].obs;

  // Observable to store the search query
  final RxString searchQuery = ''.obs;

  // Add a TextEditingController for the search input
  final searchController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    fetchCategories();
  }

  // Fetch all categories from the repository
  Future<void> fetchCategories() async {
    try {
      isLoading.value = true;
      final categories = await _categoryRepository.getAllCategories();
      allCategories.assignAll(categories);

      // Optionally, you can filter featured categories
      featuredCategories.assignAll(
        allCategories.where((category) => category.isFeatured).toList(),
      );
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  // Update the search query
  void updateSearchQuery(String query) {
    searchQuery.value = query;
  }

  // Clear search query and reload all categories
  void clearSearchAndRefresh() {
    searchQuery.value = '';  // Clear the search query
    searchController.clear(); // Clear the search controller text
    fetchCategories(); // Reload all categories
  }

  // Getter to filter categories based on search query
  List<CategoryModel> get filteredCategories {
    if (searchQuery.isEmpty) {
      return allCategories;  // Return all categories if no search query
    } else {
      return allCategories
          .where((category) =>
              category.name.toLowerCase().contains(searchQuery.value.toLowerCase()))
          .toList();
    }
  }

  @override
  void onClose() {
    super.onClose();
  }
}
