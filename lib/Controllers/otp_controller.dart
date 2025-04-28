import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GenerateOtpController extends GetxController {
  final Dio _dio = Dio();

  var isLoading = false.obs;
  var mobileNumber = ''.obs;

  Future<void> generateOtp() async {
    String phone = mobileNumber.value.trim();

    if (phone.length != 10) {
      Get.snackbar("Error", "Please enter a valid 10-digit mobile number");
      return;
    }

    isLoading.value = true;

    try {
      var response = await _dio.post(
        "https://admin.multiwebx.com/farmerAPI/sendOTPJWTToken/",
        options: Options(headers: {
          "Content-Type": "application/x-www-form-urlencoded",
        }),
        data: {
          "action": "sendOtp",
          "mobile": "+91$phone",
        },
      );

      if (kDebugMode) {
        print("Response: ${response.data}");
      }

      if (response.statusCode == 200 && response.data["status"] == "success") {
        String? token = response.data["token"];
        if (token == null || token.isEmpty) {
          Get.snackbar("Error", "Token missing in response");
          return;
        }

        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString("auth_token", token);
        await prefs.setString("mobile_number", phone);

        Get.snackbar("Success", response.data["message"]);
        Get.toNamed("/otp_verify", arguments: {"mobile": phone});
      } else {
        Get.snackbar("Error", response.data["message"] ?? "Failed to generate OTP");
      }
    } catch (e) {
      print("❌ Error in OTP Generation: $e");
      Get.snackbar("Error", "Something went wrong. Please try again.");
    } finally {
      isLoading.value = false;
    }
  }
}
