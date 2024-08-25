

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


class AudioFileMessage extends StatelessWidget {
  final String audioSrc;
  final Duration maxDuration;


  const AudioFileMessage({
    Key? key,
    required this.audioSrc,
    this.maxDuration = const Duration(seconds: 30),

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      child: Column(
        children: [
          VoiceMessageView(
            controller: VoiceController(
              audioSrc: audioSrc,
              maxDuration: maxDuration,
              isFile: true,
              onComplete: () {
                      print("Audio playback completed.");
                    },
                    onPause: () {
                      print("Audio paused.");
                    },
                    onPlaying: () {
                      print("Audio is playing.");
                    },
                    onError: (err) {
                      print("Error playing audio: $err");
                    },
                  ),
         
            innerPadding: 12,
            cornerRadius: 20,
          ),
          SizedBox(height: 8), 
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
