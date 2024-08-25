

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

// more_view.dart
// more_view.dart

class MoreView extends GetView<MoreController> {
  final AuthController authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    final MoreController controller = Get.put(MoreController());

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            children: [
              SizedBox(height: 20.h),
              UserProfileWidget(),
              SizedBox(height: 20.h),
              MenuItemWidget(
                icon: Icons.person,
                title: Strings.profile.tr,
                onTap: () {
                  Get.toNamed(Routes.PROFILE);
                },
              ),
              MenuItemWidget(
                icon: Icons.settings,
                title: Strings.settings.tr,
                onTap: () {
                  Get.toNamed(Routes.SETTINGS);
                },
              ),
              MenuItemWidget(
                icon: Icons.star,
                title: Strings.rateOurApp.tr,
                onTap: controller.rateApp,
              ),
              MenuItemWidget(
                icon: Icons.share,
                title: Strings.shareTheApp.tr,
                onTap: controller.shareApp,
              ),
              MenuItemWidget(
                icon: Icons.logout,
                title: Strings.logout.tr,
                onTap: () async {
                  await authController.logout();
                },
                textColor: Colors.red,
                iconColor: Colors.red,
              ),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }
}


class UserProfileWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final local_user.User? currentUser = MyHive.getCurrentUser();

    return Column(
      children: [
        SizedBox(height: 20.h),
        CircleAvatar(
          radius: 50.r,
          backgroundColor: Colors.grey[300],
          backgroundImage: currentUser?.avatarUrl != null && currentUser!.avatarUrl!.isNotEmpty
              ? NetworkImage(currentUser.avatarUrl!)
              : null,
          child: currentUser?.avatarUrl == null || currentUser!.avatarUrl!.isEmpty
              ? Icon(Icons.person, size: 50.r, color: Colors.grey[600])
              : null,
        ),
        SizedBox(height: 10.h),
        Text(
          '${currentUser?.firstName ?? ''} ${currentUser?.lastName ?? ''}',
          style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
        ),
      ],
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
