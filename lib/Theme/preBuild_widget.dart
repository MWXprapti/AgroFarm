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

Widget buildDropdown(
    RxString selectedValue,
    String label,
    List<String> items,
    IconData icon, {
      void Function(String)? onChanged,
    }) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        label,
        style: GoogleFonts.poppins(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: Colors.grey.shade700,
        ),
      ),
      const SizedBox(height: 6),
      GestureDetector(
        onTap: () {
          Get.bottomSheet(
            Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
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
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Expanded(
                    child: ListView(
                      children: items.map((item) {
                        return ListTile(
                          title: Text(item),
                          onTap: () {
                            selectedValue.value = item;
                            if (onChanged != null) {
                              onChanged(item);
                            }
                            Get.back();
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
          margin: const EdgeInsets.symmetric(vertical: 8),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: Colors.grey.shade400,
              width: 1.2,
            ),
          ),
          child: Obx(() {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 14),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 5, right: 10),
                    child: Icon(icon, color: Colors.green.shade600),
                  ),
                  Expanded(
                    child: Text(
                      selectedValue.value.isEmpty
                          ? "Select $label"
                          : selectedValue.value,
                      style: GoogleFonts.poppins(
                        color: selectedValue.value.isEmpty
                            ? Colors.grey
                            : Colors.black,
                        fontSize: 16,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const Icon(Icons.arrow_drop_down, color: Colors.grey),
                ],
              ),
            );
          }),
        ),
      ),
    ],
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