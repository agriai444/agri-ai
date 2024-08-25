

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


class ChatDrawer extends StatefulWidget {
  const ChatDrawer({
    Key? key,
    this.screenIndex,
    this.iconAnimationController,
    this.callBackIndex,
  }) : super(key: key);

  final AnimationController? iconAnimationController;
  final DrawerIndex? screenIndex;
  final Function(DrawerIndex)? callBackIndex;

  @override
  _ChatDrawerState createState() => _ChatDrawerState();
}


class _ChatDrawerState extends State<ChatDrawer> {
  final ChatAiChatController controller = Get.put(ChatAiChatController());

  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isLightMode = brightness == Brightness.light;

    List<DrawerList>? drawerList = controller.drawerList;

    return SafeArea(
      child: Scaffold(
        backgroundColor: AppTheme.white,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 10.h),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Obx(() {
                bool isButtonDisabled = controller.isDefaultConversation() || controller.isLoadingAnswerAI.value;

                return ElevatedButton.icon(
                  onPressed: isButtonDisabled ? null : () {
                    // Create a new conversation
                    controller.addNewConversation('New Chat');
                    if (drawerList.isNotEmpty) {
                      navigationtoScreen(drawerList[0].index!);
                    }
                  },
                  icon: const Icon(Icons.add),
                  label: Text('New Chat'.tr),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: BorderSide(color: Colors.blue, width: 1),
                    ),
                    minimumSize: const Size(double.infinity, 50),
                  ),
                );
              }),
            ),
            Divider(
              height: 1,
              color: AppTheme.grey.withOpacity(0.6),
            ),
            Expanded(
              child: Obx(() {
                if (controller.isLoadingConversations.value) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  return ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.all(0.0),
                    itemCount: drawerList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return inkwell(drawerList[index]);
                    },
                  );
                }
              }),
            ),
            Divider(
              height: 1,
              color: AppTheme.grey.withOpacity(0.6),
            ),
            ListTile(
              title: Text(
                'Sign Out'.tr,
                style: TextStyle(
                  fontFamily: AppTheme.fontName,
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: AppTheme.darkText,
                ),
                textAlign: TextAlign.left,
              ),
              trailing: const Icon(
                Icons.power_settings_new,
                color: Colors.red,
              ),
              onTap: () {
                onTapped();
              },
            ),
            SizedBox(
              height: MediaQuery.of(context).padding.bottom,
            ),
          ],
        ),
      ),
    );
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
