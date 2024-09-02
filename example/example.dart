import 'package:aws_lambda_dart_runtime_ns/aws_lambda_dart_runtime_ns.dart';

Future<void> main() async => await invokeAwsLambdaRuntime([
      _sayHelloWorldFunction,
      _doSomethingFunction,
      _sayHelloWorldForApiGatewayFunction,
    ]);

/// GET endpoint that just returns "Hello, World!".
FunctionHandler get _sayHelloWorldFunction => FunctionHandler(
      name: 'main.helloWorld',
      action: (context, event) {
        return InvocationResult(
          requestId: context.requestId,
          body: {
            'message': 'Hello, World!',
          },
        );
      },
    );

/// POST endpoint does something.
FunctionHandler get _doSomethingFunction => FunctionHandler(
      name: 'main.doSomething',
      action: (context, event) {
        // Do something here...

        return InvocationResult(requestId: context.requestId);
      },
    );

/// GET endpoint that returns "Hello, World!" with statusCode and headers.
FunctionHandler get _sayHelloWorldForApiGatewayFunction => FunctionHandler(
      name: 'main.helloWorld',
      action: (context, event) {
        return InvocationResult(
          requestId: context.requestId,
          body: AwsApiGatewayResponse.fromJson(
            {'message': 'Hello, World!'},
            isBase64Encoded: false,
            statusCode: 200,
            headers: const {'Content-Type': 'application/json'},
          ),
        );
      },
    );
