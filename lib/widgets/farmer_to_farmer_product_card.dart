import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// MODEL
class FarmertoFarmerProduct {
  final String productName;
  final String category;
  final String productImage;

  FarmertoFarmerProduct({
    required this.productName,
    required this.category,
    required this.productImage,
  });

  factory FarmertoFarmerProduct.fromJson(Map<String, dynamic> json) {
    return FarmertoFarmerProduct(
      productName: json['ProductName'] ?? '',
      category: json['category'] ?? '',
      productImage: json['ProductImage'] ?? '',
    );
  }
}

/// CONTROLLER
class FarmertoFarmer_ProductController extends GetxController {
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

      final response = await dio.post(
        "https://admin.multiwebx.com/farmerAPI/FarmertoFarmerProductListing/",
        options: Options(
          headers: {"Content-Type": "application/x-www-form-urlencoded"},
        ),
        data: requestData,
      );

      if (response.statusCode == 200 && response.data['status'] == 'success') {
        final List products = response.data['data'];
        productList.value = products
            .map((e) => FarmertoFarmerProduct.fromJson(e))
            .toList();
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

/// UI WIDGET
class FTOF_DrinkCardPageGrid extends StatelessWidget {
  const FTOF_DrinkCardPageGrid({super.key, required List<FarmertoFarmerProduct> products});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FarmertoFarmer_ProductController());
    controller.fetchProducts();

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      if (controller.productList.isEmpty) {
        return const Center(child: Text("No products available"));
      }

      return Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.03, vertical: 10),
        child: GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: controller.productList.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: screenWidth > 600 ? 3 : 2,
            crossAxisSpacing: screenWidth * 0.04,
            mainAxisSpacing: screenHeight * 0.03,
            childAspectRatio: 0.7,
          ),
          itemBuilder: (context, index) {
            final product = controller.productList[index];

            return GestureDetector(
              onTap: () {
                // Navigate to details if needed
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.green.shade50,
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.4),
                      blurRadius: 10,
                      offset: const Offset(4, 4),
                    ),
                  ],
                ),
                padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.03, vertical: screenHeight * 0.015),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.network(
                          product.productImage.isNotEmpty
                              ? product.productImage
                              : "https://via.placeholder.com/150",
                          height: screenHeight * 0.15,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) =>
                          const Icon(Icons.broken_image, size: 50),
                        ),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    Text(
                      product.productName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: screenWidth * 0.04,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.008),
                    Text(
                      product.category,
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: screenWidth * 0.035,
                      ),
                    ),
                    const Spacer(),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Container(
                        padding: EdgeInsets.all(screenWidth * 0.02),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                        child: const Icon(Icons.favorite_border, color: Colors.red),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      );
    });
  }
}
