import 'package:palm_api/src/models/safety_rating.model.dart';
import 'package:palm_api/src/models/safety_settings.model.dart';

/// Provides safety feedback based on the request.
///
/// SafetyFeedback utilizes data from both SafetyRating and SafetySetting.
/// It provides feedback on the model's response based on the safety settings
/// applied and the inherent safety rating associated with the generated content.
class SafetyFeedback {
  /// The SafetyRating instance representing the rating that triggered blocking.
  final SafetyRating rating;

  /// The SafetySetting instance applied.
  final SafetySetting setting;

  SafetyFeedback({
    required this.rating,
    required this.setting,
  });

  /// Creates a new SafetyFeedback from a map.
  factory SafetyFeedback.fromJson(Map<String, dynamic> json) => SafetyFeedback(
        rating: SafetyRating.fromJson(json['rating']),
        setting: SafetySetting.fromJson(json['setting']),
      );

  /// Converts the SafetyFeedback instance into a Map.
  Map<String, dynamic> toJson() => {
        'rating': rating.toJson(),
        'setting': setting.toJson(),
      };
}
