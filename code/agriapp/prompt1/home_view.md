

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



class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
 @override
  Widget build(BuildContext context) {
    return  AppHomeScreen();
  }
  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     body: Column(
  //       children: [
  //         // ----------------------- Header ----------------------- //
  //         const Header(),

  //         // ----------------------- Content ----------------------- //
  //         GetBuilder<HomeController>(
  //           builder: (_) {
  //             return Expanded(
  //               child: MyWidgetsAnimator(
  //                 apiCallStatus: controller.apiCallStatus,
  //                 loadingWidget: () => const Center(child: CupertinoActivityIndicator(),),
  //                 errorWidget: () => ApiErrorWidget(
  //                     message: Strings.internetError.tr,
  //                     retryAction: () => controller.getData(),
  //                     padding: EdgeInsets.symmetric(horizontal: 20.w),
  //                 ),
  //                 successWidget: () => SingleChildScrollView(
  //                   child: Column(
  //                     children: [
  //                       20.verticalSpace,
  //                       // ----------------------- Attendance List Tile ----------------------- //
  //                       Padding(
  //                         padding: EdgeInsets.symmetric(horizontal: 20.w),
  //                         child: ListTile(
  //                           title: Text(Strings.attendanceRegistration.tr),
  //                           subtitle: Text(Strings.time.tr),
  //                           trailing: const Icon(Icons.arrow_forward),
  //                           leading: Container(
  //                             height: 47.h,
  //                             width: 47.h,
  //                             decoration: BoxDecoration(
  //                               color: Theme.of(context).primaryColor,
  //                               borderRadius: BorderRadius.circular(8),
  //                             ),
  //                             child: SvgPicture.asset(
  //                               'assets/vectors/profile.svg',
  //                               fit: BoxFit.none,
  //                               color: Colors.white,
  //                               height: 19.h,
  //                               width: 19.h,
  //                             ),
  //                           ),
  //                         ),
  //                       ),
  //                       20.verticalSpace,

  //                       // ----------------------- Employee details cards ----------------------- //
  //                       Padding(
  //                         padding: EdgeInsets.symmetric(horizontal: 20.w),
  //                         child: DataGrid(),
  //                       ),
  //                       20.verticalSpace,

  //                       // ----------------------- Employees List ----------------------- //
  //                       EmployeesList(),
  //                     ],
  //                   ),
  //                 ),
  //               ),
  //             );
  //           }
  //         ),
  //       ],
  //     ),
  //   );
  // }
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
