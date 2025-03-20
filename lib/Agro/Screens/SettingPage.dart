import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              child: Text(
                "App\nSettings",
                style: GoogleFonts.poppins(
                  fontSize: 30,
                  letterSpacing: 1.2,
                  color: Colors.black,
                ),
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 5,
                      spreadRadius: 2,
                    )
                  ],
                  borderRadius: BorderRadius.vertical(top: Radius.circular(50)),
                ),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                child: Column(
                  children: [
                    _buildSettingOption(
                      icon: Icons.person_4_outlined,
                      title: "Profile",
                      subtitle: "You can see your profile",
                      onTap: () => Get.toNamed('/farm_profile'),
                    ),
                    _buildSettingOption(
                      icon: Icons.language_outlined,
                      title: "Edit Language",
                      subtitle: "You can change language",
                      onTap: () => _showLanguageBottomSheet(context),
                    ),
                    _buildSettingOption(
                      icon: Icons.logout_outlined,
                      title: "Logout",
                      subtitle: "You can logout",
                      onTap: () => Get.toNamed("/logout"),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingOption({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 5,
              spreadRadius: 2,
            )
          ],
        ),
        child: ListTile(
          leading: Icon(icon, color: Colors.black, size: 30),
          title: Text(title, style: GoogleFonts.sora(fontWeight: FontWeight.bold)),
          subtitle: Text(subtitle, style: TextStyle(color: Colors.grey)),
          trailing: Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 18),
          onTap: onTap,
        ),
      ),
    );
  }

  void _showLanguageBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: const Text('English'),
                onTap: () {
                  Get.snackbar('Language Changed', 'English Selected');
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('Hindi'),
                onTap: () {
                  Get.snackbar('Language Changed', 'Hindi Selected');
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('Gujarati'),
                onTap: () {
                  Get.snackbar('Language Changed', 'Gujarati Selected');
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}