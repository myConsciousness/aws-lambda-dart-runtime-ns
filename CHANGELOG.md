# Release Note

## 1.0.1

### Bug Fixes
- **RuntimeContext**: Fixed null check operator error when AWS Lambda environment variables are missing
  - Replaced null assertion operators (`!`) with proper error handling in `RuntimeContext.fromNextInvocation`
  - Added clear error messages when required environment variables are not set
  - Added `RuntimeContext.forTesting` factory constructor for testing and local development with sensible defaults

### Changes
- `lib/src/runtime/context.dart`:
  - Modified `fromNextInvocation` factory to use `getRequiredEnvVar` helper function
  - Added descriptive error messages for missing environment variables
  - Added new `forTesting` factory constructor with default values for all required fields

## 1.0.0

- Support Dart 3.8.0.

## 0.1.0

- Add `AwsApiGatewayResponse`. ([#2](https://github.com/myConsciousness/aws-lambda-dart-runtime-ns/pull/2))

## 0.0.13

- Add `invokeAwsLambdaRuntime` function.
- Minor optimization.

## 0.0.12

- Minor changes.

## 0.0.11

- Minor changes.

## 0.0.10

- Minor changes.

## 0.0.9

- Minor changes.

## 0.0.8

- Minor changes.

## 0.0.7

- Minor changes.

## 0.0.6

- Minor changes.

## 0.0.5

- Minor changes.

## 0.0.4

- Minor changes.

## 0.0.3

- Fix document.

## 0.0.2

- Fix document.

## 0.0.1

- Initial version.
