import 'package:palm_api/src/exception.dart';
import 'package:palm_api/src/models/api_models.dart';
import 'package:palm_api/src/models/gen_model.model.dart';
import 'package:palm_api/src/services/base_service.dart';
import 'package:palm_api/src/services/text_service.dart';

class GenerativeLanguage extends BaseService {
  final GenModel model;
  final TextService _textService;

  GenerativeLanguage({
    required this.model,
    required super.apiKey,
    super.apiClient,
  }) : _textService = TextService(
          apiKey: apiKey,
          apiClient: apiClient,
        );

  void _checkMethodSupportAndThrow(String methodName) {
    final supportedMethods = model.supportedGenerationMethods ?? [];
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
      model.name,
      text,
    );
  }

  Future<GenerateMessageResponse> generateMessage(
    GenerateMessageRequest messageRequest,
  ) async {
    _checkMethodSupportAndThrow('generateMessage');
    return _textService.generateMessage(
      model.name,
      messageRequest,
    );
  }

  Future<CountMessageTokensResponse> countMessageTokens(
    String text,
  ) async {
    _checkMethodSupportAndThrow('countMessageTokens');
    return _textService.countMessageTokens(
      model.name,
      text,
    );
  }

  Future<GenerateTextResponse> generateText(
    GenerateTextRequest textRequest,
  ) async {
    _checkMethodSupportAndThrow('generateText');
    return _textService.generateText(
      model.name,
      textRequest,
    );
  }
}
