import 'dart:convert';


class Authentication {
  final String? email;
  final String? password;


  Authentication({
    this.email,
    this.password,

  });

  factory Authentication.fromJson(Map<String, dynamic> data) => Authentication(
        email: data.containsKey("email") ? data["email"] : "",
        password: data["password"] ?? "",
      );
}
