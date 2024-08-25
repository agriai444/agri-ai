

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



class ChatDetailScreen extends StatelessWidget {
  const ChatDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //Get.lazyPut(() => ChatDetailControllerImpl());
    ChatDetailControllerImpl controller = Get.put(ChatDetailControllerImpl());
    return Scaffold(
      backgroundColor: AppColor.blueGrey,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(AppSize.screenHeight! * .07),
          child: const CustomAppBar()),
      body: Container(
        width: AppSize.screenWidth,
        height: AppSize.screenHeight,
        decoration: const BoxDecoration(
            color: Colors.transparent,
            image: DecorationImage(
                image: AssetImage(AppImage.bg), fit: BoxFit.cover)),
        child: WillPopScope(
          onWillPop: () => controller.onWillPop(),
          child: Column(
            children: [
              Expanded(
                  child: GetBuilder<ChatDetailControllerImpl>(
                builder: (controller) => ListView.builder(
                  controller: controller.scrollController,
                  itemBuilder: (context, index) {
                    if (index == controller.messages.length) {
                      return const VerticalSpacer(7);
                    }
                    return MessageChat(
                      isSender: controller.messages[index].type == "sender"
                          ? true
                          : false,
                      message: controller.messages[index].message,
                      date: controller.messages[index].date,
                    );
                  },
                  itemCount: controller.messages.length + 1,
                ),
              )),
              Align(
                alignment: Alignment.bottomCenter,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Row(
                      children: [
                        Container(
                            margin: const EdgeInsets.only(
                                left: 2, right: 2, bottom: 10),
                            width: AppSize.screenWidth! - 60,
                            child: const MessageInput()),
                        Container(
                          margin: const EdgeInsets.only(
                              left: 3, right: 3, bottom: 10),
                          child: CircleAvatar(
                            radius: 25,
                            backgroundColor: AppColor.second,
                            child: IconButton(
                                onPressed: () => controller.sendMessge(),
                                icon: GetBuilder<ChatDetailControllerImpl>(
                                  builder: (controller) => Icon(
                                      controller.isSend
                                          ? Icons.send
                                          : Icons.mic,
                                      color: AppColor.white),
                                )),
                          ),
                        ),
                      ],
                    ),
                    GetBuilder<ChatDetailControllerImpl>(
                      builder: (controller) => controller.isEmojiShow
                          ? CustomEmoji(
                              onEmojiSelected: (category, emoji) =>
                                  controller.onEmojiSelected(category, emoji),
                            )
                          : const SizedBox(),
                    )
                  ],
                ),
              )
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
