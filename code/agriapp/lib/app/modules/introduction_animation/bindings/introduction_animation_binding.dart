import 'package:get/get.dart';

import '../controllers/introduction_animation_controller.dart';

class IntroductionAnimationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<IntroductionAnimationController>(
      () => IntroductionAnimationController(),
    );
  }
}
