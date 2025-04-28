import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_app/Controllers/verify_otp.dart';
import 'package:new_app/Theme/theme.dart';
import 'package:pinput/pinput.dart';

class MyVerify extends StatelessWidget {
  final String phoneNumber;

  MyVerify({Key? key, required this.phoneNumber}) : super(key: key);

  final VerifyOtpController verifyOtpController = Get.put(VerifyOtpController());

  @override
  Widget build(BuildContext context) {
    // ✅ Debug print to check received phone number
    print("Received phone number in Verify Screen: $phoneNumber");

    // ✅ Set the mobile number in the controller
    verifyOtpController.setMobileNumber(phoneNumber);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_back_ios_rounded, color: Colors.black),
        ),
        elevation: 0,
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 25),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/farm2.png',
                fit: BoxFit.cover,
                width: MediaQuery.of(context).size.width * 0.9,
                height: MediaQuery.of(context).size.height * 0.4,
              ),
              const SizedBox(height: 20),

              // ✅ Show verifying message dynamically
              Obx(() => Text(
                "Verifying +91 ${verifyOtpController.mobileNumber.value}",
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              )),

              const SizedBox(height: 30),

              // ✅ OTP Input Field
              Pinput(
                length: 6,
                showCursor: true,
                onChanged: (value) {
                  verifyOtpController.otpCode.value = value.trim();
                  print("Entered OTP: ${verifyOtpController.otpCode.value}"); // ✅ Debugging OTP input
                },
                onCompleted: (pin) {
                  verifyOtpController.otpCode.value = pin.trim();
                  print("Final OTP: ${verifyOtpController.otpCode.value}"); // ✅ Debugging final OTP
                },
              ),

              const SizedBox(height: 20),

              // ✅ Verify Button
              SizedBox(
                width: double.infinity,
                height: 45,
                child: Obx(() => ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.lightgreen,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  onPressed: verifyOtpController.isLoading.value
                      ? null
                      : () {
                    print("Verifying OTP for ${verifyOtpController.mobileNumber.value}");
                    verifyOtpController.verifyOtp();
                  },
                  child: verifyOtpController.isLoading.value
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text("Verify Phone Number"),
                )),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () => Get.back(),
                    child: const Text("Edit Phone Number ?", style: TextStyle(color: Colors.black)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
