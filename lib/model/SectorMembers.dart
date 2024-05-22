

import 'package:askute/model/GroupModel.dart';

class SectorMembers{
  final int? id;
  final int? sectorid;
  final String? name;
  final String? avatar;
  final int? userid;
  final String? first_name;
  final String? last_name;
  final String? avatarUser;


  SectorMembers({
    required this.id,
    required this.sectorid,
    required this.name,
    required this.avatar,
    required this.userid,
    required this.first_name,
    required this.last_name,
    required this.avatarUser
  });

  factory SectorMembers.fromJson(Map<String,dynamic> json){
    return SectorMembers(
        id: json['id']??0,
      sectorid:  json['sectorid'] ?? 0,
      name:  json['name'] ?? '',
      avatar: json['avatar'] ??'',
      userid:  json['userid'] ?? '',
      first_name:  json['first_name'] ?? '',
      last_name:  json['last_name'] ?? '',
      avatarUser: json['avatarUser']?? ''
    );

  }



}