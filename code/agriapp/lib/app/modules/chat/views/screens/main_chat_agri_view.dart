import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:agri_ai/app/controllers/auth_controller.dart';
import 'package:agri_ai/app/data/models/conversation_model.dart';
import 'package:agri_ai/app/data/providers/conversation_provider.dart';
import 'package:agri_ai/app/modules/chat/controllers/chat_ai_chat_controller.dart';
import 'package:agri_ai/app/modules/chat/views/widgets/messages_view.dart';
import 'package:agri_ai/config/translations/strings_enum.dart';

class MainChatAgriView extends StatefulWidget {
  const MainChatAgriView({super.key});

  @override
  _MainChatAgriViewState createState() => _MainChatAgriViewState();
}

class _MainChatAgriViewState extends State<MainChatAgriView> {
  @override
  Widget build(BuildContext context) {
    return  AgriView();
  }
}

class AgriView extends GetView<ChatAiChatController> {
  final AuthController authController = Get.find();
  final ConversationProvider convProvider = Get.find();

   AgriView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      PreferredSizeWidget appBar;
      Widget body;
      if (controller.state.isUserAgri()) {
        if (controller.state.showChatMessageUserToAgri.value) {
           appBar = _buildAppBarChatAgriUser('');
          body = MessagesView();
        } else {
          appBar = _buildChatListAppBar();
          if (controller.state.isLoadingAgriConversations.value) {
            // Show loading indicator while conversations are being fetched
            body = const Center(child: CircularProgressIndicator());
          } else if (controller.state.listAgriConversations.isEmpty) {
            // Show a message when there are no conversations
            body = const Center(child: Text('No conversations found'));
          } else {
            // Show the list of conversations
            body = ListView.builder(
              itemCount: controller.state.listAgriConversations.length,
              itemBuilder: (context, index) {
                final conversation =
                    controller.state.listAgriConversations[index];
                return _buildConversationItem(conversation);
              },
            );
          }
        }
      } else {
             Get.snackbar(
        'Error',
      'Error inserting answer: ',
        snackPosition: SnackPosition.BOTTOM,
   
        duration: const Duration(seconds: 30),
      );
        appBar = _buildAppBar();
        body = MessagesView();
      }

      return Scaffold(
        appBar: appBar,
        body: body,
      );
    });
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title: Padding(
        padding: EdgeInsets.symmetric(vertical: 8.w),
        child: Row(
          children: [
            const CircleAvatar(
              backgroundImage: AssetImage('assets/images/gardener.png'),
              backgroundColor: Colors.white,
            ),
            SizedBox(width: 8.w), // Adjust spacing between the avatar and text
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  Strings.agriculturalExpert.tr,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.circle,
                      color: Colors.greenAccent,
                      size: 12,
                    ),
                    SizedBox(width: 5.w),
                    Text(
                      Strings.online.tr,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }


PreferredSizeWidget _buildAppBarChatAgriUser( String? avatar) {
  return AppBar(
    leading: IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
    controller.state.showChatMessageUserToAgri.value = false;
      },
    ),
    title: Padding(
      padding: EdgeInsets.symmetric(vertical: 2.w),
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: (avatar != null && avatar.isNotEmpty)
                ? NetworkImage(avatar)
                : const AssetImage('assets/images/boy.png') as ImageProvider<Object>,
            radius: 25,
          ),
          SizedBox(width: 8.w), // Adjust spacing between the avatar and text
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                controller.state.currentConversation.value?.title ??'',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

  
  PreferredSizeWidget _buildChatListAppBar() {
    return AppBar(
      title: Padding(
        padding: EdgeInsets.symmetric(vertical: 8.w),
        child: Row(
          children: [
            SizedBox(width: 8.w), // Adjust spacing between the icon and text
            const Text(
              'Strings.chatList.tr', // Replace with the appropriate string for chat list
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.search),
          onPressed: () {
            // Handle search action
          },
        ),
      ],
    );
  }

  Widget _buildConversationItem(Conversation conversation) {
    return GestureDetector(
      onTap: () {
        controller.state.showChatMessageUserToAgri.value = true;
        Conversation newConveration = conversation;

        newConveration.question = [];
        controller.getQuestionAndAnswerAgri(newConveration);
        controller.state.nameHeaderQuestion.value = conversation.title ?? 'Client';
         controller.state.nameHeaderAnswer.value =  'You';
      },
      child: FutureBuilder<String?>(
        future: authController.getAvatarUser(conversation.userId ?? ''),
        builder: (BuildContext context, AsyncSnapshot<String?> avatarSnapshot) {
          return FutureBuilder<String?>(
            future: convProvider
                .getLastQuestionContentByConversationId(conversation.id ?? ''),
            builder: (BuildContext context,
                AsyncSnapshot<String?> questionSnapshot) {
              if (avatarSnapshot.connectionState == ConnectionState.waiting ||
                  questionSnapshot.connectionState == ConnectionState.waiting) {
                // Show a placeholder while waiting for the result
                return Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
                  child: Row(
                    children: [
                      const CircleAvatar(
                        backgroundColor: Colors.grey,
                        radius: 25,
                      ),
                      SizedBox(width: 16.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              conversation.title ?? 'No Title',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16.sp),
                            ),
                            SizedBox(height: 4.h),
                            Text(
                              'Loading...',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 14.sp, color: Colors.grey[600]),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              } else if (avatarSnapshot.hasError || questionSnapshot.hasError) {
                // Handle error state
                return Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
                  child: Row(
                    children: [
                      const CircleAvatar(
                        backgroundImage: AssetImage('assets/images/boy.png'),
                        radius: 25,
                      ),
                      SizedBox(width: 16.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              conversation.title ?? 'No Title',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16.sp),
                            ),
                            SizedBox(height: 4.h),
                            Text(
                              'Error loading content',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 14.sp, color: Colors.grey[600]),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              } else if (!avatarSnapshot.hasData ||
                  avatarSnapshot.data == null) {
                // Show default icon if URL is null
                return Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
                  child: Row(
                    children: [
                      const CircleAvatar(
                        backgroundImage: AssetImage('assets/images/boy.png'),
                        radius: 25,
                      ),
                      SizedBox(width: 16.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              conversation.title ?? 'No Title',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16.sp),
                            ),
                            SizedBox(height: 4.h),
                            Text(
                              questionSnapshot.data ?? 'No Description',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 14.sp, color: Colors.grey[600]),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                // Show avatar from URL and last question content
                return Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: (avatarSnapshot.data != null &&
                                avatarSnapshot.data!.isNotEmpty)
                            ? NetworkImage(avatarSnapshot.data!)
                            : const AssetImage('assets/images/boy.png')
                                as ImageProvider<Object>,
                        radius: 25,
                      ),
                      SizedBox(width: 16.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              conversation.title ?? 'No Title',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16.sp),
                            ),
                            SizedBox(height: 4.h),
                            Text(
                              questionSnapshot.data ?? 'No Description',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 14.sp, color: Colors.grey[600]),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }
            },
          );
        },
      ),
    );
  }
}
