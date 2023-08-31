import 'package:palm_api/src/dto/discuss_service.dto.dart';
import 'package:palm_api/src/dto/model.dto.dart';
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

  Future<GenerateMessageResponse> generateMessage(
    GenerateMessageRequest params,
  ) async {
    _checkMethodSupportAndThrow('generateMessage');
    return _discussionService.generateMessage(
      model: model.name,
      prompt: params.prompt,
      temperature: params.temperature,
      candidateCount: params.candidateCount,
      topP: params.topP,
      topK: params.topK,
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

  Future<GenerateTextResponse> generateText(GenerateTextRequest params) async {
    _checkMethodSupportAndThrow('generateText');
    return _textService.generateText(
      model: model.name,
      prompt: params.prompt,
      temperature: params.temperature,
      candidateCount: params.candidateCount,
      maxOutputTokens: params.maxOutputTokens,
      topP: params.topP,
      topK: params.topK,
      safetySettings: params.safetySettings,
      stopSequences: params.stopSequences,
    );
  }
}
