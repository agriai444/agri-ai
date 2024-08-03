import 'package:agri_ai/app/data/models/conversation_model.dart';
import 'package:agri_ai/app/modules/chat/ai_chat/views/widgets/voice_recording.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/chat_ai_chat_controller.dart';
import 'image_preview.dart';

class CustomInputField extends GetView<ChatAiChatController> {
  final String hintText;


  const CustomInputField({super.key, required this.hintText, required Null Function(String value) onSubmitted,});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Obx(() {
          if (controller.isRecording.value) {
            return VoiceRecording(
              onCancel: controller.cancelRecording,
              onPause: controller.pauseRecording,
              onResume: controller.resumeRecording,
              onConfirm: controller.confirmRecording,
              isRecording: controller.isRecording.value,
              isPaused: controller.isPaused.value,
              isUserRegistered: !controller.isTextEmpty.value, 
            );
          }
          return SizedBox.shrink();
        }),
        
        Obx(() {
          return controller.selectedImagePath.value.isNotEmpty
              ? ImagePreview(
                  imagePath: controller.selectedImagePath.value,
                  onRemove: controller.removeSelectedImage,
                  progress: controller.imageUploadProgress.value,
                )
              : const SizedBox.shrink();
        }),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(25),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 5,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller.textController,
                    decoration: InputDecoration(
                      hintText: hintText,
                      hintStyle: TextStyle(color: Colors.grey[400]),
                      border: InputBorder.none,
                    ),
                    maxLines: 4,
                    minLines: 1,
                    keyboardType: TextInputType.multiline,
                  ),
                ),
                Obx(() => Visibility(
                      visible: controller.isTextEmpty.value && !controller.isLoadingAnswerAI.value,
                      child: IconButton(
                        icon: const Icon(Icons.mic, color: Colors.blue),
                        onPressed: () {
                          controller.startRecording();
                        },
                      ),
                    )),
                IconButton(
                  icon: const Icon(Icons.camera_alt_outlined, color: Colors.blue),
                  onPressed: controller.pickImage,
                ),
                Obx(() => controller.isLoadingAnswerAI.value
                    ? IconButton(
                        icon: const Icon(Icons.stop, color: Colors.red),
                        onPressed: () {
                          controller.stopLoading();
                        },
                      )
                    : IconButton(
                        icon: Icon(Icons.send, color: controller.isTextEmpty.value ? Colors.grey[400] : Colors.blue),
                        onPressed: controller.isTextEmpty.value ? null : () {
                          controller.submitQuestion(controller.textController.text);
                        },
                      )),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
