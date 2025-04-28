import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_app/Controllers/otp_controller.dart';
import 'package:new_app/Controllers/verify_otp.dart';
import 'package:new_app/theme/theme.dart';
import 'package:pinput/pinput.dart';

class PhoneVerificationScreen extends StatefulWidget {
  @override
  _PhoneVerificationScreenState createState() =>
      _PhoneVerificationScreenState();
}

class _PhoneVerificationScreenState extends State<PhoneVerificationScreen> {
  final GenerateOtpController generateOtpController =
  Get.put(GenerateOtpController());
  final VerifyOtpController verifyOtpController =
  Get.put(VerifyOtpController());

  bool showOtpField = false;
  TextEditingController phoneController = TextEditingController();
  TextEditingController countryController = TextEditingController(text: "+91");

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: screenHeight * 0.05),
                Image.asset(
                  'assets/farm2.png',
                  fit: BoxFit.cover,
                  width: screenWidth * 0.8,
                  height: screenHeight * 0.25,
                ),
                SizedBox(height: screenHeight * 0.05),
                AnimatedSwitcher(
                  duration: Duration(milliseconds: 500),
                  transitionBuilder: (widget, animation) => SlideTransition(
                    position: Tween<Offset>(
                      begin: showOtpField ? Offset(-1, 0) : Offset(1, 0),
                      end: Offset.zero,
                    ).animate(animation),
                    child: widget,
                  ),
                  child: showOtpField
                      ? Column(
                    key: ValueKey(2),
                    children: [
                      Text("Enter OTP",
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold)),
                      SizedBox(height: screenHeight * 0.02),
                      Pinput(
                        length: 6,
                        showCursor: true,
                        onChanged: (value) {
                          verifyOtpController.otpCode.value = value;
                        },
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      SizedBox(
                        width: double.infinity,
                        height: 45,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.lightgreen,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                          ),
                          onPressed: () {
                            verifyOtpController.mobileNumber.value =
                                phoneController.text;
                            verifyOtpController.verifyOtp();
                          },
                          child: Text("Verify Phone Number"),
                        ),
                      ),
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: Row(
                              children: [
                                Text(
                                  "${phoneController.text}",
                                  style: AppTextStyles.headingStyle
                                      .copyWith(fontSize: 19),
                                ),
                                TextButton(
                                  onPressed: () {
                                    setState(() {
                                      showOtpField = false;
                                    });
                                  },
                                  child: Text("Edit Number ?"),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
                    ],
                  )
                      : Column(
                    key: ValueKey(1),
                    children: [
                      Text("Phone Verification",
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold)),
                      SizedBox(height: screenHeight * 0.01),
                      Text(
                        "We need to register your phone before getting started!",
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: screenHeight * 0.03),
                      Container(
                        height: 55,
                        decoration: BoxDecoration(
                          border: Border.all(width: 1, color: Colors.grey),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          children: [
                            SizedBox(width: 10),
                            SizedBox(
                              width: 40,
                              child: TextField(
                                controller: countryController,
                                keyboardType: TextInputType.number,
                                decoration:
                                InputDecoration(border: InputBorder.none),
                              ),
                            ),
                            Text("|",
                                style: TextStyle(
                                    fontSize: 33, color: Colors.grey)),
                            SizedBox(width: 10),
                            Expanded(
                              child: TextField(
                                controller: phoneController,
                                keyboardType: TextInputType.phone,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Phone"),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      SizedBox(
                        width: double.infinity,
                        height: 45,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.lightgreen,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                          ),
                          onPressed: () {
                            generateOtpController.mobileNumber.value =
                                phoneController.text;
                            generateOtpController.generateOtp();
                            setState(() {
                              showOtpField = true;
                            });
                          },
                          child: Text("Send the code"),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: screenHeight * 0.05),
              ],
            ),
          ),
        ),
      ),
    );
  }
}