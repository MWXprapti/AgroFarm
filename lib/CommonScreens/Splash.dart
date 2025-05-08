import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';
import 'package:new_app/Theme/theme.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkLoginStatus(); // 🔍 Check token on launch
  }

  Future<void> _checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("auth_token");

    // 🕒 Delay for splash screen
    await Future.delayed(Duration(seconds: 2));

    if (token != null && token.isNotEmpty) {
      // ✅ Token exists: navigate to dashboard/farm_detail_form
      Get.offAllNamed("/dash");
    } else {
      // 🔐 No token: go to login/intro
      Get.offAllNamed("/intro");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgcolor,
      body: Center(
        child: Image.asset(
          "assets/AgroFarm_logo.png",
          width: 200,
          height: 200,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
