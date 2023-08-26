/// Holds a single prompt text string intended for the generative process.
///
/// The purpose of this class is to supply a prompt in textual format
/// which serves as an input for the generative model to respond to.
class TextPrompt {
  /// The textual input used as a prompt for the generative model.
  final String text;

  TextPrompt({
    required this.text,
  });

  /// Creates a new TextPrompt instance from a map.
  factory TextPrompt.fromMap(Map<String, dynamic> map) => TextPrompt(
        text: map['text'],
      );

  /// Converts the TextPrompt instance into a Map.
  Map<String, dynamic> toMap() => {
        'text': text,
      };

  Map<String, dynamic> toJson() => {
        'text': text,
      };
}
