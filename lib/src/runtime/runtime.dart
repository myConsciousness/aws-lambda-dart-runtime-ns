// Project imports:
import '../api/runtime_api.dart';
import '../invocation_error.dart';
import '../next_invocation.dart';
import 'context.dart';
import 'errors/runtime_exception.dart';
import 'errors/runtime_state_error.dart';
import 'handler.dart';

/// Shortcut to safely run [AwsLambdaRuntime].
Future<void> invokeAwsLambdaRuntime(
  final List<FunctionHandler> handlers,
) async {
  final runtime = AwsLambdaRuntime();

  for (final handler in handlers) {
    runtime.addHandler(handler);
  }

  await runtime.invoke();
}

final class AwsLambdaRuntime {
  AwsLambdaRuntime._(final RuntimeApi client) : _client = client;

  factory AwsLambdaRuntime() {
    return AwsLambdaRuntime._(RuntimeApi());
  }

  final RuntimeApi _client;
  final _handlers = <String, FunctionAction>{};

  /// Add a function handler.
  AwsLambdaRuntime addHandler(final FunctionHandler handler) {
    if (_handlers.containsKey(handler.name)) {
      throw RuntimeStateError(
        'The handler "${handler.name}" has already been added.',
      );
    }

    _handlers[handler.name] = handler.action;

    return this;
  }

  Future<void> invoke() async {
    if (_handlers.isEmpty) {
      throw RuntimeStateError(
        'No handlers could be found to be invoked. '
        'Use .addHandler to add handlers.',
      );
    }

    NextInvocation? nextInvocation;
    while (true) {
      try {
        nextInvocation = await _client.getNextInvocation();

        final context = RuntimeContext.fromNextInvocation(nextInvocation);
        final result = await _getFunction(
          context,
        ).call(context, nextInvocation.event);

        await _client.postInvocationResponse(result);
      } catch (error, stackTrace) {
        if (nextInvocation != null) {
          await _client.postInvocationError(
            requestId: nextInvocation.requestId,
            error: InvocationError(error, stackTrace),
          );
        }
      }
    }
  }

  FunctionAction _getFunction(final RuntimeContext context) {
    final action = _handlers[context.handler];
    if (action == null) {
      throw RuntimeException(
        'No handler with name "${context.handler}" registered in runtime!',
      );
    }

    return action;
  }
}
