

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




class NavigationConversationScreen extends StatefulWidget {
  @override
  _NavigationConversationScreenState createState() => _NavigationConversationScreenState();
}

class _NavigationConversationScreenState extends State<NavigationConversationScreen> {
  final ChatAiChatController controller = Get.put(ChatAiChatController());
  final ConversationProvider provider = Get.find<ConversationProvider>();

  @override
  void initState() {
    super.initState();
    // Call loadConversations when the screen is initialized
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.loadConversations();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
   
      body: Obx(() {
        if (controller.isLoading.value && controller.listConversations.isEmpty) {
          return Center(child: CircularProgressIndicator());
        }
        return Column(
          children: [
            Expanded(
              child: ListView.separated(
                padding: EdgeInsets.all(16.r),
                itemCount: controller.listConversations.length,
                separatorBuilder: (context, index) => SizedBox(height: 16.h),
                itemBuilder: (context, index) {
                  return ConversationItem(
                    conversation: controller.listConversations[index],
                    onTap: () {
                      Get.toNamed('/chat', arguments: controller.listConversations[index]);
                    },
                  );
                },
              ),
            ),
            if (controller.hasMoreConversations.value)
              Padding(
                padding: EdgeInsets.all(16.r),
                child: ElevatedButton(
                  onPressed: controller.isLoadingMore.value
                      ? null
                      : () => controller.loadMoreConversations(),
                  child: controller.isLoadingMore.value
                      ? SizedBox(
                          width: 20.r,
                          height: 20.r,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : Text('Load More'),
                ),
              ),
          ],
        );
      }),
    );
  }

  void _addNewConversation() {
    Get.dialog(
      AlertDialog(
        title: Text('New Conversation'),
        content: TextField(
          decoration: InputDecoration(hintText: 'Enter conversation title'),
          onSubmitted: (value) {
            Get.back();
            controller.addNewConversation(value);
          },
        ),
        actions: [
          TextButton(
            child: Text('Cancel'),
            onPressed: () => Get.back(),
          ),
          TextButton(
            child: Text('Create'),
            onPressed: () {
              final title = (Get.find<TextField>().controller?.text ?? '').trim();
              if (title.isNotEmpty) {
                Get.back();
                controller.addNewConversation(title);
              }
            },
          ),
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
