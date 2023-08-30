import 'dart:convert';
import 'dart:core';

import 'package:palm_api/src/dto/citation.dto.dart';
import 'package:palm_api/src/dto/safety.dto.dart';
import 'package:palm_api/src/helpers/deep_collection_equality.dart';

class GenerateTextRequest {
  // Required. The model name to use with the format name=models/{model}.
  final String model;

  // Required. The free-form input text given to the model as a prompt.
  //
  // Given a prompt, the model will generate a TextCompletion response it
  // predicts as the completion of the input text.
  final TextPrompt prompt;

  // Controls the randomness of the output.
  // Note: The default value varies by model, see the `Model.temperature`
  // attribute of the `Model` returned the `getModel` function.
  //
  // Values can range from [0.0,1.0],
  // inclusive. A value closer to 1.0 will produce responses that are more
  // varied and creative, while a value closer to 0.0 will typically result in
  // more straightforward responses from the model.
  final double? temperature;

  // Number of generated responses to return.
  //
  // This value must be between [1, 8], inclusive. If unset, this will default
  // to 1.
  final int? candidateCount;

  // The maximum number of tokens to include in a candidate.
  //
  // If unset, this will default to 64.
  final int? maxOutputTokens;

  // The maximum cumulative probability of tokens to consider when sampling.
  //
  // The model uses combined Top-k and nucleus sampling.
  //
  // Tokens are sorted based on their assigned probabilities so that only the
  // most liekly tokens are considered. Top-k sampling directly limits the
  // maximum number of tokens to consider, while Nucleus sampling limits number
  // of tokens based on the cumulative probability.
  //
  // Note: The default value varies by model, see the `Model.top_p`
  // attribute of the `Model` returned the `getModel` function.
  final double? topP;

  // The maximum number of tokens to consider when sampling.
  //
  // The model uses combined Top-k and nucleus sampling.
  //
  // Top-k sampling considers the set of `top_k` most probable tokens.
  // Defaults to 40.
  //
  // Note: The default value varies by model, see the `Model.top_k`
  // attribute of the `Model` returned the `getModel` function.
  final int? topK;

  // A list of unique `SafetySetting` instances for blocking unsafe content.
  //
  // that will be enforced on the `GenerateTextRequest.prompt` and
  // `GenerateTextResponse.candidates`. There should not be more than one
  // setting for each `SafetyCategory` type. The API will block any prompts and
  // responses that fail to meet the thresholds set by these settings. This list
  // overrides the default settings for each `SafetyCategory` specified in the
  // safety_settings. If there is no `SafetySetting` for a given
  // `SafetyCategory` provided in the list, the API will use the default safety
  // setting for that category.
  final List<SafetySetting>? safetySettings;

  // The set of character sequences (up to 5) that will stop output generation.
  // If specified, the API will stop at the first appearance of a stop
  // sequence. The stop sequence will not be included as part of the response.
  final List<String>? stopSequences;

  GenerateTextRequest({
    required this.model,
    required this.prompt,
    this.temperature,
    this.candidateCount,
    this.maxOutputTokens,
    this.topP,
    this.topK,
    this.safetySettings,
    this.stopSequences,
  });

  @override
  String toString() {
    return 'GenerateTextRequest(model: $model, prompt: $prompt, temperature: $temperature, candidateCount: $candidateCount, maxOutputTokens: $maxOutputTokens, topP: $topP, topK: $topK, safetySettings: $safetySettings, stopSequences: $stopSequences)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other is GenerateTextRequest &&
        other.model == model &&
        other.prompt == prompt &&
        other.temperature == temperature &&
        other.candidateCount == candidateCount &&
        other.maxOutputTokens == maxOutputTokens &&
        other.topP == topP &&
        other.topK == topK &&
        listEquals(other.safetySettings, safetySettings) &&
        listEquals(other.stopSequences, stopSequences);
  }

  @override
  int get hashCode {
    return model.hashCode ^
        prompt.hashCode ^
        temperature.hashCode ^
        candidateCount.hashCode ^
        maxOutputTokens.hashCode ^
        topP.hashCode ^
        topK.hashCode ^
        safetySettings.hashCode ^
        stopSequences.hashCode;
  }

