import 'package:get/get.dart';
import 'package:agri_ai/app/data/models/conversation_model.dart';
import 'package:uuid/uuid.dart';

class CurrentConversationController extends GetxController {
  var currentConversation = Rxn<Conversation>();
  final Uuid uuid = Uuid();
  late String defaultConversationId;

  CurrentConversationController() {
    // Initialize with a default conversation
    setDefaultConversation();
  }

  void setDefaultConversation() {
    defaultConversationId = uuid.v1();
    Conversation defaultConversation = Conversation(
      id: '',
      userId: 'default_user',
      title: 'New Conversation',
      createdAt: DateTime.now().toIso8601String(),
      updatedAt: DateTime.now().toIso8601String(),
      question: [],
    );
    currentConversation.value = defaultConversation;
  }

  void setCurrentConversation(Conversation conversation) {
    currentConversation.value = conversation;
  }

  Conversation get getCurrentConversation => currentConversation.value ?? _getDefaultConversation();

  Conversation _getDefaultConversation() {
    if (currentConversation.value == null) {
      setDefaultConversation();
    }
    return currentConversation.value!;
  }

  bool isDefaultConversation() {
     return currentConversation.value?.id == '';
    // return currentConversation.value?.id == defaultConversationId;
  }

    void setQuestionsAndAnswers(List<Question> questions) {
    if (currentConversation.value != null) {
      currentConversation.value!.question = questions;
      currentConversation.refresh(); // Refresh the observable
    }
  }
}
