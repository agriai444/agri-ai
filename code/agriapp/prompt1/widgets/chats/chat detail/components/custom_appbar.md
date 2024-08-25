

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


class CustomAppBar extends GetView<ChatDetailControllerImpl> {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      actions: [
        // IconButton(onPressed: () {}, icon: const Icon(Icons.videocam)),
        // IconButton(onPressed: () {}, icon: const Icon(Icons.call)),
        // PopupMenuButton(
        //   itemBuilder: (context) => [
        //     ...List.generate(
        //         controller.popMenuItems.length,
        //         (index) => PopupMenuItem(
        //               value: Text(controller.popMenuItems[index]),
        //               child: Text(controller.popMenuItems[index]),
        //             ))
        //   ],
        // )
      ],
      leadingWidth: AppSize.screenWidth! / 6,
      leading: InkWell(
        onTap: () => controller.back(),
        child: Row(children: [
          const Icon(Icons.arrow_back, size: 24),
          CircleAvatar(
              backgroundColor: AppColor.blueGrey,
              child: Icon(controller.chat.isGroup ? Icons.groups : Icons.person,
                  size: 30, color: AppColor.white))
        ]),
      ),
      titleSpacing: 0,
      title: InkWell(
        onTap: () {},
        child: Container(
          margin: const EdgeInsets.all(6),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                controller.chat.name,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const Text(
                "Last seen today at 14:28",
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.normal),
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
