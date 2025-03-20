import 'package:get/get.dart';
import 'package:google_mlkit_translation/google_mlkit_translation.dart';
import 'package:dio/dio.dart';

class ApiTranslateController extends GetxController {
  var apiData = <Map<String, dynamic>>[].obs;
  var isLoading = false.obs;
  var isTranslating = false.obs;
  var currentLanguage = TranslateLanguage.english.obs;

  Future<void> fetchData() async {
    try {
      isLoading.value = true;
      final response = await Dio().get('https://fakestoreapi.com/products');
      apiData.value = List<Map<String, dynamic>>.from(response.data);
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch data: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> translateData(TranslateLanguage targetLanguage) async {
    if (apiData.isEmpty) {
      Get.snackbar('Error', 'No data to translate');
      return;
    }

    try {
      isTranslating.value = true;
      currentLanguage.value = targetLanguage;
      final onDeviceTranslator = OnDeviceTranslator(
        sourceLanguage: TranslateLanguage.english,
        targetLanguage: targetLanguage,
      );

      for (var item in apiData) {
        item['title'] = await onDeviceTranslator.translateText(item['title']);
        item['description'] = await onDeviceTranslator.translateText(item['description']);
        item['category'] = await onDeviceTranslator.translateText(item['category']);
      }

      apiData.refresh();
    } catch (e) {
      Get.snackbar('Error', 'Translation failed: $e');
    } finally {
      isTranslating.value = false;
    }
  }
}
