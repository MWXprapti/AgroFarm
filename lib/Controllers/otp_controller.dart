import 'package:dio/dio.dart';
import 'package:dio/dio.dart' as dio;

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GenerateOtpController extends GetxController {
  final Dio _dio = Dio();

  var isLoading = false.obs;
  var mobileNumber = ''.obs;

  Future<void> generateOtp() async {
    String phone = mobileNumber.value.trim();

    if (phone.length != 10 || !RegExp(r'^\d{10}$').hasMatch(phone)) {
      Get.snackbar("Error", "Please enter a valid 10-digit mobile number");
      return;
    }

    isLoading.value = true;
    dio.Response? response;

    try {
      // API call
      response = await _dio.post(
        "https://admin.multiwebx.com/farmerAPI/sendOTPJWTToken/",
        options: Options(
          headers: {"Content-Type": "application/x-www-form-urlencoded"},
        ),
        data: {
          "action": "sendOtp",
          "mobile": "+91$phone",
        },
      );
    } on DioError catch (dioErr) {
      if (kDebugMode) print("DioError: $dioErr");

      String errorMsg = "Network error occurred";
      if (dioErr.type == DioErrorType.connectionTimeout) {
        errorMsg = "Connection timed out";
      } else if (dioErr.type == DioErrorType.receiveTimeout) {
        errorMsg = "Server took too long to respond";
      } else if (dioErr.type == DioErrorType.badResponse &&
          dioErr.response != null) {
        errorMsg = "Server error: ${dioErr.response?.statusCode}";
      } else if (dioErr.type == DioErrorType.cancel) {
        errorMsg = "Request cancelled";
      }

      Get.snackbar("Error", errorMsg);
      isLoading.value = false;
      return;
    } catch (e) {
      if (kDebugMode) print("❌ Error during request: $e");
      Get.snackbar("Error", "Unexpected error occurred");
      isLoading.value = false;
      return;
    }

    // Handle the API response
    try {
      if (response != null &&
          response.statusCode == 200 &&
          response.data["status"] == "success") {
        String? token = response.data["token"];

        if (token == null || token.isEmpty) {
          Get.snackbar("Error", "Token missing in response");
          return;
        }

        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString("auth_token", token);
        await prefs.setString("mobile_number", phone);

        Get.snackbar(
          "Success",
          response.data["message"] ?? "OTP sent successfully",
          duration: const Duration(seconds: 2),
        );

        Get.toNamed("/otp_verify", arguments: {"mobile": phone});
      } else {
        Get.snackbar("Error", response.data["message"] ?? "Failed to generate OTP");
      }
    } catch (e) {
      if (kDebugMode) print("❌ Error in OTP Generation: $e");
      Get.snackbar("Error", "Something went wrong while processing the response");
    } finally {
      isLoading.value = false;
    }
  }
}
