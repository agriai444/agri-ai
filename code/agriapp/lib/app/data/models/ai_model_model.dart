class AiModel {
  String? id;
  String? companyId;
  Company? company;
  String? name;
  String? modelCode;
  String? description;
  bool? isActivate;
  String? version;
  List<AiModelOutput>? aiModelOutput;
  String? createdAt;
  String? updatedAt;

  AiModel(
      {this.id,
      this.companyId,
      this.company,
      this.name,
      this.modelCode,
      this.description,
      this.isActivate,
      this.version,
      this.aiModelOutput,
      this.createdAt,
      this.updatedAt});

  AiModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    companyId = json['company_id'];
    company =
        json['company'] != null ? Company?.fromJson(json['company']) : null;
    name = json['name'];
    modelCode = json['model_code'];
    description = json['description'];
    isActivate = json['is_activate'];
    version = json['version'];
    if (json['ai_model_output'] != null) {
      aiModelOutput = <AiModelOutput>[];
      json['ai_model_output'].forEach((v) {
        aiModelOutput?.add(AiModelOutput.fromJson(v));
      });
    }
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['company_id'] = companyId;
    if (company != null) {
      data['company'] = company?.toJson();
    }
    data['name'] = name;
    data['model_code'] = modelCode;
    data['description'] = description;
    data['is_activate'] = isActivate;
    data['version'] = version;
    if (aiModelOutput != null) {
      data['ai_model_output'] = aiModelOutput?.map((v) => v.toJson()).toList();
    }
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class Company {
  String? id;
  String? name;
  String? companyUrl;
  String? logoUrl;
  String? apiUrl;
  bool? isActivate;
  String? createdAt;
  String? updatedAt;

  Company(
      {this.id,
      this.name,
      this.companyUrl,
      this.logoUrl,
      this.apiUrl,
      this.isActivate,
      this.createdAt,
      this.updatedAt});

  Company.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    companyUrl = json['company_url'];
    logoUrl = json['logo_url'];
    apiUrl = json['api_url'];
    isActivate = json['is_activate'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['company_url'] = companyUrl;
    data['logo_url'] = logoUrl;
    data['api_url'] = apiUrl;
    data['is_activate'] = isActivate;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class AiModelOutput {
  String? id;
  String? modelId;
  String? outputData;

  AiModelOutput({this.id, this.modelId, this.outputData});

  AiModelOutput.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    modelId = json['model_id'];
    outputData = json['output_data'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['model_id'] = modelId;
    data['output_data'] = outputData;
    return data;
  }
}
