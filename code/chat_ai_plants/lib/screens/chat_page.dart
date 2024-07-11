// import 'dart:convert';
// import 'dart:io';
// import 'dart:math';

// import 'package:flutter/material.dart';
// import 'package:flutter_chat_ui/flutter_chat_ui.dart';
// import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
// import 'package:hive/hive.dart';
// import 'package:http/http.dart' as http;
// import 'package:image_picker/image_picker.dart';

// import '../hive_model/chat_item.dart';
// import '../hive_model/message_item.dart';
// import '../hive_model/message_role.dart';

// class ChatPage extends StatefulWidget {
//   const ChatPage({super.key, required this.chatItem});

//   final ChatItem chatItem;

//   @override
//   State<ChatPage> createState() => _ChatPageState();
// }

// class _ChatPageState extends State<ChatPage> {
//   final List<types.Message> _messages = [];
//   late types.User ai;
//   late types.User user;
//   late Box messageBox;

//   late String appBarTitle;

//   bool isAiTyping = false;
//   File? _imageFile;

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
//       if (messageItem.role == MessageRole.ai) {
//         final textMessage = types.TextMessage(
//           author: ai,
//           createdAt: messageItem.createdAt.millisecondsSinceEpoch,
//           id: randomString(),
//           text: messageItem.message,
//         );
//         _messages.insert(0, textMessage);
//       } else {
//         final textMessage = types.TextMessage(
//           author: user,
//           createdAt: messageItem.createdAt.millisecondsSinceEpoch,
//           id: randomString(),
//           text: messageItem.message,
//         );
//         _messages.insert(0, textMessage);
//       }
//     }
//   }

//   String randomString() {
//     final random = Random.secure();
//     final values = List<int>.generate(16, (i) => random.nextInt(255));
//     return base64UrlEncode(values);
//   }

//   Future<String> generateText(String prompt) async {
//     final apiUrl = Uri.parse(
//         'https://api-inference.huggingface.co/models/mistralai/Mistral-7B-Instruct-v0.2');
//     final headers = {
//       'Authorization':
//           'Bearer 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',
//       'Content-Type': 'application/json'
//     };
//     final body = jsonEncode({
//       'inputs': prompt,
//       'stream': false
//     });

//     final response =
//         await http.post(apiUrl, headers: headers, body: body);

//     if (response.statusCode == 200) {
//       final result = jsonDecode(response.body);
//       final generatedText = result[0]['generated_text'];

//       return generatedText;
//     } else {
//       throw Exception(
//           'Failed to generate text: ${response.statusCode} ${response.body}');
//     }
//   }

//   void _completeChat(String prompt) async {
//     setState(() {
//       isAiTyping = true;
//     });

//     try {
//       final generatedText = await generateText(prompt);
//       onMessageReceived(message: generatedText);
//       _saveMessage(generatedText, MessageRole.ai);
//     } catch (e) {
//       print('Error generating text: $e');
//     } finally {
//       setState(() {
//         isAiTyping = false;
//       });
//     }
//   }

//   void onMessageReceived({required String message}) {
//     var newMessage = types.TextMessage(
//       author: ai,
//       id: DateTime.now().millisecondsSinceEpoch.toString(),
//       text: message,
//       createdAt: DateTime.now().millisecondsSinceEpoch,
//     );
//     _addMessage(newMessage);
//   }

//   void _addMessage(types.Message message) {
//     setState(() {
//       _messages.insert(0, message);
//     });
//   }

//   void _saveMessage(String message, MessageRole role) {
//     final messageItem = MessageItem(message, role, DateTime.now());
//     messageBox.add(messageItem);
//     widget.chatItem.messages.add(messageItem);
//     widget.chatItem.save();
//   }

//   Future<void> _handleImageUpload() async {
//     final pickedFile =
//         await ImagePicker().getImage(source: ImageSource.gallery);
//     if (pickedFile != null) {
//       setState(() {
//         _imageFile = File(pickedFile.path);
//       });
//       _uploadImage();
//     }
//   }

//   Future<void> _uploadImage() async {
//     try {
//       final apiUrl = Uri.parse('https://your-backend-api.com/upload-image');
//       final response = await http.post(
//         apiUrl,
//         body: {
//           'image': await _imageFile!.readAsBytes(),
//         },
//       );

//       if (response.statusCode == 200) {
//         final imageUrl = response.body['imageUrl'];
//         final message = types.ImageMessage(
//           author: user,
//           id: randomString(),
//           uri: imageUrl,
//           createdAt: DateTime.now().millisecondsSinceEpoch,
//         );
//         _addMessage(message);
//         _saveMessage(imageUrl, MessageRole.user);
//         _completeChat(imageUrl);
//       } else {
//         throw Exception('Failed to upload image: ${response.statusCode}');
//       }
//     } catch (e) {
//       print('Error uploading image: $e');
//     }
//   }

//   void _handleSendPressed(types.PartialText message) async {
//     final textMessage = types.TextMessage(
//       author: user,
//       createdAt: DateTime.now().millisecondsSinceEpoch,
//       id: randomString(),
//       text: message.text,
//     );

//     _addMessage(textMessage);
//     _saveMessage(message.text, MessageRole.user);
//     _completeChat(message.text);
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
//               inputOptions: InputOptions(enabled: !isAiTyping),
//               messages: _messages,
//               onSendPressed: _handleSendPressed,
//               user: user,
//               theme: DefaultChatTheme(
//                 backgroundColor: Theme.of(context).scaffoldBackgroundColor,
//               ),
//             ),
//           ),
//           ElevatedButton(
//             onPressed: _handleImageUpload,
//             child: Text('Upload Image'),
//           ),
//         ],
//       ),
//     );
//   }
// }

