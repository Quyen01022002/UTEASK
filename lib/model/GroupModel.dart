import 'dart:convert';

import 'package:askute/model/PostModel.dart';



class GroupModel {
  final int? id;
  final String? name;
  final String? description;
  final String? avatar;
  final DateTime? createdDate;
  final DateTime? updatedDate;
  final List<UserMember> listMembers;
  final List<PostModel> listPost;

  GroupModel({
   required this.name,
    required this.id,
    required this.createdDate,
    required this.description,
    required this.avatar,
    required this.updatedDate,
    required this.listMembers,
    required this.listPost,

});

  factory GroupModel.fromJson(Map<String, dynamic> json){
    //final user = UserMember.fromJson(json['adminId']);
    List<UserMember> listUser = [];
    if (json['groupMembers'] == null)
      listUser= [];
    else
      listUser = (json['groupMembers'] as List)
    .map((item) => UserMember.fromJson(item)).toList();
    List<PostModel> listPost = [];
    if (json['listPost'] == null)
      listUser= [];
    else
      listPost = (json['listPost'] as List)
          .map((item) => PostModel.fromJson(item)).toList();
    return GroupModel(
      id: json['id'] ?? 0,
        createdDate: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
        updatedDate: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
      description: json['description'] ?? '',
      avatar: json['avatar'] ?? '',
      name: json['name'] ?? '',
      listMembers: listUser,
      listPost: listPost
    );


  }



}
class UserMember {
  final int id;
  final int idMembers;
  final String firstName;
  final String lastName;
  final String phone;
  final String email;
  final String profilePicture;

  UserMember({
    required this.id,
    required this.idMembers,
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.email,
    required this.profilePicture,
  });

  factory UserMember.fromJson(Map<String, dynamic> json) {
    return UserMember(
      id: json['user']['id'] ?? 0,
      idMembers: json['id'] ?? 0,
      firstName: json['user']['firstName'] ?? "",
      lastName: json['user']['lastName'] ?? "",
      phone: json['user']['phone'] ?? "" ,
      email: json['user']['email'] ?? "",
      profilePicture: json['user']['profilePicture'] ?? "",
    );

  }
}