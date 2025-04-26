// ignore_for_file: use_function_type_syntax_for_parameters

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:onboarding/utils/formatters/formatter.dart';

class UserModel {
  final String id;
  String firstName;
  String lastName;
  String username;
  final String email;
  String phoneNumber;
  String profilePicture;

  UserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.username,
    required this.email,
    required this.phoneNumber,
    this.profilePicture = '',
  });

  String get fullName => '$firstName $lastName';

  String get formattedPhoneNo => TFormatter.formatPhoneNumber(phoneNumber);

  static List<String> nameParts(fullName) => fullName.split(' ');

  static String generateUsername(fullName) {
    List<String> nameParts = fullName.split(" ");
    String firstName = nameParts[0].toLowerCase();
    String lastName = nameParts.length > 1 ? nameParts[1].toLowerCase() : "";

    String camelCaseUsername = "$firstName$lastName";
    String usernameWithPrefix = "cwt_$camelCaseUsername";
    return usernameWithPrefix;
  }

  static UserModel empty() => UserModel(
      id: "",
      firstName: "",
      lastName: "",
      username: "",
      email: "",
      phoneNumber: "",
      profilePicture: "");

  Map<String, dynamic> toJson() {
    return {
      "FirstName": firstName,
      "LastName": lastName,
      "Username": username,
      "Email": email,
      "PhoneNumber": phoneNumber,
      "ProfilePicture": profilePicture,
    };
  }

  factory UserModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    try {
      final data = document.data();
      print("Firestore Raw Data: $data"); // Debugging

      if (data == null) return UserModel.empty();

      return UserModel(
        id: document.id,
        firstName: data['FirstName'] ?? "",
        lastName: data['LastName'] ?? "",
        username: data['Username'] ?? "",
        email: data['Email'] ?? "",
        phoneNumber: data['PhoneNumber'] ?? "",
        profilePicture: data['ProfilePicture'] ?? "",
      );
    } catch (e) {
      print("Error parsing Firestore data: $e");
      return UserModel.empty();
    }
  }
}
