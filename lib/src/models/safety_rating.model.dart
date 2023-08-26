/// Represents the safety rating for a certain type of content.
///
/// The safety rating is categorized under different types and each category
/// has an associated probability of causing harm. The final rating is influenced
/// by these two aspects.
class SafetyRating {
  /// The applicable safety category.
  final String category;

  /// The probability representing potential harm.
  final String probability;

  SafetyRating({
    required this.category,
    required this.probability,
  });

  /// Creates a new SafetyRating from a map.
  factory SafetyRating.fromMap(Map<String, dynamic> map) => SafetyRating(
        category: map['category'],
        probability: map['probability'],
      );

  /// Converts the SafetyRating instance into a Map.
  Map<String, dynamic> toMap() => {
        'category': category,
        'probability': probability,
      };
}
