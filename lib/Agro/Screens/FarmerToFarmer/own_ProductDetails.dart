import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import '../../../Controllers/own_ProductController.dart';

class ProductDetailsPage extends StatefulWidget {
  final String productId;
  final String productName;
  final String imageUrl;
  final double price;
  final String description;
  final String category;
  final int stockQuantity;
  final String unit;
  final double perUnitQuantity;
  final String productVideo;  // Add product video URL

  const ProductDetailsPage({
    Key? key,
    required this.productId,
    required this.productName,
    required this.imageUrl,
    required this.price,
    required this.description,
    required this.category,
    required this.stockQuantity,
    required this.unit,
    required this.perUnitQuantity,
    required this.productVideo,  // Add product video URL here
  }) : super(key: key);

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  bool isExpanded = false;
  bool isEditTapped = false;
  bool isDeleteTapped = false;
  late VideoPlayerController _videoPlayerController;

  final OwnProductController controller = Get.find<OwnProductController>();

  @override
  void initState() {
    super.initState();
    if (widget.productVideo.isNotEmpty) {
      _videoPlayerController = VideoPlayerController.network(widget.productVideo)
        ..initialize().then((_) {
          setState(() {});
        });
    }
  }
  void _showEditDialog() {
    final TextEditingController productNameController = TextEditingController(text: widget.productName);
    final TextEditingController descriptionController = TextEditingController(text: widget.description);
    final TextEditingController priceController = TextEditingController(text: widget.price.toString());
    final TextEditingController stockQuantityController = TextEditingController(text: widget.stockQuantity.toString());
    final TextEditingController categoryController = TextEditingController(text: widget.category);
    final TextEditingController unitController = TextEditingController(text: widget.unit);
    final TextEditingController perUnitQuantityController = TextEditingController(text: widget.perUnitQuantity.toString());
    final TextEditingController imageUrlController = TextEditingController(text: widget.imageUrl);
    final TextEditingController productVideoController = TextEditingController(text: widget.productVideo);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Edit Product"),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: productNameController,
                decoration: const InputDecoration(labelText: "Product Name"),
              ),
              TextField(
                controller: descriptionController,
                decoration: const InputDecoration(labelText: "Description"),
                maxLines: 3,
              ),
              TextField(
                controller: priceController,
                decoration: const InputDecoration(labelText: "Price"),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: stockQuantityController,
                decoration: const InputDecoration(labelText: "Stock Quantity"),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: categoryController,
                decoration: const InputDecoration(labelText: "Category"),
              ),
              TextField(
                controller: unitController,
                decoration: const InputDecoration(labelText: "Unit"),
              ),
              TextField(
                controller: perUnitQuantityController,
                decoration: const InputDecoration(labelText: "Per Unit Quantity"),
                keyboardType: TextInputType.number,
              ),
              // TextField(
              //   controller: imageUrlController,
              //   decoration: const InputDecoration(labelText: "Image URL"),
              // ),
              // TextField(
              //   controller: productVideoController,
              //   decoration: const InputDecoration(labelText: "Product Video URL"),
              // ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () async {
              final updatedProductName = productNameController.text;
              final updatedDescription = descriptionController.text;
              final updatedPrice = double.tryParse(priceController.text) ?? widget.price;
              final updatedStockQuantity = int.tryParse(stockQuantityController.text) ?? widget.stockQuantity;
              final updatedCategory = categoryController.text;
              final updatedUnit = unitController.text;
              final updatedPerUnitQuantity = double.tryParse(perUnitQuantityController.text) ?? widget.perUnitQuantity;
              // final updatedImageUrl = imageUrlController.text;
              // final updatedProductVideo = productVideoController.text;

