import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_app/Controllers/farmerProfileUpload_Controller.dart';
import 'package:new_app/Theme/theme.dart';

class FarmerProfileForm extends StatefulWidget {
  @override
  _FarmerProfileFormState createState() => _FarmerProfileFormState();
}

class _FarmerProfileFormState extends State<FarmerProfileForm> {
  final FarmerProfileUploadController controller = Get.put(FarmerProfileUploadController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightgreen,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 150),
          child: SingleChildScrollView(
            child: Container(
              constraints:
                  BoxConstraints(minHeight: MediaQuery.of(context).size.height),
              decoration: BoxDecoration(
                color: AppColors.bgcolor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(50),
                ),
              ),
              padding: const EdgeInsets.only(
                  top: 40, left: 16, right: 16, bottom: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _buildProfileImagePicker(controller),
                  SizedBox(height: 16),
                  _buildTextField("Name", Icons.person,
                      (val) => controller.name.value = val),
                  SizedBox(height: 16),
                  _buildTextField("City", Icons.location_city,
                      (val) => controller.city.value = val),
                  SizedBox(height: 16),
                  _buildTextField("State", Icons.location_city_sharp,
                      (val) => controller.state.value = val),
                  SizedBox(height: 16),
                  _buildTextField("Address", Icons.home,
                      (val) => controller.address.value = val),
                  SizedBox(height: 16),
                  _buildTextField(
                      "Pincode",
                      Icons.numbers,
                      (val) => controller.pincode.value = val,
                      TextInputType.phone),
                  // SizedBox(height: 16),
                  // _buildTextField("Crop Name", Icons.grass,
                  //     (val) => controller.cropName.value = val),
                  SizedBox(height: 16),
                  _buildDropdown(
                      ['wheat', 'rice', 'cotton', 'jute', 'sugarcane','Barley','Mustard'],
                      controller.cropName, label: 'Crop Name'),
                  SizedBox(height: 16),
                  _buildDropdown(
                      ['1', '2', '3', '4', '5+'], controller.landSize, label: 'Land Acer'),
                  SizedBox(height: 16),
                  _buildReferralDropdown(),
                  Obx(
                    () => controller.referredBy.value == 'Agent'
                        ? Column(
                            children: [
                              SizedBox(height: 16),
                              _buildTextField("Executive Name", Icons.vpn_key,
                                  (val) => controller.referralCode.value = val),
                            ],
                          )
                        : SizedBox.shrink(),
                  ),
                  SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.yellow,
                        padding: EdgeInsets.symmetric(vertical: 16),
                      ),
                      onPressed: () {
                        controller.submitForm(
                          name_: controller.name.value,
                          city_: controller.city.value,
                          state_: controller.state.value,
                          address_: controller.address.value,
                          pincode_: controller.pincode.value,
                          cropName_: controller.cropName.value,
                          landSize_: controller.landSize.value,
                          referredBy_: controller.referredBy.value,
                          agentName_: controller.referredBy.value == 'Agent' ? controller.referralCode.value : '',
                        );
                      },

                      child: Text(
                        "Submit",
                        style: AppTextStyles.bodyStyle
                            .copyWith(color: Colors.white),
                      ),
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

  Widget _buildProfileImagePicker(FarmerProfileUploadController controller) {
    return Column(
      children: [
        Text("Profile Photo", style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 8),
        Obx(() => Stack(
          alignment: Alignment.center,
          children: [
            GestureDetector(
              onTap: controller.pickImage,
              child: CircleAvatar(
                radius: 50,
                backgroundColor: Colors.grey.shade300,
                backgroundImage: controller.profileImage.value != null
                    ? FileImage(controller.profileImage.value!)
                    : null,
                child: controller.profileImage.value == null
                    ? Icon(Icons.camera_alt, color: Colors.white, size: 30)
                    : null,
              ),
            ),
            if (controller.profileImage.value != null)
              Positioned(
                top: 0,
                right: 0,
                child: GestureDetector(
                  onTap: controller.removeImage,
                  child: CircleAvatar(
                    radius: 14,
                    backgroundColor: Colors.red,
                    child: Icon(Icons.close, color: Colors.white, size: 18),
                  ),
                ),
              ),
          ],
        ),
        ),
      ],
    );
  }

  Widget _buildTextField(
      String label, IconData icon, Function(String) onChanged,
      [TextInputType keyboardType = TextInputType.text]) {
    return TextField(
      keyboardType: keyboardType,
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  Widget _buildDropdown(
      List<String> items,
      RxString selectedItem, {
        required String label,
      }) {
    return Obx(
          () => DropdownButtonFormField<String>(
        value: selectedItem.value.isNotEmpty ? selectedItem.value : null,
        onChanged: (String? newValue) {
          if (newValue != null) {
            selectedItem.value = newValue;
          }
        },
        items: items.map(
              (String item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(item),
            );
          },
        ).toList(),
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }


  Widget _buildReferralDropdown() {
    return Obx(
      () => DropdownButtonFormField<String>(
        value: controller.referredBy.value,
        onChanged: (String? newValue) {
          if (newValue != null) {
            controller.referredBy.value = newValue;
          }
        },
        items: [
          DropdownMenuItem(
            value: 'other',
            child: Text('Other'),
          ),
          DropdownMenuItem(
            value: 'Agent',
            child: Text('Agent'),
          ),
        ],
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
