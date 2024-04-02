import 'dart:convert';

enum RoleEnum { USER, TEACHER }

class Register {
  final String? email;
  final String? phone;
  final String? password;
  final RoleEnum? roleEnum;

  Register({
    this.email,
    this.phone,
    this.password,
    this.roleEnum,
  });

  factory Register.fromJson(Map<String, dynamic> data) => Register(
    email: data.containsKey("email") ? data["email"] : "",
    phone: data["phone"] ?? "",
    password: data["password"] ?? "",
    roleEnum: _parseRoleEnum(data["roleEnum"]),
  );

  static RoleEnum? _parseRoleEnum(String? value) {
    if (value == null) return null;
    switch (value) {
      case 'USER':
        return RoleEnum.USER;
      case 'TEACHER':
        return RoleEnum.TEACHER;
      default:
        return null;
    }
  }
}
