import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';

class BannerModel {
  final bool active;
  final String targetScreen;
  String imageUrl;

  BannerModel({
    required this.active,
    required this.targetScreen,
    required this.imageUrl,
  });

  Map<String, dynamic> toJson() {
    return {
      'Active': active,
      'TargetScreen': targetScreen,
      'ImageUrl': imageUrl,
    };
  }

  factory BannerModel.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String,dynamic>;
    return BannerModel(

      active: data['Active'] ?? false,
      targetScreen: data['TargetScreen'] ?? '',
      imageUrl: data['ImageUrl'] ?? '',
    );
  }
}
