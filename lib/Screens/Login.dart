import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:new_app/Screens/DashBoard.dart';
import 'package:new_app/Screens/Register.dart';
import 'package:new_app/Theme/theme.dart';

import 'Home.dart';

class LoginController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  var isLoading = false.obs;

  Future<void> login(String email, String password) async {
    try {
      isLoading.value = true;
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      Get.offAll(() => DashBoard());
    } catch (e) {
      Get.snackbar("Error", "Incorrect password");
    } finally {
      isLoading.value = false;
      Get.snackbar("Error", "other error");

    }
  }
}

class LoginScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final LoginController loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 40),
                Center(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: MediaQuery.of(context).size.width * 0.8,
                    child: Image.asset("assets/farm2.png"),
                  ),
                ),
                const SizedBox(height: 30),
                const Padding(
                  padding: EdgeInsets.only(left: 20, bottom: 10),
                  child: Text(
                    'Login',
                    style: TextStyle(fontSize: 30, color: AppColors.darkgreen),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Text(
                    'Please Sign in to continue',
                    style: TextStyle(fontSize: 20, color: AppColors.yellow),
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: _emailController,
                    validator: (value) {
                      if (value == null || !value.contains("@")) {
                        return "Enter a valid email";
                      }
                      return null;
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: "Email Address",
                      hintText: "Start Typing",
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
                      prefixIcon: const Icon(Icons.person_2_outlined, color: AppColors.darkgreen),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Obx(() => TextFormField(
                    controller: _passwordController,
                    obscureText: loginController.isLoading.value,
                    decoration: InputDecoration(
                      labelText: "Password",
                      hintText: "Start Typing",
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
                      prefixIcon: const Icon(Icons.lock, color: AppColors.darkgreen),
                      suffixIcon: IconButton(
                        icon: Icon(
                          loginController.isLoading.value ? Icons.visibility_off : Icons.visibility,
                          color: AppColors.darkgreen,
                        ),
                        onPressed: () {
                          loginController.isLoading.value = !loginController.isLoading.value;
                        },
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.length < 6) {
                        return "Password must be at least 6 characters";
                      }
                      return null;
                    },
                  )
                  ),
                ),
                SizedBox(height: 50,),
                InkWell(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: double.infinity,
                      height: 50,
                      decoration: BoxDecoration(
                        color: AppColors.lightgreen,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Obx(() => Center(
                        child: loginController.isLoading.value
                            ? CircularProgressIndicator(color: Colors.white)
                            : Text('Sign In', style: TextStyle(fontSize: 20, color: Colors.white)),
                      )),
                    ),
                  ),
                  onTap:() {
                    Get.toNamed("/farm_profile");
                  },
                  //     () {
                  //   if (_formKey.currentState!.validate()) {
                  //     loginController.login(_emailController.text.trim(), _passwordController.text.trim());
                  //   }
                  // },
                ),
                SizedBox(height: 50,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have an account?", style: TextStyle(color: Colors.grey, fontSize: 15)),
                     SizedBox(width: 10),
                    InkWell(
                      onTap: () => Get.to(() => const SignUpScreen()),
                      child: const Text("Sign Up", style: TextStyle(color: AppColors.darkgreen, fontSize: 15)),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}