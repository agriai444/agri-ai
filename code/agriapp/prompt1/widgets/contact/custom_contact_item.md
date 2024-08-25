

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


class CustomContactItem extends StatelessWidget {
  final String name;
  final String? secondeName;
  final bool? isSecond;
  final VoidCallback? onTap;
  final IconData? icon;
  final bool isSelect;
  const CustomContactItem(
      {super.key,
      required this.name,
      this.secondeName,
      this.isSecond,
      this.onTap,
      this.icon,
      required this.isSelect});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Stack(
        children: [
          CircleAvatar(
            backgroundColor: isSecond == false || isSecond == null
                ? AppColor.blueGrey200
                : AppColor.second,
            radius: 23,
            child: Icon(
                isSecond == false || isSecond == null ? Icons.person : icon,
                size: 25,
                color: AppColor.white),
          ),
          isSecond == false || isSecond == null && isSelect == true
              ? const Positioned(
                  bottom: 0,
                  right: 0,
                  child: CircleAvatar(
                      radius: 12,
                      backgroundColor: AppColor.second,
                      child:
                          Icon(Icons.check, color: AppColor.white, size: 16)),
                )
              : const SizedBox(),
        ],
      ),
      title: name == "New contact"
          ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.bold),
                ),
                Icon(Icons.qr_code, size: 26, color: AppColor.blueGrey)
              ],
            )
          : Text(
              name,
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
      subtitle: isSecond == false || isSecond == null
          ? Text(
              secondeName!,
              style:
                  const TextStyle(fontSize: 13, fontWeight: FontWeight.normal),
            )
          : null,
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
