import 'package:palm_api/src/dtos/citation.dto.dart';
import 'package:palm_api/src/dtos/safety.dto.dart';

// Enums are not nested within the classes.

// Message classes with comments based on the reference.

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
}

/// Counts the number of tokens in the `prompt` sent to a model.
///
/// Models may tokenize text differently, so each model may return a different
/// `token_count`.
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
}
