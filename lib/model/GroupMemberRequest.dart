import 'package:flutter/cupertino.dart';

class GroupMemberRequest{
  int? user_id;
  int? group_id;

  GroupMemberRequest({
    required this.user_id,
  required this.group_id
});



  factory GroupMemberRequest.fromJson(Map<String, dynamic> json){
    return GroupMemberRequest(
      user_id: json['userId'] ?? 0,
      group_id : json['groupId'] ?? 0
    );
  }


}