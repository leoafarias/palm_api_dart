/// Represents a source citation for a portion of the content with
/// specific attributes for the start and end indices of the attributed
/// segment, the URI of the attributed source, and its license.
class CitationSource {
  /// The start position of the attributed segment.
  final int startIndex;

  /// The end position of the attributed segment.
  final int endIndex;

  /// The URI of the source attributed.
  final String? uri;

  /// The license of the attributed content.
  final String? license;

  CitationSource({
    required this.startIndex,
    required this.endIndex,
    this.uri,
    this.license,
  });

  /// Parse a map to create a new instance of CitationSource.
  ///
  /// The constructor takes a map and initializes a new CitationSource
  /// object with the values associated with keys 'startIndex', 'endIndex',
  /// 'uri' and 'license'.
  factory CitationSource.fromJson(Map<String, dynamic> json) => CitationSource(
        startIndex: json["startIndex"],
        endIndex: json["endIndex"],
        uri: json["uri"],
        license: json["license"],
      );

  /// Converts the CitationSource object into a map.
  ///
  /// The generated map carries keys which match with property names
  /// of CitationSource and corresponding values representing the
  /// current property values of the object.
  Map<String, dynamic> toJson() => {
        "startIndex": startIndex,
        "endIndex": endIndex,
        "uri": uri,
        "license": license,
      };
}
