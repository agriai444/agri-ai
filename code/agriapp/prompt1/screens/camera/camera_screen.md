

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


class CameraScren extends StatelessWidget {
  const CameraScren({super.key});

  @override
  Widget build(BuildContext context) {
    CameraControllerImpl controller = Get.put(CameraControllerImpl());
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          width: AppSize.screenWidth,
          height: AppSize.screenHeight,
          child: Stack(
            children: [
              GetBuilder<CameraControllerImpl>(
                builder: (controller) => FutureBuilder(
                  future: controller.cameraValue,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return SizedBox(
                          height: AppSize.screenHeight,
                          child: CameraPreview(controller.cameraController));
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  },
                ),
              ),
              Positioned(
                  top: 15,
                  right: 15,
                  left: 15,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                          onTap: () => controller.backToHome(),
                          child: const Icon(Icons.close,
                              size: 28, color: AppColor.white)),
                      GetBuilder<CameraControllerImpl>(
                        builder: (controller) => IconButton(
                            onPressed: () => controller.openFlash(),
                            icon: Icon(
                                controller.isOpenFlash
                                    ? Icons.flash_on
                                    : Icons.flash_off,
                                color: AppColor.white,
                                size: 28)),
                      ),
                    ],
                  )),
              Positioned(
                right: 15,
                left: 15,
                bottom: AppSize.screenHeight! * 0.02,
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  width: AppSize.screenWidth,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CameraButton(
                        icon: Icons.photo_album_rounded,
                        onTap: () {},
                      ),
                      GestureDetector(
                          onTap: () => controller.takePhotoWithCamera(),
                          onLongPress: () => controller.takeVideoWithCamera(),
                          onLongPressUp: () => controller.stopRecordingVideo(),
                          child: GetBuilder<CameraControllerImpl>(
                            builder: (controller) => controller.isRecording
                                ? const Icon(
                                    Icons.radio_button_on,
                                    color: Colors.red,
                                    size: 80,
                                  )
                                : const Icon(Icons.panorama_fish_eye,
                                    color: AppColor.white, size: 80),
                          )),
                      GetBuilder<CameraControllerImpl>(
                        builder: (controller) => CameraButton(
                          icon: Icons.flip_camera_android,
                          onTap: () => controller.changePositionOfCamera(),
                        ),
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
