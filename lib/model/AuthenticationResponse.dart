import 'dart:convert';

enum RoleEnum {
  USER,
  TEACHER,
  HEADDEPARTMENT
}

List<AuthenticationResponse> userListFromJson(String val) =>
    List<AuthenticationResponse>.from(json.decode(val)['data']);

class AuthenticationResponse {
  final int? id;
  final String? email;
  final String? token;
  final String? firstName;
  final String? lastName;
  final String? avatar;
  final RoleEnum roleEnum; // Use RoleEnum as the type

  AuthenticationResponse({
    this.id,
    this.email,
    this.token,
    this.firstName,
    this.lastName,
    this.avatar, // Corrected the field name to lowercase 'avatar'
    required this.roleEnum, // Make sure to include 'required' for non-nullable fields
  });

  factory AuthenticationResponse.fromJson(Map<String, dynamic> data) {
    String roleString = data["roleEnum"] ?? ""; // Lấy giá trị của trường roleEnum, hoặc một chuỗi rỗng nếu không có
    RoleEnum role;

    // Xác định giá trị enum dựa trên giá trị chuỗi
    switch (roleString.toUpperCase()) {
      case "USER":
        role = RoleEnum.USER;
        break;
      case "TEACHER":
        role = RoleEnum.TEACHER;
        break;
      case "HEADDEPARTMENT":
        role = RoleEnum.HEADDEPARTMENT;
        break;
      default:
        role = RoleEnum.USER; // Hoặc một giá trị mặc định khác nếu không xác định được
    }

    return AuthenticationResponse(
      id: data["id"],
      email: data["email"],
      token: data["token"],
      firstName: data["firstName"],
      lastName: data["lastName"],
      avatar: data["avatar"],
      roleEnum: role, // Gán giá trị enum đã xác định
    );
  }
}
