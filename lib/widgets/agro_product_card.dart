import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_app/Controllers/agro_product_controller.dart';

import '../Agro/Screens/agro_to_farmer/agro_product_details.dart';
import '../Agro/model/agro_produ_model.dart';

class DrinkCardPageGrid extends StatelessWidget {
  final List<AgroProduct> products;

  const DrinkCardPageGrid({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    final controller = Get.put(AgroProductController());

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

          return GestureDetector(
            onTap: () {
              Get.to(() => ProductDetailsPage(product: product));
            },
            child: Container(
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Image section
                  ClipRRect(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
                    child: AspectRatio(
                      aspectRatio: 1.5,
                      child: Image.network(
                        product.imageUrl,
                        // "https://img.freepik.com/premium-photo/flax-seed-linseed-isolated-white-surface_256988-1126.jpg?w=900",
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => Icon(Icons.broken_image),
                      ),
                    ),
                  ),
                  // Info section
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.04, vertical: screenHeight * 0.015),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: screenWidth * 0.04,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.005),
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
                  Spacer(),
                  // Favorite icon
                  Padding(
                    padding: EdgeInsets.only(
                      right: screenWidth * 0.04,
                      bottom: screenHeight * 0.015,
                    ),
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: Container(
                        padding: EdgeInsets.all(screenWidth * 0.02),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                        child: Icon(Icons.favorite_border, color: Colors.red),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
