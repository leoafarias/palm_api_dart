import 'package:collection/collection.dart';
import 'package:mockito/annotations.dart';
import 'package:palm_api/palm_api.dart';
import 'package:palm_api/src/helpers/palm_models.dart';
import 'package:test/test.dart';

import '../constants.dart';

@GenerateMocks([PalmClient])
void main() {
  group('ModelService', () {
    test('Retrieves a model by id', () async {
      final modelService = ModelService(apiKey: TestEnv.palmApiKey);

      const textBison001 = 'text-bison-001';
      const chatBison001 = 'chat-bison-001';
      const embeddingGecko001 = 'embedding-gecko-001';

      final futures = [
        modelService.getModel(textBison001),
        modelService.getModel(chatBison001),
        modelService.getModel(embeddingGecko001),
      ];

      final models = await Future.wait(futures);

      expect(models, isA<List<Model>>());
      expect(models.length, 3);
      expect(models[0].name, equals(PalmModel.textBison001.name));
      expect(models[1].name, equals(PalmModel.chatBison001.name));
      expect(models[2].name, equals(PalmModel.embeddingGecko001.name));
    });

    test('List all models', () async {
      final modelService = ModelService(apiKey: TestEnv.palmApiKey);

      List<Model> models = await modelService.listModels();
      expect(models, isA<List<Model>>());
      expect(models.length, 3);

      final textBison001 = models.firstWhereOrNull(
        (model) => model.name == PalmModel.textBison001.name,
      );

      final chatBison001 = models.firstWhereOrNull(
        (model) => model.name == PalmModel.chatBison001.name,
      );

      final embeddingGecko001 = models.firstWhereOrNull(
        (model) => model.name == PalmModel.embeddingGecko001.name,
      );

      expect(textBison001, isA<Model>());
      expect(textBison001?.name, equals('models/text-bison-001'));

      expect(chatBison001, isA<Model>());
      expect(chatBison001?.name, equals('models/chat-bison-001'));

      expect(embeddingGecko001, isA<Model>());
      expect(embeddingGecko001?.name, equals('models/embedding-gecko-001'));
    });
  });
}
