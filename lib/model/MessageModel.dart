



import 'package:askute/model/Class.dart';
import 'package:askute/model/GroupModel.dart';

class MessageModel{
  final int? id;
  TeacherMember listMembers;

  MessageModel({
    required this.id,
    required this.listMembers,

  });

  factory MessageModel.fromJson(Map<String,dynamic> json){
    final user = TeacherMember.fromJson(json['user']);
    return MessageModel(
        id: json['id']??0,
        listMembers: user
    );

  }
}