import 'dart:ffi';

import 'package:agri_ai/app/modules/chat/ai_chat/controllers/current_conversation_controller.dart';
import 'package:agri_ai/app/modules/chat/ai_chat/views/widgets/item_conversation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:agri_ai/app/data/models/conversation_model.dart';
import 'package:agri_ai/app/modules/chat/ai_chat/controllers/chat_ai_chat_controller.dart';
import 'package:agri_ai/app/modules/chat/ai_chat/views/widgets/messages/answer_message.dart';
import 'package:agri_ai/app/modules/chat/ai_chat/views/widgets/custom_input_ai.dart';
import 'package:agri_ai/app/modules/chat/ai_chat/views/widgets/messages/question_message.dart';
import 'package:agri_ai/app/modules/chat/ai_chat/views/widgets/messages/welcome_chat.dart';
class ChatAiView extends GetView<ChatAiChatController> {
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      child: Scaffold(
        body: Obx(() {
          final conversation = Get.find<CurrentConversationController>().getCurrentConversation;
          
          if (controller.isLoadingQuestions.value) {
            return Center(child: CircularProgressIndicator());
          }

          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (_scrollController.hasClients) {
              _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
            }
          });

          return Column(
           
            children: [
             
              Expanded(
                 
                child: conversation.question == null || conversation.question!.isEmpty
                  ? const WelcomeChat()
                  : Container(
                      margin: EdgeInsets.symmetric(vertical: 45.h),
                    child: ListView.builder(
                        controller: _scrollController,
                        itemCount: conversation.question?.length ?? 0,
                        itemBuilder: (context, index) {
                          final question = conversation.question![index];
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              _buildQuestionWidget(question),
                              if (question.answer != null && question.answer!.isNotEmpty)
                                _buildAnswerWidget(question.answer!),
                              SizedBox(height: 16.h),
                            ],
                          );
                        },
                      ),
                  ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 72.0),
                child: CustomInputField(
                  hintText: 'Ask me anything...'.tr,
                  onSubmitted: (value) {
                    controller.submitQuestion(value);
                  },
                ),
              ),
            ],
          );
        }),
      ),
    );
  }

  Widget _buildQuestionWidget(Question question) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 0.h),
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: QuestionMessage(question: question),
    );
  }

  Widget _buildAnswerWidget(List<Answer> answers) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 3,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: AnswerMessage(answers: answers),
    );
  }
}
