import 'package:palm_api/src/models/citation_metadata.model.dart';
import 'package:palm_api/src/models/safety_rating.model.dart';

/// Represents a generated text response.
///
/// Each instance of TextCompletion represents the model's response
/// to a given text prompt. It also includes safety ratings and optionally,
/// information about the sources contributing to the content.
class TextCompletion {
  /// The generated text response.
  final String output;

  /// List of SafetyRating objects representing ratings for the output.
  final List<SafetyRating> safetyRatings;

  /// Citation metadata attributing sources for the content.
  final CitationMetadata citationMetadata;

  TextCompletion({
    required this.output,
    required this.safetyRatings,
    required this.citationMetadata,
  });

  /// Creates a new TextCompletion from a map.
  factory TextCompletion.fromJson(Map<String, dynamic> json) => TextCompletion(
        output: json['output'],
        safetyRatings: List<SafetyRating>.from(
            json['safetyRatings'].map((x) => SafetyRating.fromJson(x))),
        citationMetadata: CitationMetadata.fromJson(json['citationMetadata']),
      );

  /// Converts the TextCompletion instance into a Map.
  Map<String, dynamic> toJson() => {
        'output': output,
        'safetyRatings':
            List<dynamic>.from(safetyRatings.map((x) => x.toJson())),
        'citationMetadata': citationMetadata.toJson(),
      };
}
