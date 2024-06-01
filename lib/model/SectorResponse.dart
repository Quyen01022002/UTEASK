

import 'package:askute/model/GroupModel.dart';

class SectorResponse{
  final int? id;
  final String? name;
  final String? description;
  final String? avatar;
  final int? groupId;
  final String? nameGroup;
  final String? avatarGroup;

  SectorResponse({
    required this.id,
    required this.name,
    required this.description,
    required this.avatar,
    required this.groupId,
    required this.nameGroup,
    required this.avatarGroup
});

  factory SectorResponse.fromJson(Map<String,dynamic> json){
    return SectorResponse(
        id: json['id']??0,
      name: json['name']??'',
      description: json['description']??'',
      avatar: json['avatar']??'',
      groupId: json['groupId']??0,
      nameGroup: json['nameGroup']??'',
      avatarGroup: json['avatarGroup']??''
    );

  }



}