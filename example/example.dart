import 'package:aws_lambda_dart_runtime_ns/aws_lambda_dart_runtime_ns.dart';

Future<void> main() async => await AwsLambdaRuntime()
    .addHandler(FunctionHandler(
      name: 'main.hello',
      action: (context, event) {
        // Do something here...

        return InvocationResult(
          requestId: context.requestId,
          body: {
            'message': 'Hello, World!',
            ...event,
          },
        );
      },
    ))
    .invoke();
