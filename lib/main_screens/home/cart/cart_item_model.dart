class CartItemModel {
  String productId;
  String? title;
  String? image;
  double price;
  int quantity;
  String variationId;
//  String? brandName;
  Map<String, String>? selectedVariation;

  CartItemModel(
      {required this.productId,
      this.title = '',
      this.image,
      this.price = 0.0,
      required this.quantity,
      this.variationId = '',
 //     this.brandName,
      this.selectedVariation});

  static CartItemModel empty() => CartItemModel(productId: '', quantity: 0);
  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'title': title,
      'image': image,
      'price': price,
      'quantity': quantity,
      'variationId': variationId,
//      'brandName': brandName,
      'selectedVariation': selectedVariation
    };
  }

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
      productId: json['productId'],
      title: json['title'],
      image: json['image'],
      price: json['price']?.toDouble(),
      quantity: json['quantity'],
      variationId: json['variationId'],
 //     brandName: json['brandName'],
      selectedVariation: json['selectedVariation'] != null
          ? Map<String, String>.from(json['selectedVariation'])
          : null,
    );
  }
}
