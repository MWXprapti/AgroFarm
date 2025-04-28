import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ProductFetchController extends GetxController {
  var isLoading = false.obs;
  var errorMessage = ''.obs;

  // All product fields as string observables
  var productID = ''.obs;
  var ProductName = ''.obs;
  var category = ''.obs;
  var description = ''.obs;
  var price = ''.obs;
  var stockQuantity = ''.obs;
  var unit = ''.obs;
  var perUnitQuantity = ''.obs;
  var imageURL = ''.obs;
  var productVideo = ''.obs;
  var token = ''.obs;


  // Full product map (if needed)
  var productDetails = {}.obs;

  static const String baseUrl = 'https://admin.multiwebx.com/farmerAPI';
  Future<void> loadToken() async {
    final prefs = await SharedPreferences.getInstance();
    token.value = prefs.getString("auth_token") ?? "";

    if (token.value.isEmpty) {
      print("⚠️ Token not found in SharedPreferences.");
    } else {
      print("🔑 Loaded token: ${token.value}");
    }
  }
  /// Fetch product using default token and productId 35
  Future<void> initAndFetchProductDetails({String productId = "35"}) async {
    isLoading.value = true;
    await fetchProductDetails(token: token.value, productId: productId);
    isLoading.value = false;
  }

  /// Actual fetch logic
  Future<void> fetchProductDetails({
    required String token,
    required String productId,
  }) async {
    final url = Uri.parse("$baseUrl/farmerProductAPI/");

    try {
      final response = await http.post(
        url,
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
        },
        body: {
          "action": "getProduct",
          "productID": productId,
          "token": token,
        },
      );

      print("🌐 Status: ${response.statusCode}");
      print("📥 Body: ${response.body}");

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data["status"] == "success" && data.containsKey("data")) {
          final productData = data["data"];

          // Safely convert everything to string
          productID.value = productData["ProductID"]?.toString() ?? '';
          ProductName.value = productData["ProductName"]?.toString() ?? '';
          category.value = productData["Category"]?.toString() ?? '';
          description.value = productData["Description"]?.toString() ?? '';
          price.value = productData["Price"]?.toString() ?? '';
          stockQuantity.value = productData["StockQuantity"]?.toString() ?? '';
          unit.value = productData["Unit"]?.toString() ?? '';
          perUnitQuantity.value = productData["PerUnitQuantity"]?.toString() ?? '';
          imageURL.value = productData["ImageURL"]?.toString() ?? '';
          productVideo.value = productData["ProductVideo"]?.toString() ?? '';

          productDetails.value = productData;
        } else {
          Get.snackbar("Error", data["message"] ?? "Invalid response format");
        }
      } else {
        Get.snackbar("Error", "Failed to fetch product details");
      }
    } catch (e) {
      Get.snackbar("Exception", e.toString());
    }
  }
}
