import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:onboarding/utils/formatters/formatter.dart';

class AddressModel {
  String id;
  final String name;
  final String phoneNumber;
  final String street;
  final String city;
  final String state;
  final String postalCode;
  final String country;
  final DateTime? dateTime;
  bool selectedAddress;

  AddressModel({
    required this.id,
    required this.name,
    required this.phoneNumber,
    required this.street,
    required this.city,
    required this.state,
    required this.postalCode,
    required this.country,
    this.dateTime,
    this.selectedAddress = true,
  });

  String get formattedPhoneNo => TFormatter.formatPhoneNumber(phoneNumber);

  static AddressModel empty() => AddressModel(
      id: '',
      name: '',
      phoneNumber: '',
      street: '',
      city: '',
      state: '',
      postalCode: '',
      country: '');

  Map<String, dynamic> toJson() {
    return {
      'Id': id,          //error here
      'Name': name,
      'PhoneNumber': phoneNumber,
      'Street': street,
      'City': city,
      'State': state,
      'PostalCode': postalCode,
      'Country': country,
      'DateTime': DateTime.now(),
      'SelectedAddress': selectedAddress,
    };
  }

  factory AddressModel.formMap(Map<String, dynamic> data) {
    return AddressModel(
      id: data['Id'] as String,
      name: data['Name'] as String,
      phoneNumber: data['PhoneNumber'] as String,
      city: data['City'] as String,
      state: data['State'] as String,
      street: data['Street'] as String,
      postalCode: data['PostalCode'] as String,
      country: data['Country'] as String,
      dateTime: (data['DateTime'] as Timestamp).toDate(),
      selectedAddress: data['SelectedAddress'] as bool,
    );
  }

  factory AddressModel.formDocumentSnapshot(DocumentSnapshot snapshot) {
    return AddressModel(
      id: snapshot.id,
      name: snapshot['Name'] ?? '',
      phoneNumber: snapshot['PhoneNumber'] ?? '',
      city: snapshot['City'] ?? '',
      state: snapshot['State'] ?? '',
      street: snapshot['Street'] ?? '',
      postalCode: snapshot['PostalCode'] ?? '',
      country: snapshot['Country'] ?? '',
      dateTime: (snapshot['DateTime'] as Timestamp).toDate(),
      selectedAddress: snapshot['SelectedAddress'] ?? bool,
    );
  }
  @override
  String toString() {
    return '$street, $city, $state, $postalCode, $country';
  }
}
