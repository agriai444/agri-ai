

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




class ContactScreen extends StatelessWidget {
  const ContactScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ContactControllerImpl controller = Get.put(ContactControllerImpl());
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Select Contact",
                style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold)),
            Text("${controller.contacts.length} contacts",
                style: const TextStyle(
                    fontSize: 13, fontWeight: FontWeight.normal)),
          ],
        ),
        actions: [
          IconButton(
              onPressed: () {}, icon: const Icon(Icons.search, size: 26)),
          PopupMenuButton(
            itemBuilder: (context) => [
              ...List.generate(
                  controller.popMenuItems.length,
                  (index) => PopupMenuItem(
                        value: Text(controller.popMenuItems[index]),
                        child: Text(controller.popMenuItems[index]),
                      ))
            ],
          )
        ],
      ),
      body: ListView(
        children: [
          const VerticalSpacer(1),
          ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: controller.buttonsItems.length,
              itemBuilder: (context, index) {
                return CustomContactItem(
                  name: controller.buttonsItems[index]["name"],
                  isSecond: true,
                  icon: controller.buttonsItems[index]["icon"],
                  onTap: controller.buttonsItems[index]["function"],
                  isSelect: false,
                );
              }),
          Container(
            margin: const EdgeInsets.fromLTRB(15, 15, 5, 10),
            child: Text(
              "Contacts on WhatsApp",
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: AppColor.blueGrey),
            ),
          ),
          ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: controller.contacts.length,
              itemBuilder: (context, index) {
                ChatModel chat = controller.contacts[index];
                return CustomContactItem(
                  name: chat.name,
                  secondeName: chat.status,
                  isSelect: chat.isSelect,
                );
              })
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
