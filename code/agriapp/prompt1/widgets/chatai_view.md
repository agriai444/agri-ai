

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


class ChatAiView extends GetView<ChatAiChatController> {
  final ScrollController _scrollController = ScrollController();

  ChatAiView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      child: Scaffold(
        body: Obx(() {
          final conversation = controller.getCurrentConversation;
          
          if (controller.isLoadingQuestions.value) {
            return const Center(child: CircularProgressIndicator());
          }

          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (_scrollController.hasClients) {
              _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
            }
          });

          // Determine if the last answer has 'pending' status
          bool showInputField = true;
          if(controller.isCurrentAgriConv()){
          if (conversation.question?.isNotEmpty ?? false) {
            final lastQuestion = conversation.question!.last;
            final lastAnswer = lastQuestion.answer?.last;
            if (lastAnswer?.status == 'pending') {
              showInputField = false;
            }
          }}

          return Column(
            children: [
              Expanded(
                child: conversation.question == null || conversation.question!.isEmpty
                  ? const WelcomeChat()
                  : Container(
                      margin: EdgeInsets.only(top: 50.h),
                      child: ListView.builder(
                        controller: _scrollController,
                        itemCount: conversation.question?.length ?? 0,
                        itemBuilder: (context, index) {
                          final question = conversation.question![index];
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              _buildQuestionWidget(question),
                              if (question.answer != null && question.answer!.isNotEmpty)
                                _buildAnswerWidget(question.answer!),
                              SizedBox(height: 16.h),
                            ],
                          );
                        },
                      ),
                    ),
              ),
              if (showInputField)
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 75.0),
                  child: CustomInputField(
                    hintText: 'Ask me anything...'.tr,
                    onSubmitted: (value) {
                      controller.submitQuestion(value);
                    },
                  ),
                ),
            ],
          );
        }),
      ),
    );
  }

  Widget _buildQuestionWidget(Question question) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 0.h),
      padding: EdgeInsets.all(8.w),
      decoration: BoxDecoration(
        color: Colors.green[100],
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12.r),
          topRight: Radius.circular(12.r),
        ),
      ),
      child: QuestionMessage(question: question),
    );
  }

  Widget _buildAnswerWidget(List<Answer> answers) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 0.h),
      padding: EdgeInsets.all(8.w),
      decoration: BoxDecoration(
        color: Colors.green[100],
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(12.r),
          bottomRight: Radius.circular(12.r),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 3,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: AnswerMessage(answers: answers),
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
