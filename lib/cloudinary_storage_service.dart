import 'dart:io';
import 'dart:typed_data';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'dart:convert';

class TCloudinaryStorageService extends GetxController {
  static TCloudinaryStorageService get instance => Get.find();

  final String cloudinaryUrl =
      "https://api.cloudinary.com/v1_1/dj0reez2d/image/upload";
  final String uploadPreset = "neeljaviya"; // Set this in Cloudinary settings

  /// Upload image from Uint8List (Assets, Memory, etc.)
  Future<String> uploadImageData(Uint8List image, String fileName) async {
    try {
      var request = http.MultipartRequest("POST", Uri.parse(cloudinaryUrl));
      request.fields['upload_preset'] = uploadPreset;

      request.files.add(http.MultipartFile.fromBytes(
        'file',
        image,
        filename: fileName,
      ));

      var response = await request.send();
      if (response.statusCode == 200) {
        var responseData = await response.stream.bytesToString();
        var jsonData = json.decode(responseData);
        return jsonData['secure_url']; // Return the Cloudinary image URL
      } else {
        throw "Failed to upload image: ${response.reasonPhrase}";
      }
    } catch (e) {
      throw "Error uploading image: $e";
    }
  }

  /// Upload image from File (Gallery, Camera)
  Future<String> uploadImageFile(XFile imageFile) async {
    try {
      var request = http.MultipartRequest("POST", Uri.parse(cloudinaryUrl));
      request.fields['upload_preset'] = uploadPreset;

      request.files.add(await http.MultipartFile.fromPath(
        'file',
        imageFile.path,
        filename: basename(imageFile.path),
      ));

      var response = await request.send();
      if (response.statusCode == 200) {
        var responseData = await response.stream.bytesToString();
        var jsonData = json.decode(responseData);
        return jsonData['secure_url']; // Return Cloudinary image URL
      } else {
        throw "Failed to upload image: ${response.reasonPhrase}";
      }
    } catch (e) {
      throw "Error uploading image: $e";
    }
  }
}
