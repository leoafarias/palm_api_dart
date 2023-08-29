import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:palm_api/src/dto/citation.dto.dart';
import 'package:palm_api/src/dto/safety.dto.dart';

/// Request to generate a message.

class GenerateMessageRequest {
  /// Required. The name of the model to use.
  ///
  /// Format: `name=models/{model}`.
  final String model;

  /// Required. The structured textual input given to the model as a prompt.
  ///
  /// Given a
  /// prompt, the model will return what it predicts is the next message in the
  /// discussion.
  final MessagePrompt prompt;

  /// Optional. Controls the randomness of the output.
  ///
  /// Values can range over `[0.0,1.0]`,
  /// inclusive. A value closer to `1.0` will produce responses that are more
  /// varied, while a value closer to `0.0` will typically result in
  /// less surprising responses from the model.
  final double? temperature;

  /// Optional. The number of generated response messages to return.
  ///
  /// This value must be between
  /// `[1, 8]`, inclusive. If unset, this will default to `1`.
  final int? candidateCount;

  /// Optional. The maximum cumulative probability of tokens to consider when
  /// sampling.
  ///
  /// The model uses combined Top-k and nucleus sampling.
  ///
  /// Nucleus sampling considers the smallest set of tokens whose probability
  /// sum is at least `top_p`.
  final double? topP;

  /// Optional. The maximum number of tokens to consider when sampling.
  ///
  /// The model uses combined Top-k and nucleus sampling.
  ///
  /// Top-k sampling considers the set of `top_k` most probable tokens.
  final int? topK;

