import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Agro/Screens/FarmerToFarmer/own_ProductDetails.dart';

class ProductCard extends StatefulWidget {
  final String productId;
  final String imageUrl;
  final String videoUrl;
  final String name;
  final double price;
  final String description;
  final String category;
  final int stockQuantity;
  final String unit;
  final double perUnitQuantity;

  const ProductCard({
    Key? key,
    required this.productId,
    required this.imageUrl,
    required this.name,
    required this.price,
    required this.description,
    required this.category,
    required this.stockQuantity,
    required this.unit,
    required this.perUnitQuantity,
    required this.videoUrl,
  }) : super(key: key);

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () {
        Get.to(() => ProductDetailsPage(
          productId: widget.productId,
          productName: widget.name,
          imageUrl: widget.imageUrl,
          price: widget.price,
          description: widget.description,
          category: widget.category,
          stockQuantity: widget.stockQuantity,
          unit: widget.unit,
          perUnitQuantity: widget.perUnitQuantity, productVideo: widget.videoUrl,
        ));
      },
      child: LayoutBuilder(
        builder: (context, constraints) {
          double cardWidth = constraints.maxWidth * 0.95;
          double cardHeight = cardWidth * 1.3;
          double imageHeight = cardHeight * 1;

          return Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                width: cardWidth,
                height: cardHeight,
                padding: EdgeInsets.only(top: imageHeight * 0.6),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    )
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        widget.name,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: screenWidth * 0.042,
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        "₹${widget.price.toStringAsFixed(1)}",
                        style: TextStyle(
                          fontSize: screenWidth * 0.038,
                          color: Colors.black54,
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Padding(
                      padding: const EdgeInsets.only(left: 10, bottom: 10),
                      child: Text(
                        "Stock: ${widget.stockQuantity}",
                        style: TextStyle(
                          fontSize: screenWidth * 0.035,
                          fontWeight: FontWeight.bold,
                          color: widget.stockQuantity > 0 ? Colors.green : Colors.red,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: -imageHeight * 0.3,
                left: cardWidth * 0.25,
                right: cardWidth * 0.1,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(
                    widget.imageUrl,
                    height: imageHeight,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
