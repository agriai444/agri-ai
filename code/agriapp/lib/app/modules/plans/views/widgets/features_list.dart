import 'package:agri_ai/config/translations/strings_enum.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class FeaturesListWidget extends StatelessWidget {
  final List<String> features = [
  //   Strings.chatAIExpert.tr,
  // Strings.chatHumanExpert.tr,
  Strings.aiAdvice.tr,
  Strings.humanAdvice.tr,
  Strings.chatHumanExpert.tr,
  ];

   FeaturesListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: features.map((feature) => FeatureItem(text: feature)).toList(),
    );
  }
}

class FeatureItem extends StatelessWidget {
  final String text;

  const FeatureItem({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          const Icon(Icons.check_circle, color: Colors.green),
          const SizedBox(width: 10),
          Expanded(child: Text(text)),
        ],
      ),
    );
  }
}