import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onboarding/loaders.dart';
import 'package:onboarding/product/product_model.dart';
import 'package:onboarding/product/product_repository.dart';
import 'package:onboarding/utils/local_storage/storage_utility.dart';

class FavouriteController extends GetxController {
  static FavouriteController get instance => Get.find();

  final favourites = <String, bool>{}.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    initFavorites();
  }

  Future<void> initFavorites() async {
    final json = TLocalStorage.instance().readData('favourites');
    if (json != null) {
      final storedFavourites = jsonDecode(json) as Map<String, dynamic>;
      favourites.assignAll(
          storedFavourites.map((key, value) => MapEntry(key, value as bool)));
    }
  }

  bool isFavourite(String productId) {
    return favourites[productId] ?? false;
  }

   /// Toggle favorite status and save to local storage
  void toggleFaveouriteProduct(String productId) {
    if (isFavourite(productId)) {
      favourites.remove(productId); // Remove from favorites
    } else {
      favourites[productId] = true; // Add to favorites
    }
    saveFavoritesToStorage();
    update(); // Force widget update
    TLoaders.customToast(
      message: isFavourite(productId)
          ? 'Product added to Wishlist.'
          : 'Product removed from Wishlist.',
    );
  }
  void saveFavoritesToStorage(){
    final encodedFavourites = json.encode(favourites);
    TLocalStorage.instance().saveData('favourites', encodedFavourites);
  }

  Future<List<ProductModel>> favoriteProducts() async{
    return await ProductRepository.instance.getFavouriteProducts(favourites.keys.toList());
  }
}
