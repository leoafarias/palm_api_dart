import 'dart:convert';

import 'package:palm_api/src/helpers/deep_collection_equality.dart';

/// A collection of source attributions for a piece of content.

class CitationMetadata {
  /// Citations to sources for a specific response.
  final List<CitationSource> citationSources;

  CitationMetadata({
    required this.citationSources,
  });

  @override
  String toString() => 'CitationMetadata(citationSources: $citationSources)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other is CitationMetadata &&
        listEquals(other.citationSources, citationSources);
  }

  @override
  int get hashCode => citationSources.hashCode;

  Map<String, dynamic> toMap() {
    return {
      'citationSources': citationSources.map((x) => x.toMap()).toList(),
    };
  }

  factory CitationMetadata.fromMap(Map<String, dynamic> map) {
    return CitationMetadata(
      citationSources: List<CitationSource>.from(
          map['citationSources']?.map((x) => CitationSource.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory CitationMetadata.fromJson(String source) =>
      CitationMetadata.fromMap(json.decode(source));

  CitationMetadata copyWith({
    List<CitationSource>? citationSources,
  }) {
    return CitationMetadata(
      citationSources: citationSources ?? this.citationSources,
    );
  }
}

/// A citation to a source for a portion of a specific response.

class CitationSource {
  /// Optional. Start of segment of the response that is attributed to this
  /// source.
  ///
  /// Index indicates the start of the segment, measured in bytes.
  final int? startIndex;

  /// Optional. End of the attributed segment, exclusive.
  final int? endIndex;

  /// Optional. URI that is attributed as a source for a portion of the text.
  final String? uri;

  /// Optional. License for the GitHub project that is attributed as a source for
  /// segment.
  ///
  /// License info is required for code citations.
  final String? license;

  CitationSource({
    this.startIndex,
    this.endIndex,
    this.uri,
    this.license,
  });

  @override
  String toString() {
    return 'CitationSource(startIndex: $startIndex, endIndex: $endIndex, uri: $uri, license: $license)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CitationSource &&
        other.startIndex == startIndex &&
        other.endIndex == endIndex &&
        other.uri == uri &&
        other.license == license;
  }

  @override
  int get hashCode {
    return startIndex.hashCode ^
        endIndex.hashCode ^
        uri.hashCode ^
        license.hashCode;
  }

  CitationSource copyWith({
    int? startIndex,
    int? endIndex,
    String? uri,
    String? license,
  }) {
    return CitationSource(
      startIndex: startIndex ?? this.startIndex,
      endIndex: endIndex ?? this.endIndex,
      uri: uri ?? this.uri,
      license: license ?? this.license,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'startIndex': startIndex,
      'endIndex': endIndex,
      'uri': uri,
      'license': license,
    };
  }

  factory CitationSource.fromMap(Map<String, dynamic> map) {
    return CitationSource(
      startIndex: map['startIndex']?.toInt(),
      endIndex: map['endIndex']?.toInt(),
      uri: map['uri'],
      license: map['license'],
    );
  }

  String toJson() => json.encode(toMap());

  factory CitationSource.fromJson(String source) =>
      CitationSource.fromMap(json.decode(source));
}
