

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


class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Strings.profile.tr),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Obx(() => Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20.h),
            TextField(
              controller: controller.firstNameC,
              decoration: InputDecoration(
                labelText: Strings.firstName.tr,
                prefixIcon: const Icon(Icons.person),
                errorText: controller.firstNameError.value,
              ),
            ),
            SizedBox(height: 16.h),
            TextField(
              controller: controller.lastNameC,
              decoration: InputDecoration(
                labelText: Strings.lastName.tr,
                prefixIcon: const Icon(Icons.person),
                errorText: controller.lastNameError.value,
              ),
            ),
            SizedBox(height: 16.h),
            TextField(
              controller: controller.dateOfBirthC,
              decoration: InputDecoration(
                labelText: Strings.dateOfBirth.tr,
                prefixIcon: Icon(Icons.calendar_today),
              ),
              readOnly: true,
              onTap: () => _selectDate(context),
            ),
            SizedBox(height: 16.h),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                labelText: Strings.gender.tr,
                prefixIcon: Icon(Icons.person_outline),
              ),
              value: controller.genderC.text.isEmpty ? null : controller.genderC.text,
              items: ['Male', 'Female', 'Other'].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                controller.genderC.text = newValue ?? '';
              },
            ),
            SizedBox(height: 16.h),
            TextField(
              controller: controller.countryC,
              decoration: InputDecoration(
                labelText: Strings.country.tr,
                prefixIcon: Icon(Icons.public),
              ),
              readOnly: true,
              onTap: () {
                showCountryPicker(
                  context: context,
                  onSelect: (Country country) {
                    controller.countryC.text = country.name;
                  },
                );
              },
            ),
            SizedBox(height: 20.h),
            ElevatedButton(
              onPressed: controller.isLoading.value ? null : () => controller.updateProfile(),
              child: Text(controller.isLoading.value ? Strings.updating.tr : Strings.updateProfile.tr),
            ),
          ],
        )),
      ),
    );
  }





  void _updateProfileImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      controller.updateProfileImage(image.path);
    }
  }

  void _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      controller.dateOfBirthC.text = picked.toIso8601String().split('T')[0];
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
