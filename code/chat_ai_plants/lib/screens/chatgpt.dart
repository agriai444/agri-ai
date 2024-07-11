import 'dart:convert';
import 'dart:io';
import 'dart:math';


import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;
import 'package:dart_openai/openai.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:hive/hive.dart';

import '../hive_model/chat_item.dart';
import '../hive_model/message_item.dart';
import '../hive_model/message_role.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key, required this.chatItem});

  final ChatItem chatItem;

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final List<types.Message> _messages = [];
  final List<OpenAIChatCompletionChoiceMessageModel> _aiMessages = [];
  late types.User ai;
  late types.User user;
  late Box messageBox;

  late String appBarTitle;

  var chatResponseId = '';
  var chatResponseContent = '';

  bool isAiTyping = false;

  @override
  void initState() {
    super.initState();
    ai = const types.User(id: 'ai', firstName: 'AI');
    user = const types.User(id: 'user', firstName: 'You');

    messageBox = Hive.box('messages');

    appBarTitle = widget.chatItem.title;

    // read chat history from Hive
    for (var messageItem in widget.chatItem.messages) {
      messageItem as MessageItem;
      // Add to chat view
      final textMessage = types.TextMessage(
        author: messageItem.role == MessageRole.ai ? ai : user,
        createdAt: messageItem.createdAt.millisecondsSinceEpoch,
        id: randomString(),
        text: messageItem.message,
      );

      _messages.insert(0, textMessage);

      // construct chatgpt messages
      _aiMessages.add(OpenAIChatCompletionChoiceMessageModel(
        content: messageItem.message,
        role: messageItem.role == MessageRole.ai
            ? OpenAIChatMessageRole.assistant
            : OpenAIChatMessageRole.user,
      ));
    }
  }

  String randomString() {
    final random = Random.secure();
    final values = List<int>.generate(16, (i) => random.nextInt(255));
    return base64UrlEncode(values);
  }

  void _completeChat(String prompt) async {
    _aiMessages.add(OpenAIChatCompletionChoiceMessageModel(
      content: prompt,
      role: OpenAIChatMessageRole.user,
    ));

    Stream<OpenAIStreamChatCompletionModel> chatStream =
        OpenAI.instance.chat.createStream(
      model: "gpt-3.5-turbo",
      messages: _aiMessages,
    );

    chatStream.listen((chatStreamEvent) {
      debugPrint(chatStreamEvent.toString());
      // existing id: just update to the same text bubble
      if (chatResponseId == chatStreamEvent.id) {
        chatResponseContent +=
            chatStreamEvent.choices.first.delta.content ?? '';

        _addMessageStream(chatResponseContent);

        if (chatStreamEvent.choices.first.finishReason == "stop") {
          isAiTyping = false;
          _aiMessages.add(OpenAIChatCompletionChoiceMessageModel(
            content: chatResponseContent,
            role: OpenAIChatMessageRole.assistant,
          ));
          _saveMessage(chatResponseContent, MessageRole.ai);
          chatResponseId = '';
          chatResponseContent = '';
        }
      } else {
        // new id: create new text bubble
        chatResponseId = chatStreamEvent.id;
        chatResponseContent = chatStreamEvent.choices.first.delta.content ?? '';
        onMessageReceived(id: chatResponseId, message: chatResponseContent);
        isAiTyping = true;
      }
    });
  }

  void onMessageReceived({String? id, required String message}) {
    var newMessage = types.TextMessage(
      author: ai,
      id: id ?? DateTime.now().millisecondsSinceEpoch.toString(),
      text: message,
      createdAt: DateTime.now().millisecondsSinceEpoch,
    );
    _addMessage(newMessage);
  }

  // add new bubble to chat
  void _addMessage(types.Message message) {
    setState(() {
      _messages.insert(0, message);
    });
  }

  /// Save message to Hive database
  void _saveMessage(String message, MessageRole role) {
    final messageItem = MessageItem(message, role, DateTime.now());
    messageBox.add(messageItem);
    widget.chatItem.messages.add(messageItem);
    widget.chatItem.save();
  }

  // modify last bubble in chat
  void _addMessageStream(String message) {
    setState(() {
      _messages.first =
          (_messages.first as types.TextMessage).copyWith(text: message);
    });
  }

  void _handleSendPressed(types.PartialText message) async {
    final textMessage = types.TextMessage(
      author: user,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: randomString(),
      text: message.text,
    );

    _addMessage(textMessage);
    _saveMessage(message.text, MessageRole.user);
    _completeChat(message.text);
  }


   void _handlePreviewDataFetched(
    types.TextMessage message,
    types.PreviewData previewData,
  ) {
    final index = _messages.indexWhere((element) => element.id == message.id);
    final updatedMessage = (_messages[index] as types.TextMessage).copyWith(
      previewData: previewData,
    );

    setState(() {
      _messages[index] = updatedMessage;
    });
  }

 void _handleFileSelection() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.any,
    );

    if (result != null && result.files.single.path != null) {
      final message = types.FileMessage(
        author: user,
        createdAt: DateTime.now().millisecondsSinceEpoch,
        id: const Uuid().v4(),
        mimeType: lookupMimeType(result.files.single.path!),
        name: result.files.single.name,
        size: result.files.single.size,
        uri: result.files.single.path!,
      );

      _addMessage(message);
    }
  }

   void _handleImageSelection() async {
    final result = await ImagePicker().pickImage(
      imageQuality: 70,
      maxWidth: 1440,
      source: ImageSource.gallery,
    );

    if (result != null) {
      final bytes = await result.readAsBytes();
      final image = await decodeImageFromList(bytes);

      final message = types.ImageMessage(
        author: user,
        createdAt: DateTime.now().millisecondsSinceEpoch,
        height: image.height.toDouble(),
        id: const Uuid().v4(),
        name: result.name,
        size: bytes.length,
        uri: result.path,
        width: image.width.toDouble(),
      );

      _addMessage(message);
    }
  }

   void _handleAttachmentPressed() {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) => SafeArea(
        child: SizedBox(
          height: 144,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  _handleImageSelection();
                },
                child: const Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Text('Photo'),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  _handleFileSelection();
                },
                child: const Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Text('File'),
                ),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Text('Cancel'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }



 void _handleMessageTap(BuildContext _, types.Message message) async {
    if (message is types.FileMessage) {
      var localPath = message.uri;

      if (message.uri.startsWith('http')) {
        try {
          final index =
              _messages.indexWhere((element) => element.id == message.id);
          final updatedMessage =
              (_messages[index] as types.FileMessage).copyWith(
            isLoading: true,
          );

          setState(() {
            _messages[index] = updatedMessage;
          });

          final client = http.Client();
          final request = await client.get(Uri.parse(message.uri));
          final bytes = request.bodyBytes;
          final documentsDir = (await getApplicationDocumentsDirectory()).path;
          localPath = '$documentsDir/${message.name}';

          if (!File(localPath).existsSync()) {
            final file = File(localPath);
            await file.writeAsBytes(bytes);
          }
        } finally {
          final index =
              _messages.indexWhere((element) => element.id == message.id);
          final updatedMessage =
              (_messages[index] as types.FileMessage).copyWith(
            isLoading: null,
          );

          setState(() {
            _messages[index] = updatedMessage;
          });
        }
      }

      await OpenFilex.open(localPath);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(appBarTitle),
      ),
      body: Chat(
        typingIndicatorOptions: TypingIndicatorOptions(
          typingUsers: [if (isAiTyping) ai],
        ),
        inputOptions: InputOptions(enabled: !isAiTyping),
        messages: _messages,
            onAttachmentPressed: _handleAttachmentPressed,
          onMessageTap: _handleMessageTap,
          onPreviewDataFetched: _handlePreviewDataFetched,
        onSendPressed: _handleSendPressed,
        user: user,
        theme: DefaultChatTheme(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        ),
      ),
    );
  }
}


