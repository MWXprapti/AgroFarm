import 'package:flutter/material.dart';
import 'package:new_app/Screens/intro.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import '../Theme/theme.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  bool _showOtpField = false;
  String _verificationId = '';

  final TextEditingController _otpController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController(text: '');
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void dispose() {
    _otpController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> sendOtp() async {
    String phoneNumber = "+91" + _phoneController.text.trim();
    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential phoneAuthCredential) async {
        await _auth.signInWithCredential(phoneAuthCredential);
        Get.snackbar("Success", "Logged in automatically");
        Get.offAll(() => intro());
      },
      verificationFailed: (FirebaseAuthException error) {
        Get.snackbar("Error", "Verification failed: \${error.message}");
      },
      codeSent: (String verificationId, int? resendToken) {
        setState(() {
          _verificationId = verificationId;
          _showOtpField = true;
        });
        Get.snackbar("OTP Sent", "Check your SMS for the OTP.");
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        _verificationId = verificationId;
      },
      timeout: const Duration(seconds: 60),
    );
  }

  Future<void> signWithOTP() async {
    try {
      await _auth.signInWithCredential(
        PhoneAuthProvider.credential(
          verificationId: _verificationId,
          smsCode: _otpController.text.trim(),
        ),
      );
      Get.snackbar("Success", "Logged In Successfully");
      Get.offAll(() => intro());
    } catch (e) {
      Get.snackbar("Error", "Could not log in: \${e.toString()}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.olive,
        body: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 150),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors.bgcolor,
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(60),
                      topLeft: Radius.circular(60),
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(height: 40),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Log In ",
                                style: AppTextStyles.bodyStyle.copyWith(
                                  fontSize: 25,
                                  color: AppColors.lightgreen,
                                  fontWeight: FontWeight.bold,
                                )),
                            Text("to your account.",
                                style: AppTextStyles.bodyStyle.copyWith(
                                  fontSize: 25,
                                  color: Colors.black,
                                )),
                          ],
                        ),
                        const SizedBox(height: 40),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            controller: _phoneController,
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                              labelText: "Mobile Number",
                              hintText: "Enter Mobile Number",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              prefixIcon: const Icon(Icons.phone_outlined, color: Colors.black),
                              prefixText: "+91 ",
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        GestureDetector(
                          onTap: sendOtp,
                          child: Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(15),
                            decoration: BoxDecoration(
                              color: AppColors.yellow,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Center(
                              child: Text('Generate OTP',
                                  style: AppTextStyles.bodyStyle.copyWith(
                                    fontSize: 20,
                                    color: Colors.white,
                                  )),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        if (_showOtpField) ...[
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 30),
                            child: PinCodeTextField(
                              appContext: context,
                              length: 6,
                              controller: _otpController,
                              keyboardType: TextInputType.number,
                              pinTheme: PinTheme(
                                shape: PinCodeFieldShape.box,
                                borderRadius: BorderRadius.circular(3),
                                fieldHeight: 60,
                                fieldWidth: 50,
                                activeFillColor: Colors.white,
                                selectedFillColor: Colors.grey.shade300,
                                inactiveFillColor: Colors.white,
                                activeColor: AppColors.darkgreen,
                                selectedColor: AppColors.yellow,
                                inactiveColor: AppColors.darkgreen,
                              ),
                              onChanged: (value) {},
                            ),
                          ),
                          const SizedBox(height: 20),
                          GestureDetector(
                            onTap: signWithOTP,
                            child: Container(
                              width: double.infinity,
                              padding: EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                color: AppColors.lightgreen,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Center(
                                child: Text('Log In',
                                    style: AppTextStyles.bodyStyle.copyWith(
                                      fontSize: 20,
                                      color: Colors.white,
                                    )),
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
