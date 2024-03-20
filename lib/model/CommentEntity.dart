import 'dart:convert';

List<CommentEntity> CommentEntityListFromJson(String val) =>
    List<CommentEntity>.from(json.decode(val)['data']);

class CommentEntity {
  final int? comment_id;
  final int? user_id;
  final int? post_id;
  final String? content_post;
  final int? timestamp;
  final String? first_name;
  final String? last_name;
  final String? avatar;


  CommentEntity({
    this.comment_id,
    this.user_id,
    this.post_id,
    this.content_post,
    this.timestamp,
    this.first_name,
    this.last_name,
    this.avatar,

  });

  factory CommentEntity.fromJson(Map<String, dynamic> data) => CommentEntity(
    comment_id: data["comment_id"] ?? 0,
    user_id: data["user_id"] ?? 0,
    post_id: data["post_id"] ?? 0,
    content_post: data["content_post"] ?? "",
    timestamp: data["postimestampt_id"] ?? 0,
    first_name: data["first_name"] ?? "",
    last_name: data["last_name"] ?? "",
    avatar: data["avatar"] ?? "",
  );

}
