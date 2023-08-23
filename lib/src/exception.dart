class PalmApiException implements Exception {
  final String message;
  final int code;

  PalmApiException(this.message, this.code);

  @override
  String toString() => 'PalmApiException(code: $code, message: $message)';
}

class MethodNotSupportedException implements Exception {
  String model;
  String methodName;
  List<String> supportedMethods;

  MethodNotSupportedException({
    required this.model,
    required this.methodName,
    required this.supportedMethods,
  });

  String get message =>
      'Method $methodName is not supported for model $model. Supported methods are: $supportedMethods';

  @override
  String toString() => 'GenerationMethodNotSupported(message: $message)';
}
