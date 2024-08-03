import 'package:agri_ai/app/data/models/conversation_model.dart';
import 'package:agri_ai/app/data/providers/conversation_provider.dart';
import 'package:agri_ai/app/modules/chat/ai_chat/controllers/current_conversation_controller.dart';
import 'package:get/get.dart';

import '../controllers/chat_ai_chat_controller.dart';

class ChatAiChatBinding extends Bindings {
  @override
  void dependencies() {
      // Get.put(CurrentConversationController());
          Get.lazyPut<ChatAiChatController>(
      () => ChatAiChatController(),
    );
    //  Get.lazyPut<Conversation>(() => ConversationProvider());
    Get.lazyPut<ChatAiChatController>(
      () => ChatAiChatController(),
    );
  }
}
