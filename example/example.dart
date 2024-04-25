import 'package:aws_lambda_dart_runtime_ns/aws_lambda_dart_runtime_ns.dart';

Future<void> main() async => await invokeAwsLambdaRuntime([
      _sayHelloFunction,
      _sayWorldFunction,
    ]);

/// GET endpoint that just returns “Hello".
FunctionHandler get _sayHelloFunction => FunctionHandler(
      name: 'main.hello',
      action: (context, event) {
        // Do something here...

        return InvocationResult(
          requestId: context.requestId,
          body: {
            'message': 'Hello',
          },
        );
      },
    );

/// GET endpoint that just returns "World".
FunctionHandler get _sayWorldFunction => FunctionHandler(
      name: 'main.world',
      action: (context, event) {
        return InvocationResult(
          requestId: context.requestId,
          body: {
            'message': 'world',
          },
        );
      },
    );
