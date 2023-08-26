// Request Classes

import 'package:palm_api/src/models/content_filter.model.dart';
import 'package:palm_api/src/models/embedding.model.dart';
import 'package:palm_api/src/models/message.model.dart';
import 'package:palm_api/src/models/message_prompt.model.dart';
import 'package:palm_api/src/models/safety_settings.model.dart';
import 'package:palm_api/src/models/text_completion.model.dart';
import 'package:palm_api/src/models/text_prompt.model.dart';

class CountMessageTokensRequest {
  MessagePrompt prompt;
  CountMessageTokensRequest({
    required this.prompt,
  });

  Map<String, dynamic> toJson() => {'prompt': prompt.toJson()};

  static CountMessageTokensRequest fromJson(Map<String, dynamic> json) =>
      CountMessageTokensRequest(prompt: MessagePrompt.fromJson(json['prompt']));
}

class EmbedTextRequest {
  String text;
  EmbedTextRequest({
    required this.text,
  });

  Map<String, dynamic> toJson() => {'text': text};

  static EmbedTextRequest fromJson(Map<String, dynamic> json) =>
      EmbedTextRequest(text: json['text'] as String);
}

class GenerateMessageRequest {
  MessagePrompt prompt;
  double? temperature;
  int? candidateCount;
  double? topP;
  int? topK;

  GenerateMessageRequest({
    required this.prompt,
    this.temperature,
    this.candidateCount,
    this.topP,
    this.topK,
  });

  Map<String, dynamic> toJson() => {
        'prompt': prompt.toJson(),
        'temperature': temperature,
        'candidateCount': candidateCount,
        'topP': topP,
        'topK': topK,
      };

  static GenerateMessageRequest fromJson(Map<String, dynamic> json) =>
      GenerateMessageRequest(
        prompt: MessagePrompt.fromJson(json['prompt']),
        temperature: json['temperature'] as double?,
        candidateCount: json['candidateCount'] as int?,
        topP: json['topP'] as double?,
        topK: json['topK'] as int?,
      );
}

class GenerateTextRequest {
  TextPrompt prompt;
  List<SafetySetting>? safetySettings;
  List<String>? stopSequences;
  double? temperature;
  int? candidateCount;
  int? maxOutputTokens;
  double? topP;
  int? topK;

  GenerateTextRequest({
    required this.prompt,
    this.safetySettings,
    this.stopSequences,
    this.temperature,
    this.candidateCount,
    this.maxOutputTokens,
    this.topP,
    this.topK,
  });

  Map<String, dynamic> toMap() => {
        'prompt': prompt.toMap(),
        'safetySettings': safetySettings?.map((e) => e.toMap()).toList(),
        'stopSequences': stopSequences,
        'temperature': temperature,
        'candidateCount': candidateCount,
        'maxOutputTokens': maxOutputTokens,
        'topP': topP,
        'topK': topK,
      };

  Map<String, dynamic> toJson() {
    return {
      'prompt': prompt.toJson(),
      'safety_settings': safetySettings?.map((e) => e.toJson()).toList(),
      'stop_sequences': stopSequences,
      'temperature': temperature,
      'candidate_count': candidateCount,
      'max_output_tokens': maxOutputTokens,
      'top_p': topP,
      'top_k': topK,
    };
  }

  static GenerateTextRequest fromMap(Map<String, dynamic> map) {
    final stopSequences = map['stopSequences'] as List<dynamic>?;
    final safetySettings = map['safetySettings'] as List<dynamic>?;
    return GenerateTextRequest(
      prompt: TextPrompt.fromMap(map['prompt']),
      safetySettings: safetySettings
          ?.map<SafetySetting>((e) => SafetySetting.fromMap(e))
          .toList(),
      stopSequences: stopSequences != null
          ? List<String>.from(map['stopSequences'])
          : null,
      temperature: map['temperature'] as double?,
      candidateCount: map['candidateCount'] as int?,
      maxOutputTokens: map['maxOutputTokens'] as int?,
      topP: map['topP'] as double?,
      topK: map['topK'] as int?,
    );
  }
}

class CountMessageTokensResponse {
  int tokenCount;

  CountMessageTokensResponse({
    required this.tokenCount,
  });

  Map<String, dynamic> toJson() {
    return {'tokenCount': tokenCount};
  }

  static CountMessageTokensResponse fromJson(Map<String, dynamic> json) {
    return CountMessageTokensResponse(
      tokenCount: json['tokenCount'] as int,
    );
  }
}

class EmbedTextResponse {
  Embedding embedding;

  EmbedTextResponse({
    required this.embedding,
  });

  Map<String, dynamic> toJson() {
    return {
      'embedding': embedding.toJson(),
    };
  }

  static EmbedTextResponse fromJson(Map<String, dynamic> json) {
    return EmbedTextResponse(
      embedding: Embedding.fromJson(json['embedding']),
    );
  }
}

class GenerateMessageResponse {
  List<Message>? candidates;
  List<Message>? messages;
  List<ContentFilter>? filters;

  GenerateMessageResponse({
    required this.candidates,
    this.messages,
    this.filters,
  });

  Map<String, dynamic> toJson() {
    return {
      'candidates': candidates?.map((e) => e.toJson()).toList(),
      'messages': messages?.map((e) => e.toJson()).toList(),
      'filters': filters?.map((e) => e.toMap()).toList(),
    };
  }

  static GenerateMessageResponse fromJson(Map<String, dynamic> json) {
    return GenerateMessageResponse(
      candidates: (json['candidates'] as List<dynamic>?)
          ?.map<Message>((e) => Message.fromJson(e))
          .toList(),
      messages: (json['messages'] as List<dynamic>?)
          ?.map<Message>((e) => Message.fromJson(e))
          .toList(),
      filters: (json['filters'] as List<dynamic>?)
          ?.map<ContentFilter>((e) => ContentFilter.fromMap(e))
          .toList(),
    );
  }
}

class GenerateTextResponse {
  List<TextCompletion>? candidates;
  List<ContentFilter>? filters;
  List<SafetySetting>? safetyFeedback;

  GenerateTextResponse({
    this.candidates,
    this.filters,
    this.safetyFeedback,
  });

  Map<String, dynamic> toMap() {
    return {
      'candidates': candidates?.map((e) => e.toMap()).toList(),
      'filters': filters?.map((e) => e.toMap()).toList(),
      'safetyFeedback': safetyFeedback?.map((e) => e.toMap()).toList(),
    };
  }

  static GenerateTextResponse fromMap(Map<String, dynamic> map) {
    return GenerateTextResponse(
      candidates: (map['candidates'] as List<dynamic>?)
          ?.map<TextCompletion>((e) => TextCompletion.fromMap(e))
          .toList(),
      filters: (map['filters'] as List<dynamic>?)
          ?.map<ContentFilter>((e) => ContentFilter.fromMap(e))
          .toList(),
      safetyFeedback: (map['safetyFeedback'] as List<dynamic>?)
          ?.map<SafetySetting>((e) => SafetySetting.fromMap(e))
          .toList(),
    );
  }
}
