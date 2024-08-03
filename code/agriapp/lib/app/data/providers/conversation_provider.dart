import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/conversation_model.dart';

class ConversationProvider extends GetConnect {
  final supabase = Supabase.instance.client;
  final userId = "37b581d9-3e40-45f5-9456-6aff162cec22";

  @override
  void onInit() {
    httpClient.defaultDecoder = (map) {
      if (map is Map<String, dynamic>) return Conversation.fromJson(map);
      if (map is List) return map.map((item) => Conversation.fromJson(item)).toList();
    };
    httpClient.baseUrl = 'YOUR-API-URL';
  }

  Future<List<Conversation>> getConversations( {int page = 1}) async {
    final response = await supabase
        .from('conversation')
        .select()
        .eq('user_id', userId)
        .order('created_at', ascending: false)
        .range((page - 1) * 10, page * 10 - 1);
print(response);
    return (response as List).map((item) => Conversation.fromJson(item)).toList();
  }

  Future<Conversation?> getConversationById(String conversationId) async {
    final response = await supabase
        .from('conversation')
        .select()
        .eq('id', conversationId)
        .single();

    return response != null ? Conversation.fromJson(response) : null;
  }

  Future<Conversation> addNewConversation(String title) async {
    final response = await supabase
        .from('conversation')
        .insert({
          'user_id': userId,
          'title': title,
        })
        .select()
        .single();

    return Conversation.fromJson(response);
  }

Future<List<Question>> getListQuestionAnswerByConversationId(String conversationId) async {
  final response = await supabase
    .from('question')
    .select('*, answer(*), question_media(*)')
    .eq('conversation_id', conversationId);

print(response);
  final data = response as List<dynamic>;
  return data.map((item) => Question.fromJson(item)).toList();
}

  Future<Conversation> addQuestionAnswerByConversationId(String conversationId, String content) async {
    final response = await supabase
        .from('chat_ai')
        .insert({
          'conversation_id': conversationId,
          'user_id': userId,
          'content': content,
        })
        .select()
        .single();

    return Conversation.fromJson(response);
  }

  // Existing methods...
  Future<Conversation?> getConversation(int id) async {
    final response = await get('Conversation/$id');
    return response.body;
  }

  Future<Response<Conversation>> postConversation(Conversation conversation) async =>
      await post('Conversation', conversation);

  Future<Response> deleteChatAi(int id) async => await delete('chatai/$id');
}