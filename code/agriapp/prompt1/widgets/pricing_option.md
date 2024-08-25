

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
    Key? key,
    required this.title,
    this.subtitle,
    required this.price,
    this.isPopular = false,
    this.isHighlighted = false,
    this.savings,
  }) : super(key: key);

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
