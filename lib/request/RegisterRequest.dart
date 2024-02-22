import 'dart:convert';


class Register {
  final String? email;
  final String? phone;
  final String? password;


  Register({
    this.email,
    this.phone,
    this.password,

  });

  factory Register.fromJson(Map<String, dynamic> data) => Register(
        email: data.containsKey("email") ? data["email"] : "",
        phone: data["phone"] ?? "",
        password: data["password"] ?? "",

      );
}
