

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

// welcome_widget.dart

class WelcomeChat extends GetView<ChatAiChatController> {
  const WelcomeChat({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Check if the current conversation is 'Agri-Expert'
    final isAgriExpert = controller.isCurrentAgriConv();

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Image logo
          Image.asset(
            'assets/images/app_icon.png',
            width: 100.w,
            height: 100.h,
            fit: BoxFit.cover,
          ),
          SizedBox(height: 10.h),
          // Bold welcome message
          GradientText(
            text: isAgriExpert ? 'Agricultural Expert' : 'Welcome',
          ),
          SizedBox(height: 10.h),
          // Description text
          Text(
            isAgriExpert
                ? 'You can chat and get help for your plants with our Agricultural Expert.'
                : 'You can chat and get help for your plants.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 13.sp,
            ),
          ),
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
