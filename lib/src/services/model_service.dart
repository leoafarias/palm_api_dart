import 'package:palm_api/src/models/gen_model.model.dart';
import 'package:palm_api/src/services/base_service.dart';

enum ModelNames {
  textBison001('text-bison-001'),
  chatBison001('chat-bison-001'),

  embeddingGecko001('embedding-gecko-001');

  const ModelNames(this.name);

  final String name;
}

/// ModelService deals with all model related API endpoints, providing a higher
/// level and organized way of managing models in the API.
class ModelService extends BaseService {
  ModelService({
    required super.apiKey,
    super.apiClient,
  });

  /// Get information about a specific model.
  ///
  /// Throws an ApiException if the request fails.
  /// Otherwise, returns a Model containing the model details.
  Future<GenModel> getModel(String modelId) async {
    final response = await apiClient.get('models/$modelId$keyParam');

    // Here we assume that there will be a separate Model.fromJson()
    // factory method that converts JSON to a Model instance.
    return GenModel.fromJson(response);
  }

  /// Lists all the available models.
  ///
  /// Throws an ApiException if the request fails.
  /// Otherwise, returns a list of Model instances.
  Future<List<GenModel>> listModels() async {
    final response = await apiClient.get('models$keyParam');

    // Here we assume that we receive a dictionary where the models are under the key 'models'.
    // Also, we assume that there will be a separate Model.fromJson()
    // factory method that converts JSON to a Model instance.
    final List<GenModel> models = (response['models'] as List)
        .map((model) => GenModel.fromJson(model))
        .toList();

    return models;
  }
}
