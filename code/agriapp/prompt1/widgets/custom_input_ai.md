

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


class CustomInputField extends GetView<ChatAiChatController> {
  final String hintText;

  const CustomInputField({
    Key? key,
    required this.hintText,
    required Function(String value) onSubmitted,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Obx(() {
          if (controller.isRecording.value) {
            return SocialMediaRecorder(
              startRecording: () {},
              stopRecording: (_time) {},
              sendRequestFunction: (soundFile, _time) {
                controller.selectedMediaFiles.add(soundFile);
              },
              encode: AudioEncoderType.AAC,
            );
          } else {
            return Column(
              children: [
                if (controller.selectedMediaFiles.isNotEmpty)
                  Obx(() {
                    return Wrap(
                      spacing: 8.0,
                      runSpacing: 8.0,
                      children: List.generate(
                        controller.selectedMediaFiles.length,
                        (index) => ImagePreview(
                          imagePath: controller.selectedMediaFiles[index].path,
                          onRemove: () => controller.removeSelectedMedia(index),
                          progress: controller.mediaUploadProgress[index],
                        ),
                      ),
                    );
                  }),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.grey, width: 1), // Add border
                    borderRadius: BorderRadius.circular(8), // Rounded corners
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
                  child: Row(
                    children: [
                      Expanded(
                      child: TextField(
                          controller: controller.textController,
                          decoration: InputDecoration(
                            hintText: hintText,
                            hintStyle: TextStyle(color: Colors.grey[400]),
                            border: InputBorder.none, // No border
                            focusedBorder: InputBorder.none, // No border when focused
                            enabledBorder: InputBorder.none, // No border when enabled
                            fillColor: Colors.transparent, // No fill color
                            filled: false, // Ensure no fill color is applied
                          ),
                          maxLines: 4,
                          minLines: 1,
                          keyboardType: TextInputType.multiline,
                        ),
                      ),
                      SizedBox(width: 8), // Gap between icons
                      Obx(() => Visibility(
                        visible: controller.isTextEmpty.value && !controller.isLoadingAnswerAI.value && controller.isAudioAllow(),
                        child: _buildIconButton(
                          icon: Icons.mic,
                          color: Colors.blue, // Ensure color is non-nullable
                          onPressed: () {},
                        ),
                      )),
                      SizedBox(width: 8), // Gap between icons
                      Obx(() => Visibility(
                        visible: controller.isImageAllow(),
                        child: _buildIconButton(
                          icon: Icons.camera_alt,
                          color: Colors.blue, // Ensure color is non-nullable
                          onPressed: () async {
                            final capturedImage = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CameraAwesomePage(),
                              ),
                            );
                            if (capturedImage != null) {
                              controller.selectedMediaFiles.add(capturedImage);
                            }
                          },
                        ),
                      )),
                      SizedBox(width: 8), // Gap between icons
                      Obx(() => Visibility(
                        visible: controller.isImageAllow(),
                        child: _buildIconButton(
                          icon: Icons.attach_file,
                          color: Colors.blue, // Ensure color is non-nullable
                          onPressed: controller.pickMultipleMedia,
                        ),
                      )),
                      SizedBox(width: 8), // Gap between icons
                      Obx(() => controller.isLoadingAnswerAI.value
                        ? _buildIconButton(
                            icon: Icons.stop,
                            color: Colors.red, // Ensure color is non-nullable
                            onPressed: () {
                              controller.stopAIResponse();
                            },
                          )
                        : _buildIconButton(
                            icon: Icons.send,
                            color: controller.isTextEmpty.value ? Colors.grey[400]! : Colors.blue, // Ensure color is non-nullable
                            onPressed: controller.isTextEmpty.value
                                ? null
                                : () {
                                    controller.submitQuestion(controller.textController.text);
                                  },
                          ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }
        }),
      ],
    );
  }

  // Helper function to create an icon button with a circular background
  Widget _buildIconButton({
    required IconData icon,
    required Color color,
    required VoidCallback? onPressed,
  }) {
    return SizedBox(
      width: 30,
      height: 30,
      child: CircleAvatar(
        backgroundColor: color, // Background color of the icon button
        child: IconButton(
          icon: Icon(icon, color: Colors.white),
          onPressed: onPressed,
          splashRadius: 20, // Adjust splash radius if needed
          padding: EdgeInsets.zero,
          iconSize: 18, // Adjust icon size if needed
        ),
      ),
    );
  }
}

class CameraAwesomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CameraAwesomeBuilder.awesome(
        saveConfig: SaveConfig.photo(),
        onMediaTap: (mediaCapture) {
          print(mediaCapture);
          Navigator.pop(context, mediaCapture);
        },
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
