import 'package:agri_ai/app/data/models/conversation_model.dart';
import 'package:agri_ai/app/modules/chat/ai_chat/controllers/current_conversation_controller.dart';
import 'package:agri_ai/app/modules/chat/ai_chat/views/widgets/chatai_view.dart';
import 'package:agri_ai/app/modules/chat/ai_chat/views/widgets/chat_drawer/chat_drawer.dart';
import 'package:agri_ai/app/modules/chat/ai_chat/views/widgets/chat_drawer/drawer_chat_controller.dart';
import 'package:agri_ai/utils/app_theme.dart';
import 'package:agri_ai/utils/feedback_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class ChatAiChatView extends StatefulWidget {
  @override
  _ChatAiChatViewState createState() => _ChatAiChatViewState();
}

class _ChatAiChatViewState extends State<ChatAiChatView> {
  Widget? screenView;
  DrawerIndex? drawerIndex;

  @override
  void initState() {
    drawerIndex = DrawerIndex.ChatAiChatView;
    screenView =  ChatAiView();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.white,
      child: SafeArea(
        top: false,
        bottom: false,
        child: Scaffold(
          backgroundColor: AppTheme.nearlyWhite,
          body: DrawerChatController(
            screenIndex: drawerIndex,
            drawerWidth: MediaQuery.of(context).size.width * 0.75,
            onDrawerCall: (DrawerIndex drawerIndexdata) {
              changeIndex(drawerIndexdata);
              //callback from drawer for replace screen as user need with passing DrawerIndex(Enum index)
            },
            screenView: screenView,
            //we replace screen view as we need on navigate starting screens like MyHomePage, HelpScreen, FeedbackScreen, etc...
          ),
        ),
      ),
    );
  }

  void changeIndex(DrawerIndex drawerIndexdata) {
    if (drawerIndex != drawerIndexdata) {
      drawerIndex = drawerIndexdata;
      switch (drawerIndex) {
        case DrawerIndex.ChatAiChatView:
      //    final CurrentConversationController currentConversationController =
      // Get.put(CurrentConversationController());
      //   currentConversationController.setCurrentConversation(drawerIndexdata.);
          break;

        default:
          break;
      }
    }
  }
}

