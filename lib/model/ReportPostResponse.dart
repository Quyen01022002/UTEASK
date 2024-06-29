
import 'dart:convert';

import 'package:askute/model/PostModel.dart';

List<ReportPostResponse> postModelListFromJson(String jsonString) {
  final jsonData = json.decode(jsonString) as List;
  return jsonData.map((item) => ReportPostResponse.fromJson(item)).toList();
}

class ReportPostResponse{
  final int id;
  final CreateBy reporter;
  final PostModel postModel;
  final String reason;
  final String timeStamp;
  final bool status;
  ReportPostResponse({
    required this.id,
    required this.reporter,
    required this.postModel,
    required this.reason,
    required this.timeStamp,
    required this.status
});

  factory ReportPostResponse.fromJson(Map<String, dynamic> json) {
    final createBy = CreateBy.fromJson(json['reporterID']);
    final post = PostModel.fromJson(json['reportedPostID']);

    return ReportPostResponse(
        id: json['id'] ?? 0,
      reporter: createBy,
      postModel: post,
      reason: json['reason'] ?? '',
      timeStamp: json['timestamp'] ?? '',
      status: json['status'] ?? false,
    );
  }





}