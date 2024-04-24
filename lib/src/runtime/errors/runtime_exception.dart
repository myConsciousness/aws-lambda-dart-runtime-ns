final class RuntimeException implements Exception {
  const RuntimeException(this.message, [this.stackTrace]);

  final String message;
  final StackTrace? stackTrace;

  @override
  String toString() => 'RuntimeException: $message';
}
