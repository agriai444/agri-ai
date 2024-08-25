import 'package:agri_ai/config/translations/strings_enum.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart'; // Add this dependency in pubspec.yaml

class NoCreditCardWidget extends StatelessWidget {
  const NoCreditCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return  Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.credit_card_off, size: 16),
        const SizedBox(width: 8),
        Text(Strings.noCreditCard.tr),
      ],
    );
  }
}

class TryForFreeButton extends StatelessWidget {
  const TryForFreeButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 16),
      ),
      onPressed: () {
        // Handle button press
      },
      child:  Text(Strings.tryForFree.tr),
    );
  }
}

class TermsAndPolicyWidget extends StatelessWidget {
  final String? termsOfUseUrl;
  final String? privacyPolicyUrl;

  const TermsAndPolicyWidget({super.key, this.termsOfUseUrl, this.privacyPolicyUrl});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        TextButton(
          child:  Text(
            Strings.termsOfUse.tr,
            style: const TextStyle(
              fontSize: 12, // Small font size
              color: Colors.grey, // Gray color
              decoration: TextDecoration.underline, // Underline
            ),
          ),
          onPressed: () {
            if (termsOfUseUrl != null) {
              _launchURL(termsOfUseUrl!);
            }
          },
        ),
        TextButton(
          child:  Text(
            Strings.pricingOptions.tr,
            style: const TextStyle(
              fontSize: 12, // Small font size
              color: Colors.grey, // Gray color
              decoration: TextDecoration.underline, // Underline
            ),
          ),
          onPressed: () {
            // Handle Restore
          },
        ),
        TextButton(
          child:  Text(
            Strings.privacyPolicy.tr,
            style: const TextStyle(
              fontSize: 12, // Small font size
              color: Colors.grey, // Gray color
              decoration: TextDecoration.underline, // Underline
            ),
          ),
          onPressed: () {
            if (privacyPolicyUrl != null) {
              _launchURL(privacyPolicyUrl!);
            }
          },
        ),
      ],
    );
  }

  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
