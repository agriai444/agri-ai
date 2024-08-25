

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


class MessageChat extends StatelessWidget {
  final String message;
  final DateTime date;
  final bool isSender;
  const MessageChat(
      {super.key,
      required this.isSender,
      required this.message,
      required this.date});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        constraints: BoxConstraints(maxWidth: AppSize.screenWidth! - 60),
        decoration: BoxDecoration(
          color: isSender ? AppColor.green10 : AppColor.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: const [
            BoxShadow(
                color: Colors.grey, blurRadius: 1, offset: Offset(1, 0.5)),
          ],
        ),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 5, 60, 20),
              child: Text(
                message,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
            ),
            Positioned(
              bottom: 6,
              right: 10,
              child: isSender
                  ? Row(
                      children: [
                        Text(
                          transferDate(date),
                          style:
                              TextStyle(fontSize: 13, color: AppColor.grey600),
                        ),
                        const HorizintalSpacer(0.5),
                        const Icon(Icons.done_all, size: 18)
                      ],
                    )
                  : Text(
                      transferDate(date),
                      style: TextStyle(fontSize: 13, color: AppColor.grey600),
                    ),
            )
          ],
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
