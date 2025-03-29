import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class ScanResultWidget extends StatelessWidget {
  final String text;

  const ScanResultWidget({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Text(text),
        ),
        const SizedBox(height: 10),
        ElevatedButton.icon(
          onPressed: () {
            Clipboard.setData(ClipboardData(text: text));
            Get.snackbar(
              'تم',
              'تم نسخ النص',
              snackPosition: SnackPosition.BOTTOM,
            );
          },
          icon: const Icon(Icons.copy),
          label: const Text('نسخ النص'),
        ),
      ],
    );
  }
} 