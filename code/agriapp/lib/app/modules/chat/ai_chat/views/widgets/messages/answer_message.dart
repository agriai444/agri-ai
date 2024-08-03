import 'package:agri_ai/app/data/models/conversation_model.dart';
import 'package:agri_ai/app/modules/chat/ai_chat/controllers/chat_ai_chat_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class AnswerMessage extends GetView<ChatAiChatController> {
  final List<Answer> answers;

  AnswerMessage({
    super.key,
    required this.answers,
  });

  final FlutterTts flutterTts = FlutterTts();
  final RxBool isSpeaking = false.obs;
  final RxInt currentAnswerIndex = 0.obs;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      // Determine whether to show navigation buttons based on the number of answers
      bool showNavigationButtons = answers.length > 1;

      return Container(
        padding: const EdgeInsets.all(8.0),
        margin: EdgeInsets.only(bottom: 4.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CircleAvatar(
                  backgroundColor: Colors.blue,
                  child: Text('A', style: TextStyle(color: Colors.white)),
                ),
                const SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('AI',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                    Text(answers[currentAnswerIndex.value].createdAt ?? '',
                        style: const TextStyle(color: Colors.grey, fontSize: 10)),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 4),
            answers[currentAnswerIndex.value].isLoading == true
                ? Row(
                    children: [
                      const CircularProgressIndicator(),
                      const SizedBox(width: 8),
                      Expanded(
                          child: Text(answers[currentAnswerIndex.value].content ?? '',
                              style: const TextStyle(fontSize: 15))),
                    ],
                  )
                : MarkdownBody(
                    data: answers[currentAnswerIndex.value].content ?? '',
                    styleSheet: MarkdownStyleSheet(
                      p: const TextStyle(fontSize: 15),
                    ),
                  ),
            const SizedBox(height: 4),
            if (answers[currentAnswerIndex.value].isLoading ?? true) 
              _buildIconRow(context, showNavigationButtons),
          ],
        ),
      );
    });
  }

  Widget _buildIconRow(BuildContext context, bool showNavigationButtons) {
    return Container(
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 230, 240, 227),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (showNavigationButtons)
            _buildIconButton(
              Icons.arrow_back,
              'Previous',
              () => _changeAnswer(-1),
              enabled: currentAnswerIndex.value > 0,
            ),
          if (showNavigationButtons)
            _buildIconButton(
              Icons.arrow_forward,
              'Next',
              () => _changeAnswer(1),
              enabled: currentAnswerIndex.value < answers.length - 1,
            ),
          _buildIconButton(Icons.thumb_up, 'Like', () {}),
          _buildIconButton(Icons.thumb_down, 'Dislike', () {}),
          Obx(() => _buildIconButton(
            isSpeaking.value ? Icons.stop : Icons.volume_up,
            isSpeaking.value ? 'Stop' : 'Sound',
            () => _toggleSpeech(context),
          )),
          _buildIconButton(Icons.copy, 'Copy', _copyToClipboard),
        ],
      ),
    );
  }

  Widget _buildIconButton(
      IconData icon, String tooltip, VoidCallback onPressed, {bool enabled = true}) {
    return StatefulBuilder(
      builder: (BuildContext context, StateSetter setState) {
        Color iconColor = enabled ? Colors.black : Colors.grey;
        Color backgroundColor = enabled ? Colors.transparent : Colors.grey.withOpacity(0.2);

        return MouseRegion(
          onEnter: enabled ? (_) {
            setState(() {
              iconColor = Colors.blue;
              backgroundColor = Colors.blue.withOpacity(0.1);
            });
          } : null,
          onExit: enabled ? (_) {
            setState(() {
              iconColor = Colors.grey;
              backgroundColor = Colors.transparent;
            });
          } : null,
          child: Tooltip(
            message: tooltip,
            child: GestureDetector(
              onTapDown: enabled ? (_) {
                setState(() {
                  backgroundColor = Colors.blue.withOpacity(0.2);
                });
              } : null,
              onTapUp: enabled ? (_) {
                setState(() {
                  backgroundColor = Colors.blue.withOpacity(0.1);
                });
                onPressed();
              } : null,
              onTapCancel: enabled ? () {
                setState(() {
                  backgroundColor = Colors.transparent;
                });
              } : null,
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 10.0, right: 10.0, top: 4, bottom: 4),
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: backgroundColor,
                  ),
                  padding: const EdgeInsets.all(4.0),
                  child: Icon(icon, color: iconColor, size: 15),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void _changeAnswer(int direction) {
    int newIndex = currentAnswerIndex.value + direction;
    if (newIndex >= 0 && newIndex < answers.length) {
      currentAnswerIndex.value = newIndex;
    }
  }

  Future<void> _copyToClipboard() async {
    await Clipboard.setData(ClipboardData(text: answers[currentAnswerIndex.value].content ?? ''));
    Get.snackbar(
      'Copied',
      'Text has been copied to clipboard',
      snackPosition: SnackPosition.BOTTOM,
      duration: Duration(seconds: 2),
    );
  }

  Future<void> _toggleSpeech(BuildContext context) async {
    if (isSpeaking.value) {
      await flutterTts.stop();
    } else {
      await flutterTts.speak(answers[currentAnswerIndex.value].content ?? '');
    }

    isSpeaking.value = !isSpeaking.value;
  }
}
