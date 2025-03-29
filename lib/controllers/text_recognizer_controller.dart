import 'dart:io';
import 'package:get/get.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class TextRecognizerController extends GetxController {
  final _scannedText = ''.obs;
  final _isScanning = false.obs;
  final _picker = ImagePicker();

  String get scannedText => _scannedText.value;
  bool get isScanning => _isScanning.value;

  Future<void> getImage(ImageSource source) async {
    if (source == ImageSource.camera) {
      var status = await Permission.camera.request();
      if (status.isDenied) return;
    }

    final XFile? image = await _picker.pickImage(source: source);

    if (image != null) {
      _setScanning(true);
      _updateScannedText("جاري تحليل الصورة...");

      await _processImage(image);
    }
  }

  Future<void> _processImage(XFile image) async {
    final File imageFile = File(image.path);
    final InputImage inputImage = InputImage.fromFile(imageFile);
    final textRecognizer = TextRecognizer(
      script: TextRecognitionScript.latin,
    );

    try {
      final RecognizedText recognizedText = await textRecognizer.processImage(
        inputImage,
      );
      
      _updateScannedText(recognizedText.text);
    } catch (e) {
      _updateScannedText("حدث خطأ أثناء تحليل الصورة");
    } finally {
      textRecognizer.close();
      _setScanning(false);
    }
  }

  void _setScanning(bool scanning) {
    _isScanning.value = scanning;
  }

  void _updateScannedText(String text) {
    _scannedText.value = text;
  }
} 