

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



class AuthSignupView extends GetView<AuthSignupController> {
  const AuthSignupView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(8.0.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.all(16.0.h),
                  child: Row(
                    children: [
                      Obx(() => Visibility(
                        visible: controller.currentStep.value > 0,
                        child: IconButton(
                          icon: const Icon(Icons.arrow_back),
                          onPressed: controller.currentStep.value > 0 ? controller.previousPage : null,
                        ),
                      )),
                    ],
                  ),
                ),
                SizedBox(height: 30.h),
                 Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GradientText(text: Strings.create.tr),
                    GradientText(text: Strings.account.tr),
                  ],
                ),
                SizedBox(height: 30.h),
                
                ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height - 160.h, 
                  ),
                  child: PageView(
                    controller: controller.pageController,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      StepOne(controller: controller),
                      StepTwo(controller: controller),
                      StepThree(controller: controller),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class StepOne extends StatelessWidget {
  final AuthSignupController controller;
  const StepOne({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0.h),
      child: Column(
        children: [
          Obx(() => TextField(
            controller: controller.firstNameC,
            focusNode: controller.firstNameFocus,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
              labelText: Strings.firstName.tr,
              prefixIcon: const Icon(Icons.person),
              errorText: controller.firstNameError.value.isEmpty ? null : controller.firstNameError.value,
            ),
          )),
          SizedBox(height: 16.h),
          Obx(() => TextField(
            controller: controller.lastNameC,
            focusNode: controller.lastNameFocus,
            decoration: InputDecoration(
              labelText: Strings.lastName.tr,
              prefixIcon: const Icon(Icons.person),
              errorText: controller.lastNameError.value.isEmpty ? null : controller.lastNameError.value,
            ),
          )),
          SizedBox(height: 20.h),
          Obx(() => ElevatedButton(
            onPressed: controller.canProceed() ? controller.nextPage : null,
            child: Text(Strings.next.tr),
          )),

          SizedBox(height: 20.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                Strings.alreadyHaveAccount.tr,
                style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.normal,
                ),
              ),
              GestureDetector(
                onTap: () => Get.toNamed('/login'),
                child: GradientUnderlineText(
                  text: Strings.login.tr,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 10.h),
          const OrDivider(),
          SizedBox(height: 20.h),
          SocialMediaButtons(
            onGooglePressed: () {
              // Add Google login logic here
            },
            onFacebookPressed: () {
              // Add Facebook login logic here
            },
          ),
        ],
      ),
    );
  }
}

class StepTwo extends StatelessWidget {
  final AuthSignupController controller;
  const StepTwo({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0.h),
      child: Column(
        children: [
          TextField(
            controller: controller.countryC,
            decoration: InputDecoration(
              labelText: Strings.country.tr,
              prefixIcon: const Icon(Icons.public),
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
          SizedBox(height: 16.h),
          Obx(() => AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            margin: controller.showGenderDropdownMargin.value ? EdgeInsets.only(bottom: 20.h) : EdgeInsets.zero,
            child: DropdownButtonFormField<String>(
              decoration: InputDecoration(
                labelText: Strings.gender.tr,
                prefixIcon: const Icon(Icons.person_outline),
              ),
              value: controller.genderC.text.isEmpty ? 'Male' : controller.genderC.text,
              items: ['Male', 'Female', 'Other'].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                controller.genderC.text = newValue ?? '';
                controller.showGenderDropdownMargin.value = newValue != null && newValue.isNotEmpty;
              },
            ),
          )),
          SizedBox(height: 20.h),
          Obx(() => ElevatedButton(
            onPressed: controller.canProceed() ? controller.nextPage : null,
            child: Text(Strings.next.tr),
          )),
        ],
      ),
    );
  }
}

class StepThree extends StatelessWidget {
  final AuthSignupController controller;
  const StepThree({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0.h),
      child: Column(
        children: [
          Obx(() => TextField(
            controller: controller.emailC,
            focusNode: controller.emailFocus,
            decoration: InputDecoration(
              labelText: Strings.email.tr,
              prefixIcon: const Icon(Icons.email),
              errorText: controller.emailError.value.isEmpty ? null : controller.emailError.value,
            ),
          )),
          SizedBox(height: 16.h),
          Obx(() => TextField(
            controller: controller.passwordC,
            focusNode: controller.passwordFocus,
            obscureText: controller.isHidden.value,
            decoration: InputDecoration(
              labelText: Strings.password.tr,
              prefixIcon: const Icon(Icons.lock),
              suffixIcon: IconButton(
                icon: Icon(
                  controller.isHidden.value ? Icons.visibility : Icons.visibility_off,
                ),
                onPressed: () => controller.isHidden.toggle(),
              ),
              errorText: controller.passwordError.value.isEmpty ? null : controller.passwordError.value,
            ),
          )),
          SizedBox(height: 16.h),
          Obx(() => TextField(
            controller: controller.confirmPasswordC,
            focusNode: controller.confirmPasswordFocus,
            obscureText: controller.isHidden.value,
            decoration: InputDecoration(
              labelText: Strings.confirmPassword.tr,
              prefixIcon: const Icon(Icons.lock),
              errorText: controller.confirmPasswordError.value.isEmpty ? null : controller.confirmPasswordError.value,
            ),
          )),
          SizedBox(height: 20.h),
          Obx(() => ElevatedButton(
            onPressed: controller.canSubmit() ? controller.signUp : null,
            child: Text(controller.isLoading.isFalse ? Strings.register.tr : Strings.loading.tr),
          )),
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
