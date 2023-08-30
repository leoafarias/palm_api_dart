extension ListExtension<T> on List<T> {
  /// Returns firstWhereOrNull
  T? firstWhereOrNull(bool Function(T) test) {
    for (var element in this) {
      if (test(element)) {
        return element;
      }
    }
    return null;
  }
}
