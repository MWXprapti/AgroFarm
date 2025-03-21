import 'package:dio/dio.dart';
import 'package:get/get.dart';

class GenerateOtpController extends GetxController {
  final Dio _dio = Dio();

  var isLoading = false.obs;
  var mobileNumber = ''.obs;

  Future<void> generateOtp() async {
    if (mobileNumber.value.length != 10) {
      Get.snackbar("Error", "Please enter a valid 10-digit mobile number");
      return;
    }

    isLoading.value = true;

    try {
      print("Sending OTP request for +91${mobileNumber.value}");

      var response = await _dio.post(
        "https://admin.multiwebx.com/FBAPI/simbaMobileOTP/",
        options: Options(headers: {
          "Content-Type": "application/x-www-form-urlencoded"
        }),
        data: {
          "action": "sendOtp",
          "mobile": "+91${mobileNumber.value}"
        },
      );

      print("Response Data: ${response.data}");

      if (response.statusCode == 200) {
        Get.toNamed("/verifyotp", arguments: {"mobile": mobileNumber.value});
      } else {
        Get.snackbar("Error", response.data["message"] ?? "Failed to generate OTP");
      }
    } catch (e) {
      print("Error: $e");
      Get.snackbar("Error", "Something went wrong. Please try again.");
    } finally {
      isLoading.value = false;
    }
  }
}
