import 'dart:convert';

List<CommentEntity> CommentEntityListFromJson(String val) =>
    List<CommentEntity>.from(json.decode(val)['data']);

class CommentEntity {
  final int? comment_id;
  final int? user_id;
  final int? post_id;
  final String? content_cmt;
  final String? timestamp;
  final String? first_name;
  final String? last_name;
  final String? avatar;
  final bool? is_reply;
  final List<CommentEntity?>? listCommentReply;
  final int? cmtReply;

  CommentEntity({
    this.comment_id,
    this.user_id,
    this.post_id,
    this.content_cmt,
    this.timestamp,
    this.first_name,
    this.last_name,
    this.avatar,
this.is_reply,
    this.listCommentReply,
    this.cmtReply
  });

  factory CommentEntity.fromJson(Map<String, dynamic> data) {


    final listReply = (data['commentsReplyList'] as List)
        .map((item) => CommentEntity.fromJson(item))
        .toList();
    return CommentEntity(
    comment_id: data["commentId"] ?? 0,
    user_id: data["createBy"]["id"] ?? 0,
    post_id: data["postID"]["id"] ?? 0,
    content_cmt: data["commentContent"] ?? "",
    timestamp: data["timeStamp"] ?? 0,
    first_name: data["createBy"]["firstName"] ?? "",
    last_name: data["createBy"]["lastName"] ?? "",
    avatar: data["createBy"]["profilePicture"] ?? "",
    is_reply: data["anwser"] ?? false,
    listCommentReply: listReply,
        cmtReply: data["cmtReply"] ?? 0
  );}

}
