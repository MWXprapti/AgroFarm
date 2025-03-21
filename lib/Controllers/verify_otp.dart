import 'package:dio/dio.dart';
import 'package:get/get.dart';

class VerifyOtpController extends GetxController {
  final Dio _dio = Dio();

  var isLoading = false.obs;
  var mobileNumber = "".obs;  // ✅ Observable variable
  var otpCode = "".obs;       // ✅ Observable variable

  Future<void> verifyOtp() async {
    if (mobileNumber.value.isEmpty || otpCode.value.isEmpty) {
      Get.snackbar("Error", "Mobile number and OTP are required.");
      return;
    }

    isLoading.value = true;

    try {
      var response = await _dio.post(
        "https://admin.multiwebx.com/FBAPI/simbaMobileOTP/",
        options: Options(headers: {"Content-Type": "application/x-www-form-urlencoded"}),
        data: {
          "action": "verifyOtp",
          "mobile": "+91${mobileNumber.value}",
          "otp": otpCode.value,
        },
      );

      if (response.statusCode == 200 && response.data["status"] == "success") {
        Get.snackbar("Success", response.data["message"] ?? "OTP verified successfully!");
        Get.offAllNamed("/home");
      } else {
        Get.snackbar("Error", response.data["message"] ?? "Invalid OTP. Please try again.");
      }
    } catch (e) {
      Get.snackbar("Error", "An unexpected error occurred. Please try again.");
    } finally {
      isLoading.value = false;
    }
  }
}
