import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OwnProductController extends GetxController {
  var isLoading = true.obs;
  var productList = [].obs;

  final Dio _dio = Dio();

  @override
  void onInit() {
    super.onInit();
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    try {
      isLoading.value = true;

      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('auth_token') ?? '';

      final response = await _dio.post(
        "https://admin.multiwebx.com/farmerAPI/farmerProductAPI/",
        options: Options(
          headers: {"Content-Type": "application/x-www-form-urlencoded"},
        ),
        data: {
          "action": "listProducts",
          "token": token,
        },
      );

      if (response.statusCode == 200 && response.data['status'] == "success") {
        productList.value = response.data['data'];
      } else {
        productList.clear();
        Get.snackbar("Error", response.data['message'] ?? "Failed to load products");
      }
    } catch (e) {
      productList.clear();
      Get.snackbar("Error", "Something went wrong: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> deleteProduct(String productId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('auth_token') ?? '';

      final response = await _dio.post(
        "https://admin.multiwebx.com/farmerAPI/farmerProductAPI/",
        options: Options(
          headers: {"Content-Type": "application/x-www-form-urlencoded"},
        ),
        data: {
          "action": "deleteProduct",
          "token": token,
          "id": productId,
        },
      );

      if (response.statusCode == 200 && response.data['status'] == "success") {
        Get.snackbar("Success", "Product deleted successfully");
        fetchProducts();
      } else {
        Get.snackbar("Error", response.data['message'] ?? "Failed to delete product");
      }
    } catch (e) {
      Get.snackbar("Error", "Something went wrong: $e");
    }
  }

  Future<void> updateProduct({
    required String productId,
    required String productName,
    required String category,
    required String description,
    required double price,
    required int stockQuantity,
    required String unit,
    required double perUnitQuantity,
    // required String imageUrl,
    // required String productVideo,
  }) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('auth_token') ?? '';

      final response = await _dio.post(
        'https://admin.multiwebx.com/farmerAPI/farmerProductAPI/',
        options: Options(
          headers: {"Content-Type": "application/x-www-form-urlencoded"},
        ),
        data: {
          'action': 'updateProduct',
          'token': token,
          'id': productId,
          'ProductName': productName,
          'Category': category,
          'Description': description,
          'Price': price,
          'StockQuantity': stockQuantity,
          'Unit': unit,
          'PerUnitQuantity': perUnitQuantity,
          // 'ImageURL': imageUrl,
          // 'productVideo': productVideo,
        },
      );

      if (response.data['status'] == "success") {
        // Product updated successfully
        Get.snackbar(
          "Updated",
          "Product updated successfully",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );

        // Optionally, you can refresh the product list if needed
        await fetchProducts();
      } else {
        // Handle errors in the response
        Get.snackbar(
          "Error",
          response.data['message'] ?? "Failed to update product",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      print('Error updating product: $e');
      Get.snackbar(
        "Error",
        "Something went wrong: $e",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

}
