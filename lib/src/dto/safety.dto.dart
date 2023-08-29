import 'dart:convert';

// The category of a rating.
//
// These categories cover various kinds of harms that developers
// may wish to adjust.
enum HarmCategory {
  // Category is unspecified.
  harmCategoryUnspecified(0),

  // Negative or harmful comments targeting identity and/or protected attribute.
  harmCategoryDerogatory(1),

  // Content that is rude, disrepspectful, or profane.
  harmCategoryToxicity(2),

  // Describes scenarios depictng violence against an individual or group, or
  // general descriptions of gore.
  harmCategoryViolence(3),

  // Contains references to sexual acts or other lewd content.
  harmCategorySexual(4),

  // Promotes unchecked medical advice.
  harmCategoryMedical(5),

  // Dangerous content that promotes, facilitates, or encourages harmful acts.
  harmCategoryDangerous(6);

  const HarmCategory(this.value);

  final int value;
}

// Block at and beyond a specified harm probability.
enum HarmBlockThreshold {
  // Threshold is unspecified.
  harmBlockThresholdUnspecified(0),

  // Content with NEGLIGIBLE will be allowed.
  blockLowAndAbove(1),

  // Content with NEGLIGIBLE and LOW will be allowed.
  blockMediumAndAbove(2),

  // Content with NEGLIGIBLE, LOW, and MEDIUM will be allowed.
  blockOnlyHigh(3);

  const HarmBlockThreshold(this.value);

  final int value;
}

// A list of reasons why content may have been blocked.
enum BlockedReason {
  // A blocked reason was not specified.
  blockedReasonUnspecified(0),

  // Content was blocked by safety settings.
  safety(1),

  // Content was blocked, but the reason is uncategorized.
  other(2);

  const BlockedReason(this.value);

  final int value;
}

// The probability that a piece of content is harmful.
//
// The classification system gives the probability of the content being
// unsafe. This does not indicate the severity of harm for a piece of content.
enum HarmProbability {
  // Probability is unspecified.
  harmProbabilityUnspecified(0),

  // Content has a negligible chance of being unsafe.
  negligible(1),

  // Content has a low chance of being unsafe.
  low(2),

  // Content has a medium chance of being unsafe.
  medium(3),

  // Content has a high chance of being unsafe.
  high(4);

  const HarmProbability(this.value);

  final int value;
}

// Content filtering metadata associated with processing a single request.
//
// ContentFilter contains a reason and an optional supporting string. The reason
// may be unspecified.

class ContentFilter {
  // The reason content was blocked during request processing.
  final BlockedReason reason;

  // A string that describes the filtering behavior in more detail.
  final String? message;

  ContentFilter({
    required this.reason,
    this.message,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ContentFilter &&
        other.reason == reason &&
        other.message == message;
  }

  @override
  int get hashCode => reason.hashCode ^ message.hashCode;

  ContentFilter copyWith({
    BlockedReason? reason,
    String? message,
  }) {
    return ContentFilter(
      reason: reason ?? this.reason,
      message: message ?? this.message,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'reason': reason.value,
      'message': message,
    };
  }

  factory ContentFilter.fromMap(Map<String, dynamic> map) {
    return ContentFilter(
      reason: map['reason'] as BlockedReason,
      message: map['message'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ContentFilter.fromJson(String source) =>
      ContentFilter.fromMap(json.decode(source));

  @override
  String toString() => 'ContentFilter(reason: $reason, message: $message)';
}

// Safety feedback for an entire request.
//
// This field is populated if content in the input and/or response is blocked
// due to safety settings. SafetyFeedback may not exist for every HarmCategory.
// Each SafetyFeedback will return the safety settings used by the request as
// well as the lowest HarmProbability that should be allowed in order to return
// a result.

class SafetyFeedback {
  // Safety rating evaluated from content.
  final SafetyRating rating;

  // Safety settings applied to the request.
  final SafetySetting setting;

  SafetyFeedback({
    required this.rating,
    required this.setting,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SafetyFeedback &&
        other.rating == rating &&
        other.setting == setting;
  }

  @override
  int get hashCode => rating.hashCode ^ setting.hashCode;

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

  String toJson() => json.encode(toMap());

  factory SafetyFeedback.fromJson(String source) =>
      SafetyFeedback.fromMap(json.decode(source));

  @override
  String toString() => 'SafetyFeedback(rating: $rating, setting: $setting)';
}

// Safety rating for a piece of content.
//
// The safety rating contains the category of harm and the
// harm probability level in that category for a piece of content.
// Content is classified for safety across a number of
// harm categories and the probability of the harm classification is included
// here.

class SafetyRating {
  // Required. The category for this rating.
  final HarmCategory category;

  // Required. The probability of harm for this content.
  final HarmProbability probability;

  SafetyRating({
    required this.category,
    required this.probability,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SafetyRating &&
        other.category == category &&
        other.probability == probability;
  }

  @override
  int get hashCode => category.hashCode ^ probability.hashCode;

  SafetyRating copyWith({
    HarmCategory? category,
    HarmProbability? probability,
  }) {
    return SafetyRating(
      category: category ?? this.category,
      probability: probability ?? this.probability,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'category': category,
      'probability': probability,
    };
  }

  factory SafetyRating.fromMap(Map<String, dynamic> map) {
    return SafetyRating(
      category: map['category'] as HarmCategory,
      probability: map['probability'] as HarmProbability,
    );
  }

  String toJson() => json.encode(toMap());

  factory SafetyRating.fromJson(String source) =>
      SafetyRating.fromMap(json.decode(source));

  @override
  String toString() =>
      'SafetyRating(category: $category, probability: $probability)';
}

// Safety setting, affecting the safety-blocking behavior.
//
// Passing a safety setting for a category changes the allowed proability that
// content is blocked.

class SafetySetting {
  // Required. The category for this setting.
  final HarmCategory category;

  // Required. Controls the probability threshold at which harm is blocked.
  final HarmBlockThreshold threshold;

  SafetySetting({
    required this.category,
    required this.threshold,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SafetySetting &&
        other.category == category &&
        other.threshold == threshold;
  }

  @override
  int get hashCode => category.hashCode ^ threshold.hashCode;

  SafetySetting copyWith({
    HarmCategory? category,
    HarmBlockThreshold? threshold,
  }) {
    return SafetySetting(
      category: category ?? this.category,
      threshold: threshold ?? this.threshold,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'category': category,
      'threshold': threshold,
    };
  }

  factory SafetySetting.fromMap(Map<String, dynamic> map) {
    return SafetySetting(
      category: map['category'] as HarmCategory,
      threshold: map['threshold'] as HarmBlockThreshold,
    );
  }

  String toJson() => json.encode(toMap());

  factory SafetySetting.fromJson(String source) =>
      SafetySetting.fromMap(json.decode(source));

  @override
  String toString() =>
      'SafetySetting(category: $category, threshold: $threshold)';
}
