import 'package:palm_api/src/dto/discussion_service.dto.dart';
import 'package:palm_api/src/dto/model.dto.dart';
import 'package:palm_api/src/dto/safety.dto.dart';
import 'package:palm_api/src/dto/text_service.dto.dart';
import 'package:palm_api/src/helpers/exception.dart';
import 'package:palm_api/src/services/base_service.dart';
import 'package:palm_api/src/services/discuss_service.dart';
import 'package:palm_api/src/services/text_service.dart';

class GenerativeLanguage extends BaseService {
  final Model model;
  final TextService _textService;
  final DiscussService _discussionService;

  GenerativeLanguage({
    required this.model,
    required super.apiKey,
    super.apiClient,
  })  : _textService = TextService(
          apiKey: apiKey,
          apiClient: apiClient,
        ),
        _discussionService = DiscussService(
          apiKey: apiKey,
          apiClient: apiClient,
        );

  void _checkMethodSupportAndThrow(String methodName) {
    final supportedMethods = model.supportedGenerationMethods;
    if (!supportedMethods.contains(methodName)) {
      throw MethodNotSupportedException(
        model: model.name,
        methodName: methodName,
        supportedMethods: supportedMethods,
      );
    }
  }

  Future<EmbedTextResponse> embedText(
    String text,
  ) async {
    _checkMethodSupportAndThrow('embedText');
    return _textService.embedText(
      model: model.name,
      text: text,
    );
  }

  Future<GenerateMessageResponse> generateMessage({
    required MessagePrompt prompt,
    double? temperature,
    int? candidateCount,
    double? topP,
    int? topK,
  }) async {
    _checkMethodSupportAndThrow('generateMessage');
    return _discussionService.generateMessage(
      model: model.name,
      prompt: prompt,
      temperature: temperature,
      candidateCount: candidateCount,
      topP: topP,
      topK: topK,
    );
  }

  Future<CountMessageTokensResponse> countMessageTokens({
    required String text,
  }) async {
    _checkMethodSupportAndThrow('countMessageTokens');
    return _discussionService.countMessageTokens(
      model: model.name,
      text: text,
    );
  }

  Future<GenerateTextResponse> generateText({
    required TextPrompt prompt,
    double? temperature,
    int? candidateCount,
    int? maxOutputTokens,
    double? topP,
    int? topK,
    List<SafetySetting>? safetySettings,
    List<String>? stopSequences,
  }) async {
    _checkMethodSupportAndThrow('generateText');
    return _textService.generateText(
      model: model.name,
      prompt: prompt,
      temperature: temperature,
      candidateCount: candidateCount,
      maxOutputTokens: maxOutputTokens,
      topP: topP,
      topK: topK,
      safetySettings: safetySettings,
      stopSequences: stopSequences,
    );
  }
}
