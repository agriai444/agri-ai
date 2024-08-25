

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



class VideoViewScreen extends StatelessWidget {
  const VideoViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    VideoViewControllerImpl controller = Get.put(VideoViewControllerImpl());
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: AppSize.screenHeight,
          width: AppSize.screenWidth,
          color: Colors.transparent,
          child: Stack(
            children: [
              SizedBox(
                height: AppSize.screenHeight! - 20,
                width: AppSize.screenWidth,
                child: GetBuilder<VideoViewControllerImpl>(
                  builder: (controller) =>
                      controller.playerController.value.isInitialized
                          ? AspectRatio(
                              aspectRatio:
                                  controller.playerController.value.aspectRatio,
                              child: VideoPlayer(controller.playerController))
                          : Container(),
                ),
              ),
              Align(
                  alignment: Alignment.center,
                  child: GetBuilder<VideoViewControllerImpl>(
                    builder: (controller) => HeaderButton(
                      icon: controller.playerController.value.isLooping ||
                              !controller.isCompleted
                          ? Icons.pause
                          : Icons.play_arrow,
                      isVideo: true,
                      onPressed: () => controller.playVideo(),
                    ),
                  )),
              Positioned(
                bottom: 0,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  color: AppColor.black,
                  width: AppSize.screenWidth,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Expanded(flex: 6, child: CaptionInput()),
                      Expanded(
                          child: HeaderButton(
                              icon: Icons.check,
                              color: AppColor.second,
                              onPressed: () {}))
                    ],
                  ),
                ),
              ),
              Positioned(
                  top: 10,
                  right: 10,
                  left: 10,
                  child: Row(
                    children: [
                      HeaderButton(
                          icon: controller.headersItems[0]["icon"],
                          onPressed: controller.headersItems[0]["function"]),
                      const Spacer(),
                      ...List.generate(controller.headersItems.length - 1,
                          (index) {
                        return HeaderButton(
                            icon: controller.headersItems[index + 1]["icon"],
                            onPressed: controller.headersItems[index + 1]
                                ["function"]);
                      })
                    ],
                  )),
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
