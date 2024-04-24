/// Next invocation data wraps the data from the
/// invocation endpoint of the Lambda Runtime Interface.
final class NextInvocation {
  const NextInvocation({
    required this.event,
    required this.requestId,
    required this.invokedFunctionArn,
    required this.deadlineMs,
    required this.traceId,
    required this.clientContext,
    required this.cognitoIdentity,
  });

  /// Raw response of invocation data that we received.
  final Map<String, dynamic> event;

  /// Request Id is the identifier of the request.
  final String requestId;

  /// Invoked function ARN is the identifier of the function.
  final String invokedFunctionArn;

  /// Deadline milliseconds is the setting for ultimate cancellation
  /// of the invocation.
  final String? deadlineMs;

  /// Tracing id is the identifier for tracing like X-Ray.
  final String? traceId;

  /// Client context is the context that is provided to the function.
  final String? clientContext;

  /// Cognito identity is the identity that maybe is used for authorizing
  /// the request.
  final String? cognitoIdentity;
}
