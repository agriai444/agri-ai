import 'package:get/get.dart';

import '../models/ai_model_model.dart';

class AiModelProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.defaultDecoder = (map) {
      if (map is Map<String, dynamic>) return AiModel.fromJson(map);
      if (map is List)
        return map.map((item) => AiModel.fromJson(item)).toList();
    };
    httpClient.baseUrl = 'YOUR-API-URL';
  }

  Future<AiModel?> getAiModel(int id) async {
    final response = await get('aimodel/$id');
    return response.body;
  }

  Future<Response<AiModel>> postAiModel(AiModel aimodel) async =>
      await post('aimodel', aimodel);
  Future<Response> deleteAiModel(int id) async => await delete('aimodel/$id');
}
