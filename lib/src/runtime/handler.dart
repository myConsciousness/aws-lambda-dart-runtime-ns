// Dart imports:
import 'dart:async';

// Project imports:
import '../invocation_result.dart';
import 'context.dart';

typedef FunctionAction = FutureOr<InvocationResult> Function(
  RuntimeContext context,
  Map<String, dynamic> event,
);

/// Represents a function to be executed by AWS Lambda.
final class FunctionHandler {
  const FunctionHandler({
    required this.name,
    required this.action,
  });

  /// Handler name that is used for the invocation of the function.
  final String name;

  /// Behavior of the function executed.
  final FunctionAction action;
}