  GenerateMessageRequest({
    required this.model,
    required this.prompt,
    this.temperature,
    this.candidateCount,
    this.topP,
    this.topK,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is GenerateMessageRequest &&
        other.model == model &&
        other.prompt == prompt &&
        other.temperature == temperature &&
        other.candidateCount == candidateCount &&
        other.topP == topP &&
        other.topK == topK;
  }

  @override
  int get hashCode {
    return model.hashCode ^
        prompt.hashCode ^
        temperature.hashCode ^
        candidateCount.hashCode ^
        topP.hashCode ^
        topK.hashCode;
  }

  GenerateMessageRequest copyWith({
    String? model,
    MessagePrompt? prompt,
    double? temperature,
    int? candidateCount,
    double? topP,
    int? topK,
  }) {
    return GenerateMessageRequest(
      model: model ?? this.model,
      prompt: prompt ?? this.prompt,
      temperature: temperature ?? this.temperature,
      candidateCount: candidateCount ?? this.candidateCount,
      topP: topP ?? this.topP,
      topK: topK ?? this.topK,
    );
  }

  @override
  String toString() {
    return 'GenerateMessageRequest(model: $model, prompt: $prompt, temperature: $temperature, candidateCount: $candidateCount, topP: $topP, topK: $topK)';
  }

  Map<String, dynamic> toMap() {
    return {
      'model': model,
      'prompt': prompt.toMap(),
      'temperature': temperature,
      'candidateCount': candidateCount,
      'topP': topP,
      'topK': topK,
    };
  }

  factory GenerateMessageRequest.fromMap(Map<String, dynamic> map) {
    return GenerateMessageRequest(
      model: map['model'] ?? '',
      prompt: MessagePrompt.fromMap(map['prompt']),
      temperature: map['temperature']?.toDouble(),
      candidateCount: map['candidateCount']?.toInt(),
      topP: map['topP']?.toDouble(),
      topK: map['topK']?.toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory GenerateMessageRequest.fromJson(String source) =>
      GenerateMessageRequest.fromMap(json.decode(source));
}

/// The response from the model.
///
/// This includes candidate messages and
/// conversation history in the form of chronologically-ordered messages.

class GenerateMessageResponse {
  /// Candidate response messages from the model.
  final List<Message> candidates;

  /// The conversation history used by the model.
  final List<Message> messages;

  /// A set of content filtering metadata for the prompt and response
  /// text.
  ///
  /// This indicates which `SafetyCategory`(s) blocked a
  /// candidate from this response, the lowest `HarmProbability`
  /// that triggered a block, and the HarmThreshold setting for that category.
  final List<ContentFilter> filters;

  GenerateMessageResponse({
    required this.candidates,
    required this.messages,
    required this.filters,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other is GenerateMessageResponse &&
        listEquals(other.candidates, candidates) &&
        listEquals(other.messages, messages) &&
        listEquals(other.filters, filters);
  }

  @override
  int get hashCode =>
      candidates.hashCode ^ messages.hashCode ^ filters.hashCode;

  GenerateMessageResponse copyWith({
    List<Message>? candidates,
    List<Message>? messages,
    List<ContentFilter>? filters,
  }) {
    return GenerateMessageResponse(
      candidates: candidates ?? this.candidates,
      messages: messages ?? this.messages,
      filters: filters ?? this.filters,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'candidates': candidates.map((x) => x.toMap()).toList(),
      'messages': messages.map((x) => x.toMap()).toList(),
      'filters': filters.map((x) => x.toMap()).toList(),
    };
  }

  factory GenerateMessageResponse.fromMap(Map<String, dynamic> map) {
    return GenerateMessageResponse(
      candidates:
          List<Message>.from(map['candidates']?.map((x) => Message.fromMap(x))),
      messages:
          List<Message>.from(map['messages']?.map((x) => Message.fromMap(x))),
      filters: List<ContentFilter>.from(
          map['filters']?.map((x) => ContentFilter.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory GenerateMessageResponse.fromJson(String source) =>
      GenerateMessageResponse.fromMap(json.decode(source));

  @override
  String toString() =>
      'GenerateMessageResponse(candidates: $candidates, messages: $messages, filters: $filters)';
}

/// The base unit of structured text.
///
/// A `Message` includes an `author` and the `content` of
/// the `Message`.
///
/// The `author` is used to tag messages when they are fed to the
/// model as text.

class Message {
  /// Optional. The author of this Message.
  ///
  /// This serves as a key for tagging
  /// the content of this Message when it is fed to the model as text.
  ///
  /// The author can be any alphanumeric string.
  final String? author;

  /// Required. The text content of the structured `Message`.
  final String content;

  /// Output only. Citation information for model-generated `content` in this
  /// `Message`.
  ///
  /// If this `Message` was generated as output from the model, this field may be
  /// populated with attribution information for any text included in the
  /// `content`. This field is used only on output.
  final CitationMetadata? citationMetadata;

  Message({
    this.author,
    required this.content,
    this.citationMetadata,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Message &&
        other.author == author &&
        other.content == content &&
        other.citationMetadata == citationMetadata;
  }

  @override
  int get hashCode =>
      author.hashCode ^ content.hashCode ^ citationMetadata.hashCode;

  Message copyWith({
    String? author,
    String? content,
    CitationMetadata? citationMetadata,
  }) {
    return Message(
      author: author ?? this.author,
      content: content ?? this.content,
      citationMetadata: citationMetadata ?? this.citationMetadata,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'author': author,
      'content': content,
      'citationMetadata': citationMetadata?.toMap(),
    };
  }

  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      author: map['author'],
      content: map['content'] ?? '',
      citationMetadata: map['citationMetadata'] != null
          ? CitationMetadata.fromMap(map['citationMetadata'])
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Message.fromJson(String source) =>
      Message.fromMap(json.decode(source));

  @override
  String toString() =>
      'Message(author: $author, content: $content, citationMetadata: $citationMetadata)';
}

/// All of the structured input text passed to the model as a prompt.
///
/// A `MessagePrompt` contains a structured set of fields that provide context
/// for the conversation, examples of user input/model output message pairs that
/// prime the model to respond in different ways, and the conversation history
/// or list of messages representing the alternating turns of the conversation
/// between the user and the model.

class MessagePrompt {
  /// Optional. Text that should be provided to the model first to ground the
  /// response.
  ///
  /// If not empty, this `context` will be given to the model first before the
  /// `examples` and `messages`. When using a `context` be sure to provide it
  /// with every request to maintain continuity.
  ///
  /// This field can be a description of your prompt to the model to help provide
  /// context and guide the responses. Examples: "Translate the phrase from
  /// English to French." or "Given a statement, classify the sentiment as happy,
  /// sad or neutral."
  ///
  /// Anything included in this field will take precedence over message history
  /// if the total input size exceeds the model's `input_token_limit` and the
  /// input request is truncated.
  final String? context;

  /// Optional. Examples of what the model should generate.
  ///
  /// This includes both user input and the response that the model should
  /// emulate.
  ///
  /// These `examples` are treated identically to conversation messages except
  /// that they take precedence over the history in `messages`:
  /// If the total input size exceeds the model's `input_token_limit` the input
  /// will be truncated. Items will be dropped from `messages` before `examples`.
  final List<Example>? examples;

  /// Required. A snapshot of the recent conversation history sorted
  /// chronologically.
  ///
  /// Turns alternate between two authors.
  ///
  /// If the total input size exceeds the model's `input_token_limit` the input
  /// will be truncated: The oldest items will be dropped from `messages`.
  final List<Message> messages;

  MessagePrompt({
    this.context,
    this.examples,
    required this.messages,
  });

  @override
  String toString() =>
      'MessagePrompt(context: $context, examples: $examples, messages: $messages)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other is MessagePrompt &&
        other.context == context &&
        listEquals(other.examples, examples) &&
        listEquals(other.messages, messages);
  }

  @override
  int get hashCode => context.hashCode ^ examples.hashCode ^ messages.hashCode;

  MessagePrompt copyWith({
    String? context,
    List<Example>? examples,
    List<Message>? messages,
  }) {
    return MessagePrompt(
      context: context ?? this.context,
      examples: examples ?? this.examples,
      messages: messages ?? this.messages,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'context': context,
      'examples': examples?.map((x) => x.toMap()).toList(),
      'messages': messages.map((x) => x.toMap()).toList(),
    };
  }

  factory MessagePrompt.fromMap(Map<String, dynamic> map) {
    return MessagePrompt(
      context: map['context'],
      examples: map['examples'] != null
          ? List<Example>.from(map['examples']?.map((x) => Example.fromMap(x)))
          : null,
      messages:
          List<Message>.from(map['messages']?.map((x) => Message.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory MessagePrompt.fromJson(String source) =>
      MessagePrompt.fromMap(json.decode(source));
}

/// An input/output example used to instruct the Model.
///
/// It demonstrates how the model should respond or format its response.

class Example {
  /// Required. An example of an input `Message` from the user.
  final Message input;

  /// Required. An example of what the model should output given the input.
  final Message output;

  Example({
    required this.input,
    required this.output,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Example && other.input == input && other.output == output;
  }

  @override
  int get hashCode => input.hashCode ^ output.hashCode;

  Example copyWith({
    Message? input,
    Message? output,
  }) {
    return Example(
      input: input ?? this.input,
      output: output ?? this.output,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'input': input.toMap(),
      'output': output.toMap(),
    };
  }

  factory Example.fromMap(Map<String, dynamic> map) {
    return Example(
      input: Message.fromMap(map['input']),
      output: Message.fromMap(map['output']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Example.fromJson(String source) =>
      Example.fromMap(json.decode(source));

  @override
  String toString() => 'Example(input: $input, output: $output)';
}

/// Counts the number of tokens in the `prompt` sent to a model.
///
/// Models may tokenize text differently, so each model may return a different
/// `tokenCount`.

class CountMessageTokensRequest {
  /// Required. The model's resource name. This serves as an ID for the Model to
  /// use.
  ///
  /// This name should match a model name returned by the `ListModels` method.
  ///
  /// Format: `models/{model}`
  final String model;

  /// Required. The prompt, whose token count is to be returned.
  final MessagePrompt prompt;

  CountMessageTokensRequest({
    required this.model,
    required this.prompt,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CountMessageTokensRequest &&
        other.model == model &&
        other.prompt == prompt;
  }

  @override
  int get hashCode => model.hashCode ^ prompt.hashCode;

  CountMessageTokensRequest copyWith({
    String? model,
    MessagePrompt? prompt,
  }) {
    return CountMessageTokensRequest(
      model: model ?? this.model,
      prompt: prompt ?? this.prompt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'model': model,
      'prompt': prompt.toMap(),
    };
  }

  factory CountMessageTokensRequest.fromMap(Map<String, dynamic> map) {
    return CountMessageTokensRequest(
      model: map['model'] ?? '',
      prompt: MessagePrompt.fromMap(map['prompt']),
    );
  }

  String toJson() => json.encode(toMap());

  factory CountMessageTokensRequest.fromJson(String source) =>
      CountMessageTokensRequest.fromMap(json.decode(source));

  @override
  String toString() =>
      'CountMessageTokensRequest(model: $model, prompt: $prompt)';
}

/// A response from `CountMessageTokens`.
///
/// It returns the model's `token_count` for the `prompt`.

class CountMessageTokensResponse {
  /// The number of tokens that the `model` tokenizes the `prompt` into.
  ///
  /// Always non-negative.
  final int tokenCount;

  CountMessageTokensResponse({
    required this.tokenCount,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CountMessageTokensResponse &&
        other.tokenCount == tokenCount;
  }

  @override
  int get hashCode => tokenCount.hashCode;

  CountMessageTokensResponse copyWith({
    int? tokenCount,
  }) {
    return CountMessageTokensResponse(
      tokenCount: tokenCount ?? this.tokenCount,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'tokenCount': tokenCount,
    };
  }

  factory CountMessageTokensResponse.fromMap(Map<String, dynamic> map) {
    return CountMessageTokensResponse(
      tokenCount: map['tokenCount']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory CountMessageTokensResponse.fromJson(String source) =>
      CountMessageTokensResponse.fromMap(json.decode(source));

  @override
  String toString() => 'CountMessageTokensResponse(tokenCount: $tokenCount)';
}
