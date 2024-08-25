

strings_enum.dart:
```dart

    static const String hello = 'hello';
    static const String loading = 'loading';

    static const String noInternetConnection = 'no internet connection';
    static const String serverNotResponding = 'server not responding';

```
en_us_translation.dart:
```dart

    Strings.hello : 'Hello!',
    Strings.loading : 'Loading',

    Strings.noInternetConnection : 'No internet connection!',
    Strings.serverNotResponding : 'Server is not responding!',

```
and use like Text(Strings.hello.tr)

now add translate for this code

```dart


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
  final String? termsOfUseUrl;
  final String? privacyPolicyUrl;

  const TermsAndPolicyWidget({super.key, this.termsOfUseUrl, this.privacyPolicyUrl});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        TextButton(
          child: const Text(
            'Terms of Use',
            style: TextStyle(
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
          child: const Text(
            'Restore',
            style: TextStyle(
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
          child: const Text(
            'Privacy Policy',
            style: TextStyle(
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

```

        i want answer like below formate. dont added any thing explain 
### Step 1: Update `Strings` Class

```dart
    // New keys for SplashPageView
    static const String agricultural = 'agricultural';
    static const String expert = 'expert';
    static const String companionText = 'companion_text';

```

### Step 2: Update `en_us_translation.dart`

```dart

    // Translations for SplashPageView
    Strings.agricultural : 'Agricultural',
    Strings.expert : 'Expert',
    Strings.companionText : 'Your companion for agricultural expertise',

```

### Step 3: write new code to Use Translations liks Strings.agricultural.tr

```dart



```
