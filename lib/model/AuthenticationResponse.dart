import 'dart:convert';

List<AuthenticationResponse> userListFromJson(String val) =>
    List<AuthenticationResponse>.from(json.decode(val)['data']);

class AuthenticationResponse {
  final int? id;
  final String? email;
  final String? token;
  final String? firstName;
  final String? lastName;
  final String? Avatar;

  AuthenticationResponse({
    this.id,
    this.email,
    this.token,
    this.firstName,
    this.lastName,
    this.Avatar
  });

  factory AuthenticationResponse.fromJson(Map<String, dynamic> data) => AuthenticationResponse(
    id: data["id"] ?? 0,
    email: data["email"] ?? "",
    token: data["token"] ?? "",
    firstName: data["firstName"] ?? "",
    lastName: data["lastName"] ?? "",
    Avatar: data["avatar"] ?? "",


  );
}
