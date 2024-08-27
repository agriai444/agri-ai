import 'package:agri_ai/app/modules/chat/controllers/chat_ai_chat_controller.dart';
import 'package:agri_ai/app/modules/chat/views/screens/chat_view.dart';
import 'package:agri_ai/app/modules/home/views/screen/home_screen.dart';
import 'package:agri_ai/app/modules/home/views/screen/models/tabIcon_data.dart';
import 'package:agri_ai/app/modules/more/views/more_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../utils/constants.dart';
import '../../../services/api_call_status.dart';
import '../../../services/base_client.dart';

class HomeController extends GetxController  with GetSingleTickerProviderStateMixin {
  late AnimationController animationController;
  late List<TabIconData> tabIconsList;
  late Rx<Widget> tabBody;
  late RxInt selectedTabIndex;

  final chatAiChatController = Get.put(ChatAiChatController());

  @override
  void onInit() {
    super.onInit();

     animationController = AnimationController(
      duration: const Duration(milliseconds: 200), 
      vsync: this,
    );

    tabIconsList = TabIconData.tabIconsList;
    tabBody = Rx<Widget>(Container());
    selectedTabIndex = 0.obs;

    updateUserType();

    if (isUserAgri()) {
      tabIconsList.removeWhere((tab) => tab.index == 0 || tab.index == 1);
      selectedTabIndex.value = 0;
    } else {
      selectedTabIndex.value = 0; // Use a default index or provide a parameter if needed.
    }

    for (var tab in tabIconsList) {
      tab.isSelected = false;
    }
    tabIconsList[selectedTabIndex.value].isSelected = true;

    setTabBody(tabIconsList[selectedTabIndex.value].index);
  }

  void updateUserType() {
    chatAiChatController.state.updateUserType();
  }

  bool isUserAgri() => chatAiChatController.state.isUserAgri.value;
  bool isUserClient() => chatAiChatController.state.isUserClient.value;

  void setTabBody(int index) {
    switch (index) {
      case 1:
        chatAiChatController.initializeAISetup();
        tabBody.value = const ChatView();
        break;
      case 2:
        chatAiChatController.initializeAgriSetup();
        tabBody.value = const ChatView();
        break;
      case 3:
        tabBody.value = MoreView();
        break;
      case 0:
      default:
        tabBody.value = MyDiaryScreen(animationController: animationController);
        break;
    }
  }

  @override
  void onClose() {
    animationController.dispose();
    super.onClose();
  }
}
