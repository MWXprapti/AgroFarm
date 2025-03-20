import 'dart:async';
import 'package:flutter/material.dart';
import 'package:new_app/Agro/Screens/signIn.dart';
import 'package:new_app/CommonScreens/Intro.dart';
import 'package:new_app/Theme/theme.dart';


class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Intro()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgcolor,
      body: Center(
        child: Image.asset(
          "assets/AgroFarm_logo.png",
          width: 200, // Adjust image size
          height: 200,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}


