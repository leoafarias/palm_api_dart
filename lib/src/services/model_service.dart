import 'package:palm_api/src/dto/model.dto.dart';
import 'package:palm_api/src/services/base_service.dart';

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
  Future<Model> getModel(String modelId) async {
    final response = await apiClient.get('models/$modelId$keyParam');

    return Model.fromMap(response);
  }

  /// Lists all the available models.
  ///
  /// Throws an ApiException if the request fails.
  /// Otherwise, returns a list of Model instances.
  Future<List<Model>> listModels() async {
    final response = await apiClient.get('models$keyParam');

    final List<Model> models = (response['models'] as List)
        .map((model) => Model.fromMap(model))
        .toList();

    return models;
  }
}
