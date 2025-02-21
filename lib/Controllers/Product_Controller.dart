import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ProductController extends GetxController {
  final TextEditingController productNameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController stockQuantityController = TextEditingController();
  final TextEditingController perUnitQuantityController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  var selectedCategory = "Seeds".obs;
  var selectedUnit = "Kg".obs;
  var imageFile = Rx<File?>(null);
  var isUploading = false.obs;
  var productCount = 0.obs;

  @override
  void onInit() {
    super.onInit();
    fetchProductCount();
  }

  Future<void> pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      imageFile.value = File(pickedFile.path);
    }
  }

  Future<String?> uploadImageToStorage(File image) async {
    try {
      String fileName = "products/${DateTime.now().millisecondsSinceEpoch}.jpg";
      Reference ref = FirebaseStorage.instance.ref().child(fileName);
      UploadTask uploadTask = ref.putFile(image);
      TaskSnapshot snapshot = await uploadTask;
      return await snapshot.ref.getDownloadURL();
    } catch (e) {
      print("Image upload failed: $e");
      return null;
    }
  }
  Future<void> deleteProduct(String productId, String imageUrl) async {
    try {
      // Show confirmation dialog
      bool? confirmDelete = await Get.dialog(
        AlertDialog(
          title: Text("Delete Product"),
          content: Text("Are you sure you want to delete this product?"),
          actions: [
            TextButton(
              onPressed: () => Get.back(result: false), // Cancel
              child: Text("Cancel", style: TextStyle(color: Colors.grey)),
            ),
            TextButton(
              onPressed: () => Get.back(result: true), // Confirm
              child: Text("Delete", style: TextStyle(color: Colors.red)),
            ),
          ],
        ),
      );

      if (confirmDelete == true) {
        // Delete from Firestore
        await FirebaseFirestore.instance.collection('products').doc(productId).delete();

        // Delete image from Firebase Storage
        if (imageUrl.isNotEmpty) {
          await FirebaseStorage.instance.refFromURL(imageUrl).delete();
        }
        Get.back();
        // Show success message
        Get.snackbar("Success", "Product deleted successfully",
            backgroundColor: Colors.green, colorText: Colors.white, snackPosition: SnackPosition.BOTTOM);
      }
    } catch (e) {
      // Show error message
      Get.snackbar("Error", "Failed to delete product: ${e.toString()}",
          backgroundColor: Colors.red, colorText: Colors.white, snackPosition: SnackPosition.BOTTOM);
    }
  }
  Future<void> uploadProduct() async {
    if (productNameController.text.isEmpty ||
        priceController.text.isEmpty ||
        stockQuantityController.text.isEmpty ||
        perUnitQuantityController.text.isEmpty ||
        descriptionController.text.isEmpty ||
        imageFile.value == null) {
      Get.snackbar("Error", "All fields are required!",
          snackPosition: SnackPosition.TOP,backgroundColor: Colors.red);
      return;
    }

    try {
      isUploading.value = true;
      String? imageUrl = await uploadImageToStorage(imageFile.value!);
      if (imageUrl == null) throw "Image upload failed";

      String userId = FirebaseAuth.instance.currentUser?.uid ?? "guest";

      await FirebaseFirestore.instance.collection("products").add({
        "productId": DateTime.now().millisecondsSinceEpoch.toString(),
        "userId": userId,
        "productName": productNameController.text,
        "category": selectedCategory.value,
        "price": double.parse(priceController.text),
        "stockQuantity": int.parse(stockQuantityController.text),
        "unit": selectedUnit.value,
        "perUnitQuantity": double.parse(perUnitQuantityController.text),
        "description": descriptionController.text,
        "imageUrl": imageUrl,
        "createdAt": Timestamp.now(),
      });

      Get.snackbar("Success", "Product uploaded successfully!",
          snackPosition: SnackPosition.TOP,backgroundColor: Colors.greenAccent);
      clearForm();
    } catch (e) {
      Get.snackbar("Error", e.toString(), snackPosition: SnackPosition.BOTTOM);
    } finally {
      isUploading.value = false;
    }
  }

  void fetchProductCount() {
    String uid = FirebaseAuth.instance.currentUser!.uid; // Get logged-in user ID

    FirebaseFirestore.instance.collection("products")
        .where("userId", isEqualTo: uid)
        .snapshots().listen((snapshot)
    {
      productCount.value = snapshot.size; // Realtime count
    });
  }

  void clearForm() {
    productNameController.clear();
    priceController.clear();
    stockQuantityController.clear();
    perUnitQuantityController.clear();
    descriptionController.clear();
    selectedCategory.value = "Seeds";
    selectedUnit.value = "Kg";
    imageFile.value = null;
  }
}