



import 'package:askute/model/Class.dart';
import 'package:askute/model/GroupModel.dart';

class MessageContent{
  final int? id;
  final TeacherMember user;
  final String content;
  final String createdAt;

  MessageContent({
    required this.id,
    required this.user,
    required this.content,
    required this.createdAt,


  });

  factory MessageContent.fromJson(Map<String,dynamic> json){
    final user = TeacherMember.fromJson(json['user']);
    return MessageContent(
      id: json['id']??0,
      user: user,
      content: json['content'] ?? '',
      createdAt: json['createdAt'] ?? '',

    );

  }
}