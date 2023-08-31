import 'dart:convert';

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

    test('Generative Text from MakerSuite', () async {
      final response = await textService.generateTextFromMakerSuite(
          //Makersuite Json export adds \n as newline but it don't work for jsonDecode, they needs manually replacement.
          jsonDecode("""
          {
            "prompt": "How do I microwave hot water??",
            "model_name": "models/text-bison-001",
            "temperature": 0.7,
            "candidate_count": 1,
            "top_k": 40,
            "top_p": 0.95,
            "max_output_tokens": 1024,
            "stop_sequences": [],
             "safety_settings": [{"category":"HARM_CATEGORY_DEROGATORY","threshold":1},{"category":"HARM_CATEGORY_TOXICITY","threshold":1},{"category":"HARM_CATEGORY_VIOLENCE","threshold":2},{"category":"HARM_CATEGORY_SEXUAL","threshold":2},{"category":"HARM_CATEGORY_MEDICAL","threshold":2},{"category":"HARM_CATEGORY_DANGEROUS","threshold":2}]
        }
      """));

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
