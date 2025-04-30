import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:new_app/Agro/Screens/ConsultantForm.dart';

// Screens
import 'package:new_app/Agro/Screens/DashBoard.dart';
import 'package:new_app/Agro/Screens/FarmerToFarmer/Dash_Farmer.dart';
import 'package:new_app/Agro/Screens/FarmerProfile.dart';
import 'package:new_app/Agro/Screens/Farmer_form.dart';
import 'package:new_app/Agro/Screens/agro_to_farmer/Product_ListingPage.dart';
import 'package:new_app/Agro/Screens/Product_UploadPage.dart';
import 'package:new_app/Agro/Screens/Report_Page.dart';
import 'package:new_app/Agro/Screens/SalesListing.dart';
import 'package:new_app/Agro/Screens/auth/signIn.dart';
import 'package:new_app/Agro/Screens/editProfile.dart';
import 'package:new_app/Agro/Screens/translateScreen.dart';
import 'package:new_app/Agro/Screens/weather.dart';
import 'package:new_app/CommonScreens/Splash.dart';
import 'package:new_app/Agro/Screens/product_details.dart';
import 'package:new_app/Agro/Screens/auth/verifyOtp.dart';
import 'package:new_app/CommonScreens/Intro.dart';
import 'package:new_app/CommonScreens/reels.dart';
import 'package:new_app/weather_Page/location_page.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyBZ7P51nc-tA1Tpk_ls4O0Sok3LRVZcW88",
      appId: "1:98947686492:android:ee474aae65edd001960699",
      messagingSenderId: "98947686492",
      projectId: "blockr-app",
      storageBucket: "blockr-app.appspot.com",
    ),
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: "/splash",
      getPages: [
        GetPage(name: "/signin", page: () => PhoneVerificationScreen()),
        GetPage(name: "/verifyotp", page: () => MyVerify(phoneNumber: '',)),
        GetPage(name: "/splash", page: () => SplashScreen()),
        GetPage(name: "/dash", page: () => DashBoard()),
        //GetPage(name: "/farm", page: () => FarmerProductDash()),
        GetPage(name: "/product", page: () => ProductDetails(productId: '35',)),
        GetPage(name: "/farm_detail_Form", page: () => FarmerProfileForm()),
        GetPage(name: "/report", page: () => ReportPage()),
        GetPage(name: "/add", page: () => AddProductPage()),
        GetPage(name: "/test", page: () => SalesListPage()),
        GetPage(name: "/list", page: () => ProductListing()),
        GetPage(name: "/intro", page: () => Intro()),
        GetPage(name: "/editProfile", page: () => EditProfilePage()),
        GetPage(name: "/farm_profile", page: () => FarmerProfilePage()),
        GetPage(name: "/reels", page: () => ReelsScreen()),
        GetPage(name: "/translate", page: () => ApiTranslatorScreen()),
        GetPage(name: "/weather", page: () => weatherPage()),
        GetPage(name: "/LocationPage", page: () => LocationPage()),
        GetPage(name: "/consultant", page: () => consultantProfileForm(uid: '',)),
        GetPage(name: "/dashboard_farmer", page: () => Farm_Dashboard()),

      ],
    );
  }
}

// Function to switch language
void toggleLanguage(String langCode) {
  Get.updateLocale(Locale(langCode));
}
