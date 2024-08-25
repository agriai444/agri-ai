

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


class ChatAgriChatView extends GetView<ChatAgriChatController> {
  const ChatAgriChatView({super.key});

  @override
  Widget build(BuildContext context) {
    // ChatAgriChatController controller = Get.put(ChatAgriChatController());
    
return 
Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              const CircleAvatar(
                backgroundImage: AssetImage('assets/images/supportIcon.png'),
              ),
              SizedBox(width: 10.h),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Agricultural Expert'.tr,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.circle,
                        color: Colors.greenAccent,
                        size: 12,
                      ),
                      SizedBox(width: 5.w),
                      Text(
                        'Online'.tr,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
       
        ),
        body: ChatAiView()
      );
  }
}



    // Defer navigation until after the current frame is drawn
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   controller.goToHomeScreen(0);
    // });

    // return const Scaffold(
    //   body: Center(child: CircularProgressIndicator()), 
    // );


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
