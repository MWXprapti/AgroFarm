import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductListing extends StatefulWidget {
  const ProductListing({super.key});

  @override
  State<ProductListing> createState() => _ProductListingState();
}



class _ProductListingState extends State<ProductListing> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:DrinkCardPageGrid(),

    );
  }
}
class DrinkCardPageGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.03, vertical: 10),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: screenWidth > 600 ? 3 : 2,
              crossAxisSpacing: screenWidth * 0.04,
              mainAxisSpacing: screenHeight * 0.03,
              childAspectRatio: 0.7,
            ),
            itemCount: 6,
            itemBuilder: (context, index) {
              return Stack(
                clipBehavior: Clip.none,
                children: [
                  Positioned(
                    bottom: screenHeight * 0.02,
                    left: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: () {
                        Get.toNamed("product");
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
                              'White Chocolate Cappuccino',
                              style: TextStyle(
                                color: Colors.black87,
                                fontSize: screenWidth * 0.04, // Responsive text
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: screenHeight * 0.008),
                            Text(
                              'Delicious & creamy',
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: screenWidth * 0.035, // Responsive text
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
                    child: Image.asset(
                      'assets/fertilizer.png',
                      height: screenHeight * 0.18,
                      fit: BoxFit.contain,
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
          );
        },
      ),
    );
  }
}
