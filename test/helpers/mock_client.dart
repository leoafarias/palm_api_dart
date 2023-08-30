import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:palm_api/palm_api.dart';

// ignore: constant_identifier_names
const MOCK_API_KEY = 'MOCK_API_KEY';

// ignore: non_constant_identifier_names
final MockPalmClient = PalmClient(client: _mockHttpClient);

final _mockHttpClient = MockClient((request) async {
  // pathSegments[0] is always v1beta2
  final firstSegment = request.url.pathSegments[1];
  final segmentsCount = request.url.pathSegments.length;

  if (firstSegment == 'models') {
    if (segmentsCount >= 3) {
      final modelName =
          request.url.pathSegments[2]; // Get the modelId from the path
      try {
        final model = PalmModel.fromModelName(modelName);

        return http.Response(model.toJson(), 200);
      } on ArgumentError {
        return http.Response('Not Found', 404);
      }
    } else {
      final modelsPayload = {
        'models': [
          PalmModel.chatBison001.toMap(),
          PalmModel.textBison001.toMap(),
          PalmModel.embeddingGecko001.toMap(),
        ]
      };

      return http.Response(json.encode(modelsPayload), 200);
    }
  }

  return http.Response('Not Found', 404);
});
