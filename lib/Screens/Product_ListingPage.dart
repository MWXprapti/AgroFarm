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
    return Padding(
      padding: const EdgeInsets.only(left: 8.0,right: 8,top: 20),
      child: GridView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 30,
          childAspectRatio: 0.8,
        ),
        itemCount: 6,
        itemBuilder: (context, index) {
          return Stack(
            clipBehavior: Clip.none,
            children: [
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: GestureDetector(
                  onTap: () {
                    Get.toNamed("/product");
                  },
                  child: Container(
                    height: 200,
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
                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text('White Chocolate Cappuccino', style: TextStyle(color: Colors.black87, fontSize: 18, fontWeight: FontWeight.bold)),
                        SizedBox(height: 10),
                        Text('', style: TextStyle(color: Colors.black54, fontSize: 14)),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                top: -35,
                left: 40,
                child: Image.asset(
                  'assets/fertilizer.png',
                  height: 170,
                  fit: BoxFit.contain,
                ),
              ),
              // Positioned(
              //   top: 40,
              //   left: 15,
              //   child: Row(
              //     children: [
              //       Icon(Icons.star, color: Colors.yellow, size: 18),
              //       SizedBox(width: 4),
              //       Text('7.8', style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold)),
              //     ],
              //   ),
              // ),
              Positioned(
                bottom: 20,
                right: 7,
                child: Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white),
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