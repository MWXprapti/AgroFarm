import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'theme.dart';
Widget buildTextField(TextEditingController controller, String label, IconData icon, {bool isNumber = false, bool isMultiline = false}) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      // boxShadow: [
      //   BoxShadow(color: Colors.black26, blurRadius: 8, offset: Offset(4, 4)),
      //   BoxShadow(color: Colors.white, blurRadius: 8, offset: Offset(-4, -4)),
      // ],
    ),
    padding: EdgeInsets.symmetric(horizontal: 16),
    child: TextFormField(
      controller: controller,
      keyboardType: isNumber ? TextInputType.number : TextInputType.text,
      maxLines: isMultiline ? 3 : 1,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.black),
        border: InputBorder.none,
        prefixIcon: Icon(icon, color: AppColors.lightgreen),
      ),
      style: TextStyle(color: Colors.black),
    ),
  );
}

Widget buildDropdown(RxString selectedValue, String label, List<String> items,IconData icon) {
  return GestureDetector(
    onTap: () {
      // Show Bottom Sheet when tapped
      Get.bottomSheet(
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),

          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold,color: Colors.black),
              ),

              SizedBox(height: 8),
              Expanded(
                child: ListView(
                  children: items.map((item) {
                    return ListTile(
                      title: Text(item),
                      onTap: () {
                        selectedValue.value = item;
                        Get.back(); // Close the bottom sheet
                      },
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      );
    },
    child: Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      padding: EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        // boxShadow: [
        //   BoxShadow(color: Colors.black26, blurRadius: 8, offset: Offset(4, 4)),
        //   BoxShadow(color: Colors.white, blurRadius: 8, offset: Offset(-4, -4)),
        // ],
      ),
      child: Obx(() {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 14),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Icon(Icons.category_outlined, color: AppColors.lightgreen),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    selectedValue.value,
                    style: GoogleFonts.poppins(color: Colors.black, fontSize: 16),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    ),
  );
}

Widget buildSubmitButton(String text, VoidCallback onPressed) {
  return Container(
    width: double.infinity,
    height: 50,
    decoration: BoxDecoration(
      color: AppColors.lightgreen,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(color: Colors.black26, blurRadius: 8, offset: Offset(4, 4)),
        BoxShadow(color: Colors.white, blurRadius: 8, offset: Offset(-4, -4)),
      ],
    ),
    child: TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(padding: EdgeInsets.symmetric(vertical: 16)),
      child: Text(text, style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15)),
    ),
  );
}