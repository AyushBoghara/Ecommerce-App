import 'package:cloud_firestore/cloud_firestore.dart';

class ReviewModel {
  String id;
  String userId;
  String username;
  double rating;
  String comment;
  DateTime date;
  String userImage;

  ReviewModel({
    this.id = '',
    required this.userId,
    required this.username,
    required this.rating,
    required this.comment,
    required this.date,
    required this.userImage,
  });

  static ReviewModel empty() => ReviewModel(
      id: '',
      userId: '',
      username: '',
      rating: 0.0,
      comment: '',
      date: DateTime.now(),
      userImage: '');

  Map<String, dynamic> toJson() {
    return {
      'Id': id,
      'UserId': userId,
      'Username': username,
      'Rating': rating,
      'Comment': comment,
      'Date': date.toIso8601String(),
      'UserImage': userImage
    };
  }

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      id: json['Id'] ?? '',
      userId: json['UserId'] ?? '',
      username: json['Username'] ?? '',
      rating: (json['Rating'] ?? 0.0).toDouble(),
      comment: json['Comment'] ?? '',
      date: DateTime.parse(json['Date']),
      userImage: json['UserImage'] ?? '',
    );
  }

  factory ReviewModel.fromSnapShot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() == null) return ReviewModel.empty();
    final data = document.data()!;
    return ReviewModel(
      id: document.id,
      userId: data['UserId'] ?? '',
      username: data['Username'] ?? '',
      rating: (data['Rating'] ?? 0.0).toDouble(),
      comment: data['Comment'] ?? '',
      date: DateTime.parse(data['Date']),
      userImage: data['UserImage'] ?? '',
    );
  }
}
