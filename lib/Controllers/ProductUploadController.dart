import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductController extends GetxController {
  // Text controllers
  final productNameController = TextEditingController();
  final descriptionController = TextEditingController();
  final priceController = TextEditingController();
  final stockQuantityController = TextEditingController();
  final perUnitQuantityController = TextEditingController();

  // Reactive variables
  var category = ''.obs;
  var unit = ''.obs;
  var imageFile = Rxn<File>();
  var imageUrl = ''.obs;
  var isUploading = false.obs;

  var token = ''.obs;

  final ImagePicker _picker = ImagePicker();

  // ✅ Load token from SharedPreferences
  Future<void> loadToken() async {
    final prefs = await SharedPreferences.getInstance();
    token.value = prefs.getString("auth_token") ?? "";

    if (token.value.isEmpty) {
      print("⚠️ Token not found in SharedPreferences.");
    } else {
      print("🔑 Loaded token: ${token.value}");
    }
  }

  // ✅ Pick an image from gallery
  Future<void> pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      imageFile.value = File(pickedFile.path);
    }
  }

  // ✅ Upload product to API
  Future<void> uploadProduct() async {
    isUploading.value = true;

    await loadToken(); // Load the token before the request

    final url = Uri.parse("https://admin.multiwebx.com/farmerAPI/farmerProductAPI/");

    try {
      final response = await http.post(
        url,
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
        },
        body: {
          "action": "createProduct",
          "token": token.value, // Use loaded token
          "ProductName": productNameController.text,
          "Category": category.value,
          "Description": descriptionController.text,
          "Price": priceController.text,
          "StockQuantity": stockQuantityController.text,
          "Unit": unit.value,
          "PerUnitQuantity": perUnitQuantityController.text,
          "ImageURL": "https://example.com/image.jpg", // Optional: Replace if dynamic
          "productVideo": "https://example.com/video.mp4", // Optional: Replace if dynamic
        },
      );

      final data = json.decode(response.body);
      if (data["status"] == "success") {
        Get.snackbar('Success', 'Product uploaded successfully!',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.green,
            colorText: Colors.white);
        await Future.delayed(Duration(milliseconds: 500));
        Get.offAllNamed('/dash');
      } else {
        Get.snackbar('Error', data["message"] ?? "Upload failed",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white);
      }
    } catch (e) {
      Get.snackbar('Error', 'Something went wrong: $e',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    } finally {
      isUploading.value = false;
    }
  }

  @override
  void onClose() {
    productNameController.dispose();
    descriptionController.dispose();
    priceController.dispose();
    stockQuantityController.dispose();
    perUnitQuantityController.dispose();
    super.onClose();
  }
}
