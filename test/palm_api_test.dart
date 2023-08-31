import 'package:palm_api/palm_api.dart';
import 'package:test/test.dart';

import 'testing_helpers.dart';

void main() {
  group('A group of tests', () {
    final textService = TextService(apiKey: TestEnv.palmApiKey);
    final discussService = DiscussService(apiKey: TestEnv.palmApiKey);

    test('Generative Text', () async {
      final response = await textService.generateText(
        model: PalmModel.textBison001.name,
        prompt: TextPrompt(
          text: 'How do I microwave hot water?',
        ),
      );

      expect(response.candidates, isNotEmpty);
    });

    test('Generative Message', () async {
      final response = await discussService.generateMessage(
        model: PalmModel.chatBison001.name,
        prompt: MessagePrompt(
          messages: [Message(content: 'Wikipedia definition of water?')],
        ),
      );

      expect(response.candidates, isNotEmpty);
    });
    // final awesome = Awesome();

    // setUp(() {
    //   // Additional setup goes here.
    // });

    // test('First Test', () {
    //   expect(awesome.isAwesome, isTrue);
    // });
  });
}
