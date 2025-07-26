/// Invocation error occurs when there has been an
/// error in the invocation of a handlers. It dynamically
/// wraps the inner [error] and attaches the requestId to
/// track it along the event.
final class InvocationError {
  const InvocationError(this.error, this.stackTrace);

  /// The error that caught during the invocation and
  /// which is posted to the Lambda Runtime Interface.
  final dynamic error;

  /// The stack trace of this error.
  final StackTrace stackTrace;

  /// Returns the JSON representation.
  Map<String, dynamic> toJson() => {
    'errorType': 'InvocationError',
    'errorMessage': error.toString(),
    'stackTrace': stackTrace.toString(),
  };
}
