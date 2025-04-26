import 'package:get/get.dart';
import 'package:onboarding/main_screens/home/cart/cart_controller.dart';
import 'package:onboarding/product/product_model.dart';
import 'package:onboarding/product/product_variation_model.dart';
import 'package:onboarding/product_detail/images_controller.dart';

class VariationController extends GetxController {
  static VariationController get instance => Get.find();

  final RxMap<String, String> selectedAttributes = <String, String>{}.obs;
  final RxString variationStockStatus = ''.obs;
  final Rx<ProductVariationModel> selectedVariation =
      ProductVariationModel.empty().obs;

  void onAttributeSelected(
      ProductModel product, String attributeName, String attributeValue) {
    selectedAttributes[attributeName] = attributeValue;

    final matchedVariation = _findMatchingVariation(product);
    selectedVariation.value = matchedVariation;

    if (matchedVariation.image.isNotEmpty) {
      ImagesController.instance.selectedProductImage.value =
          matchedVariation.image;
    }

    if (matchedVariation.id.isNotEmpty) {
      final cartController = CartController.instance;
      cartController.productQuantityInCart.value = cartController
          .getVariationQuantityInCart(product.id, matchedVariation.id);
    }

    _updateStockStatus(matchedVariation);
  }

  ProductVariationModel _findMatchingVariation(ProductModel product) {
    return product.productVariations?.firstWhere(
          (variation) =>
              _attributesMatch(variation.attributeValues, selectedAttributes),
          orElse: () => ProductVariationModel.empty(),
        ) ??
        ProductVariationModel.empty();
  }

  bool _attributesMatch(
      Map<String, dynamic> variationAttributes, Map<String, String> selected) {
    if (variationAttributes.length != selected.length) return false;

    for (final key in variationAttributes.keys) {
      final variationValue = variationAttributes[key]?.toString().toLowerCase();
      final selectedValue = selected[key]?.toLowerCase();
      if (variationValue != selectedValue) return false;
    }
   
    return true;
  }

  Set<String> getAttributesAvailabilityInVariation(
      List<ProductVariationModel> variations, String attributeName) {
    final values = variations
        .where((v) =>
            v.attributeValues[attributeName] != null &&
            v.attributeValues[attributeName]!.isNotEmpty &&
            v.stock > 0)
        .map((v) => v.attributeValues[attributeName]!)
        .toSet();
    return values;
  }

  String getVariationPrice() {
    final price = selectedVariation.value.salePrice > 0
        ? selectedVariation.value.salePrice
        : selectedVariation.value.price;
    return '$price';
  }

  void _updateStockStatus(ProductVariationModel variation) {
    variationStockStatus.value =
        variation.stock > 0 ? 'In Stock' : 'Out of Stock';
  }

  void resetSelectedAttributes() {
    selectedAttributes.clear();
    variationStockStatus.value = '';
    selectedVariation.value = ProductVariationModel.empty();
  }
}
