


import 'dart:convert';

import 'package:askute/model/UserProfile.dart';
import 'package:get/get.dart';

List<UserProgress> postModelListFromJson(String jsonString) {
  final jsonData = json.decode(jsonString) as List;
  return jsonData.map((item) => UserProgress.fromJson(item)).toList();
}
class UserProgress extends GetxController{

  final UserProfile? userProfile;
  final int? countAllPostReply;
  final int? countPostRelied;

  UserProgress({
    required this.userProfile,
   required this.countAllPostReply,
   required this.countPostRelied
});

  factory UserProgress.fromJson(Map<String, dynamic> json){

    final user = UserProfile.fromJson(json['userResponse']);
    return UserProgress(
      userProfile: user,
      countAllPostReply: json["countAllPostReply"] ?? 0,
      countPostRelied: json["countPostReplied"]??0
    );

  }

}