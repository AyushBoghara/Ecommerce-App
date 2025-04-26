// ignore_for_file: body_might_complete_normally_nullable

import 'package:flutter/material.dart';
import 'package:onboarding/cloudinary_service.dart';

class TCloudHelperFunctions {
  static Widget? checkSingleRecordState<T>(AsyncSnapshot<T> snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return const Center(child: CircularProgressIndicator());
    }

    if (!snapshot.hasData || snapshot.data == null) {
      return const Center(child: Text('No products found'));
    }

    if (snapshot.hasError) {
      return const Center(child: Text('Error fetching products'));
    }
    return null;
  }

  static Widget? checkMultipleRecordState<T>(
      {required AsyncSnapshot<List<T>> snapshot,
      Widget? loader,
      Widget? error,
      Widget? nothingFound}) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return const Center(child: CircularProgressIndicator());
    }
    if (!snapshot.hasData || snapshot.data == null || snapshot.data!.isEmpty) {
      return const Center(child: Text('No products found'));
    }

    if (snapshot.hasError) {
      return const Center(child: Text('Error fetching products'));
    }
    return null;
  }

}
