/// Configures the safety settings for a generative session.
///
/// Each instance of this class represents a certain category of safety
/// and a corresponding blocking threshold. The settings defined here contribute
/// to the AI's ability to generate safe and policy-compliant content.
class SafetySetting {
  /// Represents the category of safety.
  final String category;

  /// Represents the blocking threshold for this safety setting.
  final String threshold;

  SafetySetting({
    required this.category,
    required this.threshold,
  });

  /// Creates a new SafetySetting instance from a map.
  factory SafetySetting.fromJson(Map<String, dynamic> json) => SafetySetting(
        category: json['category'],
        threshold: json['threshold'],
      );

  /// Converts the SafetySetting instance into a Map.
  Map<String, dynamic> toJson() => {
        'category': category,
        'threshold': threshold,
      };
}
