import 'dart:convert';


import 'package:askute/model/GroupModel.dart';
import 'package:askute/model/PostModel.dart';
import 'package:askute/model/UsersEnity.dart';



class ClassModel {
  final int? id;
  final TeacherMember? teacher;

  final String? name;
  final int? groups;
  final String? description;
  final String? avatar;
  final String? backAvatar;
  final DateTime? createdDate;
  final DateTime? updatedDate;
  final List<UserMember> listMembers;
  final List<PostModel> listPost;

  ClassModel({
    required this.name,
    required this.id,
      this.teacher,
    required this.groups,
    required this.createdDate,
    required this.description,
    required this.backAvatar,
    required this.avatar,
    required this.updatedDate,
    required this.listMembers,
    required this.listPost,

});

  factory ClassModel.fromJson(Map<String, dynamic> json) {
    final user = TeacherMember.fromJson(json['teacher']);
    List<UserMember> listUser = [];
    if (json['classMembers'] != null) {
      listUser = (json['classMembers'] as List)
          .map((item) => UserMember.fromJson(item)).toList();
    }
    List<PostModel> listPost = [];
    if (json['listPost'] != null) {
      listPost = (json['listPost'] as List)
          .map((item) => PostModel.fromJson(item)).toList();
    }
    return ClassModel(
        id: json['id'] ?? 0,
        teacher: user,
        groups: json['groups'] ?? 0,
        createdDate: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
        updatedDate: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
        description: json['description'] ?? '',
        avatar: json['avatar'] ?? '',
        backAvatar: json['backAvatar'] ?? '', // Fix this typo
        name: json['name'] ?? '',
        listMembers: listUser,
        listPost: listPost
    );
  }


}
class TeacherMember {
  final int id;
  final String firstName;
  final String lastName;
  final String phone;
  final String email;
  final String profilePicture;

  TeacherMember({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.email,
    required this.profilePicture,
  });

  factory TeacherMember.fromJson(Map<String, dynamic> json) {
    return TeacherMember(
      id: json['id'] ?? 0,
      firstName: json['firstName'] ?? "",
      lastName: json['lastName'] ?? "",
      phone: json['phone'] ?? "" ,
      email: json['email'] ?? "",
      profilePicture: json['profilePicture'] ?? "",
    );
  }
}