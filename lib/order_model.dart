import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:onboarding/main_screens/home/cart/cart_item_model.dart';
import 'package:onboarding/main_screens/profile/account_settings/my_addresses/address_model.dart';
import 'package:onboarding/utils/constants/enums.dart';
import 'package:onboarding/utils/helpers/helper_functions.dart';

class OrderModel {
  final String id;
  final String userId;
  final OrderStatus status;
  final double totalAmount;
  final double shippingCost;
  final double taxCost;
  final DateTime orderDate;
  final String paymentMethod;
  final AddressModel? address;
  final DateTime? deliveryDate;
  final List<CartItemModel> items;

  OrderModel({
    required this.id,
    this.userId = '',
    required this.status,
    required this.totalAmount,
    this.shippingCost = 0.0,
    this.taxCost = 0.0,
    required this.orderDate,
    this.paymentMethod = 'Paypal',
    this.address,
    this.deliveryDate,
    required this.items,
  });

  /// Get formatted order date
  String get formattedOrderDate => THelperFunctions.getFormattedDate(orderDate);

  /// Get formatted delivery date
  String get formattedDeliveryDate => deliveryDate != null
      ? THelperFunctions.getFormattedDate(deliveryDate!)
      : 'N/A';

  /// Get order status as text
  String get orderStatusText {
    switch (status) {
      case OrderStatus.delivered:
        return 'Delivered';
      case OrderStatus.shipped:
        return 'Shipment on the way';
      default:
        return 'Processing';
    }
  }

  /// Convert model to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'status': status.toString(),
      'totalAmount': totalAmount,
      'shippingCost': shippingCost,
      'taxCost': taxCost,
      'orderDate': orderDate,
      'paymentMethod': paymentMethod,
      'address': address?.toJson(),
      'deliveryDate': deliveryDate,
      'items': items.map((item) => item.toJson()).toList(),
    };
  }

  /// Create model from Firestore snapshot
  factory OrderModel.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>? ?? {};

    return OrderModel(
      id: data['id'] as String? ?? '',
      userId: data['userId'] as String? ?? '',
      status: OrderStatus.values.firstWhere(
        (e) => e.toString() == (data['status'] as String? ?? ''),
        orElse: () => OrderStatus.pending,
      ),
      totalAmount: (data['totalAmount'] as num?)?.toDouble() ?? 0.0,
      shippingCost: (data['shippingCost'] as num?)?.toDouble() ?? 0.0,
      taxCost: (data['taxCost'] as num?)?.toDouble() ?? 0.0,
      orderDate: (data['orderDate'] as Timestamp?)?.toDate() ?? DateTime.now(),
      paymentMethod: data['paymentMethod'] as String? ?? 'Paypal',
      address: data.containsKey('address') && data['address'] != null
          ? AddressModel.formMap(data['address'] as Map<String, dynamic>)
          : null,
      deliveryDate:
          data.containsKey('deliveryDate') && data['deliveryDate'] != null
              ? (data['deliveryDate'] as Timestamp).toDate()
              : null,
      items: (data['items'] as List<dynamic>?)
              ?.map((itemData) =>
                  CartItemModel.fromJson(itemData as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }
}
