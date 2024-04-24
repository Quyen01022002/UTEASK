import 'package:flutter/cupertino.dart';

class ClassMemberRequest{
  int? user;
  int? classes;

  ClassMemberRequest({
    required this.user,
  required this.classes
});



  factory ClassMemberRequest.fromJson(Map<String, dynamic> json){
    return ClassMemberRequest(
      user: json['user'] ?? 0,
      classes : json['classes'] ?? 0
    );
  }


}