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
  final List<SafetyRating>? safetyRatings;

  /// Citation metadata attributing sources for the content.
  final CitationMetadata? citationMetadata;

  TextCompletion({
    required this.output,
    this.safetyRatings,
    this.citationMetadata,
  });

  /// Creates a new TextCompletion from a map.
  factory TextCompletion.fromMap(Map<String, dynamic> map) {
    return TextCompletion(
      // Check if values exist
      output: map['output'] ?? '',
      safetyRatings: (map['safetyRatings'] as List<dynamic>?)
          ?.map((x) => SafetyRating.fromMap(x as Map<String, dynamic>))
          .toList(),
      citationMetadata: map['citationMetadata'] != null
          ? CitationMetadata.fromMap(map['citationMetadata'])
          : null,
    );
  }

  /// Converts the TextCompletion instance into a Map.
  Map<String, dynamic> toMap() => {
        'output': output,
        'safetyRatings': safetyRatings?.map((x) => x.toMap()),
        'citationMetadata': citationMetadata?.toMap(),
      };
}
