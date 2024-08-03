import 'package:get/get.dart';
import 'package:agri_ai/app/routes/app_pages.dart';
import 'package:agri_ai/app/controllers/auth_controller.dart';

class SplashPageController extends GetxController {
  final AuthController authController = Get.find<AuthController>();
  @override
  void onReady() {
    super.onReady();
    _checkLoginStatus();
  }

  void _checkLoginStatus() async {
    try {
      await Future.delayed(const Duration(seconds: 1));
      if (authController.isLogin()) {
        Get.offAllNamed(Routes.HOME);
      } else {
        Get.offAllNamed(Routes.HOME);
      }
    } catch (e) {
      print('Error in _checkLoginStatus: $e');
    }
  }
}


