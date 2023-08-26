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

  SafetyFeedback copyWith({
    SafetyRating? rating,
    SafetySetting? setting,
  }) {
    return SafetyFeedback(
      rating: rating ?? this.rating,
      setting: setting ?? this.setting,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'rating': rating.toMap(),
      'setting': setting.toMap(),
    };
  }

  factory SafetyFeedback.fromMap(Map<String, dynamic> map) {
    return SafetyFeedback(
      rating: SafetyRating.fromMap(map['rating']),
      setting: SafetySetting.fromMap(map['setting']),
    );
  }

  @override
  String toString() => 'SafetyFeedback(rating: $rating, setting: $setting)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SafetyFeedback &&
        other.rating == rating &&
        other.setting == setting;
  }

  @override
  int get hashCode => rating.hashCode ^ setting.hashCode;
}
