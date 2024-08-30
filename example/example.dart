import 'package:aws_lambda_dart_runtime_ns/aws_lambda_dart_runtime_ns.dart';
import 'dart:convert';

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
        Map<String, dynamic> body = {
          'message': 'Hello, World!',
        };
        bool isBase64Encoded = false;
        Map<String, String> headers = {
          'Content-Type': 'application/json',
        };
        int statusCode = 200;
        return InvocationResult(
            requestId: context.requestId,
            body: AwsApiGatewayResponse(
                json.encode(body), isBase64Encoded, headers, statusCode));
      },
    );
