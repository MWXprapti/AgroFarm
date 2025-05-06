import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart' as dio;
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FarmerProfileUploadController extends GetxController {
  final dio.Dio _dio = dio.Dio();
  final ImagePicker _picker = ImagePicker();

  var name = ''.obs;
  var city = ''.obs;
  var state = ''.obs;
  var address = ''.obs;
  var pincode = ''.obs;
  var cropName = ''.obs;
  var landSize = '1'.obs;
  var referredBy = 'other'.obs;
  var referralCode = ''.obs;
  var profileImage = Rx<File?>(null);

  Future<void> pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      profileImage.value = File(pickedFile.path);
    }
  }

  void removeImage() {
    profileImage.value = null;
  }

  bool _validateFields({
    required String name_,
    required String city_,
    required String state_,
    required String address_,
    required String pincode_,
    required String cropName_,
    required String landSize_,
    required String referredBy_,
    required String agentName_,
  }) {
    if (name_.isEmpty ||
        city_.isEmpty ||
        state_.isEmpty ||
        address_.isEmpty ||
        pincode_.isEmpty ||
        cropName_.isEmpty ||
        landSize_.isEmpty ||
        referredBy_.isEmpty) {
      Get.snackbar("Validation Error", "All fields are required");
      return false;
    }

    if (pincode_.length != 6 || int.tryParse(pincode_) == null) {
      Get.snackbar("Validation Error", "Pincode must be a 6-digit number");
      return false;
    }

    if (referredBy_ == "Agent" && agentName_.isEmpty) {
      Get.snackbar("Validation Error", "Agent name is required when referred by an Agent");
      return false;
    }

    return true;
  }

  Future<void> submitForm({
    required String name_,
    required String city_,
    required String state_,
    required String address_,
    required String pincode_,
    required String cropName_,
    required String landSize_,
    required String referredBy_,
    String agentName_ = '',
  }) async {
    if (!_validateFields(
      name_: name_,
      city_: city_,
      state_: state_,
      address_: address_,
      pincode_: pincode_,
      cropName_: cropName_,
      landSize_: landSize_,
      referredBy_: referredBy_,
      agentName_: agentName_,
    )) return;

    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString("auth_token");

      if (token == null) {
        Get.snackbar("Error", "Authentication token not found");
        return;
      }

      String? base64Image;
      if (profileImage.value != null) {
        List<int> imageBytes = await profileImage.value!.readAsBytes();
        base64Image = base64Encode(imageBytes);
        print("📤 Upload Base64 Length: ${base64Image.length}");
      }

      var formData = dio.FormData.fromMap({
        "action": "updateUserDetails",
        "token": token,
        "name": name_,
        "cropName": cropName_,
        "landSize": landSize_,
        "referredBy": referredBy_,
        "agentName": referredBy_ == "Agent" ? agentName_ : "",
        "address": address_,
        "pincode": pincode_,
        "state": state_,
        "city": city_,
        "profileImage": base64Image ?? "null",
      });

      var response = await _dio.post(
        "https://admin.multiwebx.com/farmerAPI/farmerUserAuth/",
        data: formData,
      );

      if (response.data["status"] == "success") {
        Get.snackbar("Success", "User details updated successfully");
        Get.offAllNamed("dash");
      } else {
        Get.snackbar("Error", response.data["message"] ?? "Failed to update details");
      }
    } catch (e) {
      Get.snackbar("Error", "Something went wrong: $e");
    }
  }
}
