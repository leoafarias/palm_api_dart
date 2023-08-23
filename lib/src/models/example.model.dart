import 'package:palm_api/src/models/message.model.dart';

/// Represents an input/output example for guiding the generative model.
///
/// An instance of Example constitutes an input/output pair demonstrating
/// a potential interaction with the generative model.
class Example {
  /// The input exemplar enacted as a Message.
  final Message input;

  /// The expected output for the provided input, enacted as a Message.
  final Message output;

  Example({
    required this.input,
    required this.output,
  });

  /// Creates a new Example object from a map.
  factory Example.fromJson(Map<String, dynamic> json) => Example(
        input: Message.fromJson(json['input']),
        output: Message.fromJson(json['output']),
      );

  /// Converts the Example instance into a Map.
  Map<String, dynamic> toJson() => {
        'input': input.toJson(),
        'output': output.toJson(),
      };
}
