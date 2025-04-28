import 'dart:convert';
import 'dart:typed_data';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class FarmerProfileFetchController extends GetxController {
  var isLoading = true.obs;
  var name = "".obs;
  var phone = "".obs;
  var city = "".obs;
  var state = "".obs;
  var address = "".obs;
  var pincode = "".obs;
  var cropName = "".obs;
  var landSize = "".obs;
  var referredBy = "".obs;
  var agentName = "".obs;
  var profileImage = "".obs;

  @override
  void onInit() {
    super.onInit();
    fetchFarmerDetails();
  }

  Future<void> fetchFarmerDetails() async {
    try {
      isLoading(true);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString("auth_token");

      if (token == null) {
        Get.snackbar("Error", "Token not found. Please log in again.");
        return;
      }

      var url = Uri.parse("https://admin.multiwebx.com/farmerAPI/farmerUserAuth/");
      var response = await http.post(
        url,
        headers: {"Content-Type": "application/x-www-form-urlencoded"},
        body: {"action": "getUserDetails", "token": token},
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        if (data["status"] == "success" && data.containsKey("data")) {
          name.value = data["data"]["name"] ?? "";
          phone.value = data["data"]["mobile"] ?? "";
          city.value = data["data"]["city"] ?? "";
          state.value = data["data"]["state"] ?? "";
          address.value = data["data"]["address"] ?? "";
          pincode.value = data["data"]["pincode"] ?? "";
          cropName.value = data["data"]["cropName"] ?? "";
          landSize.value = data["data"]["landSize"] ?? "";
          referredBy.value = data["data"]["referredBy"] ?? "";
          agentName.value = data["data"]["agentName"] ?? "";
          profileImage.value = data["data"]["profileImage"]?? "";

          print(profileImage.value);

        } else {
          Get.snackbar("Error", data["message"] ?? "Invalid response");
        }
      } else {
        Get.snackbar("Error", "Failed to fetch profile");
      }
    } finally {
      isLoading(false);
    }
  }
}
