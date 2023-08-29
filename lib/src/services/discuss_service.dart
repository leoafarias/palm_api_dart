import 'package:palm_api/src/dto/discussion_service.dto.dart';
import 'package:palm_api/src/services/base_service.dart';

/// DiscussService deals with all chat related API endpoints. It provides
/// an organized way of interactively working with the language model API.
class DiscussService extends BaseService {
  DiscussService({
    required super.apiKey,
    super.apiClient,
  });

  /// Generate a response for a given text using a specific model.
  ///
  /// Throws an ApiException if the request fails.
  /// Otherwise, returns a GenerateMessageResponse.
  Future<GenerateMessageResponse> generateMessage({
    required String model,
    required MessagePrompt prompt,
    double? temperature,
    int? candidateCount,
    double? topP,
    int? topK,
  }) async {
    final modelPathBuilder = getModelPathBuilder(model);
    final requestParams = GenerateMessageRequest(
      model: model,
      prompt: prompt,
      temperature: temperature,
      candidateCount: candidateCount,
      topP: topP,
      topK: topK,
    );

    final response = await apiClient.post(
      modelPathBuilder(':generateMessage'),
      requestParams.toMap(),
    );

    return GenerateMessageResponse.fromMap(response);
  }

  /// Count message tokens in a string.
  ///
  /// Throws an ApiException if the request fails.
  /// Otherwise, returns a CountMessageTokensResponse.
  Future<CountMessageTokensResponse> countMessageTokens({
    required String model,
    required String text,
  }) async {
    final modelPathBuilder = getModelPathBuilder(model);
    final request = CountMessageTokensRequest(
      model: model,
      prompt: MessagePrompt(messages: [Message(content: text)]),
    );

    final response = await apiClient.post(
      modelPathBuilder(':countMessageTokens'),
      request.toMap(),
    );

    return CountMessageTokensResponse.fromMap(response);
  }
}