// import 'dart:convert';
// import 'dart:math';

// import 'package:dart_openai/openai.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_chat_ui/flutter_chat_ui.dart';
// import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
// import 'package:hive/hive.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:intl/date_symbol_data_local.dart';

// import 'package:file_picker/file_picker.dart';
// import '../hive_model/chat_item.dart';
// import '../hive_model/message_item.dart';
// import '../hive_model/message_role.dart';
// import 'custom_input.dart'; // Import the custom input widget

// class ChatPage extends StatefulWidget {
//   const ChatPage({super.key, required this.chatItem});

//   final ChatItem chatItem;

//   @override
//   State<ChatPage> createState() => _ChatPageState();
// }

// class _ChatPageState extends State<ChatPage> {
//   final List<types.Message> _messages = [];
//   final List<OpenAIChatCompletionChoiceMessageModel> _aiMessages = [];
//   late types.User ai;
//   late types.User user;
//   late Box messageBox;

//   late String appBarTitle;

//   var chatResponseId = '';
//   var chatResponseContent = '';

//   bool isAiTyping = false;

//   @override
//   void initState() {
//     super.initState();
//     ai = const types.User(id: 'ai', firstName: 'AI');
//     user = const types.User(id: 'user', firstName: 'You');

//     messageBox = Hive.box('messages');

//     appBarTitle = widget.chatItem.title;

//     // read chat history from Hive
//     for (var messageItem in widget.chatItem.messages) {
//       messageItem as MessageItem;
//       // Add to chat view
//       final textMessage = types.TextMessage(
//         author: messageItem.role == MessageRole.ai ? ai : user,
//         createdAt: messageItem.createdAt.millisecondsSinceEpoch,
//         id: randomString(),
//         text: messageItem.message,
//       );

//       _messages.insert(0, textMessage);

//       // construct chatgpt messages
//       _aiMessages.add(OpenAIChatCompletionChoiceMessageModel(
//         content: messageItem.message,
//         role: messageItem.role == MessageRole.ai
//             ? OpenAIChatMessageRole.assistant
//             : OpenAIChatMessageRole.user,
//       ));
//     }
//   }

