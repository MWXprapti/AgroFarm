import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_app/Agro/model/farmertofarmer_product_model.dart';
import 'package:new_app/Theme/theme.dart';


class FarmertoFarmer_ProductDetailsPage extends StatelessWidget {
  final FarmertoFarmerProduct product;

  const FarmertoFarmer_ProductDetailsPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.productName),
        backgroundColor: AppColors.lightgreen, // Adjust color if needed
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hero Image Section
            Container(
              height: MediaQuery.of(context).size.height * 0.35,
              decoration: BoxDecoration(
                color: AppColors.lightgreen,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(200),
                  bottomRight: Radius.circular(200),
                ),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(product.imageUrl),
                ),
              ),
            ),
            const SizedBox(height: 30),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                children: [
                  // Product Name and Category
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.productName,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        product.category,
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  // Price
                  Column(
                    children: [
                      Text(
                        "₹${product.price}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 40,
                          color: Colors.green,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Description Section
            Padding(
              padding: const EdgeInsets.all(15),
              child: Text(
                product.description,
                style: const TextStyle(fontSize: 18, color: Colors.black),
              ),
            ),
            const SizedBox(height: 20),

            // Seller Details Section
            _buildSectionTitle("Seller Details"),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Text(
                  //   "Name: ${product.name}",
                  //   style: const TextStyle(fontSize: 18, color: Colors.black),
                  // ),
                  // Text(
                  //   "Phone: ${product.mobile}",
                  //   style: const TextStyle(fontSize: 18, color: Colors.black),
                  // ),
                  // Text(
                  //   "Location: ${product.city}",
                  //   style: const TextStyle(fontSize: 18, color: Colors.black),
                  // ),
                ],
              ),
            ),
            const SizedBox(height: 30),

            // Call to Action (Optional: Add Cart or Contact Button)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // Add to Cart functionality or direct contact
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    ),
                    child: const Text("Contact Seller"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.green,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(color: Colors.grey.withOpacity(0.5), blurRadius: 10),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
