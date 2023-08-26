import 'package:palm_api/src/models/citation_source.model.dart';

/// Represents metadata about the source of generated content.
///
/// An instance of CitationMetadata holds a list of [CitationSource] objects
/// that provides detailed source citations for a piece of content generated
/// by the model. See [CitationSource] for more details.
class CitationMetadata {
  /// A list of citation sources for the content.
  final List<CitationSource> citationSources;

  CitationMetadata({
    required this.citationSources,
  });

  /// Create a new CitationMetadata object from a map.
  ///
  /// The factory constructor reads the 'citationSources' key from
  /// the map and creates a new instance of CitationSource for each
  /// entry, using the map constructor of the CitationSource class.
  factory CitationMetadata.fromMap(Map<String, dynamic> map) =>
      CitationMetadata(
        citationSources: List<CitationSource>.from(
            map["citationSources"].map((x) => CitationSource.fromJson(x))),
      );

  /// Convert the CitationMetadata object into a map.
  ///
  /// The map contains a key 'citationSources', which holds a list of maps
  /// returned by the toJson method of each CitationSource object.
  Map<String, dynamic> toMap() => {
        "citationSources":
            List<dynamic>.from(citationSources.map((x) => x.toJson())),
      };
}
