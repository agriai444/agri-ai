

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



class EmployeeMockModel {
  final String name;
  final String date;
  final String location;
  final Color backgroundColor;
  final String imagePath;

  EmployeeMockModel(this.name, this.date, this.location,this.backgroundColor,this.imagePath);
}

class EmployeesList extends StatelessWidget {
  EmployeesList({super.key});

  List<EmployeeMockModel> employees = [
    EmployeeMockModel(
        Strings.name.tr,
        '4 july 2023',
        Strings.gaza.tr,
        const Color(0xFFFFE2C2),
        'assets/images/person1.png'
    ),
    EmployeeMockModel(
      Strings.abdQader.tr,
      '16 july 2023',
      Strings.gaza.tr,
      const Color(0xFFD9839F),
      'assets/images/person2.png'
    ),
    EmployeeMockModel(
      Strings.loai.tr,
      '13 mar 2023',
      Strings.gaza.tr,
      const Color(0xFFFFE2C2),
      'assets/images/person1.png'
    ),
  ];

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var employeeItemTheme = theme.extension<EmployeeListItemThemeData>();
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                Strings.vacationingEmployees.tr,
                style: theme.textTheme.displaySmall,
              ),
              const Spacer(),
              Text(
                Strings.viewAll.tr,
                style: theme.textTheme.bodySmall?.copyWith(fontSize: 12.sp),
              ),
            ],
          ),
        ),
        20.verticalSpace,
        ListView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: employees.length,
            itemBuilder: (ctx, index) {
              return Container(
                margin: EdgeInsets.zero,
                padding: EdgeInsets.symmetric(horizontal: 20.h,vertical: 13.h),
                // border only from top and bottom
                decoration: BoxDecoration(
                  color: employeeItemTheme?.backgroundColor,
                  border: Border(
                    // bottom: BorderSide(
                    //   color: theme.dividerColor
                    // ),
                    top: BorderSide(
                      color: Get.isDarkMode ? const Color(0xFF414141) : const Color(0xFFF6F6F6),
                    ),
                  )
                ),
                child: Row(
                  children: [
                    Container(
                      height: 65.h,
                      width: 65.h,
                      decoration: BoxDecoration(
                        color: employees[index].backgroundColor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Image.asset(employees[index].imagePath),
                    ),
                    17.horizontalSpace,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(employees[index].name,style: employeeItemTheme?.nameTextStyle,),
                        4.verticalSpace,
                        Row(
                          children: [
                            SvgPicture.asset('assets/vectors/calendar.svg',color: employeeItemTheme?.iconTheme?.color,),
                            4.horizontalSpace,
                            Text(employees[index].date,style: employeeItemTheme?.subtitleTextStyle,),
                          ],
                        ),
                        6.verticalSpace,
                        Row(
                          children: [
                            SvgPicture.asset('assets/vectors/vocation.svg',color: employeeItemTheme?.iconTheme?.color,height: 15.h,),
                            4.horizontalSpace,
                            Text(employees[index].location,style: employeeItemTheme?.subtitleTextStyle,),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              );
            }),
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
