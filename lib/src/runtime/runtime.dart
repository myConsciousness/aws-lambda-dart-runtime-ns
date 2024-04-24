// Project imports:
import '../api/runtime_api.dart';
import '../invocation_error.dart';
import '../next_invocation.dart';
import 'context.dart';
import 'errors/runtime_exception.dart';
import 'errors/runtime_state_error.dart';
import 'handler.dart';

final class AwsLambdaRuntime {
  AwsLambdaRuntime._(final RuntimeApi client) : _client = client;

  factory AwsLambdaRuntime() {
    return AwsLambdaRuntime._(RuntimeApi());
  }

  final RuntimeApi _client;
  final _handlers = <FunctionHandler>[];

  /// Add a function handler.
  void addHandler(final FunctionHandler handler) {
    if (hasHandler(handler.name)) {
      throw RuntimeStateError(
        'The handler "${handler.name}" has already been added.',
      );
    }

    _handlers.add(handler);
  }

  /// Returns true if this runtime has a handler associated with handler [name],
  /// otherwise false.
  bool hasHandler(final String name) {
    for (final handler in _handlers) {
      if (handler.name == name) {
        return true;
      }
    }

    return false;
  }

  void invoke() async {
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
        final result = await _getFunction(context).call(
          context,
          nextInvocation.event,
        );

        await _client.postInvocationResponse(result);
      } catch (e, s) {
        await _client.postInvocationError(
          requestId: nextInvocation!.requestId,
          error: InvocationError(e, s),
        );
      }
    }
  }

  FunctionAction _getFunction(final RuntimeContext context) {
    for (final handler in _handlers) {
      if (handler.name == context.handler) {
        return handler.action;
      }
    }

    throw RuntimeException(
      'No handler with name "${context.handler}" registered in runtime!',
    );
  }
}
