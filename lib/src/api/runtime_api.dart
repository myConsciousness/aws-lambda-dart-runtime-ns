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
const _kRuntimeDeadlineMs = 'lambda-runtime-aws-deadline-ms';
const _kRuntimeInvokedFunctionArn = 'lambda-runtime-invoked-functions-arn';
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

  /// Get the next invocation from the AWS Lambda Runtime Interface
  /// (see https://docs.aws.amazon.com/lambda/latest/dg/runtimes-api.html).
  Future<NextInvocation> getNextInvocation() async {
    final response = await http.get(
      Uri.http(
        _authority,
        '/$_kRuntimeApiVersion/runtime/invocation/next',
      ),
    );

    print(response.headers);
    print(response.body);

    return NextInvocation(
      event: jsonDecode(response.body),
      requestId: response.headers[_kRuntimeRequestId]!,
      invokedFunctionArn: response.headers[_kRuntimeInvokedFunctionArn]!,
      deadlineMs: response.headers[_kRuntimeDeadlineMs]!,
      traceId: response.headers[_kRuntimeTraceId]!,
      clientContext: response.headers[_kRuntimeClientContext]!,
      cognitoIdentity: response.headers[_kRuntimeCognitoIdentity]!,
    );
  }

  Future<void> postInvocationResponse(final InvocationResult result) async =>
      await http.post(
        Uri.http(
          _authority,
          '/$_kRuntimeApiVersion/runtime/invocation/${result.requestId}/response',
        ),
        body: result,
      );

  Future<void> postInvocationError({
    required final String requestId,
    required final InvocationError error,
  }) async =>
      await http.post(
        Uri.http(
          _authority,
          '/$_kRuntimeApiVersion/runtime/invocation/$requestId/error',
        ),
        body: error.toJson(),
      );
}
