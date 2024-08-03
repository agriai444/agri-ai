// more_controller.dart
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class MoreController extends GetxController {
  //TODO: Implement MoreController

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void shareApp() {
    Share.share('Check out this amazing app: [App Link]');
  }

  void rateApp() async {
    const url = 'https://play.google.com/store/apps/details?id=com.yourapp.package'; // or App Store URL
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      // Handle URL launch failure
    }
  }
}
