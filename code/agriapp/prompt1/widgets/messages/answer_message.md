

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



class AnswerMessage extends GetView<ChatAiChatController> {
  final List<Answer> answers;

  AnswerMessage({
    super.key,
    required this.answers,
  });

  final FlutterTts flutterTts = FlutterTts();
  final RxBool isSpeaking = false.obs;
  final RxInt currentAnswerIndex = 0.obs;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final currentAnswer = answers[currentAnswerIndex.value];
      final typeConversation = controller.getCurrentConversation.type ?? 'AI';
      local_user.User? currentUser = MyHive.getCurrentUser();
     final avatarUser = currentUser?.avatarUrl != null
          ? "A"
          : (currentUser?.firstName?.isNotEmpty ?? false
              ? currentUser!.firstName![0].toUpperCase()
              : '?');

      return Container(
        padding: const EdgeInsets.all(8.0),
        margin: EdgeInsets.only(bottom: 4.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if ( controller.isCurrentAgriConv() || currentAnswer.status != null)
              _buildStateWidget(currentAnswer.status!)
            else if (currentAnswer.isError ?? false)
              _buildErrorWidget()
            else ...[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   CircleAvatar(
                    backgroundColor: Colors.blue,
                    backgroundImage: currentUser?.avatarUrl != null
                        ? NetworkImage(currentUser!.avatarUrl!)
                        : null,
                    child: currentUser?.avatarUrl == null
                        ? Text(avatarUser , style: const TextStyle(color: Colors.white))
                        : null,
                  ),
                  const SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(typeConversation,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 14)),
                      Text(currentAnswer.createdAt ?? '',
                          style:
                              const TextStyle(color: Colors.grey, fontSize: 10)),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 4),
              AnimatedOpacity(
                opacity: currentAnswer.isLoading ?? false ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 300),
                child: const LinearProgressIndicator(),
              ),
              const SizedBox(height: 4),
              MarkdownBody(
                data: currentAnswer.content ?? '',
                styleSheet: MarkdownStyleSheet(
                  p: const TextStyle(fontSize: 15),
                ),
              ),
              SizedBox(height: 7.h),
              if (!(currentAnswer.isLoading ?? false))
                _buildIconRow(context, answers.length > 1),
            ],
          ],
        ),
      );
    });
  }


  Widget _buildStateWidget(String status) {
    switch (status) {
      case 'pending':
        return _buildPendingWidget();
      case 'rejected':
        return _buildRejectedWidget();
      default:
        return SizedBox.shrink();
    }
  }

  Widget _buildPendingWidget() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(height: 50.h),
        Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset('assets/images/pending.png', height: 100.h), 
              SizedBox(height: 20.h),
              Text(
                'Your request is pending',
                style: TextStyle(fontSize: 18.sp, color: Colors.orange, ),
              ),
            ],
          ),
        ),
         SizedBox(height: 50.h),
      ],
    );
  }

  Widget _buildRejectedWidget() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(height: 50.h),
        Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset('assets/images/rejected.png', height: 100.h), 
              SizedBox(height: 20.h),
              Text(
                'Your request has been rejected',
                style: TextStyle(fontSize: 18.sp, color: Colors.red),
              ),
            ],
          ),
        ),
         SizedBox(height: 50.h),
      ],
    );
  }
  Widget _buildErrorWidget() {
        return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(height: 50.h),
        Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset('assets/images/errormessage.png', height: 100.h), 
              SizedBox(height: 20.h),
              Text(
                'Sometimes there is an error',
                style: TextStyle(fontSize: 18.sp, color: Colors.red),
              ),
            ],
          ),
        ),
         SizedBox(height: 50.h),
      ],
    );
  
  }

  Widget _buildIconRow(BuildContext context, bool showNavigationButtons) {
    return Container(
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 230, 240, 227),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (showNavigationButtons)
            _buildIconButton(
              Icons.arrow_back,
              'Previous',
              () => _changeAnswer(-1),
              enabled: currentAnswerIndex.value > 0,
            ),
          if (showNavigationButtons)
            _buildIconButton(
              Icons.arrow_forward,
              'Next',
              () => _changeAnswer(1),
              enabled: currentAnswerIndex.value < answers.length - 1,
            ),
          Obx(() => _buildIconButton(
                isSpeaking.value ? Icons.stop : Icons.volume_up,
                isSpeaking.value ? 'Stop' : 'Sound',
                () => _toggleSpeech(context),
              )),
          _buildIconButton(Icons.copy, 'Copy', _copyToClipboard),
        ],
      ),
    );
  }

  Widget _buildIconButton(IconData icon, String tooltip, VoidCallback onPressed,
      {bool enabled = true}) {
    return StatefulBuilder(
      builder: (BuildContext context, StateSetter setState) {
        Color iconColor = enabled ? Colors.black : Colors.grey;
        Color backgroundColor =
            enabled ? Colors.transparent : Colors.grey.withOpacity(0.2);

        return MouseRegion(
          onEnter: enabled
              ? (_) {
                  setState(() {
                    iconColor = Colors.blue;
                    backgroundColor = Colors.blue.withOpacity(0.1);
                  });
                }
              : null,
          onExit: enabled
              ? (_) {
                  setState(() {
                    iconColor = Colors.grey;
                    backgroundColor = Colors.transparent;
                  });
                }
              : null,
          child: Tooltip(
            message: tooltip,
            child: GestureDetector(
              onTapDown: enabled
                  ? (_) {
                      setState(() {
                        backgroundColor = Colors.blue.withOpacity(0.2);
                      });
                    }
                  : null,
              onTapUp: enabled
                  ? (_) {
                      setState(() {
                        backgroundColor = Colors.blue.withOpacity(0.1);
                      });
                      onPressed();
                    }
                  : null,
              onTapCancel: enabled
                  ? () {
                      setState(() {
                        backgroundColor = Colors.transparent;
                      });
                    }
                  : null,
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 10.0, right: 10.0, top: 4, bottom: 4),
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: backgroundColor,
                  ),
                  padding: const EdgeInsets.all(4.0),
                  child: Icon(icon, color: iconColor, size: 15),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void _changeAnswer(int direction) {
    int newIndex = currentAnswerIndex.value + direction;
    if (newIndex >= 0 && newIndex < answers.length) {
      currentAnswerIndex.value = newIndex;
    }
  }

  Future<void> _copyToClipboard() async {
    await Clipboard.setData(
        ClipboardData(text: answers[currentAnswerIndex.value].content ?? ''));
    Get.snackbar(
      'Copied',
      'Text has been copied to clipboard',
      snackPosition: SnackPosition.BOTTOM,
      duration: Duration(seconds: 2),
    );
  }

  Future<void> _toggleSpeech(BuildContext context) async {
    if (isSpeaking.value) {
      await flutterTts.stop();
    } else {
      await flutterTts.speak(answers[currentAnswerIndex.value].content ?? '');
    }

    isSpeaking.value = !isSpeaking.value;
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
