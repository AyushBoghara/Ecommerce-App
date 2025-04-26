import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:onboarding/loaders.dart';
import 'package:onboarding/order_model.dart';
import 'package:onboarding/repositories/authentication_repository.dart';

class OrderRepository extends GetxController {
  static OrderRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  Future<List<OrderModel>> fetchUserOrders() async {
    try {
      final userId = AuthenticationRepository.instance.authUser.uid;
      if (userId.isEmpty) throw "Unable to find user information.";

      final result = await _db
          .collection('Orders')
          .where('userId', isEqualTo: userId)
          .get();
      for (var doc in result.docs) {
        print("Raw order data: ${doc.data()}");
      }
      return result.docs
          .map((documentSnapshot) => OrderModel.fromSnapshot(documentSnapshot))
          .toList();
    } catch (e) {
      TLoaders.errorSnackBar(title: "Error from order_repository");
      print("Error fetching user orders: $e"); // Debugging information
      throw "Error occurred while fetching orders.";
    }
  }

  Future<void> saveOrder(OrderModel order, String userId) async {
    try {
      await _db.collection('Orders').add(order.toJson());
    } catch (e) {
      throw "Error occurred in saving order.";
    }
  }
}