  GenerateTextRequest copyWith({
    String? model,
    TextPrompt? prompt,
    double? temperature,
    int? candidateCount,
    int? maxOutputTokens,
    double? topP,
    int? topK,
    List<SafetySetting>? safetySettings,
    List<String>? stopSequences,
  }) {
    return GenerateTextRequest(
      model: model ?? this.model,
      prompt: prompt ?? this.prompt,
      temperature: temperature ?? this.temperature,
      candidateCount: candidateCount ?? this.candidateCount,
      maxOutputTokens: maxOutputTokens ?? this.maxOutputTokens,
      topP: topP ?? this.topP,
      topK: topK ?? this.topK,
      safetySettings: safetySettings ?? this.safetySettings,
      stopSequences: stopSequences ?? this.stopSequences,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'model': model,
      'prompt': prompt.toMap(),
      'temperature': temperature,
      'candidateCount': candidateCount,
      'maxOutputTokens': maxOutputTokens,
      'topP': topP,
      'topK': topK,
      'safetySettings': safetySettings?.map((x) => x.toMap()).toList(),
      'stopSequences': stopSequences,
    };
  }

  factory GenerateTextRequest.fromMap(Map<String, dynamic> map) {
    return GenerateTextRequest(
      model: map['model'] ?? '',
      prompt: TextPrompt.fromMap(map['prompt']),
      temperature: map['temperature']?.toDouble(),
      candidateCount: map['candidateCount']?.toInt(),
      maxOutputTokens: map['maxOutputTokens']?.toInt(),
      topP: map['topP']?.toDouble(),
      topK: map['topK']?.toInt(),
      safetySettings: map['safetySettings'] != null
          ? List<SafetySetting>.from(
              map['safetySettings']?.map((x) => SafetySetting.fromMap(x)))
          : null,
      stopSequences: List<String>.from(map['stopSequences']),
    );
  }

  String toJson() => json.encode(toMap());

  factory GenerateTextRequest.fromJson(String source) =>
      GenerateTextRequest.fromMap(json.decode(source));
}

class GenerateTextResponse {
  // Candidate responses from the model.
  final List<TextCompletion> candidates;

  // A set of content filtering metadata for the prompt and response
  // text.
  //
  // This indicates which `SafetyCategory`(s) blocked a
  // candidate from this response, the lowest `HarmProbability`
  // that triggered a block, and the HarmThreshold setting for that category.
  // This indicates the smallest change to the `SafetySettings` that would be
  // necessary to unblock at least 1 response.
  //
  // The blocking is configured by the `SafetySettings` in the request (or the
  // default `SafetySettings` of the API).
  final List<ContentFilter> filters;

  // Returns any safety feedback related to content filtering.
  final List<SafetyFeedback> safetyFeedback;

  GenerateTextResponse({
    required this.candidates,
    required this.filters,
    required this.safetyFeedback,
  });

