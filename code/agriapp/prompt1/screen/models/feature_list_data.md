

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

class FeatureListData {
  FeatureListData({
    this.imagePath = '',
    this.titleTxt = '',
    this.startColor = '',
    this.endColor = '',
    this.description,
  });

  String imagePath;
  String titleTxt;
  String startColor;
  String endColor;
  String? description;

  static List<FeatureListData> tabIconsList = <FeatureListData>[
    FeatureListData(
      imagePath: 'assets/fitness_app/chat_ai.png',
      titleTxt: 'Chat AI Agricultural Expert',
      description: 'Get instant advice from our AI expert.',
      startColor: '#FA7D82',
      endColor: '#FFB295',
    ),
    FeatureListData(
      imagePath: 'assets/fitness_app/chat_human.png',
      titleTxt: 'Chat Human Agricultural Expert',
      description: 'Talk to a human expert for personalized advice.',
      startColor: '#738AE6',
      endColor: '#5C5EDD',
    ),
  ];
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
