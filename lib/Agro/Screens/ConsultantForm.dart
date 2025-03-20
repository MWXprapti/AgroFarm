import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:new_app/Theme/preBuild_widget.dart';
import '../../theme/theme.dart';

class consultantProfileForm extends StatefulWidget {
  final String uid;
  consultantProfileForm({required this.uid});

  @override
  State<consultantProfileForm> createState() => _consultantProfileFormState();
}

class _consultantProfileFormState extends State<consultantProfileForm> {


  TextEditingController fullNameController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController gstController = TextEditingController();
  TextEditingController businessNameController = TextEditingController();
  TextEditingController firmNameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController authorizedRepController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController pincodeController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController dobController = TextEditingController();

  var fertilizerImage = ''.obs;
  var pesticideImage = ''.obs;
  var seedsImage = ''.obs;


  final picker = ImagePicker();
  Future<void> pickImage(ImageSource source, RxString imageVariable) async {
    final pickedFile = await picker.pickImage(source: source);
    if (pickedFile != null) {
      imageVariable.value = pickedFile.path; // Store the file path in RxString
    }
  }

  @override
  void dispose() {
    fullNameController.dispose();
    usernameController.dispose();
    gstController.dispose();
    businessNameController.dispose();
    phoneController.dispose();
    pincodeController.dispose();
    stateController.dispose();
    cityController.dispose();
    super.dispose();
  }

  // Method to upload data to Firestore
  void saveUserDetails() async {
    if (fullNameController.text.trim().isEmpty ||
        businessNameController.text.trim().isEmpty ||
        phoneController.text.trim().isEmpty ||
        stateController.text.trim().isEmpty ||
        cityController.text.trim().isEmpty ||
        gstController.text.trim().isEmpty ||
        usernameController.text.trim().isEmpty ||
        pincodeController.text.trim().isEmpty) {
      Get.snackbar("Error", "All fields are required!",
          backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }

    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      Get.snackbar("Error", "User not authenticated!",
          backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }

    try {
      Get.dialog(Center(child: CircularProgressIndicator()), barrierDismissible: false);

      await FirebaseFirestore.instance.collection("users_agro").doc(widget.uid).set({
        "uid": widget.uid,
        "fullName": fullNameController.text.trim(),
        "username": usernameController.text.trim(),
        "gst": gstController.text.trim(),
        "businessName": businessNameController.text.trim(),
        "email": user.email, // Get email safely
        "phone": phoneController.text.trim(),
        "state": stateController.text.trim(),
        "city": cityController.text.trim(),
        "pincode": pincodeController.text.trim(),
        "createdAt": FieldValue.serverTimestamp(), // Add Timestamp
      });

      Get.back(); // Close loading dialog

      // Show success message & navigate to home
      Get.snackbar("Success", "Profile Updated", backgroundColor: Colors.green, colorText: Colors.white);
      Get.offAllNamed("/home"); // Redirect to home

    } catch (e) {
      Get.back(); // Close loading dialog if error occurs
      print("Error saving details: $e");
      Get.snackbar("Error", "Failed to save user details",
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppColors.lightgreen,
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 100),
              child: Container(
                width: w,
                height: h,
                decoration: BoxDecoration(
                  color: AppColors.bgcolor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 50),
                  child: Container(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 5, left: 20, right: 20),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Consultant",
                                  style: GoogleFonts.poppins(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.lightgreen,
                                  ),
                                ),
                                SizedBox(width: 5),
                                Text(" Profile Form", style: AppTextStyles.headingStyle),
                              ],
                            ),
                            SizedBox(height: 40),

                            /// Using buildTextField function
                            buildTextField(fullNameController, "Full Name", Icons.person),
                            buildTextField(usernameController, "User Name", Icons.person),
                            buildTextField(gstController, "GST Number", Icons.confirmation_number),
                            buildTextField(businessNameController, "Business Name", Icons.business),
                            buildTextField(firmNameController, "Firm Name", Icons.apartment),
                            buildTextField(addressController, "Address", Icons.location_on, isMultiline: true),
                            buildTextField(authorizedRepController, "Authorized Representative", Icons.badge),
                            buildTextField(phoneController, "Phone Number", Icons.phone, isNumber: true),
                            buildTextField(pincodeController, "Pincode", Icons.location_pin, isNumber: true),
                            buildTextField(stateController, "State", Icons.map),
                            buildTextField(cityController, "City", Icons.location_city),

                            /// Date of Birth Picker
                            GestureDetector(
                              onTap: () async {
                                DateTime? pickedDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(1900),
                                  lastDate: DateTime.now(),
                                );
                                if (pickedDate != null) {
                                  dobController.text = pickedDate.toLocal().toString().split(' ')[0];
                                }
                              },
                              child: AbsorbPointer(
                                child: buildTextField(dobController, "Date of Birth", Icons.calendar_today),
                              ),
                            ),

                            // SizedBox(height: 30),
                            //
                            // /// Image Uploaders
                            // buildImageUploader("Upload Fertilizer license Image", fertilizerImage),
                            // buildImageUploader("Upload Pesticide license Image", pesticideImage),
                            // buildImageUploader("Upload Seeds license Image", seedsImage),

                            SizedBox(height: 50),

                            /// Submit Button
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * 0.07,
                              decoration: BoxDecoration(
                                color: AppColors.yellow,
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(color: Colors.black26, blurRadius: 8, offset: Offset(4, 4)),
                                  BoxShadow(color: Colors.white, blurRadius: 8, offset: Offset(-4, -4)),
                                ],
                              ),
                              child: TextButton(
                                onPressed: () {
                                  saveUserDetails();
                                },
                                style: TextButton.styleFrom(
                                  padding: EdgeInsets.symmetric(vertical: 16),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                child: Text(
                                  "Submit",
                                  style: GoogleFonts.poppins(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                ),
                              ),
                            ),
                            SizedBox(height: 50),

                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
  Widget buildImageUploader(String label, RxString imageController) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black)),
        SizedBox(height: 10),
        Obx(() => GestureDetector(
          onTap: () {
            pickImage(ImageSource.gallery, imageController); // ✅ Pass required arguments
          },
          child: Container(
            height: 100,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey),
            ),
            child: imageController.value.isEmpty
                ? Center(child: Icon(Icons.upload, color: Colors.grey, size: 30))
                : ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.file(File(imageController.value), fit: BoxFit.cover),
            ),
          ),
        )),
        SizedBox(height: 20),
      ],
    );
  }

}