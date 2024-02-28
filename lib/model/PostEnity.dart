import 'dart:convert';

List<PostEntity> PostListFromJson(String val) =>
    List<PostEntity>.from(json.decode(val)['data']);

class PostEntity {
  final int? post_id;
  final int? user_id;
  final String? content_post;
  final DateTime? timestamp;
  final String? status;

  PostEntity({
    this.post_id,
    this.user_id,
    this.content_post,
    this.timestamp,
    this.status
  });

  factory PostEntity.fromJson(Map<String, dynamic> data) => PostEntity(
    post_id: data["post_id"] ?? 0,
    user_id: data["user_id"] ?? 0,
    content_post: data["content_post"] ?? "",
    timestamp: DateTime.fromMillisecondsSinceEpoch(data["timestamp"] ?? 0),
    status: data["status"] ?? "",
  );

}
