

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


class TabIconData {
  TabIconData({
    required this.icon,
    required this.selectedIcon,
    required this.label,
    this.index = 0,
    this.isSelected = false,
    this.animationController,
  });

  IconData icon;
  IconData selectedIcon;
  String label;
  bool isSelected;
  int index;
  AnimationController? animationController;

  static List<TabIconData> tabIconsList = [
    TabIconData(
      icon: Icons.home_outlined,
      selectedIcon: Icons.home,
      label: 'Home',
      index: 0,
      isSelected: true,
    ),
    TabIconData(
      icon: Icons.chat_bubble_outline,
      selectedIcon: Icons.chat_bubble,
      label: 'Chat AI',
      index: 1,
      isSelected: false,
    ),
    TabIconData(
      icon: Icons.chat_bubble_outline,
      selectedIcon: Icons.chat_bubble_sharp,
      label: 'Chat',
      index: 2,
      isSelected: false,
    ),
    TabIconData(
      icon: Icons.more,
      selectedIcon: Icons.more,
      label: 'More',
      index: 3,
      isSelected: false,
    ),
  ];
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
