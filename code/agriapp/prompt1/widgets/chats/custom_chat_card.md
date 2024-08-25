

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



class CustomChatCard extends StatelessWidget {
  final ChatModel chatModel;
  final VoidCallback onTap;
  const CustomChatCard(
      {super.key, required this.chatModel, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: CircleAvatar(
          radius: 25,
          backgroundColor: AppColor.blueGrey200,
          child: Icon(chatModel.isGroup ? Icons.groups : Icons.person,
              size: 30, color: AppColor.white)),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Text(
              chatModel.name,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          Text(
            chatModel.time,
            style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w300,
                color: AppColor.blueGrey200),
          ),
        ],
      ),
      subtitle: Row(
        children: [
          Icon(Icons.done_all, size: 16, color: AppColor.blueGrey200),
          const HorizintalSpacer(0.4),
          Flexible(
            child: Text(chatModel.message,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.normal,
                    color: AppColor.blueGrey)),
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
