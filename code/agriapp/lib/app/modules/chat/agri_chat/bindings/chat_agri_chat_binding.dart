import 'package:get/get.dart';

import '../controllers/chat_agri_chat_controller.dart';

class ChatAgriChatBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChatAgriChatController>(
      () => ChatAgriChatController(),
    );
  }
}
