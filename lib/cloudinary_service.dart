import 'dart:io';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';

class CloudinaryService {
  final String cloudName = "dj0reez2d"; // Replace with your Cloudinary cloud name
  final String uploadPreset = "neeljaviya"; // Make sure this upload preset is configured in Cloudinary

  Future<String> uploadImage(String folder, XFile image) async {
    try {
      final url = "https://api.cloudinary.com/v1_1/$cloudName/image/upload";

      FormData formData = FormData.fromMap({
        "file": await MultipartFile.fromFile(image.path),
        "upload_preset": uploadPreset, // Use this for unsigned uploads
        "folder": folder, // Cloudinary folder (single-level only)
      });

      final response = await Dio().post(url, data: formData);

      if (response.statusCode == 200) {
        print("✅ Upload Successful: ${response.data['secure_url']}");
        return response.data["secure_url"]; // Return uploaded image URL
      } else {
        throw "❌ Upload Failed: ${response.statusMessage}";
      }
    } on DioException catch (e) {
      print("❌ Dio Error: ${e.response?.data ?? e.message}");
      throw "Cloudinary Upload Error: ${e.response?.data ?? e.message}";
    } catch (e) {
      print("❌ Unknown Error: $e");
      throw "Something went wrong. Please try again.";
    }
  }
}
