import 'package:flutter/material.dart';


class FeaturesListWidget extends StatelessWidget {
  final List<String> features = [
    'Professional planting advice',
    'Detailed plant care tutorials',
    'Highly accurate plant identifier',
    'Quick diagnosis & instant solutions',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: features.map((feature) => FeatureItem(text: feature)).toList(),
    );
  }
}

class FeatureItem extends StatelessWidget {
  final String text;

  const FeatureItem({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(Icons.check_circle, color: Colors.green),
          SizedBox(width: 10),
          Expanded(child: Text(text)),
        ],
      ),
    );
  }
}