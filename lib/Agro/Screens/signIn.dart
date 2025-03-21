import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_app/Controllers/otp_controller.dart';
import 'package:new_app/Theme/theme.dart';

class MyPhone extends StatefulWidget {
  const MyPhone({Key? key}) : super(key: key);

  @override
  State<MyPhone> createState() => _MyPhoneState();
}

class _MyPhoneState extends State<MyPhone> {
  TextEditingController countryController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  final GenerateOtpController _controller = Get.put(GenerateOtpController());

  @override
  void initState() {
    super.initState();
    countryController.text = "+91";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              SizedBox(height: MediaQuery.of(context).size.height * 0.1),
              const Text(
                "Phone Verification",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              const Text(
                "We need to register your phone without getting started!",
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              Container(
                height: 55,
                decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.grey),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    const SizedBox(width: 10),
                    SizedBox(
                      width: 40,
                      child: TextField(
                        controller: countryController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(border: InputBorder.none),
                        enabled: false, // Prevents editing of country code
                      ),
                    ),
                    const Text("|", style: TextStyle(fontSize: 33, color: Colors.grey)),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        controller: phoneController,
                        keyboardType: TextInputType.phone,
                        maxLength: 10,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: "Phone",
                          counterText: "",
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 45,
                child:ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: AppColors.lightgreen,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                    onPressed: _controller.isLoading.value
                        ? null
                        : () {
                      String phoneNumber = phoneController.text.trim();
                      if (phoneNumber.length == 10 && RegExp(r'^[0-9]+$').hasMatch(phoneNumber)) {
                        _controller.mobileNumber.value = phoneNumber;
                        _controller.generateOtp();
                      } else {
                        Get.snackbar(
                          "Error",
                          "Please enter a valid 10-digit phone number",
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: Colors.red,
                          colorText: Colors.white,
                        );
                      }
                    },
                    child: _controller.isLoading.value
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text("Send the code"),
                  ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
