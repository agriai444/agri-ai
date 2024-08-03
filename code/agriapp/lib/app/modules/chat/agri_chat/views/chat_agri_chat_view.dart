import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/chat_agri_chat_controller.dart';

class ChatAgriChatView extends GetView<ChatAgriChatController> {
  const ChatAgriChatView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ChatAgriChatView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'ChatAgriChatView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
