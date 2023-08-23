/// Represents a generative language model with descriptive and configurable properties.
///
/// An instance of this class provides detailed information about a specific
/// generative language model including its version, maximum input/output tokens,
/// and tunable parameters that control the nature of the output.
///
/// For nullable properties, a `null` value indicates that the specific detail
/// is not provided or is not applicable for the model.
class GenModel {
  /// The resource name of the Model, if provided.
  final String name;

  /// The unique identifier of the base model.
  final String baseModelId;

  /// The version number of the model.
  final String version;

  /// A human-readable string that provides the name of the model.
  final String? displayName;

  /// A short description of the model.
  final String? description;

  /// The maximum number of tokens allowed for input, if provided.
  final int? inputTokenLimit;

  /// The maximum number of tokens available for output for this model.
  final int? outputTokenLimit;

  /// The list of the model's supported generation methods.
  final List<String>? supportedGenerationMethods;

  /// A measure to control the randomness of the model's output, if provided.
  final num? temperature;

  /// A property used for Nucleus sampling, if provided.
  final num? topP;

  /// A property intended for Top-k sampling, if provided.
  final int? topK;

  GenModel({
    required this.name,
    required this.baseModelId,
    required this.version,
    this.displayName,
    this.description,
    this.inputTokenLimit,
    this.outputTokenLimit,
    this.supportedGenerationMethods,
    this.temperature,
    this.topP,
    this.topK,
  });

  /// Creates a new Model object from a map.
  ///
  /// This constructor extracts values from a Map object and assigns them
  /// to the respective properties of the Model, given the Map has the keys
  /// that match with the property names.
  factory GenModel.fromJson(Map<String, dynamic> json) => GenModel(
        name: json["name"],
        baseModelId: json["baseModelId"],
        version: json["version"],
        displayName: json["displayName"],
        description: json["description"],
        inputTokenLimit: json["inputTokenLimit"],
        outputTokenLimit: json["outputTokenLimit"],
        supportedGenerationMethods:
            List<String>.from(json["supportedGenerationMethods"].map((x) => x)),
        temperature: json["temperature"],
        topP: json["topP"],
        topK: json["topK"],
      );

  /// Converts the Model object into a Map.
  ///
  /// The created Map object has keys corresponding to the Model's property
  /// names and values corresponding to their respective current property values.
  /// This is useful for constructing API payload or storing the Model object.
  Map<String, dynamic> toJson() => {
        "name": name,
        "baseModelId": baseModelId,
        "version": version,
        "displayName": displayName,
        "description": description,
        "inputTokenLimit": inputTokenLimit,
        "outputTokenLimit": outputTokenLimit,
        "supportedGenerationMethods":
            List<dynamic>.from(supportedGenerationMethods!.map((x) => x)),
        "temperature": temperature,
        "topP": topP,
        "topK": topK,
      };
}