              // Call the controller to update the product
              controller.updateProduct(
                productId: widget.productId,
                productName: updatedProductName,
                category: updatedCategory,
                description: updatedDescription,
                price: updatedPrice,
                stockQuantity: updatedStockQuantity,
                unit: updatedUnit,
                perUnitQuantity: updatedPerUnitQuantity,
                // imageUrl: updatedImageUrl,
                // productVideo: updatedProductVideo,
              );
              Get.offAllNamed('/dashboard_farmer'); // Close the dialog
            },
            child: const Text("Update"),
          ),
        ],
      ),
    );
  }
  void _showDeleteDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: Text(
          "Delete Product",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.redAccent,
          ),
        ),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.delete_forever,
                color: Colors.redAccent,
                size: 50,
              ),
              SizedBox(height: 16),
              Text(
                "Are you sure you want to delete this product?",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16),
            ],
          ),
        ),
        actions: [
          // Cancel Button
          TextButton(
            onPressed: () {
              Get.back(); // Close the dialog
            },
            style: TextButton.styleFrom(
              primary: Colors.green,
              textStyle: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            child: Text("Cancel"),
          ),
          // Delete Button
          ElevatedButton(
            onPressed: () async {
              await controller.deleteProduct(widget.productId);
              Get.offAllNamed('/dashboard_farmer'); // Navigate to dashboard
            },
            style: ElevatedButton.styleFrom(
              primary: Colors.redAccent,
              onPrimary: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              elevation: 5,
            ),
            child: Text(
              "Delete",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }



  @override
  void dispose() {
    super.dispose();
    _videoPlayerController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.green.shade100,
      body: Column(
        children: [
          Stack(
            children: [
              AnimatedContainer(
                duration: const Duration(seconds: 1),
                height: screenHeight * 0.4,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.green.shade400, Colors.green.shade700],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                ),
              ),
              Positioned(
                top: screenHeight * 0.06,
                left: screenWidth * 0.05,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white, size: 30),
                  onPressed: () => Get.back(),
                ),
              ),
              Positioned(
                top: screenHeight * 0.12,
                left: screenWidth * 0.05,
                child: Text(
                  widget.productName,
                  style: TextStyle(
                    fontSize: screenWidth * 0.07,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              Positioned(
                top: screenHeight * 0.16,
                left: screenWidth * 0.05,
                child: Text(
                  widget.category,
                  style: TextStyle(
                    fontSize: screenWidth * 0.045,
                    color: Colors.white70,
                  ),
                ),
              ),
              Positioned(
                top: screenHeight * 0.2,
                left: screenWidth * 0.05,
                child: Text(
                  '₹${widget.price.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: screenWidth * 0.065,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              Positioned(
                top: screenHeight * 0.13,
                right: screenWidth * 0.05,
                child: Hero(
                  tag: widget.productId,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(
                      widget.imageUrl,
                      height: screenWidth * 0.4,
                      width: screenWidth * 0.4,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(screenWidth * 0.05),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Description",
                      style: TextStyle(
                        fontSize: screenWidth * 0.06,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.01),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isExpanded = !isExpanded;
                        });
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeInOut,
                        height: isExpanded ? null : screenHeight * 0.07,
                        child: Text(
                          widget.description,
                          style: TextStyle(
                            fontSize: screenWidth * 0.04,
                            color: Colors.black54,
                          ),
                          maxLines: isExpanded ? null : 2,
                          overflow: isExpanded ? TextOverflow.visible : TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.03),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildDetailCard("Stock", "${widget.stockQuantity}"),
                        _buildDetailCard("Unit", widget.unit),
                        _buildDetailCard("Per Unit", "${widget.perUnitQuantity} ${widget.unit}"),
                      ],
                    ),
                    SizedBox(height: screenHeight * 0.03),
                    // Display the Image URL
                    // widget.imageUrl.isNotEmpty
                    //     ? Column(
                    //   crossAxisAlignment: CrossAxisAlignment.start,
                    //   children: [
                    //     Text("Product Image", style: TextStyle(fontSize: screenWidth * 0.06, fontWeight: FontWeight.bold)),
                    //     SizedBox(height: screenHeight * 0.02),
                    //      Image.network(widget.imageUrl, height: screenHeight * 0.25, width: screenWidth, fit: BoxFit.cover),
                    //   ],
                    // )
                    //     : SizedBox.shrink(),
                    SizedBox(height: screenHeight * 0.03),
                    // Display the Product Video URL if available
                    // widget.productVideo.isNotEmpty
                    //     ? Column(
                    //   crossAxisAlignment: CrossAxisAlignment.start,
                    //   children: [
                    //     Text("Product Video", style: TextStyle(fontSize: screenWidth * 0.06, fontWeight: FontWeight.bold)),
                    //     SizedBox(height: screenHeight * 0.02),
                    //     _videoPlayerController.value.isInitialized
                    //         ? AspectRatio(
                    //       aspectRatio: _videoPlayerController.value.aspectRatio,
                    //       child: VideoPlayer(_videoPlayerController),
                    //     )
                    //         : Container(
                    //       height: screenHeight * 0.2,
                    //       child: Center(child: CircularProgressIndicator()),
                    //     ),
                    //     IconButton(
                    //       icon: Icon(
                    //         _videoPlayerController.value.isPlaying ? Icons.pause : Icons.play_arrow,
                    //         size: 40,
                    //         color: Colors.green,
                    //       ),
                    //       onPressed: () {
                    //         setState(() {
                    //           if (_videoPlayerController.value.isPlaying) {
                    //             _videoPlayerController.pause();
                    //           } else {
                    //             _videoPlayerController.play();
                    //           }
                    //         });
                    //       },
                    //     ),
                    //   ],
                    // )
                    //     : SizedBox.shrink(),
                    SizedBox(height: screenHeight * 0.1),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildActionButton(
                          icon: Icons.edit,
                          label: "Edit",
                          color: Colors.amber,
                          onTap: () {
                            // TODO: Implement Edit functionality later
                            _showEditDialog();
                          },
                          isTapped: isEditTapped,
                          setTapped: (value) => setState(() => isEditTapped = value),
                        ),
                        SizedBox(width: screenWidth * 0.08),
                        _buildActionButton(
                          icon: Icons.delete,
                          label: "Delete",
                          color: Colors.redAccent,
                          onTap: () async {
                            _showDeleteDialog();
                          },
                          isTapped: isDeleteTapped,
                          setTapped: (value) => setState(() => isDeleteTapped = value),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailCard(String title, String value) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.28,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.green.shade50,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [const BoxShadow(color: Colors.black12, blurRadius: 4)],
      ),
      child: Column(
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 14, color: Colors.black54),
          ),
          const SizedBox(height: 5),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.green,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
    required bool isTapped,
    required Function(bool) setTapped,
  }) {
    return GestureDetector(
      onTapDown: (_) => setTapped(true),
      onTapUp: (_) => Future.delayed(const Duration(milliseconds: 200), () => setTapped(false)),
      onTapCancel: () => setTapped(false),
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.08,
          vertical: MediaQuery.of(context).size.height * 0.015,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(colors: [color.withOpacity(0.8), color]),
        ),
        transform: Matrix4.identity()..scale(isTapped ? 0.92 : 1.0),
        child: Row(
          children: [
            Icon(icon, color: Colors.white, size: 24),
            const SizedBox(width: 10),
            Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
