

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


class MessageInput extends StatelessWidget {
  const MessageInput({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChatDetailControllerImpl>(
        builder: (controller) => TextFormField(
              controller: controller.message,
              focusNode: controller.focusNode,
              keyboardType: TextInputType.multiline,
              maxLines: 5,
              minLines: 1,
              onChanged: (value) => controller.changeMessageToVoice(value),
              decoration: InputDecoration(
                  filled: true,
                  fillColor: AppColor.white,
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  hintText: "Type a message",
                  prefixIcon: IconButton(
                      onPressed: () => controller.showEmojiKeyborad(),
                      icon: const Icon(Icons.emoji_emotions)),
                  suffixIcon: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () {
                          Get.bottomSheet(
                              elevation: 0,
                              backgroundColor: Colors.transparent,
                              Container(
                                margin: const EdgeInsets.all(15),
                                width: AppSize.screenWidth,
                                height: AppSize.screenHeight! * .25,
                                decoration: BoxDecoration(
                                  color: AppColor.white,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Wrap(
                                  runAlignment: WrapAlignment.center,
                                  alignment: WrapAlignment.center,
                                  spacing: 60,
                                  runSpacing: 20,
                                  children: [
                                    ...List.generate(
                                      controller.bottomSheetItems.length,
                                      (index) => IconBottomSheet(
                                          text: controller
                                              .bottomSheetItems[index]["text"],
                                          icon: controller
                                              .bottomSheetItems[index]["icon"],
                                          backgroundColor: controller
                                              .bottomSheetItems[index]["color"],
                                          onTap:
                                              controller.bottomSheetItems[index]
                                                  ["function"]),
                                    ),
                                  ],
                                ),
                              ));
                        },
                        icon: const Icon(Icons.attach_file),
                      ),
                      !controller.isSend
                          ? IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.camera_alt))
                          : const SizedBox()
                    ],
                  ),
                  border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(25))),
            ));
  }
}

class IconBottomSheet extends StatelessWidget {
  final String text;
  final IconData icon;
  final Color backgroundColor;
  final VoidCallback onTap;
  const IconBottomSheet(
      {super.key,
      required this.text,
      required this.icon,
      required this.backgroundColor,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: backgroundColor,
            child: Icon(icon, size: 25, color: AppColor.white),
          ),
          const VerticalSpacer(0.5),
          Text(
            text,
            style: const TextStyle(fontSize: 13),
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
