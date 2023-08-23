import 'package:palm_api/src/models/example.model.dart';
import 'package:palm_api/src/models/message.model.dart';

/// Represents a structured prompt that includes context, examples, and past messages.
///
/// MessagePrompt is used to provide a comprehensive view of the discussion
/// by carrying prior messages, examples and context to guide the generative model.
class MessagePrompt {
  /// The grounding context represented as a string.
  final String? context;

  /// The list of examples, modeled as Example objects.
  final List<Example>? examples;

  /// The list of prior message(s) represented as Message objects.
  final List<Message> messages;

  MessagePrompt({
    this.context,
    this.examples,
    required this.messages,
  });

  /// Creates a new MessagePrompt instance from a map.
  factory MessagePrompt.fromJson(Map<String, dynamic> json) => MessagePrompt(
        context: json['context'],
        examples: json['examples'] != null
            ? List<Example>.from(
                json['examples'].map((x) => Example.fromJson(x)))
            : null,
        messages: List<Message>.from(
            json['messages'].map((x) => Message.fromJson(x))),
      );

  /// Converts the MessagePrompt instance into a Map.
  Map<String, dynamic> toJson() => {
        'context': context,
        'examples': examples != null
            ? List<dynamic>.from(examples!.map((x) => x.toJson()))
            : null,
        'messages': List<dynamic>.from(messages.map((x) => x.toJson())),
      };
}
