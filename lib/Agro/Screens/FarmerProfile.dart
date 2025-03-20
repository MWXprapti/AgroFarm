import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:new_app/Theme/theme.dart';

class FarmerProfilePage extends StatefulWidget {
  @override
  _FarmerProfilePageState createState() => _FarmerProfilePageState();
}

class _FarmerProfilePageState extends State<FarmerProfilePage> {
  late ScrollController _scrollController;
  double _scrollOffset = 0.0;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      setState(() {
        _scrollOffset = _scrollController.offset;
      });
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;

    // Calculate text color transition based on scroll
    double scrollFactor = (_scrollOffset / 150).clamp(0, 1);
    Color textColor = Color.lerp(Colors.black, Colors.white, scrollFactor)!;

    return Scaffold(
      backgroundColor: AppColors.bgcolor,
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverAppBar(
            expandedHeight: h * 0.45,
            pinned: true,
            floating: false,
            stretch: true,
            backgroundColor: AppColors.lightgreen,
            shadowColor: Colors.transparent,
            title: Text("Back"),
            leading: Padding(
              padding: const EdgeInsets.only(left: 25),
              child: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                  size: w * 0.08, // Adjusted size for responsiveness
                ),
                onPressed: () => Get.back(),
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 30),
                child: IconButton(
                  icon: Icon(FontAwesomeIcons.userPen, size: w * 0.06), // New icon
                  onPressed: () {
                    // Edit profile function
                  },
                ),
              )
            ],
            flexibleSpace: LayoutBuilder(
              builder: (context, constraints) {
                double percent = (constraints.maxHeight - kToolbarHeight) /
                    (h * 0.4 - kToolbarHeight);
                percent = percent.clamp(0, 1);

                return FlexibleSpaceBar(
                  title: Text(
                    "Dhrumit Boricha",
                    style: TextStyle(
                      fontSize: w * 0.05,
                      fontWeight: FontWeight.bold,
                      color: Color.lerp(Colors.white, Colors.black, percent),
                    ),
                  ),
                  centerTitle: true,
                  background: Stack(
                    alignment: Alignment.center,
                    children: [
                      Positioned.fill(
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [AppColors.lightgreen, AppColors.bgcolor],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: h * 0.12, // Adjusted position for better small-screen support
                        child: CircleAvatar(
                          radius: w * 0.150,
                          backgroundColor: Colors.black12,
                          child: CircleAvatar(
                            backgroundColor: AppColors.cream,
                            radius: w * 0.140,
                            backgroundImage:
                            AssetImage("assets/profile_image.png"),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                SizedBox(height: h * 0.03),
                Column(
                  mainAxisSize: MainAxisSize.min, // Important for small screens
                  children: [
                    Container(
                      color: AppColors.bgcolor,
                      child: Column(
                        children: [
                          _buildInfoRow(LucideIcons.mail, "Email", "heard_j@gmail.com", w),
                          _buildInfoRow(LucideIcons.phone, "Phone", "9898712132", w),
                          _buildInfoRow(LucideIcons.globe, "Website", "www.randomweb.com", w),
                          _buildInfoRow(LucideIcons.mapPin, "Location", "Antigua", w),
                          _buildInfoRow(LucideIcons.building, "Business Name", "Agrofarm", w),
                          _buildInfoRow(LucideIcons.briefcase, "Firm Name", "XYZ", w),
                          _buildInfoRow(LucideIcons.file, "GST Number", "24ABCDE1234F1Z5", w),
                          _buildInfoRow(LucideIcons.user, "Authorized Representative", "Dhrumit Boricha", w),
                          _buildInfoRow(LucideIcons.map, "Address", "123 Street, City, State", w),
                          _buildInfoRow(LucideIcons.map, "Pincode", "123456", w),
                          _buildInfoRow(LucideIcons.map, "State", "Gujarat", w),
                          _buildInfoRow(LucideIcons.map, "City", "Ahmedabad", w),
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value, double w) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: w * 0.02, horizontal: w * 0.05),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(width: 1,color: Colors.black12,)
      ),
      child: Row(
        children: [
          Icon(icon, color: AppColors.lightgreen, size: w * 0.06), // Adjusted size
          SizedBox(width: 15),
          Expanded(
            child: Text(
              label,
              style: TextStyle(fontSize: w * 0.045, fontWeight: FontWeight.w600),
            ),
          ),
          Expanded(
            child: FittedBox(
              fit: BoxFit.scaleDown,
              alignment: Alignment.centerRight,
              child: Text(
                value,
                style: TextStyle(fontSize: w * 0.04, color: Colors.black54),
              ),
            ),
          ),
        ],
      ),
    );
  }
}