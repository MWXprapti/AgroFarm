import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_app/Controllers/farmerProfileFetch_Controller.dart';
import 'package:new_app/Controllers/farmerProfileUpload_Controller.dart';
import 'package:new_app/theme/theme.dart';

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final FarmerProfileFetchController controller_ = Get.put(FarmerProfileFetchController());
  final FarmerProfileUploadController controller = Get.put(FarmerProfileUploadController());

  late TextEditingController phoneController;
  late TextEditingController cityController;
  late TextEditingController stateController;
  late TextEditingController addressController;
  late TextEditingController pincodeController;
  late TextEditingController cropNameController;
  late TextEditingController landSizeController;
  late TextEditingController referredByController;
  late TextEditingController agentNameController;

  @override
  void initState() {
    super.initState();
    phoneController = TextEditingController(text: controller_.phone.value);
    cityController = TextEditingController(text: controller_.city.value);
    stateController = TextEditingController(text: controller_.state.value);
    addressController = TextEditingController(text: controller_.address.value);
    pincodeController = TextEditingController(text: controller_.pincode.value);
    cropNameController = TextEditingController(text: controller_.cropName.value);
    landSizeController = TextEditingController(text: controller_.landSize.value);
    referredByController = TextEditingController(text: controller_.referredBy.value);
    agentNameController = TextEditingController(text: controller_.agentName.value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgcolor,
      appBar: AppBar(
        backgroundColor: AppColors.lightgreen,
        title: Text("Edit Profile", style: TextStyle(color: Colors.white)),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            _buildTextField("Phone", phoneController),
            _buildTextField("City", cityController),
            _buildTextField("State", stateController),
            _buildTextField("Address", addressController),
            _buildTextField("Pin code", pincodeController),
            _buildTextField("Crop Name", cropNameController),
            _buildTextField("Land Size", landSizeController),
            _buildTextField("Referred by", referredByController),
            _buildTextField("Agent Name", agentNameController),
            SizedBox(height: 30),
            Center(
              child: ElevatedButton(
                onPressed: _saveChanges,
                style: ElevatedButton.styleFrom(
                  primary: AppColors.lightgreen,
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 12),
                  textStyle: TextStyle(fontSize: 18),
                ),
                child: Text("Save Changes"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  void _saveChanges() {
    controller.submitForm(
      name_: 'Farmer Name', // add actual value if needed
      city_: cityController.text,
      state_: stateController.text,
      address_: addressController.text,
      pincode_: pincodeController.text,
      cropName_: cropNameController.text,
      landSize_: landSizeController.text,
      referredBy_: referredByController.text,
      agentName_: agentNameController.text,
    );
  }
}
