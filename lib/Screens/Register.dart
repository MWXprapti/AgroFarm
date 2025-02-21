import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:new_app/Screens/DashBoard.dart';
import 'package:new_app/Screens/Login.dart';
import 'package:new_app/Screens/signIn.dart';
import 'package:new_app/Theme/theme.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool _obscureText = true;
  bool _remind = true;
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void _signUp() async {
    if (_formKey.currentState!.validate()) {
      try {
        // Firebase Auth - Register User
        UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );

        // Firestore - Store user data in `user_farm` collection
        await _firestore.collection("user_farm").doc(userCredential.user!.uid).set({
          "username": _nameController.text.trim(),
          "email": _emailController.text.trim(),
          "phone": _phoneController.text.trim(),
          "uid": userCredential.user!.uid,
          "createdAt": FieldValue.serverTimestamp(),
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Sign Up Successful!")),
        );

        // Navigate to Home/Intro Screen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const DashBoard()),
        );
      } on FirebaseAuthException catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.message ?? "Sign Up Failed")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 30),
                Center(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: MediaQuery.of(context).size.width * 0.8,
                    child: Image.asset("assets/farm2.png"),
                  ),
                ),
                const SizedBox(height: 20),
                const Padding(
                  padding: EdgeInsets.only(left: 20, bottom: 10),
                  child: Text(
                    'Sign Up',
                    style: TextStyle(fontSize: 30, color: AppColors.darkgreen),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Text(
                    'Please Sign up to continue',
                    style: TextStyle(fontSize: 20, color: AppColors.yellow),
                  ),
                ),
                const SizedBox(height: 20),

                // Name Field
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: _nameController,
                    validator: (value) => value!.isEmpty ? "Enter your name" : null,
                    decoration: InputDecoration(
                      labelText: "User Name",
                      labelStyle: TextStyle(color: AppColors.darkgreen),
                      hintText: "Enter your user name",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      prefixIcon: const Icon(Icons.person, color: AppColors.darkgreen),
                    ),
                  ),
                ),

                // Email Field
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: _emailController,
                    validator: (value) => value!.contains("@") ? null : "Enter a valid email",
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: "Email",
                      labelStyle: TextStyle(color: AppColors.darkgreen),
                      hintText: "Enter your email",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      prefixIcon: const Icon(Icons.email, color: AppColors.darkgreen),
                    ),
                  ),
                ),

                // Phone Number Field
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: _phoneController,
                    validator: (value) => value!.length == 10 ? null : "Enter a valid phone number",
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      labelText: "Phone Number",
                      labelStyle: TextStyle(color: AppColors.darkgreen),
                      hintText: "Enter your phone number",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      prefixIcon: const Icon(Icons.phone, color: AppColors.darkgreen),
                    ),
                  ),
                ),

                // Password Field
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: _passwordController,
                    validator: (value) => value!.length >= 6 ? null : "Password must be at least 6 characters",
                    obscureText: _obscureText,
                    decoration: InputDecoration(
                      labelText: "Password",
                      labelStyle: TextStyle(color: AppColors.darkgreen),
                      hintText: "Enter your password",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      prefixIcon: const Icon(Icons.lock, color: AppColors.darkgreen),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscureText ? Icons.visibility_off : Icons.visibility,
                          color: AppColors.darkgreen,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                      ),
                    ),
                  ),
                ),

                // Remind Me Checkbox
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Remind me next time",
                        style: TextStyle(color: Colors.black, fontSize: 15),
                      ),
                      IconButton(
                        icon: Icon(
                          _remind ? Icons.check_box : Icons.check_box_outline_blank,
                          color: AppColors.darkgreen,
                        ),
                        onPressed: () {
                          setState(() {
                            _remind = !_remind;
                          });
                        },
                      ),
                    ],
                  ),
                ),

                // Sign Up Button
                InkWell(
                  onTap: _signUp,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: double.infinity,
                      height: 50,
                      decoration: BoxDecoration(
                        color: AppColors.lightgreen,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: const Center(
                        child: Text(
                          'Sign Up',
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),

                // Sign In Link
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Already have an account?", style: TextStyle(color: Colors.grey, fontSize: 15)),
                    const SizedBox(width: 10),
                    InkWell(
                      onTap: () => Navigator.push(context,MaterialPageRoute(builder: (context) => LoginScreen(),)),
                      child: const Text("Sign In", style: TextStyle(color: AppColors.darkgreen, fontSize: 15)),
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
