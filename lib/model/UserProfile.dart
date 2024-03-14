import 'dart:convert';

import 'PostModel.dart';
import 'UsersEnity.dart';

List<UserProfile> userListFromJson(String val) =>
    List<UserProfile>.from(json.decode(val)['data']);

class UserProfile {
  final int? id;
  final String? first_name;
  final String? last_name;
  final String? email;
  final String? phone;
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
    this.backGround

  });


  factory UserProfile.fromJson(Map<String, dynamic> json) {

    final listPost = (json['postList'] as List)
        .map((item) => PostModel.fromJson(item))
        .toList();
    final friendships = (json['friendships'] as List)
        .map((item) => UserEnity.fromJson(item))
        .toList();

    return UserProfile(
      id: json["id"] ?? 0,
      first_name: json["firstName"] ?? "",
      last_name: json["lastName"] ?? "",
      email: json["email"] ?? "",

      phone: json["phone"] ?? "",
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