//   String randomString() {
//     final random = Random.secure();
//     final values = List<int>.generate(16, (i) => random.nextInt(255));
//     return base64UrlEncode(values);
//   }

//   void _completeChat(String prompt) async {
//     _aiMessages.add(OpenAIChatCompletionChoiceMessageModel(
//       content: prompt,
//       role: OpenAIChatMessageRole.user,
//     ));

//     Stream<OpenAIStreamChatCompletionModel> chatStream =
//         OpenAI.instance.chat.createStream(
//       model: "gpt-3.5-turbo",
//       messages: _aiMessages,
//     );

//     chatStream.listen((chatStreamEvent) {
//       debugPrint(chatStreamEvent.toString());
//       // existing id: just update to the same text bubble
//       if (chatResponseId == chatStreamEvent.id) {
//         chatResponseContent +=
//             chatStreamEvent.choices.first.delta.content ?? '';

//         _addMessageStream(chatResponseContent);

//         if (chatStreamEvent.choices.first.finishReason == "stop") {
//           isAiTyping = false;
//           _aiMessages.add(OpenAIChatCompletionChoiceMessageModel(
//             content: chatResponseContent,
//             role: OpenAIChatMessageRole.assistant,
//           ));
//           _saveMessage(chatResponseContent, MessageRole.ai);
//           chatResponseId = '';
//           chatResponseContent = '';
//         }
//       } else {
//         // new id: create new text bubble
//         chatResponseId = chatStreamEvent.id;
//         chatResponseContent = chatStreamEvent.choices.first.delta.content ?? '';
//         onMessageReceived(id: chatResponseId, message: chatResponseContent);
//         isAiTyping = true;
//       }
//     });
//   }

//   void onMessageReceived({String? id, required String message}) {
//     var newMessage = types.TextMessage(
//       author: ai,
//       id: id ?? DateTime.now().millisecondsSinceEpoch.toString(),
//       text: message,
//       createdAt: DateTime.now().millisecondsSinceEpoch,
//     );
//     _addMessage(newMessage);
//   }

//   // add new bubble to chat
//   void _addMessage(types.Message message) {
//     setState(() {
//       _messages.insert(0, message);
//     });
//   }

//  void _handleFileSelection() async {
//     final result = await FilePicker.platform.pickFiles(
//       type: FileType.any,
//     );

//     if (result != null && result.files.single.path != null) {
//       final message = types.FileMessage(
//         author: _user,
//         createdAt: DateTime.now().millisecondsSinceEpoch,
//         id: const Uuid().v4(),
//         mimeType: lookupMimeType(result.files.single.path!),
//         name: result.files.single.name,
//         size: result.files.single.size,
//         uri: result.files.single.path!,
//       );

//       _addMessage(message);
//     }
//   }

//   void _handleImageSelection() async {
//     final result = await ImagePicker().pickImage(
//       imageQuality: 70,
//       maxWidth: 1440,
//       source: ImageSource.gallery,
//     );

//     if (result != null) {
//       final bytes = await result.readAsBytes();
//       final image = await decodeImageFromList(bytes);

//       final message = types.ImageMessage(
//         author: _user,
//         createdAt: DateTime.now().millisecondsSinceEpoch,
//         height: image.height.toDouble(),
//         id: const Uuid().v4(),
//         name: result.name,
//         size: bytes.length,
//         uri: result.path,
//         width: image.width.toDouble(),
//       );

//       _addMessage(message);
//     }
//   }
//   /// Save message to Hive database
//   void _saveMessage(String message, MessageRole role) {
//     final messageItem = MessageItem(message, role, DateTime.now());
//     messageBox.add(messageItem);
//     widget.chatItem.messages.add(messageItem);
//     widget.chatItem.save();
//   }

//   // modify last bubble in chat
//   void _addMessageStream(String message) {
//     setState(() {
//       _messages.first =
//           (_messages.first as types.TextMessage).copyWith(text: message);
//     });
//   }

//   void _handleSendPressed(String text) async {
//     final textMessage = types.TextMessage(
//       author: user,
//       createdAt: DateTime.now().millisecondsSinceEpoch,
//       id: randomString(),
//       text: text,
//     );

//     _addMessage(textMessage);
//     _saveMessage(text, MessageRole.user);
//     _completeChat(text);
//   }

//   void _handleUploadPressed() {
//     // Implement your file upload logic here
//     print('Upload button pressed');
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(appBarTitle),
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: Chat(
//               typingIndicatorOptions: TypingIndicatorOptions(
//                 typingUsers: [if (isAiTyping) ai],
//               ),
//               messages: _messages,
//               onSendPressed: (types.PartialText message) {
//                 _handleSendPressed(message.text);
//               },
//               user: user,
//               theme: DefaultChatTheme(
//                 backgroundColor: Theme.of(context).scaffoldBackgroundColor,
//               ),
//             ),
//           ),
//           CustomInput(
//             onSendPressed: _handleSendPressed,
//             onUploadPressed: _handleUploadPressed,
//             enabled: !isAiTyping,
//           ),
//         ],
//       ),
//     );
//   }
// }
