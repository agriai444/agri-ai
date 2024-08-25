

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


class SettingsView extends GetView<SettingsController> {
  final AppSettingProvider appSettingProvider = Get.find();

@override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final supportedLocales = LocalizationService.supportedLanguages.values.toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(Strings.settings.tr),
      ),
      body: Obx(() {
        final appSetting = appSettingProvider.appSetting.value;

        if (appSetting == null) {
          return Center(child: CircularProgressIndicator());
        }

        return SettingsList(
          sections: [
            SettingsSection(
              title: Text(Strings.common.tr),
              tiles: <SettingsTile>[
                SettingsTile.navigation(
                  leading: Icon(Icons.language),
                  title: Text(Strings.language.tr),
                  value: Obx(() => Text(controller.selectedLanguage.value.languageCode == 'en' ? 'English' : 'Arabic')),
                  onPressed: (context) => _showLanguageDialog(context, supportedLocales, theme),
                ),
                SettingsTile.switchTile(
                  onToggle: controller.toggleCustomTheme,
                  initialValue: controller.isCustomThemeEnabled.value,
                  leading: Icon(Icons.format_paint),
                  title: Text(Strings.enableCustomTheme.tr),
                ),
              ],
            ),
            SettingsSection(
              title: Text(Strings.account.tr),
              tiles: <SettingsTile>[
                SettingsTile.navigation(
                  leading: Icon(Icons.exit_to_app),
                  title: Text(Strings.signOut.tr),
                  onPressed: (context) {
                    // Implement sign-out logic here
                  },
                ),
              ],
            ),
            SettingsSection(
              title: Text(Strings.legal.tr),
              tiles: <SettingsTile>[
                SettingsTile.navigation(
                  leading: Icon(Icons.description),
                  title: Text(Strings.termsOfUse.tr),
                  onPressed: (context) {
                    if (appSetting.termsOfUseUrl != null) {
                      _launchURL(appSetting.termsOfUseUrl ?? '');
                    }
                  },
                ),
                SettingsTile.navigation(
                  leading: const Icon(Icons.privacy_tip),
                  title: Text(Strings.privacyPolicy.tr),
                  onPressed: (context) {
                    if (appSetting.privacyPolicyUrl != null) {
                      _launchURL(appSetting.privacyPolicyUrl ?? '');
                    }
                  },
                ),
              ],
            ),
          ],
        );
      }),
    );
  }


 void _showLanguageDialog(BuildContext context, List<Locale> supportedLocales, ThemeData theme) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(Strings.chooseLanguage.tr),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: supportedLocales.map((locale) {
            return ListTile(
              title: Text(locale.languageCode == 'en' ? 'English' : 'Arabic'),
              onTap: () {
                controller.updateLanguage(locale);
                Get.back();
              },
            );
          }).toList(),
        ),
      ),
    );
  }

  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
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
