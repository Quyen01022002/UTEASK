import 'dart:convert';


class ApiReponse<T> {
  ApiReponse({
    required this.status,
    required this.payload,
    required this.error,
    required this.metadata,
  });

  String status;
  T payload;
  dynamic error;
  dynamic metadata;

  factory ApiReponse.fromJson(String str, T Function(dynamic) fromJson) {
    final jsonData = json.decode(str);
    return ApiReponse(
      status: jsonData["status"],
      payload: fromJson(jsonData["payload"]),
      error: jsonData["error"],
      metadata: jsonData["metadata"],
    );
  }
}
