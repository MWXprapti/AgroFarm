import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:new_app/Controllers/Product_Controller.dart';
import 'package:new_app/Theme/preBuild_widget.dart';
import 'package:new_app/Theme/theme.dart';



class AddProductPage extends StatefulWidget {
  @override
  _AddProductPageState createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final ProductController controller = Get.put(ProductController());

  var selectedCategory = "Herbicides".obs;
  var selectedUnit = "Kg".obs;
  var imageFile = Rx<File?>(null);
  var currentStep = 0.obs;

  Future<void> pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      imageFile.value = File(pickedFile.path);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.lightgreen,
        title: Text(
          "Farmer to Farmer product Upload page",
          style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: Obx(() => Column(
        children: [
          // Custom Progress Bar
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(3, (index) =>
                      Column(
                        children: [
                          Text("${index + 1}",
                            style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: currentStep.value == index ? AppColors.yellow : Colors.grey
                            ),
                          ),
                          Text(
                            ["Details", "Pricing", "Image"][index],
                            style: GoogleFonts.poppins(
                                fontSize: 14,
                                color: currentStep.value == index ? AppColors.yellow : Colors.grey
                            ),
                          ),
                        ],
                      ),
                  ),
                ),
                SizedBox(height: 10),
                Stack(
                  children: [
                    Container(
                      height: 10,
                      width: MediaQuery.of(context).size.width*0.85,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    AnimatedContainer(
                      duration: Duration(milliseconds: 900),
                      height: 10,
                      width: MediaQuery.of(context).size.width*0.85 * (currentStep.value / 2),
                      decoration: BoxDecoration(
                        color: AppColors.yellow,
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 15,right: 15),
              child: Column(
                children: [
                  if (currentStep.value == 0) ...[
                    buildTextField(controller.productNameController, "Product Name", Icons.shopping_bag),
                    buildDropdown(controller.selectedCategory, "Category", [
                      "Herbicides",
                      "Growth Promoters",
                      "Fungicides",
                      "Vegetable & Fruits seeds",
                      "Farm Machinery",
                      "Nutrients",
                      "Flower seeds",
                      "Insecticides",
                      "Organic farming",
                      "Animal husbandry"
                    ],Icons.category_outlined), // Use the Bottom Sheet for category selection
                    buildTextField(controller.descriptionController, "Description", Icons.description, isMultiline: true),
                  ] else if (currentStep.value == 1) ...[
                    buildTextField(controller.priceController, "Price (₹)", Icons.attach_money, isNumber: true),
                    buildTextField(controller.stockQuantityController, "Stock Quantity", Icons.storage, isNumber: true),
                    buildDropdown(controller.selectedUnit, "Unit", ["Kg", "Litre", "Packet", "Piece"],Icons.ad_units_outlined),
                    buildTextField(controller.perUnitQuantityController, "Per Unit Quantity", Icons.balance, isNumber: true),
                  ] else ...[
                    GestureDetector(
                      onTap: controller.pickImage,
                      child: Obx(() => Container(
                        width: double.infinity,
                        height: 150,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.black26),
                        ),
                        child: controller.imageFile.value == null
                            ? Center(child: Text("Tap to select image", style: GoogleFonts.poppins(color: Colors.grey)))
                            : ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.file(controller.imageFile.value!, fit: BoxFit.cover),
                        ),
                      )),
                    ),
                  ],
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (currentStep.value > 0)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 80),
                    child: TextButton(
                      onPressed: () => currentStep.value--,
                      child: Text("Back", style: GoogleFonts.poppins(fontSize: 16, color: Colors.grey)),
                    ),
                  ),
                if (currentStep.value < 2)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 80),
                    child: ElevatedButton(
                      onPressed: () => currentStep.value++,
                      child: Text("Next", style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.yellow,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      ),
                    ),
                  )
                else
                  Padding(
                    padding: const EdgeInsets.only(bottom: 80),
                    child: ElevatedButton(
                      onPressed: () async {
                        await controller.uploadProduct();
                      },
                      child: Obx(() => controller.isUploading.value
                          ? CircularProgressIndicator(color: Colors.white) // Show loading indicator
                          : Text("Submit", style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold))),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.yellow,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
      ),
    );
  }
}