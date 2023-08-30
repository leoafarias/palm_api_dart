import 'dart:convert';

import 'package:palm_api/src/dto/model.dto.dart';
import 'package:palm_api/src/helpers/deep_collection_equality.dart';

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

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is GetModelRequest && other.name == name;
  }

  @override
  int get hashCode => name.hashCode;

  GetModelRequest copyWith({
    String? name,
  }) {
    return GetModelRequest(
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
    };
  }

  factory GetModelRequest.fromMap(Map<String, dynamic> map) {
    return GetModelRequest(
      name: map['name'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory GetModelRequest.fromJson(String source) =>
      GetModelRequest.fromMap(json.decode(source));

  @override
  String toString() => 'GetModelRequest(name: $name)';
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

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ListModelsRequest &&
        other.pageSize == pageSize &&
        other.pageToken == pageToken;
  }

  @override
  int get hashCode => pageSize.hashCode ^ pageToken.hashCode;

  ListModelsRequest copyWith({
    int? pageSize,
    String? pageToken,
  }) {
    return ListModelsRequest(
      pageSize: pageSize ?? this.pageSize,
      pageToken: pageToken ?? this.pageToken,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'pageSize': pageSize,
      'pageToken': pageToken,
    };
  }

  factory ListModelsRequest.fromMap(Map<String, dynamic> map) {
    return ListModelsRequest(
      pageSize: map['pageSize']?.toInt() ?? 0,
      pageToken: map['pageToken'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ListModelsRequest.fromJson(String source) =>
      ListModelsRequest.fromMap(json.decode(source));

  @override
  String toString() =>
      'ListModelsRequest(pageSize: $pageSize, pageToken: $pageToken)';
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

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other is ListModelsResponse &&
        listEquals(other.models, models) &&
        other.nextPageToken == nextPageToken;
  }

  @override
  int get hashCode => models.hashCode ^ nextPageToken.hashCode;

  @override
  String toString() =>
      'ListModelsResponse(models: $models, nextPageToken: $nextPageToken)';

  ListModelsResponse copyWith({
    List<Model>? models,
    String? nextPageToken,
  }) {
    return ListModelsResponse(
      models: models ?? this.models,
      nextPageToken: nextPageToken ?? this.nextPageToken,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'models': models.map((x) => x.toMap()).toList(),
      'nextPageToken': nextPageToken,
    };
  }

  factory ListModelsResponse.fromMap(Map<String, dynamic> map) {
    return ListModelsResponse(
      models: List<Model>.from(map['models']?.map((x) => Model.fromMap(x))),
      nextPageToken: map['nextPageToken'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ListModelsResponse.fromJson(String source) =>
      ListModelsResponse.fromMap(json.decode(source));
}
