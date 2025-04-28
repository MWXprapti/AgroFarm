import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:new_app/Controllers/farmerProfileFetch_Controller.dart';
import 'package:new_app/Theme/theme.dart';
import 'dart:convert';

class FarmerProfilePage extends StatefulWidget {
  @override
  _FarmerProfilePageState createState() => _FarmerProfilePageState();
}

class _FarmerProfilePageState extends State<FarmerProfilePage> {
  late ScrollController _scrollController;
  double _scrollOffset = 0.0;

  final FarmerProfileFetchController controller_ = Get.put(FarmerProfileFetchController());

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      setState(() {
        _scrollOffset = _scrollController.offset;
      });
    });


    // Fetch farmer details when the page opens
    controller_.fetchFarmerDetails();
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
                  size: w * 0.08,
                ),
                onPressed: () => Get.back(),
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 30),
                child: IconButton(
                  icon: Icon(FontAwesomeIcons.userPen, size: w * 0.06),
                  onPressed: () {
                    Get.toNamed("/editProfile");
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
                  title: Obx(() => Text(
                    controller_.name.value,
                    style: TextStyle(
                      fontSize: w * 0.05,
                      fontWeight: FontWeight.bold,
                      color: Color.lerp(Colors.white, Colors.black, percent),
                    ),
                  )),
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
                        bottom: 100,
                        child: Obx(() {
                          final imageData = controller_.profileImage.value;
                          print("📸 Profile Image Length: ${imageData?.length ?? 0} bytes");

                          bool isImageValid = imageData != null && imageData.length > 500;

                          return CircleAvatar(
                            backgroundColor: Colors.grey.shade200,
                            radius: 50,
                            backgroundImage: NetworkImage(controller_.profileImage.value),
                            // backgroundImage: isImageValid ? NetworkImage("https://admin.multiwebx.com/farmerAPI/uploads/userProfile/1744026182.png") : null,
                            child: !isImageValid
                                ? Icon(Icons.person, size: 50, color: Colors.grey)
                                : null,
                          );
                        }),
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
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      color: AppColors.bgcolor,
                      child: Column(
                        children: [
                          Obx(() => _buildInfoRow(LucideIcons.phone, "Phone", controller_.phone.value, w)),
                          Obx(() => _buildInfoRow(LucideIcons.building, "City", controller_.city.value, w)),
                          Obx(() => _buildInfoRow(LucideIcons.mapPin, "State", controller_.state.value, w)),
                          Obx(() => _buildInfoRow(LucideIcons.map, "Address", controller_.address.value, w)),
                          Obx(() => _buildInfoRow(LucideIcons.code, "Pin Code", controller_.pincode.value, w)),
                          Obx(() => _buildInfoRow(LucideIcons.crop, "Crop Name", controller_.cropName.value, w)),
                          Obx(() => _buildInfoRow(LucideIcons.briefcase, "Land Size", controller_.landSize.value, w)),
                          Obx(() => _buildInfoRow(LucideIcons.user, "Referred By", controller_.referredBy.value, w)),
                          Obx(() => _buildInfoRow(LucideIcons.user, "Agent Name/Referral Code", controller_.agentName.value, w)),
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
        border: Border.all(width: 1, color: Colors.black12),
      ),
      child: Row(
        children: [
          Icon(icon, color: AppColors.lightgreen, size: w * 0.06),
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
                value.isNotEmpty ? value : "N/A",
                style: TextStyle(fontSize: w * 0.04, color: Colors.black54),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
