final class RuntimeStateError extends Error {
  RuntimeStateError(this.message);

  /// Error message.
  final String message;

  @override
  String toString() => 'RuntimeStateError: $message';
}
