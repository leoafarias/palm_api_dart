import 'package:palm_api/src/dtos/model.dto.dart';

/// Request for getting information about a specific Model.
class GetModelRequest {
  /// Required. The resource name of the model.
  ///
  /// This name should match a model name returned by the `ListModels` method.
  ///
  /// Format: `models/{model}`
  final String name;

  GetModelRequest({
    required this.name,
  });
}

/// Request for listing all Models.
class ListModelsRequest {
  /// The maximum number of `Models` to return (per page).
  ///
  /// The service may return fewer models.
  /// If unspecified, at most 50 models will be returned per page.
  /// This method returns at most 1000 models per page, even if you pass a larger
  /// page_size.
  final int pageSize;

  /// A page token, received from a previous `ListModels` call.
  ///
  /// Provide the `page_token` returned by one request as an argument to the next
  /// request to retrieve the next page.
  ///
  /// When paginating, all other parameters provided to `ListModels` must match
  /// the call that provided the page token.
  final String pageToken;

  ListModelsRequest({
    required this.pageSize,
    required this.pageToken,
  });
}

/// Response from `ListModel` containing a paginated list of Models.
class ListModelsResponse {
  /// The returned Models.
  final List<Model> models;

  /// A token, which can be sent as `page_token` to retrieve the next page.
  ///
  /// If this field is omitted, there are no more pages.
  final String nextPageToken;

  ListModelsResponse({
    required this.models,
    required this.nextPageToken,
  });
}
