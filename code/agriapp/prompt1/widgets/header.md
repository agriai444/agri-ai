

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



class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      height: 110.h,
      width: double.infinity,
      decoration: BoxDecoration(
        color: theme.primaryColor,
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          //----------------white circles decor----------------//
          Positioned(
            right: 0,
            top: -125.h,
            child: CircleAvatar(
              backgroundColor: Colors.white.withOpacity(0.05),
              radius: 111,
            ),
          ),
          Positioned(
            right: -7.w,
            top: -160.h,
            child: CircleAvatar(
              backgroundColor: Colors.white.withOpacity(0.05),
              radius: 111,
            ),
          ),
          Positioned(
            right: -21.w,
            top: -195.h,
            child: CircleAvatar(
              backgroundColor: Colors.white.withOpacity(0.05),
              radius: 111,
            ),
          ),

          //----------------Data row----------------//
          Positioned(
            bottom: 10,
            right: 16.w,
            left: 16.w,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 39.h,
                  width: 39.h,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFE2C2),
                    borderRadius: BorderRadius.circular(8.r),
                    border: Border.all(
                      color: Colors.white,
                      width: 1
                    )
                  ),
                  child: Image.asset('assets/images/person1.png',height: double.infinity,),
                ),
                9.horizontalSpace,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '${Strings.goodMorning.tr},🌞',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      Strings.name.tr,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: Colors.white,
                        fontSize: 12.sp,
                      ),
                    ),
                  ],
                ),
                const Spacer(),

                //----------------Theme Button----------------//
                InkWell(
                  onTap: () => MyTheme.changeTheme(),
                  child: Ink(
                    child: Container(
                      height: 39.h,
                      width: 39.h,
                      decoration: theme.extension<HeaderContainerThemeData>()?.decoration,
                      child: SvgPicture.asset(
                        Get.isDarkMode ? 'assets/vectors/moon.svg' : 'assets/vectors/sun.svg',
                        fit: BoxFit.none,
                        color: Colors.white,
                        height: 10,
                        width: 10,
                      ),
                    ),
                  ),
                ),

                10.horizontalSpace,

                //----------------Language Button----------------//
                InkWell(
                  onTap: () => LocalizationService.updateLanguage(
                    LocalizationService.getCurrentLocal().languageCode == 'ar' ? 'en' : 'ar',
                  ),
                  child: Ink(
                    child: Container(
                      height: 39.h,
                      width: 39.h,
                      decoration: theme.extension<HeaderContainerThemeData>()?.decoration,
                      child: SvgPicture.asset(
                        'assets/vectors/language.svg',
                        fit: BoxFit.none,
                        color: Colors.white,
                        height: 10,
                        width: 10,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
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
