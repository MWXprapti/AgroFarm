import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VerifyOtpController extends GetxController {
  final Dio _dio = Dio();

  var isLoading = false.obs;
  var mobileNumber = ''.obs;
  var otpCode = ''.obs;
  var authToken = ''.obs;

  // ✅ Function to set mobile number
  void setMobileNumber(String number) {
    mobileNumber.value = number.trim();
    print("📱 Mobile number set: ${mobileNumber.value}");
  }

  // ✅ Store token securely in SharedPreferences
  Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("auth_token", token);
    authToken.value = token;
  }

  // ✅ Load token before making API request
  Future<void> loadToken() async {
    final prefs = await SharedPreferences.getInstance();
    authToken.value = prefs.getString("auth_token") ?? "";

    if (authToken.value.isEmpty) {
      print("⚠️ Warning: Token is missing!");
    } else {
      print("🔑 Loaded Token: ${authToken.value}");
    }
  }

  Future<void> verifyOtp() async {
    String phone = mobileNumber.value.trim();
    String otp = otpCode.value.trim();

    print("🔍 Verifying OTP for: $phone | OTP: $otp");

    if (phone.isEmpty || otp.isEmpty) {
      Get.snackbar("Error", "Please enter both mobile number and OTP");
      return;
    }

    isLoading.value = true;

    await loadToken(); // ✅ Load token before sending request

    if (authToken.value.isEmpty) {
      Get.snackbar("Error", "Authentication token is missing! Please request OTP again.");
      isLoading.value = false;
      return;
    }

    try {
      print("📤 Sending OTP Verification Request...");
      print("📱 Mobile: $phone");
      print("🔢 OTP: $otp");
      print("🔑 Token: ${authToken.value}");

      var response = await _dio.post(
        "https://admin.multiwebx.com/farmerAPI/sendOTPJWTToken/",
        options: Options(headers: {
          "Content-Type": "application/x-www-form-urlencoded"
        }),
        data: {
          "action": "verifyOtp",
          "mobile": "+91${phone.trim()}",
          "otp": otp.trim(),
          "token": authToken.value, // ✅ Sending stored token
        },
      );

      print("✅ OTP Verification Response: ${response.data}");

      if (response.statusCode == 200 && response.data["status"] == "success") {
        String newToken = response.data["token"] ?? "";
        if (newToken.isNotEmpty) {
          await saveToken(newToken);
          print("✅ New Token Stored Successfully!");
        }

        Get.snackbar("Success", response.data["message"]);
        Get.offAllNamed("/farm_detail_Form"); // ✅ Navigate after success
      } else {
        Get.snackbar("Error", response.data["message"] ?? "OTP verification failed");
      }
    } catch (e) {
      print("❌ Error verifying OTP: $e");
      Get.snackbar("Error", "Something went wrong. Please try again.");
    } finally {
      isLoading.value = false;
    }
  }
}
