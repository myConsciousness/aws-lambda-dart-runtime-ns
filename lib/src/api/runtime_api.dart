// Dart imports:
import 'dart:convert';
import 'dart:io' show Platform;

// Package imports:
import 'package:http/http.dart' as http;

// Project imports:
import '../invocation_error.dart';
import '../invocation_result.dart';
import '../next_invocation.dart';

const _kRuntimeRequestId = 'lambda-runtime-aws-request-id';
const _kRuntimeDeadlineMs = 'lambda-runtime-deadline-ms';
const _kRuntimeInvokedFunctionArn = 'lambda-runtime-invoked-function-arn';
const _kRuntimeTraceId = 'lambda-runtime-trace-id';
const _kRuntimeClientContext = 'lambda-runtime-client-context';
const _kRuntimeCognitoIdentity = 'lambda-runtime-cognito-identity';

const _kRuntimeApiVersion = '2018-06-01';
const _kAwsLambdaRuntimeApiEnvKey = 'AWS_LAMBDA_RUNTIME_API';

/// This is the Lambda Runtime Interface client.
final class RuntimeApi {
  const RuntimeApi._(final String authority) : _authority = authority;

  factory RuntimeApi() {
    return RuntimeApi._(
      Platform.environment[_kAwsLambdaRuntimeApiEnvKey]!,
    );
  }

  /// The authority of AWS Lambda Runtime API.
  final String _authority;

  /// Runtime makes this HTTP request when it is ready to receive
  /// and process a new invoke.
  Future<NextInvocation> getNextInvocation() async {
    final response = await http.get(
      Uri.http(
        _authority,
        '/$_kRuntimeApiVersion/runtime/invocation/next',
      ),
    );

    return NextInvocation(
      event: jsonDecode(response.body),
      requestId: response.headers[_kRuntimeRequestId]!,
      invokedFunctionArn: response.headers[_kRuntimeInvokedFunctionArn]!,
      deadlineMs: response.headers[_kRuntimeDeadlineMs]!,
      traceId: response.headers[_kRuntimeTraceId]!,
      clientContext: response.headers[_kRuntimeClientContext],
      cognitoIdentity: response.headers[_kRuntimeCognitoIdentity],
    );
  }

  /// Runtime makes this request in order to submit a response.
  Future<void> postInvocationResponse(final InvocationResult result) async =>
      await http.post(
        Uri.http(
          _authority,
          '/$_kRuntimeApiVersion/runtime/invocation/${result.requestId}/response',
        ),
        headers: _getPostHeaders(),
        body: jsonEncode(result.body),
      );

  /// Non-recoverable initialization error. Runtime should exit after reporting
  /// the error. Error will be served in response to the first invoke.
  Future<void> postInvocationError({
    required final String requestId,
    required final InvocationError error,
  }) async =>
      await http.post(
        Uri.http(
          _authority,
          '/$_kRuntimeApiVersion/runtime/invocation/$requestId/error',
        ),
        headers: _getPostHeaders(),
        body: jsonEncode(error.toJson()),
      );

  Map<String, String> _getPostHeaders() =>
      const {'Content-type': 'application/json'};
}