  @override
  String toString() =>
      'GenerateTextResponse(candidates: $candidates, filters: $filters, safetyFeedback: $safetyFeedback)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other is GenerateTextResponse &&
        listEquals(other.candidates, candidates) &&
        listEquals(other.filters, filters) &&
        listEquals(other.safetyFeedback, safetyFeedback);
  }

  @override
  int get hashCode =>
      candidates.hashCode ^ filters.hashCode ^ safetyFeedback.hashCode;

  GenerateTextResponse copyWith({
    List<TextCompletion>? candidates,
    List<ContentFilter>? filters,
    List<SafetyFeedback>? safetyFeedback,
  }) {
    return GenerateTextResponse(
      candidates: candidates ?? this.candidates,
      filters: filters ?? this.filters,
      safetyFeedback: safetyFeedback ?? this.safetyFeedback,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'candidates': candidates.map((x) => x.toMap()).toList(),
      'filters': filters.map((x) => x.toMap()).toList(),
      'safetyFeedback': safetyFeedback.map((x) => x.toMap()).toList(),
    };
  }

  factory GenerateTextResponse.fromMap(Map<String, dynamic> map) {
    return GenerateTextResponse(
      candidates: List<TextCompletion>.from(
          map['candidates']?.map((x) => TextCompletion.fromMap(x))),
      filters: List<ContentFilter>.from(
          map['filters']?.map((x) => ContentFilter.fromMap(x))),
      safetyFeedback: List<SafetyFeedback>.from(
          map['safetyFeedback']?.map((x) => SafetyFeedback.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory GenerateTextResponse.fromJson(String source) =>
      GenerateTextResponse.fromMap(json.decode(source));
}

class TextPrompt {
  // Required. The prompt text.
  final String text;

  TextPrompt({
    required this.text,
  });

  @override
  String toString() => 'TextPrompt(text: $text)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TextPrompt && other.text == text;
  }

  @override
  int get hashCode => text.hashCode;

  TextPrompt copyWith({
    String? text,
  }) {
    return TextPrompt(
      text: text ?? this.text,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'text': text,
    };
  }

  factory TextPrompt.fromMap(Map<String, dynamic> map) {
    return TextPrompt(
      text: map['text'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory TextPrompt.fromJson(String source) =>
      TextPrompt.fromMap(json.decode(source));
}

class TextCompletion {
  // Output only. The generated text returned from the model.
  final String output;

  // Ratings for the safety of a response.
  //
  // There is at most one rating per category.
  final List<SafetyRating> safetyRatings;

  // Output only. Citation information for model-generated `output` in this
  // `TextCompletion`.
  //
  // This field may be populated with attribution information for any text
  // included in the `output`.
  final CitationMetadata? citationMetadata;

  TextCompletion({
    required this.output,
    required this.safetyRatings,
    this.citationMetadata,
  });

  @override
  String toString() =>
      'TextCompletion(output: $output, safetyRatings: $safetyRatings, citationMetadata: $citationMetadata)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other is TextCompletion &&
        other.output == output &&
        listEquals(other.safetyRatings, safetyRatings) &&
        other.citationMetadata == citationMetadata;
  }

  @override
  int get hashCode =>
      output.hashCode ^ safetyRatings.hashCode ^ citationMetadata.hashCode;

  TextCompletion copyWith({
    String? output,
    List<SafetyRating>? safetyRatings,
    CitationMetadata? citationMetadata,
  }) {
    return TextCompletion(
      output: output ?? this.output,
      safetyRatings: safetyRatings ?? this.safetyRatings,
      citationMetadata: citationMetadata ?? this.citationMetadata,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'output': output,
      'safetyRatings': safetyRatings.map((x) => x.toMap()).toList(),
      'citationMetadata': citationMetadata?.toMap(),
    };
  }

  factory TextCompletion.fromMap(Map<String, dynamic> map) {
    return TextCompletion(
      output: map['output'] ?? '',
      safetyRatings: List<SafetyRating>.from(
          map['safetyRatings']?.map((x) => SafetyRating.fromMap(x))),
      citationMetadata: map['citationMetadata'] != null
          ? CitationMetadata.fromMap(map['citationMetadata'])
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory TextCompletion.fromJson(String source) =>
      TextCompletion.fromMap(json.decode(source));
}

class EmbedTextRequest {
  // Required. The model name to use with the format model=models/{model}.
  final String model;

  // Required. The free-form input text that the model will turn into an
  // embedding.
  final String text;

  EmbedTextRequest({
    required this.model,
    required this.text,
  });

  @override
  String toString() => 'EmbedTextRequest(model: $model, text: $text)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is EmbedTextRequest &&
        other.model == model &&
        other.text == text;
  }

  @override
  int get hashCode => model.hashCode ^ text.hashCode;

  EmbedTextRequest copyWith({
    String? model,
    String? text,
  }) {
    return EmbedTextRequest(
      model: model ?? this.model,
      text: text ?? this.text,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'model': model,
      'text': text,
    };
  }

  factory EmbedTextRequest.fromMap(Map<String, dynamic> map) {
    return EmbedTextRequest(
      model: map['model'] ?? '',
      text: map['text'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory EmbedTextRequest.fromJson(String source) =>
      EmbedTextRequest.fromMap(json.decode(source));
}

class EmbedTextResponse {
  // Output only. The embedding generated from the input text.
  final Embedding? embedding;

  EmbedTextResponse({
    this.embedding,
  });

  @override
  String toString() => 'EmbedTextResponse(embedding: $embedding)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is EmbedTextResponse && other.embedding == embedding;
  }

  @override
  int get hashCode => embedding.hashCode;

  EmbedTextResponse copyWith({
    Embedding? embedding,
  }) {
    return EmbedTextResponse(
      embedding: embedding ?? this.embedding,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'embedding': embedding?.toMap(),
    };
  }

  factory EmbedTextResponse.fromMap(Map<String, dynamic> map) {
    return EmbedTextResponse(
      embedding:
          map['embedding'] != null ? Embedding.fromMap(map['embedding']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory EmbedTextResponse.fromJson(String source) =>
      EmbedTextResponse.fromMap(json.decode(source));
}

class Embedding {
  // The embedding values.
  final List<double> value;

  Embedding({
    required this.value,
  });

  @override
  String toString() => 'Embedding(value: $value)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other is Embedding && listEquals(other.value, value);
  }

  @override
  int get hashCode => value.hashCode;

  Embedding copyWith({
    List<double>? value,
  }) {
    return Embedding(
      value: value ?? this.value,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'value': value,
    };
  }

  factory Embedding.fromMap(Map<String, dynamic> map) {
    return Embedding(
      value: List<double>.from(map['value']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Embedding.fromJson(String source) =>
      Embedding.fromMap(json.decode(source));
}
