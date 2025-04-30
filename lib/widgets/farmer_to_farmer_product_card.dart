import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_app/Agro/Screens/FarmerToFarmer/FarmertoFarmer_product_details.dart';
import 'package:new_app/Agro/model/farmertofarmer_product_model.dart';
import 'package:new_app/Controllers/farmertofarmer_product_controller.dart';

import '../Agro/model/agro_produ_model.dart';

class FTOF_DrinkCardPageGrid extends StatelessWidget {
  final List<FarmertoFarmerProduct> products;

  const FTOF_DrinkCardPageGrid({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    final controller = Get.put(FarmertoFarmerProductController());


    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.03, vertical: 10),
      child: GridView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: products.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: screenWidth > 600 ? 3 : 2,
          crossAxisSpacing: screenWidth * 0.04,
          mainAxisSpacing: screenHeight * 0.03,
          childAspectRatio: 0.7,
        ),
        itemBuilder: (context, index) {
          final product = controller.productList[index];

          return Stack(
            clipBehavior: Clip.none,
            children: [
              Positioned(
                bottom: screenHeight * 0.02,
                left: 0,
                right: 0,
                child: GestureDetector(
                  onTap: () {
                     Get.to(() => FarmertoFarmer_ProductDetailsPage(product: product));
                  },
                  child: Container(
                    height: screenHeight * 0.22,
                    decoration: BoxDecoration(
                      color: Colors.green.shade50,
                      borderRadius: BorderRadius.circular(25),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.4),
                          blurRadius: 10,
                          offset: Offset(4, 4),
                        ),
                      ],
                    ),
                    padding: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.04, vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
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
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                top: -screenHeight * 0.01,
                left: screenWidth * 0.08,
                child: Image.network(
                  product.imageUrl,
                  height: screenHeight * 0.18,
                  fit: BoxFit.contain,
                  errorBuilder: (_, __, ___) => Icon(Icons.broken_image),
                ),
              ),
              Positioned(
                bottom: screenHeight * 0.02,
                right: screenWidth * 0.02,
                child: Container(
                  padding: EdgeInsets.all(screenWidth * 0.02),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  child: Icon(Icons.favorite_border, color: Colors.red),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
