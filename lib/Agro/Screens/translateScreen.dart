import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mlkit_translation/google_mlkit_translation.dart';
import 'package:new_app/Controllers/Translate_Controller.dart';

class ApiTranslatorScreen extends StatelessWidget {
  final ApiTranslateController controller = Get.put(ApiTranslateController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: controller.currentLanguage.value == TranslateLanguage.english
          ? AppBar(title: const Text('API Data Translator'))
          : null,
      body: Column(
        children: [
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: controller.fetchData,
            child: const Text('Fetch API Data'),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () => _showLanguageBottomSheet(context),
            child: const Text('Edit Language'),
          ),
          const SizedBox(height: 10),
          Obx(() {
            if (controller.isLoading.value) {
              return const CircularProgressIndicator();
            }

            if (controller.isTranslating.value) {
              return const CircularProgressIndicator();
            }

            return Expanded(
              child: ListView.builder(
                itemCount: controller.apiData.length,
                itemBuilder: (context, index) {
                  final item = controller.apiData[index];
                  return ListTile(
                    title: Text(item['title'] ?? 'No Title'),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(item['description'] ?? 'No Description'),
                        Text('Category: ${item['category'] ?? 'No Category'}'),
                      ],
                    ),
                  );
                },
              ),
            );
          }),
        ],
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
                  controller.translateData(TranslateLanguage.english);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('Hindi'),
                onTap: () {
                  controller.translateData(TranslateLanguage.hindi);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('Gujarati'),
                onTap: () {
                  controller.translateData(TranslateLanguage.gujarati);
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
