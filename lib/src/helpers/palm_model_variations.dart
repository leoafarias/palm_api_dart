import 'package:palm_api/src/dto/model.dto.dart';

class PalmModel {
  const PalmModel._();

  static Model chatBison001 = Model.fromMap(
    {
      "name": "models/chat-bison-001",
      "baseModelId": "",
      "version": "001",
      "displayName": "Chat Bison",
      "description": "Chat-optimized generative language model.",
      "inputTokenLimit": 4096,
      "outputTokenLimit": 1024,
      "supportedGenerationMethods": ["generateMessage", "countMessageTokens"],
      "temperature": 0.25,
      "topP": 0.95,
      "topK": 40
    },
  );
  static Model textBison001 = Model.fromMap({
    "name": "models/text-bison-001",
    "baseModelId": "",
    "version": "001",
    "displayName": "Text Bison",
    "description": "Model targeted for text generation.",
    "inputTokenLimit": 8196,
    "outputTokenLimit": 1024,
    "supportedGenerationMethods": ["generateText", "countTextTokens"],
    "temperature": 0.7,
    "topP": 0.95,
    "topK": 40
  });
  static Model embeddingGecko001 = Model.fromMap({
    "name": "models/embedding-gecko-001",
    "baseModelId": "",
    "version": "001",
    "displayName": "Embedding Gecko",
    "description": "Obtain a distributed representation of a text.",
    "inputTokenLimit": 1024,
    "outputTokenLimit": 1,
    "supportedGenerationMethods": ["embedText"],
    "temperature": null,
    "topP": null,
    "topK": null
  });
}
