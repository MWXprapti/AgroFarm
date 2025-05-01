import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';
import 'package:new_app/Controllers/farmerProfileFetch_Controller.dart';
import 'package:new_app/Controllers/own_ProductController.dart';
import 'package:new_app/theme/theme.dart';
import 'package:shimmer/shimmer.dart';
import 'package:new_app/Theme/build_card.dart'; // Your ProductCard

class Farm_Dashboard extends StatefulWidget {
  const Farm_Dashboard({super.key});

  @override
  State<Farm_Dashboard> createState() => _Farm_DashboardState();
}

class _Farm_DashboardState extends State<Farm_Dashboard> {
  final OwnProductController controller = Get.put(OwnProductController());
  String? username;
  final FarmerProfileFetchController controller_ = Get.put(FarmerProfileFetchController());

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: AppColors.lightgreen,
    ));
    controller.fetchProducts(); // Fetch products
    controller_.fetchFarmerDetails();
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppColors.bgcolor,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 80),
        child: FloatingActionButton(
          backgroundColor: AppColors.lightgreen,
          onPressed: () {
            Get.toNamed("/add");
          },
          child: Icon(Icons.add, color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          width: w,
          height: h,
          child: Stack(
            children: [
              _buildTopSection(h, w),
              _buildStatisticsCard(h, w),
              _buildProductGridView(h, w),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTopSection(double h, double w) {
    return Container(
      height: h * 0.28,
      width: w,
      decoration: BoxDecoration(
        color: AppColors.lightgreen,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(40),
          bottomRight: Radius.circular(40),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.only(top: h * 0.05, left: w * 0.08),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Text(
              "Farmer \nDashboard",
              style: GoogleFonts.poppins(
                fontSize: w * 0.045,
                fontWeight: FontWeight.w400,
                color: Colors.white70,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatisticsCard(double h, double w) {
    return Positioned(
      top: h * 0.20,
      left: w * 0.05,
      right: w * 0.05,
      child: Container(
        padding: EdgeInsets.all(w * 0.03),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.green.shade600, Colors.green.shade900],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(w * 0.07),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 12,
              spreadRadius: 3,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildStatsCard("Total Products", Icons.inventory_2_rounded, "${controller.productList.length}", w),
            _buildStatsCard("Total Orders", Icons.shopping_cart_rounded, "10", w),
          ],
        ),
      ),
    );
  }

  Widget _buildStatsCard(String title, IconData icon, String value, double w) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: w * 0.02),
        padding: EdgeInsets.all(w * 0.04),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(w * 0.05),
          color: Colors.white.withOpacity(0.2),
          border: Border.all(color: Colors.white.withOpacity(0.3), width: 1),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: w * 0.12, color: Colors.white),
            SizedBox(height: w * 0.02),
            Text(title.tr,
              style: GoogleFonts.poppins(
                fontSize: w * 0.035,
                fontWeight: FontWeight.w500,
                color: Colors.white70,
              ),
            ),
            SizedBox(height: w * 0.01),
            Text(value,
              style: GoogleFonts.poppins(
                fontSize: w * 0.07,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProductGridView(double h, double w) {
    return Positioned(
      top: h * 0.45,
      left: w * 0.05,
      right: w * 0.05,
      bottom: 0,
      child: Obx(() {
        if (controller.isLoading.value) {
          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: w > 600 ? 3 : 2,
              crossAxisSpacing: w * 0.04,
              mainAxisSpacing: w * 0.04,
              childAspectRatio: 0.75,
            ),
            itemCount: 6,
            itemBuilder: (context, index) => _shimmerEffect(w),
          );
        } else {
          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: w > 600 ? 3 : 2,
              crossAxisSpacing: w * 0.04,
              mainAxisSpacing: w * 0.04,
              childAspectRatio: 0.75,
            ),
            itemCount: controller.productList.length,
            itemBuilder: (context, index) {
              final product = controller.productList[index];
              return ProductCard(
                productId: product["ProductID"].toString(),
                imageUrl: product["ImageURL"] ?? '',
                name: product["ProductName"] ?? 'No Name',
                price: double.tryParse(product["Price"].toString()) ?? 0.0,
                description: product["Description"] ?? '',
                category: product["Category"] ?? '',
                stockQuantity: int.tryParse(product["StockQuantity"].toString()) ?? 0,
                unit: product["Unit"] ?? '',
                perUnitQuantity: double.tryParse(product["PerUnitQuantity"].toString()) ?? 0.0,
                videoUrl: product["productVideo"] ?? '',
              );
            },
          );
        }
      }),
    );
  }

  Widget _shimmerEffect(double w) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
