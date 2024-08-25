

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



class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    HomeControllerImpl controller = Get.put(HomeControllerImpl());
    return DefaultTabController(
      length: controller.tabBarViews.length,  // Adjust based on the number of tabs/views
      child: Scaffold(
        appBar: AppBar(
          title: const Text(AppString.appName),
          actions: [
            // IconButton(
            //   onPressed: () => controller.goToCameraScreen(),
            //   icon: const Icon(Icons.camera_alt_rounded),
            // ),
            // IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
            // PopupMenuButton(
            //   onSelected: (value) => controller.selectPopMenu(value),
            //   itemBuilder: (context) {
            //     return List.generate(
            //       controller.popMenuItems.length,
            //       (index) => PopupMenuItem(
            //         value: controller.popMenuItems[index],
            //         child: Text(controller.popMenuItems[index]),
            //       ),
            //     );
            //   },
            // ),
          ],
          // bottom: TabBar(
          //   tabs: List.generate(
          //     controller.tabBarViews.length,
          //     (index) => Tab(text: 'Tab ${index + 1}'), // Customize as needed
          //   ),
          // ),
        ),
        
        body: TabBarView(
          children: List.generate(
            controller.tabBarViews.length,
            (index) => controller.tabBarViews[index],
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
