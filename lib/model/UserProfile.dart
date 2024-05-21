import 'dart:convert';

import 'PostModel.dart';
import 'UsersEnity.dart';

List<UserProfile> userListFromJson(String val) =>
    List<UserProfile>.from(json.decode(val)['data']);

enum RoleEnum {
  USER,
  TEACHER,
  HEADDEPARTMENT
}

class UserProfile {
  final int? id;
  final String? first_name;
  final String? last_name;
  final String? email;
  final String? phone;
  final RoleEnum roleEnum;
  final String? avatarUrl;
  final String? backGround;
  final bool? isFriends;
  final int? countFriend;
  final int? idFriends;
  final List<PostModel>? listpost;
  final List<UserEnity>? friends;



  UserProfile({
    this.id,
    this.first_name,
    this.last_name,
    this.email,
    this.phone,
    this.avatarUrl,
    this.countFriend,
    this.listpost,
    this.isFriends,
    this.friends,
    this.idFriends,
    this.backGround,
required this.roleEnum
  });


  factory UserProfile.fromJson(Map<String, dynamic> json) {

    final listPost = (json['postList'] as List)
        .map((item) => PostModel.fromJson(item))
        .toList();
    final friendships = (json['friendships'] as List)
        .map((item) => UserEnity.fromJson(item))
        .toList();

    String roleString = json["role"] ?? ""; // Lấy giá trị của trường roleEnum, hoặc một chuỗi rỗng nếu không có
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
    return UserProfile(
      id: json["id"] ?? 0,
      first_name: json["firstName"] ?? "",
      last_name: json["lastName"] ?? "",
      email: json["email"] ?? "",

      phone: json["phone"] ?? "",
      roleEnum: role,
      avatarUrl: json["profilePicture"] ?? "",
      backGround: json["backGroundPicture"] ?? "",
      countFriend: json["countFriend"] ?? 0,
      idFriends: json["idFriends"] ?? 0,
      isFriends: json["isFriends"] ?? false,
      listpost: listPost,
      friends:friendships,

    );
  }
}
