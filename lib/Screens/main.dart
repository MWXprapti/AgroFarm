import 'package:flutter/material.dart';
import 'package:new_app/Screens/DashBoard.dart';
import 'package:new_app/Screens/Login.dart';
import 'package:new_app/Screens/Register.dart';
import 'package:new_app/Screens/Report_Page.dart';
import 'package:new_app/Screens/intro.dart';
import 'package:new_app/Screens/Splash.dart';
import 'package:new_app/Screens/product_details.dart';
import 'package:new_app/Screens/signIn.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';

import 'Farmer_form.dart';
import 'Product_UploadPage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyBZ7P51nc-tA1Tpk_ls4O0Sok3LRVZcW88",
      appId: "1:98947686492:android:ee474aae65edd001960699", // bb_task_app
      messagingSenderId: "98947686492",
      projectId: "blockr-app",
      storageBucket: "blockr-app.appspot.com",
    ),
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: "/splash",
      getPages: [
      GetPage(name: "/signin", page: () => SignIn(),),
    GetPage(name: "/splash", page: () => SplashScreen(),),
    GetPage(name: "/intro", page: () => intro(),),
    GetPage(name: "/dash", page: () => DashBoard(),),
    GetPage(name: "/login", page: () => LoginScreen(),),
    GetPage(name: "/regs", page: () => SignUpScreen(),),
    GetPage(name: "/product", page: () => ProductDetails(),),
    GetPage(name: "/farm_profile", page: () => FarmerProfileForm(),),
    GetPage(name: "/report", page: () => ReportPage(),),
    GetPage(name: "/add", page: () => AddProductPage(),),
    ]
    );
  }
}
