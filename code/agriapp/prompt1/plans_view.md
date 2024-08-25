

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


class PlansView extends GetView<PlansController> {
  const PlansView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AppSettingProvider appSettingProvider = Get.find();
    final appSetting = appSettingProvider.appSetting.value;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: const EdgeInsets.only(
                  left: 20.0,
                  right: 20.0,
                  top: 16,
                  bottom: 16,
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GradientText(text: 'Try For Free'),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: FeaturesListWidget(),
              ),
              const SizedBox(height: 20),
              const PricingOptionsWidget(),
              const SizedBox(height: 20),
              const NoCreditCardWidget(),
              const SizedBox(height: 20),
              const TryForFreeButton(),
              TermsAndPolicyWidget(
                termsOfUseUrl: appSetting?.termsOfUseUrl,
                privacyPolicyUrl: appSetting?.privacyPolicyUrl,
              ),
            ],
          ),
        ),
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
