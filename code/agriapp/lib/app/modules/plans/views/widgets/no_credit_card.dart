import 'package:flutter/material.dart';

class NoCreditCardWidget extends StatelessWidget {
  const NoCreditCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.credit_card_off, size: 16),
        SizedBox(width: 8),
        Text('No payment now. Cancel anytime'),
      ],
    );
  }
}

class TryForFreeButton extends StatelessWidget {
  const TryForFreeButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: const Text('Try for Free'),
      style: ElevatedButton.styleFrom(
      
        padding: const EdgeInsets.symmetric(vertical: 16),
      ),
      onPressed: () {
        // Handle button press
      },
    );
  }
}

class TermsAndPolicyWidget extends StatelessWidget {
  const TermsAndPolicyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        TextButton(
          child: const Text('Terms of Use'),
          onPressed: () {
            // Handle Terms of Use
          },
        ),
        TextButton(
          child: const Text('Restore'),
          
          onPressed: () {
            // Handle Restore
          },
        ),
        TextButton(
          child: const Text('Privacy Policy'),
          onPressed: () {
            // Handle Privacy Policy
          },
        ),
      ],
    );
  }
}