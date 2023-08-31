import 'package:palm_api/src/dto/safety.dto.dart';
import 'package:palm_api/src/dto/text_service.dto.dart';
import 'package:palm_api/src/services/base_service.dart';

/// TextService deals with all message related API endpoints. It provides
/// an organized way of interactively working with the language model API.
class TextService extends BaseService {
  TextService({
    required super.apiKey,
    super.apiClient,
  });

  /// Generate an embedding for a given text using a specific model.
  ///
  /// Throws an ApiException if the request fails.
  /// Otherwise, returns an Embedding.
  Future<EmbedTextResponse> embedText({
    required String model,
    required String text,
  }) async {
    final modelPathBuilder = getModelPathBuilder(model);
    final request = EmbedTextRequest(model: model, text: text);

    final response = await apiClient.post(
      modelPathBuilder(':embedText'),
      request.toMap(),
    );

    return EmbedTextResponse.fromMap(response);
  }

  /// Generate a response text message from's model given an input text message.
  ///
  /// Throws an ApiException if the request fails.
  /// Otherwise, returns a GenerateTextResponse.
  Future<GenerateTextResponse> generateText({
    required String model,
    required TextPrompt prompt,
    double? temperature,
    int? candidateCount,
    int? maxOutputTokens,
    double? topP,
    int? topK,
    List<SafetySetting>? safetySettings,
    List<String>? stopSequences,
  }) async {
    final params = GenerateTextRequest(
      model: model,
      prompt: prompt,
      temperature: temperature,
      candidateCount: candidateCount,
      maxOutputTokens: maxOutputTokens,
      topP: topP,
      topK: topK,
      safetySettings: safetySettings,
      stopSequences: stopSequences,
    );

    final modelPathBuilder = getModelPathBuilder(model);

    final response = await apiClient.post(
      modelPathBuilder(':generateText'),
      params.toMap(),
    );

    return GenerateTextResponse.fromMap(response);
  }

  Future<GenerateTextResponse> generateTextFromMakerSuite(
      Map<String, dynamic> params) async {
    final modelPathBuilder = getModelPathBuilder(params['model_name']);
    params.update("prompt", (value) => {"text": value});
    params.remove("model_name");
    final response = await apiClient.post(
      modelPathBuilder(':generateText'),
      params,
    );

    return GenerateTextResponse.fromMap(response);
  }
}
