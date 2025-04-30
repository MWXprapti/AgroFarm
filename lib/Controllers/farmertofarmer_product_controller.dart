import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:new_app/Agro/model/farmertofarmer_product_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FarmertoFarmerProductController extends GetxController {
  var productList = <FarmertoFarmerProduct>[].obs;
  var isLoading = false.obs;

  Future<void> fetchProducts({
    String? productName,
    String? location,
    String? category,
  }) async {
    isLoading.value = true;

    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token') ?? '';

    final dio = Dio();

    try {
      final Map<String, dynamic> requestData = {
        "action": "getAllProducts",
        "token": token,
        "ProductName": productName ?? "",
        "category": category ?? "",
        "Location": (location != null && location != "All") ? location : "",
      };

      print("📤 Sending request with data: $requestData");

      final response = await dio.post(
        "https://admin.multiwebx.com/farmerAPI/FarmertoFarmerProductListing/",
        options: Options(
          headers: {"Content-Type": "application/x-www-form-urlencoded"},
        ),
        data: requestData,
      );

      print("✅ Response status: ${response.statusCode}");
      print("📥 Response data: ${response.data}");

      if (response.statusCode == 200 && response.data['status'] == 'success') {
        final List products = response.data['data'];
        productList.value = products.map((e) => FarmertoFarmerProduct.fromJson(e)).toList();
      } else {
        productList.clear();
      }
    } catch (e) {
      print("❌ API error: $e");
      productList.clear();
    } finally {
      isLoading.value = false;
    }
  }

}
