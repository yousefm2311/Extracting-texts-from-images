import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../controllers/text_recognizer_controller.dart';
import '../widgets/scan_result_widget.dart';

class TextRecognizerScreen extends StatelessWidget {
  const TextRecognizerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(TextRecognizerController());

    return Scaffold(
      appBar: AppBar(title: const Text('Google ML Kit')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildImageSourceButtons(controller),
            const SizedBox(height: 20),
            Obx(() {
              if (controller.isScanning) {
                return const CircularProgressIndicator();
              } else if (controller.scannedText.isNotEmpty) {
                return ScanResultWidget(text: controller.scannedText);
              }
              return const SizedBox.shrink();
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildImageSourceButtons(TextRecognizerController controller) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton.icon(
          onPressed: () => controller.getImage(ImageSource.camera),
          icon: const Icon(Icons.camera_alt),
          label: const Text('الكاميرا'),
        ),
        ElevatedButton.icon(
          onPressed: () => controller.getImage(ImageSource.gallery),
          icon: const Icon(Icons.photo_library),
          label: const Text('المعرض'),
        ),
      ],
    );
  }
}
