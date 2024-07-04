import 'dart:convert';

List<CommentResponse> CommentResponseListFromJson(String val) =>
    List<CommentResponse>.from(json.decode(val)['data']);

class CommentResponse {
  final int? comment_id;
  final int? user_id;
  final PostRp? post_id;
  final String? content_cmt;
  final String? timestamp;
  final String? first_name;
  final String? last_name;
  final String? avatar;


  CommentResponse({
    this.comment_id,
    this.user_id,
    this.post_id,
    this.content_cmt,
    this.timestamp,
    this.first_name,
    this.last_name,
    this.avatar,

  });
  factory CommentResponse.fromJson(Map<String, dynamic> data) {
    final post = PostRp.fromJson(data['postID']);
    return CommentResponse(
      comment_id: data["commentId"] ?? 0,
      user_id: data["createBy"]["id"] ?? 0,
      post_id: post,
      content_cmt: data["commentContent"] ?? "",
      timestamp: data["timeStamp"] ?? 0,
      first_name: data["createBy"]["firstName"] ?? "",
      last_name: data["createBy"]["lastName"] ?? "",
      avatar: data["createBy"]["profilePicture"] ?? "",
    );
  }

}
class PostRp {
  final int id;
  final String firstName;
  final String lastName;
  final String contentPost;
  final List<String> listAnh;
  final String avatar;

  PostRp({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.contentPost,
    required this.listAnh,
    required this.avatar
  });

  factory PostRp.fromJson(Map<String, dynamic> json) {
    final listImg = (json['listAnh'] as List)
        .map((item) => item['linkPicture'].toString())
        .toList();
    return PostRp(
      id: json['id'] ?? 0,
      firstName: json['createBy']['firstName'] ?? "",
      lastName: json['createBy']['lastName'] ?? "",
      avatar: json['createBy']['profilePicture'] ?? "",
      contentPost: json['contentPost'] ?? "",
      listAnh: listImg,
    );
  }
}
class Picture {
  final int id;
  final String link_picture;

  Picture({
    required this.id,
    required this.link_picture,
  });

  factory Picture.fromJson(Map<String, dynamic> json) {
    return Picture(
      id: json['id'] ?? 0,
      link_picture: json['linkPicture'] ?? "",
    );
  }
}
