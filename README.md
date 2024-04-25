# Dart Runtime for AWS Lambda **(Sound Null Safety)**

<p align="center">
   A 🎯 <a href="https://dart.dev/">Dart</a> Runtime for ƛ <a href="https://aws.amazon.com/lambda/">AWS Lambda</a>
</p>

---

This package is based on the official [aws-lambda-dart-runtime](https://github.com/awslabs/aws-lambda-dart-runtime).
It is a restructured version of the outdated official [aws-lambda-dart-runtime](https://github.com/awslabs/aws-lambda-dart-runtime) adapted to the latest Dart SDK to make it easier to maintain.

Thanks to [katallaxie](https://github.com/katallaxie) and [AWS Labs](https://github.com/awslabs)
involved in the development of the [original stuff](https://github.com/awslabs/aws-lambda-dart-runtime)!

You can read the [official document](https://github.com/awslabs/aws-lambda-dart-runtime/blob/master/README.md) too!

---

## Features

Read [Introducing a Dart runtime for AWS Lambda](https://aws.amazon.com/de/blogs/opensource/introducing-a-dart-runtime-for-aws-lambda/)

- Great performance `< 10ms` on event processing and `< 50MB` memory consumption
- No need to ship the Dart runtime
- Multiple event handlers
- Support for [serverless framework](https://github.com/awslabs/aws-lambda-dart-runtime/blob/master/README.md#-serverless-framework-experimental)

## 📦 Install

You can easily add this package to your app.

```bash
dart pub add aws_lambda_dart_runtime_ns
```

```bash
dart pub get
```

## ƛ Use

```dart
import 'package:aws_lambda_dart_runtime_ns/aws_lambda_dart_runtime_ns.dart';

void main() => AwsLambdaRuntime()
  ..addHandler(FunctionHandler(
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
  ..invoke();
```

## License

[Apache 2.0](/LICENSE)

We :blue_heart: Dart.
