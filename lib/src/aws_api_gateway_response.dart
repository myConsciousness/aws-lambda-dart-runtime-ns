// Dart imports:
import 'dart:convert';

/// API Gateway Response contains the data for a response
/// to the API Gateway. It contains the [body] of the HTTP response.
/// It also contains a HTTP Status Code which by default is `200`.
/// Furthermore it indicates if the [body] is Base64 encoded or not.
final class AwsApiGatewayResponse {
  /// The body of the HTTP Response send from the API Gateway to the client.
  final String body;

  /// Indicates if the [body] is Base64 encoded or not. By default is `false`.
  final bool isBase64Encoded;

  // HTTP Status Code of the response of the API Gateway to the client.
  final int statusCode;

  /// The HTTP headers that should be send with the response to the client.
  final Map<String, String> headers;

  /// Returns the JSON representation of the response. This is called by
  /// the JSON encoder to produce the response.
  Map<String, dynamic> toJson() => {
        'body': body,
        'isBase64Encoded': isBase64Encoded,
        'statusCode': statusCode,
        'headers': headers
      };

  /// The factory creates a new [AwsApiGatewayResponse] from JSON.
  /// It optionally accepts the Base64 encoded flag and a HTTP Status Code
  /// for the response.
  factory AwsApiGatewayResponse.fromJson(
    Map<String, dynamic> body, {
    bool isBase64Encoded = false,
    int statusCode = 200,
    Map<String, String> headers = const {},
  }) =>
      AwsApiGatewayResponse(
        json.encode(body),
        isBase64Encoded: isBase64Encoded,
        statusCode: statusCode,
        headers: headers,
      );

  /// The Response that should be returned by the API Gateway for the
  /// Lambda invocation. It has a [body] which reflects the body of the HTTP
  /// Response.
  ///
  /// But also it signals if the [body] is Base64 encoded and what
  /// the HTTP Status Code of the response is.
  const AwsApiGatewayResponse(
    this.body, {
    this.isBase64Encoded = false,
    this.statusCode = 200,
    this.headers = const {},
  });
}
