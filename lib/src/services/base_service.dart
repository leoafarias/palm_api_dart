import 'package:palm_api/src/helpers/client.dart';

abstract class BaseService {
  final PalmClient apiClient;

  final String _apiKey;

  BaseService({
    required String apiKey,
    PalmClient? apiClient,
  })  : apiClient = apiClient ?? PalmClient(),
        _apiKey = apiKey;

  String get keyParam => '?key=$_apiKey';

  /// Returns a function that builds a model path with the given model name.
  /// Make sure to add it as models/:modelId: prefix to the path.
  String Function(String) getModelPathBuilder(String model) {
    var modelPath = model;
    if (!modelPath.startsWith('models/')) {
      modelPath = 'models/$model';
    }
    return (String path) => '$modelPath$path$keyParam';
  }
}
