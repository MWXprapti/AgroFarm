import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:new_app/Controllers/farmerProfileFetch_Controller.dart';
import 'package:new_app/Controllers/farmerProfileUpload_Controller.dart';
import 'package:new_app/theme/theme.dart';

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final controller_ = Get.put(FarmerProfileFetchController());
  final controller = Get.put(FarmerProfileUploadController());

  late TextEditingController phoneController;
  late TextEditingController nameController;
  late TextEditingController cityController;
  late TextEditingController stateController;
  late TextEditingController addressController;
  late TextEditingController pincodeController;
  late TextEditingController agentNameController;

  final RxString selectedCrop = ''.obs;
  final RxString selectedLandSize = ''.obs;
  final RxString selectedReferredBy = ''.obs;

  final List<String> cropOptions = ['wheat', 'rice', 'cotton', 'jute', 'sugarcane', 'Barley', 'Mustard'];
  final List<String> landSizeOptions = ['1', '2', '3', '4', '5+'];
  final List<String> referredByOptions = ['Friend', 'Agent', 'Online', 'Other'];

  @override
  void initState() {
    super.initState();
    phoneController = TextEditingController(text: controller_.phone.value);
    nameController = TextEditingController(text: controller_.name.value);
    cityController = TextEditingController(text: controller_.city.value);
    stateController = TextEditingController(text: controller_.state.value);
    addressController = TextEditingController(text: controller_.address.value);
    pincodeController = TextEditingController(text: controller_.pincode.value);
    agentNameController = TextEditingController(text: controller_.agentName.value);

    selectedCrop.value = controller_.cropName.value;
    selectedLandSize.value = controller_.landSize.value;
    selectedReferredBy.value = controller_.referredBy.value;
  }

  @override
  void dispose() {
    phoneController.dispose();
    nameController.dispose();
    cityController.dispose();
    stateController.dispose();
    addressController.dispose();
    pincodeController.dispose();
    agentNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgcolor,
      appBar: AppBar(
        backgroundColor: AppColors.lightgreen,
        title: const Text("Edit Profile", style: TextStyle(color: Colors.white)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            _buildProfileImagePicker(),
            Expanded(
              child: ListView(
                children: [
                  _buildTextField("Phone", phoneController, readOnly: true),
                  _buildTextField("User Name", nameController),
                  _buildTextField("City", cityController),
                  _buildTextField("State", stateController),
                  _buildTextField("Address", addressController),
                  _buildTextField("Pin code", pincodeController),
                  _buildDropdown(cropOptions, selectedCrop, label: "Crop Name"),
                  _buildDropdown(landSizeOptions, selectedLandSize, label: "Land Size"),
                  _buildDropdown(referredByOptions, selectedReferredBy, label: "Referred By"),
                  Obx(() {
                    return selectedReferredBy.value == 'Agent'
                        ? Column(
                      children: [
                        const SizedBox(height: 16),
                        _buildTextField("Executive Name", agentNameController),
                      ],
                    )
                        : const SizedBox.shrink();
                  }),
                  const SizedBox(height: 30),
                  Center(
                    child: ElevatedButton(
                      onPressed: _saveChanges,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.lightgreen,
                        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 12),
                        textStyle: const TextStyle(fontSize: 18),
                      ),
                      child: const Text("Save Changes"),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller, {bool readOnly = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextField(
        controller: controller,
        readOnly: readOnly,
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

  Widget _buildDropdown(List<String> items, RxString selectedItem, {required String label}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Obx(() => DropdownButtonFormField<String>(
        value: selectedItem.value.isNotEmpty ? selectedItem.value : null,
        hint: Text("Select $label"),
        onChanged: (String? newValue) {
          if (newValue != null) selectedItem.value = newValue;
        },
        items: items.map((String item) => DropdownMenuItem(value: item, child: Text(item))).toList(),
        decoration: InputDecoration(
          labelText: label,
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ),
      )),
    );
  }

  Widget _buildProfileImagePicker() {
    return Column(
      children: [
        const Text("Profile Photo", style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Obx(() {
          return Stack(
            alignment: Alignment.center,
            children: [
              GestureDetector(
                onTap: controller.pickImage,
                child: CircleAvatar(
                  radius: 70,
                  backgroundColor: Colors.grey.shade300,
                  backgroundImage: _getImageProvider(),
                  child: _getImageProvider() == null
                      ? const Icon(Icons.camera_alt, color: Colors.white, size: 30)
                      : null,
                ),
              ),
              if (controller.profileImage.value != null)
                Positioned(
                  top: 0,
                  right: 0,
                  child: GestureDetector(
                    onTap: controller.removeImage,
                    child: const CircleAvatar(
                      radius: 14,
                      backgroundColor: Colors.red,
                      child: Icon(Icons.close, color: Colors.white, size: 18),
                    ),
                  ),
                ),
            ],
          );
        }),
        const SizedBox(height: 16),
      ],
    );
  }

  ImageProvider? _getImageProvider() {
    final File? pickedImage = controller.profileImage.value;
    final String? base64Image = controller_.profileImage.value;

    if (pickedImage != null) {
      return FileImage(pickedImage);
    } else if (base64Image != null && base64Image.isNotEmpty) {
      try {
        return NetworkImage(controller_.profileImage.value!);
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  void _saveChanges() {
    controller.submitForm(
      name_: nameController.text.trim(),
      city_: cityController.text.trim(),
      state_: stateController.text.trim(),
      address_: addressController.text.trim(),
      pincode_: pincodeController.text.trim(),
      cropName_: selectedCrop.value,
      landSize_: selectedLandSize.value,
      referredBy_: selectedReferredBy.value,
      agentName_: selectedReferredBy.value == 'Agent' ? agentNameController.text.trim() : '',
    );
  }
}
