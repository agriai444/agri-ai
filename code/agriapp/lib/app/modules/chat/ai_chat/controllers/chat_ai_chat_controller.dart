import 'package:agri_ai/app/data/models/conversation_model.dart';
import 'package:agri_ai/app/data/providers/conversation_provider.dart';
import 'package:agri_ai/app/modules/chat/ai_chat/controllers/current_conversation_controller.dart';
import 'package:agri_ai/app/modules/chat/ai_chat/views/widgets/chat_drawer/chat_drawer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class ChatAiChatController extends GetxController {
  var conversations = <Conversation>[].obs;
  TextEditingController textController = TextEditingController();
  ScrollController scrollController = ScrollController();
  var isTextEmpty = true.obs;
  var isLoadingAnswerAI = false.obs;
  var selectedImagePath = ''.obs;
  var imageUploadProgress = 0.0.obs;

  var isRecording = false.obs;
  var isPaused = false.obs;
  var uuid = const Uuid();
  final ConversationProvider provider = Get.put(ConversationProvider());

    var isLoadingQuestions = false.obs;
  final isLoading = true.obs;
  final isLoadingConversations = true.obs;
  final isLoadingMore = false.obs;
  final hasMoreConversations = true.obs;
  int currentPage = 1;
  List<DrawerList>? drawerList =  <DrawerList>[];

  final CurrentConversationController currentConversationController =
      Get.put(CurrentConversationController());

  @override
  void onInit() {
    super.onInit();
    textController.addListener(() {
      isTextEmpty.value = textController.text.isEmpty;
    });

    // Ensure the default conversation is added to the list if not already present
    ensureDefaultConversation();

    ever(conversations, (_) => scrollToBottom());
  }

  @override
  Future<void> onReady() async {
    super.onReady();
   await loadConversations();
 
  }

bool isConversationInList(String id) {
  return drawerList?.any((item) => item.id == id) ?? false;
}


void setDrawerListArray() {
 
  for (var conversation in conversations) {
    // Check if the conversation is already in the list
    if (!isConversationInList(conversation.id!)) {
      drawerList?.add(DrawerList(
        index: DrawerIndex.ChatAiChatView,
        labelName: conversation.title ?? 'New Chat',
        icon: const Icon(Icons.chat),
        imageName: '',
        id: conversation.id!, // Ensure to use unique identifier
      ));
    }
  }
}


  void ensureDefaultConversation() {
    Conversation defaultConversation =
        currentConversationController.getCurrentConversation;
    if (conversations.indexWhere((c) => c.id == defaultConversation.id) == -1) {
      conversations.add(defaultConversation);
    }
  }

void submitQuestion(String content) async {
  isLoadingAnswerAI.value = true;
  scrollToBottom();
  var questionId = uuid.v1();
  var answerId = uuid.v1();

  // Retrieve the current conversation directly
  final currentConversation = currentConversationController.getCurrentConversation;

  textController.clear();
  removeSelectedImage();

  // Create new question and answer
  Question newQuestion = Question(
    id: questionId,
    conversationId: currentConversation.id!,
    content: content,
    createdAt: DateTime.now().toIso8601String(),
    updatedAt: DateTime.now().toIso8601String(),
    questionMedia: [],
  );

  Answer aiAnswer = Answer(
    id: answerId,
    questionId: newQuestion.id,
    content: '',
    isLoading: isLoadingAnswerAI.value,
    createdAt: DateTime.now().toIso8601String(),
    updatedAt: DateTime.now().toIso8601String(),
  );

  // Add question and answer to the current conversation
  addQuestionToCurrentConversation(newQuestion);
  addAnswerToCurrentQuestion(newQuestion.id!, aiAnswer);

  // Simulate AI response
  Stream<String> aiResponseStream = simulateStreamingAPIResponse();

  aiResponseStream.listen((chunk) {
    aiAnswer.content = (aiAnswer.content ?? '') + chunk;
    updateAnswerInCurrentConversation(newQuestion.id!, aiAnswer);
  }).onDone(() {
    aiAnswer.isLoading = false;
    updateAnswerInCurrentConversation(newQuestion.id!, aiAnswer);
    isLoadingAnswerAI.value = false;
  });

  scrollToBottom();
}


