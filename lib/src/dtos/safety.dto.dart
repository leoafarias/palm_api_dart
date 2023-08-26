// The category of a rating.
//
// These categories cover various kinds of harms that developers
// may wish to adjust.
enum HarmCategory {
  // Category is unspecified.
  HARM_CATEGORY_UNSPECIFIED,

  // Negative or harmful comments targeting identity and/or protected attribute.
  HARM_CATEGORY_DEROGATORY,

  // Content that is rude, disrepspectful, or profane.
  HARM_CATEGORY_TOXICITY,

  // Describes scenarios depictng violence against an individual or group, or
  // general descriptions of gore.
  HARM_CATEGORY_VIOLENCE,

  // Contains references to sexual acts or other lewd content.
  HARM_CATEGORY_SEXUAL,

  // Promotes unchecked medical advice.
  HARM_CATEGORY_MEDICAL,

  // Dangerous content that promotes, facilitates, or encourages harmful acts.
  HARM_CATEGORY_DANGEROUS,
}

// Block at and beyond a specified harm probability.
enum HarmBlockThreshold {
  // Threshold is unspecified.
  HARM_BLOCK_THRESHOLD_UNSPECIFIED,

  // Content with NEGLIGIBLE will be allowed.
  BLOCK_LOW_AND_ABOVE,

  // Content with NEGLIGIBLE and LOW will be allowed.
  BLOCK_MEDIUM_AND_ABOVE,

  // Content with NEGLIGIBLE, LOW, and MEDIUM will be allowed.
  BLOCK_ONLY_HIGH,
}

// A list of reasons why content may have been blocked.
enum BlockedReason {
  // A blocked reason was not specified.
  BLOCKED_REASON_UNSPECIFIED,

  // Content was blocked by safety settings.
  SAFETY,

  // Content was blocked, but the reason is uncategorized.
  OTHER,
}

// The probability that a piece of content is harmful.
//
// The classification system gives the probability of the content being
// unsafe. This does not indicate the severity of harm for a piece of content.
enum HarmProbability {
  // Probability is unspecified.
  HARM_PROBABILITY_UNSPECIFIED,

  // Content has a negligible chance of being unsafe.
  NEGLIGIBLE,

  // Content has a low chance of being unsafe.
  LOW,

  // Content has a medium chance of being unsafe.
  MEDIUM,

  // Content has a high chance of being unsafe.
  HIGH,
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
}
