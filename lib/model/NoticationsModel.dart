import 'dart:convert';

import 'PostModel.dart';

List<NoticationsModel> postModelListFromJson(String jsonString) {
  final jsonData = json.decode(jsonString) as List;
  return jsonData.map((item) => NoticationsModel.fromJson(item)).toList();
}

class NoticationsModel {
  final int id;
  final String contentNotications;
  final String timeStamp;
  final bool isRead;
  final CreateBy createBy;

  NoticationsModel({
    required this.id,
    required this.contentNotications,
    required this.timeStamp,
    required this.isRead,
    required this.createBy,
  });

  factory NoticationsModel.fromJson(Map<String, dynamic> json) {
    final createBy = CreateBy.fromJson(json['user']);

    return NoticationsModel(
        id: json['id'] ?? 0,
        contentNotications: json['contentNotications'] ?? "",
        timeStamp: json['timeStamp'] ?? "",
        isRead: json['isRead'] == "true",
        createBy: createBy
    );
  }
}
