// Dart imports:
import 'dart:io' show Platform;

// Project imports:
import '../next_invocation.dart';

/// These are the constants used to map [Platform.environment]
/// which are specific to the Lambda execution environment.
const _kAWSLambdaHandler = '_HANDLER';
const _kAWSLambdaFunctionName = 'AWS_LAMBDA_FUNCTION_NAME';
const _kAWSLambdaFunctionVersion = 'AWS_LAMBDA_FUNCTION_VERSION';
const _kAWSLambdaLogGroupName = 'AWS_LAMBDA_LOG_GROUP_NAME';
const _kAWSLambdaLogStreamName = 'AWS_LAMBDA_LOG_STREAM_NAME';
const _kAWSLambdaFunctionMemorySize = 'AWS_LAMBDA_FUNCTION_MEMORY_SIZE';
const _kAWSLambdaRegion = 'AWS_REGION';
const _kAWSLambdaExecutionEnv = 'AWS_EXECUTION_ENV';
const _kAWSLambdaAccessKey = 'AWS_ACCESS_KEY_ID';
const _kAWSLambdaSecretAccessKey = 'AWS_SECRET_ACCESS_KEY';
const _kAWSLambdaSessionToken = 'AWS_SESSION_TOKEN';

/// Context contains the Lambda execution context information.
/// They are either provided via [Platform.environment] or [NextInvocation]
/// which is the result from the Lambda API.
///
/// Note: this should not be used directly.
final class RuntimeContext {
  const RuntimeContext._({
    required this.requestId,
    required this.invokedFunctionArn,
    required this.handler,
    required this.functionName,
    required this.functionVersion,
    required this.functionMemorySize,
    required this.logGroupName,
    required this.logStreamName,
    required this.region,
    required this.executionEnv,
    required this.accessKey,
    required this.secretAccessKey,
    required this.sessionToken,
  });

  factory RuntimeContext.fromNextInvocation(
    final NextInvocation nextInvocation,
  ) {
    return RuntimeContext._(
      requestId: nextInvocation.requestId,
      invokedFunctionArn: nextInvocation.invokedFunctionArn,
      handler: Platform.environment[_kAWSLambdaHandler]!,
      functionName: Platform.environment[_kAWSLambdaFunctionName]!,
      functionVersion: Platform.environment[_kAWSLambdaFunctionVersion]!,
      functionMemorySize: Platform.environment[_kAWSLambdaFunctionMemorySize]!,
      logGroupName: Platform.environment[_kAWSLambdaLogGroupName]!,
      logStreamName: Platform.environment[_kAWSLambdaLogStreamName]!,
      region: Platform.environment[_kAWSLambdaRegion]!,
      executionEnv: Platform.environment[_kAWSLambdaExecutionEnv]!,
      accessKey: Platform.environment[_kAWSLambdaAccessKey]!,
      secretAccessKey: Platform.environment[_kAWSLambdaSecretAccessKey]!,
      sessionToken: Platform.environment[_kAWSLambdaSessionToken]!,
    );
  }

  /// Id of the request.
  /// You can use this to track the request for the invocation.
  final String requestId;

  /// The ARN to identify the function.
  final String invokedFunctionArn;

  /// Handler that is used for the invocation of the function
  final String handler;

  /// Name of the function that is invoked.
  final String functionName;

  /// Version of the function that is invoked.
  final String functionVersion;

  /// Memory sized that is allocated to execution of the function.
  final String functionMemorySize;

  /// Cloudwatch LogGroup that is associated with the Lambda.
  final String logGroupName;

  /// CloudWatch LogStream that is associated with the Lambda.
  final String logStreamName;

  /// Region that this function exists in.
  final String region;

  /// The execution environment of the function.
  final String executionEnv;

  /// Access key that is acquired via STS.
  final String accessKey;

  /// Secret access key that is acquired via STS.
  final String secretAccessKey;

  /// The session token from STS.
  final String sessionToken;
}
