import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PricingOptionsWidget extends StatelessWidget {
  const PricingOptionsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment:  MainAxisAlignment.spaceEvenly,
      children: [
        PricingOption(
          title: 'Monthly',
          price: '\$29.99/month',
          isPopular: true,
        ),
        PricingOption(
          title: 'FREE',
          subtitle: '3-day trial',
          price: 'then\n\$9.99/week',
          isHighlighted: true,
        ),
        PricingOption(
          title: 'Lifetime',
          price: '\$89.99',
          savings: 'SAVE 83%',
        ),
      ],
    );
  }
}

class PricingOption extends StatelessWidget {
  final String title;
  final String? subtitle;
  final String price;
  final bool isPopular;
  final bool isHighlighted;
  final String? savings;

  const PricingOption({
    super.key,
    required this.title,
    this.subtitle,
    required this.price,
    this.isPopular = false,
    this.isHighlighted = false,
    this.savings,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150.h,
      width: 100.w,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(color: isHighlighted ? Colors.green : Colors.grey),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
            mainAxisAlignment:  MainAxisAlignment.spaceBetween,
        children: [
          // if (isPopular) const Text('POPULAR', style: TextStyle(color: Colors.green)),
          Text(title, style:  const TextStyle(fontWeight: FontWeight.bold)),
          if (subtitle != null) 
          Text(subtitle!),

          Text(price),

          // if (savings != null)
          //   Text(savings!, style: const TextStyle(color: Colors.green)),
        ],
      ),
    );
  }
}
