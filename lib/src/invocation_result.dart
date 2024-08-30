/// Invocation result is the result that the invoked handler
/// returns and is posted to the Lambda Runtime Interface.
final class InvocationResult {
  const InvocationResult({
    required this.requestId,
    this.body = const {},
  });

  /// The Id of the request in the Lambda Runtime Interface.
  /// This is used to associate the result of the handler with
  /// the triggered execution in the Runtime.
  final String requestId;

  /// The result of the handler execution. This can contain
  /// any json-encodable data type.
  final dynamic body;
}
