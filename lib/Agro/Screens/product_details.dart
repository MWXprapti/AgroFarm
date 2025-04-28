import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_app/Controllers/ProductFetchController.dart';
import 'package:new_app/Theme/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductDetails extends StatefulWidget {
  final String productId;

  const ProductDetails({super.key, required this.productId});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  final ProductFetchController productFetchController = Get.put(ProductFetchController());
  final int _rating = 4; // You can later replace it with dynamic value from fetched data

  @override
  @override
  @override
  void initState() {
    super.initState();
    productFetchController.initAndFetchProductDetails();
  }




  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (productFetchController.isLoading.value) {
        return const Scaffold(
          body: Center(child: CircularProgressIndicator()),
        );
      }

      if (productFetchController.errorMessage.isNotEmpty) {
        return Scaffold(
          body: Center(child: Text(productFetchController.errorMessage.value)),
        );
      }

      var product = productFetchController.productDetails;
      return SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 3, right: 3),
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Positioned(
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.35,
                          decoration: BoxDecoration(
                            color: AppColors.lightgreen,
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(200),
                              bottomRight: Radius.circular(200),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.5),
                                blurRadius: 10,
                                offset: const Offset(4, 4),
                              ),
                            ],
                            image: const DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage('assets/detail_bg.png'),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: MediaQuery.of(context).size.height * 0.15,
                        left: MediaQuery.of(context).size.width * 0.16,
                        child: Image.asset(
                          'assets/fertilizer.png',
                          height: 250,
                          fit: BoxFit.contain,
                        ),
                      ),
                      Positioned(
                        top: 15,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                height: 40,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                ),
                                child: Center(
                                  child: IconButton(
                                    onPressed: () => Get.back(),
                                    icon: Icon(Icons.arrow_back_ios_new, color: AppColors.lightgreen, size: 20),
                                  ),
                                ),
                              ),
                              SizedBox(width: MediaQuery.of(context).size.width * 0.65),
                              const Icon(Icons.menu, color: Colors.white),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.13),
                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 50),
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product['ProductName']?.toString() ?? 'Product Name',
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 30, color: Colors.black),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            product['Category'] ?? 'Brand Name',
                            style: const TextStyle(fontSize: 20, color: Colors.black),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Column(
                        children: [
                          Text(
                            "₹${product['Price']?.toString() ?? '0'}",
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40, color: AppColors.yellow),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    children: [
                      ElevatedButton(
                        onPressed: _showRatingDialog,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.lightgreen,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                          textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        child: const Text("Give your review"),
                      ),
                      const Spacer(),
                      Text(
                        product['rating']?.toString() ?? '4',
                        style: const TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(width: 5),
                      Row(
                        children: List.generate(5, (index) {
                          return Icon(
                            Icons.star,
                            color: (index + 1) <= _rating ? Colors.yellow : Colors.grey,
                            size: 20,
                          );
                        }),
                      ),
                    ],
                  ),
                ),
                _buildSection("Description"),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    product['Description']?.toString() ?? 'No description provided.',
                    style: const TextStyle(fontSize: 20, color: Colors.black),
                  ),
                ),
                _buildSection("Seller Details"),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    "Name : ${product['seller_name']?.toString() ?? 'XYZ'}",
                    style: const TextStyle(fontSize: 20, color: Colors.black),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      Text(
                        "Number: ${product['seller_number']?.toString() ?? '88xxxxx25'}",
                        style: const TextStyle(fontSize: 20, color: Colors.black),
                      ),
                      const SizedBox(width: 20),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              blurRadius: 10,
                              offset: const Offset(4, 4),
                            ),
                          ],
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            "Call button",
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    "City : ${product['city']?.toString() ?? 'Junagadh'}",
                    style: const TextStyle(fontSize: 20, color: Colors.black),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0, bottom: 30, left: 10),
                  child: Text(
                    "Address: ${product['address']?.toString() ?? 'Raddha Nagar Society, near Girnar Gate'}",
                    style: const TextStyle(fontSize: 20, color: Colors.black),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget _buildSection(String title) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.yellow,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(color: Colors.grey.withOpacity(0.5), blurRadius: 10, offset: const Offset(4, 4)),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),
          ),
        ),
      ),
    );
  }

  void _showRatingDialog() {
    int selectedRating = 0;
    TextEditingController reviewController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: const Center(child: Text("Give your Review")),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(5, (index) {
                      return IconButton(
                        onPressed: () => setDialogState(() => selectedRating = index + 1),
                        icon: Icon(Icons.star, color: (index + 1) <= selectedRating ? Colors.yellow : Colors.grey),
                      );
                    }),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: reviewController,
                    maxLines: 3,
                    decoration: const InputDecoration(
                      hintText: "Write your review...",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ],
              ),
              actions: [
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: () => Get.back(),
                        child: const Text("Cancel", style: TextStyle(color: Colors.black)),
                      ),
                    ),
                    Expanded(
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll(AppColors.olive),
                        ),
                        onPressed: () {
                          Get.back();
                          Get.snackbar(
                            "Thank You!",
                            "You rated $selectedRating stars.\nReview: ${reviewController.text.trim().isEmpty ? 'No review provided.' : reviewController.text}",
                            snackPosition: SnackPosition.TOP,
                          );
                        },
                        child: const Text("Submit"),
                      ),
                    ),
                  ],
                )
              ],
            );
          },
        );
      },
    );
  }
}