void addQuestionToCurrentConversation(Question newQuestion) {
  final currentConversation = currentConversationController.getCurrentConversation;
  
  currentConversation.question ??= [];
  currentConversation.question!.add(newQuestion);
  
  // Update the conversation list
  int index = conversations.indexWhere((c) => c.id == currentConversation.id);
  if (index != -1) {
    conversations[index] = currentConversation;
    conversations.refresh();
  }
}
void addAnswerToCurrentQuestion(String questionId, Answer newAnswer) {
  final currentConversation = currentConversationController.getCurrentConversation;
  final questionIndex = currentConversation.question?.indexWhere((q) => q.id == questionId) ?? -1;
  
  if (questionIndex != -1) {
    currentConversation.question![questionIndex].answer ??= [];
    currentConversation.question![questionIndex].answer!.add(newAnswer);
    
    // Update the conversation list
    int index = conversations.indexWhere((c) => c.id == currentConversation.id);
    if (index != -1) {
      conversations[index] = currentConversation;
      conversations.refresh();
    }
  }
}
void updateAnswerInCurrentConversation(String questionId, Answer updatedAnswer) {
  final currentConversation = currentConversationController.getCurrentConversation;
  final questionIndex = currentConversation.question?.indexWhere((q) => q.id == questionId) ?? -1;

  if (questionIndex != -1) {
    final answerIndex = currentConversation.question![questionIndex].answer?.indexWhere((a) => a.id == updatedAnswer.id) ?? -1;
    if (answerIndex != -1) {
      currentConversation.question![questionIndex].answer![answerIndex] = updatedAnswer;
      
      // Update the conversation list
      int index = conversations.indexWhere((c) => c.id == currentConversation.id);
      if (index != -1) {
        conversations[index] = currentConversation;
        conversations.refresh();
      }
    }
  }
}



  void stopLoading() {
    isLoadingAnswerAI.value = false;
  }

  void scrollToBottom() {
    if (scrollController.hasClients) {
      Future.delayed(Duration(milliseconds: 300), () {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      });
    }
  }

  Stream<String> simulateStreamingAPIResponse() async* {
    await Future.delayed(Duration(seconds: 1));
    yield "This ";
    await Future.delayed(Duration(seconds: 1));
    yield "is ";
    await Future.delayed(Duration(seconds: 1));
    yield "a ";
    await Future.delayed(Duration(seconds: 1));
    yield "simulated ";
    await Future.delayed(Duration(seconds: 1));
    yield "AI ";
    await Future.delayed(Duration(seconds: 1));
    yield "response.";
  }

  Future<void> pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      selectedImagePath.value = image.path;
      simulateImageUpload();
    }
  }

  void simulateImageUpload() async {
    for (int i = 0; i <= 100; i++) {
      await Future.delayed(Duration(milliseconds: 50));
      imageUploadProgress.value = i / 100;
    }
  }

  void removeSelectedImage() {
    selectedImagePath.value = '';
    imageUploadProgress.value = 0.0;
  }

  void startRecording() {
    isRecording.value = true;
    isPaused.value = false;
  }

  void pauseRecording() {
    isPaused.value = true;
  }

  void resumeRecording() {
    isPaused.value = false;
  }

  void cancelRecording() {
    isRecording.value = false;
    isPaused.value = false;
  }

  void confirmRecording() {
    cancelRecording();
  }

  Future<void> loadConversations() async {
    try {
      isLoadingConversations(true);
      final newConversations =
          await provider.getConversations(page: currentPage);
      conversations.addAll(newConversations);
      hasMoreConversations(newConversations.length == 10);
         setDrawerListArray();
    } catch (e) {
      print('Error loading conversations: $e');
    } finally {
      isLoadingConversations(false);
    }
  }


 

  Future<void> loadMoreConversations() async {
    if (isLoadingMore.value || !hasMoreConversations.value) return;
    try {
      isLoadingMore(true);
      currentPage++;
      final newConversations =
          await provider.getConversations(page: currentPage);
      conversations.addAll(newConversations);
      hasMoreConversations(newConversations.length == 10);
         setDrawerListArray();
    } catch (e) {
      print('Error loading conversations: $e');
    } finally {
      isLoadingMore(false);
    }
  }

  // Function to check if the current conversation is the default conversation
  bool checkIfDefaultConversation() {
    return currentConversationController.isDefaultConversation();
  }

  Future<void> addNewConversation(String title) async {
    try {
      isLoading(true);
      final newConversation = await provider.addNewConversation(title);
      conversations.insert(0, newConversation);
      currentConversationController.setCurrentConversation(newConversation);
    } catch (e) {
      print('Error adding new conversation: $e');
    } finally {
      isLoading(false);
    }
  }


     Future<void> loadQuestionsAndAnswers() async {
    final currentConversation = currentConversationController.getCurrentConversation;
    if (currentConversation.id != null && (currentConversation.question?.isEmpty ?? true)) {
      isLoadingQuestions.value = true;
      try {
        final questions = await provider.getListQuestionAnswerByConversationId(currentConversation.id!);
        currentConversationController.setQuestionsAndAnswers(questions); 
      } catch (e) {
             Get.snackbar(
          'Error',
          'Failed to load questions and answers. Please try again later.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent,
          colorText: Colors.white,
          duration: Duration(seconds: 3),
        );
        print('Error loading questions and answers: $e');
      } finally {
        isLoadingQuestions.value = false;
      }
    }
  }
}
