import 'package:palm_api/src/models/api_models.dart';
import 'package:palm_api/src/models/message.model.dart';
import 'package:palm_api/src/models/message_prompt.model.dart';
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
  Future<EmbedTextResponse> embedText(
    String modelId,
    String text,
  ) async {
    final modelPathBuilder = getModelPathBuilder(modelId);
    final request = EmbedTextRequest(text: text).toJson();

    final response = await apiClient.post(
      modelPathBuilder(':embedText'),
      request,
    );

    // We assume Embedding.fromJson() factory method to convert JSON to an Embedding instance.
    return EmbedTextResponse.fromJson(response);
  }

  /// Generate a response for a given text using a specific model.
  ///
  /// Throws an ApiException if the request fails.
  /// Otherwise, returns a GenerateMessageResponse.
  Future<GenerateMessageResponse> generateMessage(
    String modelId,
    GenerateMessageRequest messageRequest,
  ) async {
    final modelPathBuilder = getModelPathBuilder(modelId);
    final request = messageRequest.toJson();

    final response = await apiClient.post(
      modelPathBuilder(':generateMessage'),
      request,
    );

    // We assume GenerateMessageResponse.fromJson() factory method to convert JSON to a GenerateMessageResponse instance.
    return GenerateMessageResponse.fromJson(response);
  }

  /// Count message tokens in a string.
  ///
  /// Throws an ApiException if the request fails.
  /// Otherwise, returns a CountMessageTokensResponse.
  Future<CountMessageTokensResponse> countMessageTokens(
    String modelId,
    String text,
  ) async {
    final modelPathBuilder = getModelPathBuilder(modelId);
    final request = CountMessageTokensRequest(
        prompt: MessagePrompt(messages: [Message(content: text)])).toJson();

    final response = await apiClient.post(
      modelPathBuilder(':countMessageTokens'),
      request,
    );

    // We assume CountMessageTokensResponse.fromJson() factory method to convert JSON to a CountMessageTokensResponse instance.
    return CountMessageTokensResponse.fromJson(response);
  }

  /// Generate a response text message from's model given an input text message.
  ///
  /// Throws an ApiException if the request fails.
  /// Otherwise, returns a GenerateTextResponse.
  Future<GenerateTextResponse> generateText(
    String modelId,
    GenerateTextRequest textRequest,
  ) async {
    final request = textRequest.toJson();

    final modelPathBuilder = getModelPathBuilder(modelId);

    final response = await apiClient.post(
      modelPathBuilder(':generateText'),
      request,
    );

    // We assume GenerateTextResponse.fromJson() factory method to convert JSON to a GenerateTextResponse instance.
    return GenerateTextResponse.fromMap(response);
  }
}
