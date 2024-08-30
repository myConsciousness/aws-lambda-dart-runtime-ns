import 'dart:convert';

/// API Gateway Response contains the data for a response
/// to the API Gateway. It contains the [body] of the HTTP response.
/// It also contains a HTTP Status Code which by default is `200`.
/// Furthermore it indicates if the [body] is Base64 encoded or not.
class AwsApiGatewayResponse {
  /// The body of the HTTP Response send from the API Gateway to the client.
  String body = '';

  /// Indicates if the [body] is Base64 encoded or not. By default is `false`.
  bool isBase64Encoded = false;

  // HTTP Status Code of the response of the API Gateway to the client.
  int statusCode = 0;

  /// The HTTP headers that should be send with the response to the client.
  Map<String, String> headers = {};

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
  factory AwsApiGatewayResponse.fromJson(Map<String, dynamic> body,
      {bool? isBase64Encoded, int? statusCode, Map<String, String>? headers}) {
    return AwsApiGatewayResponse(
        json.encode(body), isBase64Encoded ?? false,
        headers ?? {}, statusCode ?? 200);
  }

  /// The Response that should be returned by the API Gateway for the
  /// Lambda invocation. It has a [body] which reflects the body of the HTTP Response.
  /// But also it signals if the [body] is Base64 encoded and what the HTTP Status Code
  /// of the response is.
  AwsApiGatewayResponse(
    this.body,
    this.isBase64Encoded,
    this.headers,
    this.statusCode,
  );
}
