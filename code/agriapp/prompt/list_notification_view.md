

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

class ListNotificationView extends GetView<ListNotificationController> {
  const ListNotificationView({Key? key}) : super(key: key);

   @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Strings.notifications.tr),
        centerTitle: true,
      ),
      body: Obx(() => Skeletonizer(
        enabled: controller.isLoading.value,
        child: ListView.builder(
          itemCount: controller.notifications.length,
          itemBuilder: (context, index) {
            final notification = controller.notifications[index];
            return NotificationTile(notification: notification);
          },
        ),
      )),
    );
  }
  }

class NotificationTile extends StatelessWidget {
  final NotificationItem notification;

  const NotificationTile({Key? key, required this.notification}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: notification.isRead! ? Colors.grey : Colors.blue,
        child: Icon(
          _getIconData(notification.icon),
          color: Colors.white,
        ),
      ),
      title: Text(
        notification.title!,
        style: TextStyle(
          fontWeight: notification.isRead! ? FontWeight.normal : FontWeight.bold,
        ),
      ),
      subtitle: Text(notification.text!),
      trailing: Text(
        _formatDate(notification.createdAt!),
        style: TextStyle(fontSize: 12),
      ),
      onTap: () {
        Get.find<ListNotificationController>().markAsRead(notification.id!);
      },
    );
  }

  IconData _getIconData(String? icon) {
    switch (icon) {
      case 'message':
        return Icons.message;
      case 'update':
        return Icons.update;
      default:
        return Icons.notifications;
    }
  }

  String _formatDate(String dateString) {
    final date = DateTime.parse(dateString);
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays == 0) {
      return '${date.hour}:${date.minute.toString().padLeft(2, '0')}';
    } else if (difference.inDays < 7) {
      return '${_getDayName(date.weekday)} ${date.hour}:${date.minute.toString().padLeft(2, '0')}';
    } else {
      return '${date.day}/${date.month}/${date.year}';
    }
  }

  String _getDayName(int weekday) {
    switch (weekday) {
      case 1: return Strings.mon.tr;
      case 2: return Strings.tue.tr;
      case 3: return Strings.wed.tr;
      case 4: return Strings.thu.tr;
      case 5: return Strings.fri.tr;
      case 6: return Strings.sat.tr;
      case 7: return Strings.sun.tr;
      default: return '';
    }
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
