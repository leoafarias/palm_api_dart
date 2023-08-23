import 'package:palm_api/src/models/citation_metadata.model.dart';

/// Represents a structured message unit for the conversational model.
///
/// A message carries a piece of conversation as perceived by an author. It
/// might contain a citation metadata attributing references to other sources.
class Message {
  /// Optional. The author of the message.
  final String? author;

  /// Required. The text content of the message.
  final String content;

  /// Optional. Citation metadata attributing sources for the content.
  final CitationMetadata? citationMetadata;

  Message({
    this.author,
    required this.content,
    this.citationMetadata,
  });

  /// Creates a new Message instance from a map.
  factory Message.fromJson(Map<String, dynamic> json) => Message(
        author: json['author'],
        content: json['content'],
        citationMetadata: json['citationMetadata'] != null
            ? CitationMetadata.fromJson(json['citationMetadata'])
            : null,
      );

  /// Converts the Message instance into a Map.
  Map<String, dynamic> toJson() => {
        'author': author,
        'content': content,
        'citationMetadata': citationMetadata?.toJson(),
      };
}
