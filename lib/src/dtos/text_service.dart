import 'dart:core';

import 'package:palm_api/src/dtos/citation.dto.dart';
import 'package:palm_api/src/dtos/safety.dto.dart';

class GenerateTextRequest {
  // Required. The model name to use with the format name=models/{model}.
  final String model;

  // Required. The free-form input text given to the model as a prompt.
  //
  // Given a prompt, the model will generate a TextCompletion response it
  // predicts as the completion of the input text.
  final TextPrompt prompt;

  // Controls the randomness of the output.
  // Note: The default value varies by model, see the `Model.temperature`
  // attribute of the `Model` returned the `getModel` function.
  //
  // Values can range from [0.0,1.0],
  // inclusive. A value closer to 1.0 will produce responses that are more
  // varied and creative, while a value closer to 0.0 will typically result in
  // more straightforward responses from the model.
  final double? temperature;

  // Number of generated responses to return.
  //
  // This value must be between [1, 8], inclusive. If unset, this will default
  // to 1.
  final int? candidateCount;

  // The maximum number of tokens to include in a candidate.
  //
  // If unset, this will default to 64.
  final int? maxOutputTokens;

  // The maximum cumulative probability of tokens to consider when sampling.
  //
  // The model uses combined Top-k and nucleus sampling.
  //
  // Tokens are sorted based on their assigned probabilities so that only the
  // most liekly tokens are considered. Top-k sampling directly limits the
  // maximum number of tokens to consider, while Nucleus sampling limits number
  // of tokens based on the cumulative probability.
  //
  // Note: The default value varies by model, see the `Model.top_p`
  // attribute of the `Model` returned the `getModel` function.
  final double? topP;

  // The maximum number of tokens to consider when sampling.
  //
  // The model uses combined Top-k and nucleus sampling.
  //
  // Top-k sampling considers the set of `top_k` most probable tokens.
  // Defaults to 40.
  //
  // Note: The default value varies by model, see the `Model.top_k`
  // attribute of the `Model` returned the `getModel` function.
  final int? topK;

  // A list of unique `SafetySetting` instances for blocking unsafe content.
  //
  // that will be enforced on the `GenerateTextRequest.prompt` and
  // `GenerateTextResponse.candidates`. There should not be more than one
  // setting for each `SafetyCategory` type. The API will block any prompts and
  // responses that fail to meet the thresholds set by these settings. This list
  // overrides the default settings for each `SafetyCategory` specified in the
  // safety_settings. If there is no `SafetySetting` for a given
  // `SafetyCategory` provided in the list, the API will use the default safety
  // setting for that category.
  final List<SafetySetting>? safetySettings;

  // The set of character sequences (up to 5) that will stop output generation.
  // If specified, the API will stop at the first appearance of a stop
  // sequence. The stop sequence will not be included as part of the response.
  final List<String>? stopSequences;

  GenerateTextRequest({
    required this.model,
    required this.prompt,
    this.temperature,
    this.candidateCount,
    this.maxOutputTokens,
    this.topP,
    this.topK,
    this.safetySettings,
    this.stopSequences,
  });
}

class GenerateTextResponse {
  // Candidate responses from the model.
  final List<TextCompletion> candidates;

  // A set of content filtering metadata for the prompt and response
  // text.
  //
  // This indicates which `SafetyCategory`(s) blocked a
  // candidate from this response, the lowest `HarmProbability`
  // that triggered a block, and the HarmThreshold setting for that category.
  // This indicates the smallest change to the `SafetySettings` that would be
  // necessary to unblock at least 1 response.
  //
  // The blocking is configured by the `SafetySettings` in the request (or the
  // default `SafetySettings` of the API).
  final List<ContentFilter> filters;

  // Returns any safety feedback related to content filtering.
  final List<SafetyFeedback> safetyFeedback;

  GenerateTextResponse({
    required this.candidates,
    required this.filters,
    required this.safetyFeedback,
  });
}

class TextPrompt {
  // Required. The prompt text.
  final String text;

  TextPrompt({
    required this.text,
  });
}

class TextCompletion {
  // Output only. The generated text returned from the model.
  final String output;

  // Ratings for the safety of a response.
  //
  // There is at most one rating per category.
  final List<SafetyRating> safetyRatings;

  // Output only. Citation information for model-generated `output` in this
  // `TextCompletion`.
  //
  // This field may be populated with attribution information for any text
  // included in the `output`.
  final CitationMetadata? citationMetadata;

  TextCompletion({
    required this.output,
    required this.safetyRatings,
    this.citationMetadata,
  });
}

class EmbedTextRequest {
  // Required. The model name to use with the format model=models/{model}.
  final String model;

  // Required. The free-form input text that the model will turn into an
  // embedding.
  final String text;

  EmbedTextRequest({
    required this.model,
    required this.text,
  });
}

class EmbedTextResponse {
  // Output only. The embedding generated from the input text.
  final Embedding? embedding;

  EmbedTextResponse({
    this.embedding,
  });
}

class Embedding {
  // The embedding values.
  final List<double> value;

  Embedding({
    required this.value,
  });
}
