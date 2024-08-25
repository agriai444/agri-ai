

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


class AuthLoginView extends GetView<AuthLoginController> {
  final authC = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 30),
              // Add an image here
              Center(
                child: Image.asset(
                  'assets/images/login.png', // Path to your image asset
                  height: 100.h, // Adjust the height as needed
                ),
              ),
          
              Container(
                padding: const EdgeInsets.only(
                  left: 20.0,
                  right: 20.0,
                  top: 16,
                  bottom: 16,
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GradientText(text: 'Welcome'),
                    GradientText(text: 'Back!'),
                  ],
                ),
              ),
             
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                ),
                margin: const EdgeInsets.all(3), // Border width
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextField(
                        autocorrect: false,
                        controller: controller.emailC,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          labelText: "Email",
                          prefixIcon: const Icon(Icons.email),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: Colors.blue),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                                const BorderSide(color: Colors.blue, width: 2),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Obx(() => TextField(
                            autocorrect: false,
                            controller: controller.passwordC,
                            textInputAction: TextInputAction.done,
                            obscureText: controller.isHidden.value,
                            decoration: InputDecoration(
                              labelText: "Password",
                              prefixIcon: const Icon(
                                Icons.lock,
                              ),
                              suffixIcon: IconButton(
                                onPressed: () => controller.isHidden.toggle(),
                                icon: Icon(
                                  controller.isHidden.isTrue
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                ),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                    color: Color.fromARGB(255, 243, 33, 173),
                                    width: 2),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                    color: Colors.blue, width: 2),
                              ),
                            ),
                          )),
                      const SizedBox(height: 30),
                      Obx(() => ElevatedButton(
                            onPressed: () async {
                              if (controller.isLoading.isFalse) {
                                bool? cekAutoLogout = await controller.login();
                                if (cekAutoLogout != null &&
                                    cekAutoLogout == true) {
                                  await authC.logout();
                                  Get.offAllNamed(Routes.HOME);
                                }
                              }
                            },
                            child: Text(
                              controller.isLoading.isFalse
                                  ? "Login"
                                  : "Loading...",
                              style: const TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(38.0),
                              ),
                              minimumSize: const Size(double.infinity, 50),
                            ),
                          )),
                            SizedBox(height: 20.h),
                  Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Dont have an account yet? ',
                    style: TextStyle(
                      color: Colors.grey,
                   
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Get.toNamed('/signup'), 
                    child: GradientUnderlineText(
                      text: 'Sign Up',
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
                ),
              ),
            ],
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
