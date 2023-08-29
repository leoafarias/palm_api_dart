import 'dart:convert';

import 'package:collection/collection.dart';

class Model {
  /// Required. The resource name of the `Model`. Format: `models/{model}` with a `{model}` naming convention of: "{base_model_id}-{version}". Examples: `models/chat-bison-001`
  final String name;

  /// Required. The name of the base model, pass this to the generation request. Examples: `chat-bison`
  final String baseModelId;

  /// Required. The version number of the model. This represents the major version
  final String version;

  /// The human-readable name of the model. E.g. "Chat Bison". The name can be up to 128 characters long and can consist of any UTF-8 characters.
  final String displayName;

  /// A short description of the model.
  final String description;

  /// Maximum number of input tokens allowed for this model.
  final int inputTokenLimit;

  /// Maximum number of output tokens available for this model.
  final int outputTokenLimit;

  /// The model's supported generation methods. The method names are defined as Pascal case strings, such as `generateMessage` which correspond to API methods.
  final List<String> supportedGenerationMethods;

  /// Controls the randomness of the output. Values can range over `[0.0,1.0]`, inclusive. A value closer to `1.0` will produce responses that are more varied, while a value closer to `0.0` will typically result in less surprising responses from the model. This value specifies default to be used by the backend while making the call to the model.
  final double? temperature;

  /// For Nucleus sampling. Nucleus sampling considers the smallest set of tokens whose probability sum is at least `top_p`. This value specifies default to be used by the backend while making the call to the model.
  final double? topP;

  /// For Top-k sampling. Top-k sampling considers the set of `top_k` most probable tokens. This value specifies default to be used by the backend while making the call to the model.
  final int? topK;

  const Model({
    required this.name,
    required this.baseModelId,
    required this.version,
    required this.displayName,
    required this.description,
    required this.inputTokenLimit,
    required this.outputTokenLimit,
    required this.supportedGenerationMethods,
    this.temperature,
    this.topP,
    this.topK,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other is Model &&
        other.name == name &&
        other.baseModelId == baseModelId &&
        other.version == version &&
        other.displayName == displayName &&
        other.description == description &&
        other.inputTokenLimit == inputTokenLimit &&
        other.outputTokenLimit == outputTokenLimit &&
        listEquals(
            other.supportedGenerationMethods, supportedGenerationMethods) &&
        other.temperature == temperature &&
        other.topP == topP &&
        other.topK == topK;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        baseModelId.hashCode ^
        version.hashCode ^
        displayName.hashCode ^
        description.hashCode ^
        inputTokenLimit.hashCode ^
        outputTokenLimit.hashCode ^
        supportedGenerationMethods.hashCode ^
        temperature.hashCode ^
        topP.hashCode ^
        topK.hashCode;
  }

  @override
  String toString() {
    return 'Model(name: $name, baseModelId: $baseModelId, version: $version, displayName: $displayName, description: $description, inputTokenLimit: $inputTokenLimit, outputTokenLimit: $outputTokenLimit, supportedGenerationMethods: $supportedGenerationMethods, temperature: $temperature, topP: $topP, topK: $topK)';
  }

  Model copyWith({
    String? name,
    String? baseModelId,
    String? version,
    String? displayName,
    String? description,
    int? inputTokenLimit,
    int? outputTokenLimit,
    List<String>? supportedGenerationMethods,
    double? temperature,
    double? topP,
    int? topK,
  }) {
    return Model(
      name: name ?? this.name,
      baseModelId: baseModelId ?? this.baseModelId,
      version: version ?? this.version,
      displayName: displayName ?? this.displayName,
      description: description ?? this.description,
      inputTokenLimit: inputTokenLimit ?? this.inputTokenLimit,
      outputTokenLimit: outputTokenLimit ?? this.outputTokenLimit,
      supportedGenerationMethods:
          supportedGenerationMethods ?? this.supportedGenerationMethods,
      temperature: temperature ?? this.temperature,
      topP: topP ?? this.topP,
      topK: topK ?? this.topK,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'baseModelId': baseModelId,
      'version': version,
      'displayName': displayName,
      'description': description,
      'inputTokenLimit': inputTokenLimit,
      'outputTokenLimit': outputTokenLimit,
      'supportedGenerationMethods': supportedGenerationMethods,
      'temperature': temperature,
      'topP': topP,
      'topK': topK,
    };
  }

  factory Model.fromMap(Map<String, dynamic> map) {
    return Model(
      name: map['name'] ?? '',
      baseModelId: map['baseModelId'] ?? '',
      version: map['version'] ?? '',
      displayName: map['displayName'] ?? '',
      description: map['description'] ?? '',
      inputTokenLimit: map['inputTokenLimit']?.toInt() ?? 0,
      outputTokenLimit: map['outputTokenLimit']?.toInt() ?? 0,
      supportedGenerationMethods:
          List<String>.from(map['supportedGenerationMethods']),
      temperature: map['temperature']?.toDouble(),
      topP: map['topP']?.toDouble(),
      topK: map['topK']?.toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory Model.fromJson(String source) => Model.fromMap(json.decode(source));
}
