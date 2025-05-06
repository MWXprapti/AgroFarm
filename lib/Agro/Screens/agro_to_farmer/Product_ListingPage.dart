import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:new_app/theme/theme.dart';

import '../../../Controllers/agro_product_controller.dart';
import 'agro_product_details.dart';

class ProductListing extends StatefulWidget {
  const ProductListing({super.key});

  @override
  State<ProductListing> createState() => _ProductListingState();
}

class _ProductListingState extends State<ProductListing> {
  final controller = Get.put(AgroProductController());
  String selectedLocation = "All";
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    controller.fetchProducts(); // Initial load
  }

  void _applyFilters() {
    controller.fetchProducts(
      productName: searchController.text,
      location: selectedLocation,
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppColors.bgcolor,
      appBar: AppBar(
        title: const Text("Agro Products"),
        backgroundColor: AppColors.lightgreen,
        titleTextStyle: GoogleFonts.poppins(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding:
        EdgeInsets.symmetric(horizontal: screenWidth * 0.03, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Field and Location Dropdown
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Search Field
                Expanded(
                  flex: 6,
                  child: Container(
                    padding:
                    EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextField(
                      controller: searchController,
                      decoration: const InputDecoration(
                        hintText: "Search Products...",
                        border: InputBorder.none,
                        icon: Icon(Icons.search, color: Colors.black),
                      ),
                      onChanged: (value) => _applyFilters(),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                // Location Dropdown
                Expanded(
                  flex: 4,
                  child: Container(
                    padding:
                    EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: DropdownButton<String>(
                      value: selectedLocation,
                      icon:
                      const Icon(Icons.arrow_drop_down, color: Colors.black),
                      underline: const SizedBox(),
                      isExpanded: true,
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedLocation = newValue!;
                        });
                        _applyFilters();
                      },
                      items: <String>['All', 'Surat', 'Ahmedabad', 'Vadodara']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: screenHeight * 0.02),

            // Product Grid View
            Expanded(
              child: Obx(() {
                if (controller.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (controller.productList.isEmpty) {
                  return const Center(child: Text("No products found."));
                }

                return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: screenWidth > 600 ? 3 : 2,
                    crossAxisSpacing: screenWidth * 0.04,
                    mainAxisSpacing: screenHeight * 0.03,
                    childAspectRatio: 0.7,
                  ),
                  itemCount: controller.productList.length,
                  itemBuilder: (context, index) {
                    final product = controller.productList[index];
                    return GestureDetector(
                      onTap: () =>
                          Get.to(() => ProductDetailsPage(product: product)),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        elevation: 4,
                        color: Colors.white,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(20)),
                              child: Image.network(
                                product.imageUrl,
                                height: screenHeight * 0.18,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                product.name,
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.bold,
                                  fontSize: screenWidth * 0.04,
                                  color: AppColors.textColor,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0, vertical: 2),
                              child: Text(
                                product.description,
                                style: GoogleFonts.poppins(
                                  color: Colors.grey.shade600,
                                  fontSize: screenWidth * 0.035,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
