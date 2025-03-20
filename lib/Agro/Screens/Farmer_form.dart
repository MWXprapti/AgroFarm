import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_app/Theme/theme.dart';

class FarmerProfileForm extends StatefulWidget {
  @override
  _FarmerProfileFormState createState() => _FarmerProfileFormState();
}

class _FarmerProfileFormState extends State<FarmerProfileForm> {
  String? selectedReferral = 'other';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightgreen,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 200),
          child: SingleChildScrollView(
            child: Container(
              height:MediaQuery.of(context).size.height*0.77 ,
              decoration: BoxDecoration(
                color: AppColors.bgcolor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(50),
                ),
              ),
              padding: const EdgeInsets.only(top: 40, left: 16, right: 16, bottom: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _buildTextField("Name", Icons.person),
                  SizedBox(height: 16),
                  _buildTextField("Mobile Number", Icons.phone, TextInputType.phone),
                  SizedBox(height: 16),
                  _buildTextField("Crop Name", Icons.grass),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("Land Size (Acres)", style: AppTextStyles.bodyStyle),
                    ],
                  ),
                  SizedBox(height: 4),
                  _buildDropdown(['1', '2', '3', '4', '5+'], "1"),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("Referred By", style: AppTextStyles.bodyStyle),
                    ],
                  ),
                  SizedBox(height: 4),
                  _buildReferralDropdown(),
                  if (selectedReferral == 'Agent') ...[
                    SizedBox(height: 16),
                    _buildTextField("Referral Code", Icons.vpn_key),
                  ],
                  SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.yellow,
                        padding: EdgeInsets.symmetric(vertical: 16),
                      ),
                      onPressed: () {
                        Get.toNamed("dash");
                      },
                      child: Text("Submit", style: AppTextStyles.bodyStyle.copyWith(color: Colors.white)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, IconData icon, [TextInputType type = TextInputType.text]) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTextStyles.bodyStyle),
        SizedBox(height: 4),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 6,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: TextField(
            keyboardType: type,
            decoration: InputDecoration(
              border: InputBorder.none,
              prefixIcon: Icon(icon, color: AppColors.lightgreen),
              hintText: "Enter $label",
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDropdown(List<String> items, String defaultValue) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      padding: EdgeInsets.symmetric(horizontal: 12),
      child: DropdownButtonFormField<String>(
        value: defaultValue,
        onChanged: (value) {},
        items: items.map((size) => DropdownMenuItem(value: size, child: Text(size))).toList(),
        decoration: InputDecoration(border: InputBorder.none),
      ),
    );
  }

  Widget _buildReferralDropdown() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      padding: EdgeInsets.symmetric(horizontal: 12),
      child: DropdownButtonFormField<String>(
        value: selectedReferral,
        onChanged: (value) {
          setState(() {
            selectedReferral = value;
          });
        },
        items: ['other', 'Agent', 'Social Media']
            .map((ref) => DropdownMenuItem(value: ref, child: Text(ref)))
            .toList(),
        decoration: InputDecoration(border: InputBorder.none),
      ),
    );
  }
}
