class Model {
  /// Required. The resource name of the `Model`. Format: `models/{model}` with a `{model}` naming convention of: "{base_model_id}-{version}". Examples: `models/chat-bison-001`
  final String name;

  /// Required. The name of the base model, pass this to the generation request. Examples: `chat-bison`
  final String baseModelId;

  /// Required. The version number of the model. This represents the major version
  final String version;

  /// The human-readable name of the model. E.g. "Chat Bison". The name can be up to 128 characters long and can consist of any UTF-8 characters.
  final String displayName;

  /// A short description of the model.
  final String description;

  /// Maximum number of input tokens allowed for this model.
  final int inputTokenLimit;

  /// Maximum number of output tokens available for this model.
  final int outputTokenLimit;

  /// The model's supported generation methods. The method names are defined as Pascal case strings, such as `generateMessage` which correspond to API methods.
  final List<String> supportedGenerationMethods;

  /// Controls the randomness of the output. Values can range over `[0.0,1.0]`, inclusive. A value closer to `1.0` will produce responses that are more varied, while a value closer to `0.0` will typically result in less surprising responses from the model. This value specifies default to be used by the backend while making the call to the model.
  final double? temperature;

  /// For Nucleus sampling. Nucleus sampling considers the smallest set of tokens whose probability sum is at least `top_p`. This value specifies default to be used by the backend while making the call to the model.
  final double? topP;

  /// For Top-k sampling. Top-k sampling considers the set of `top_k` most probable tokens. This value specifies default to be used by the backend while making the call to the model.
  final int? topK;

  const Model({
    required this.name,
    required this.baseModelId,
    required this.version,
    required this.displayName,
    required this.description,
    required this.inputTokenLimit,
    required this.outputTokenLimit,
    required this.supportedGenerationMethods,
    this.temperature,
    this.topP,
    this.topK,
  });
}
