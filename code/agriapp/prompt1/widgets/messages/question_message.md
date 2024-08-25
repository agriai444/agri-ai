

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


class QuestionMessage extends GetView<ChatAiChatController> {
  final Question question;

  const QuestionMessage({
    super.key,
    required this.question,
  });

  @override
  Widget build(BuildContext context) {
    local_user.User? currentUser = MyHive.getCurrentUser();
    final avatarUser = currentUser?.avatarUrl != null
        ? "Q"
        : (currentUser?.firstName?.isNotEmpty ?? false
            ? currentUser!.firstName![0].toUpperCase()
            : 'Q');
    return Obx(() {
      return Container(
        padding: EdgeInsets.all(8.0.h),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundColor: Colors.blue,
              backgroundImage: currentUser?.avatarUrl != null
                  ? NetworkImage(currentUser!.avatarUrl!)
                  : null,
              child: currentUser?.avatarUrl == null
                  ? Text(avatarUser,
                      style: const TextStyle(color: Colors.white))
                  : null,
            ),
            SizedBox(width: 8.0.h),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('You'.tr,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 14.sp)),
                      SizedBox(height: 4.h),
                      Text(question.createdAt ?? '',
                          style:
                              TextStyle(color: Colors.grey, fontSize: 10.sp)),
                    ],
                  ),
                  SizedBox(height: 4.h),
                  Text(question.content ?? '',
                      style: TextStyle(fontSize: 15.sp)),
                  SizedBox(height: 4.h),
                  if (question.questionMedia != null &&
                      question.questionMedia!.isNotEmpty)
                    ...buildMediaWidgets(question.questionMedia!),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }

  List<Widget> buildMediaWidgets(List<QuestionMedia> mediaList) {
    List<Widget> widgets = [];
    List<String> imageUrls = [];

    for (var media in mediaList) {
      if (media.mediaType == 'audio') {
        widgets.add(AudioFileMessage(
          audioSrc: media.mediaUrl ?? '',
          maxDuration: const Duration(seconds: 60), 
        ));
        widgets.add(SizedBox(height: 8.h));
      } else if (media.mediaType == 'image') {
        imageUrls.add(media.mediaUrl ?? '');
      }
    }

    if (imageUrls.isNotEmpty) {
      widgets.add(ImageGridBuilder.buildImageGrid(imageUrls));
    }

    return widgets;
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
