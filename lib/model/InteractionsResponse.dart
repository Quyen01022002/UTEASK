import 'dart:convert';

List<InteractionResponse> InteractionResponseFromJson(String val) =>
    List<InteractionResponse>.from(json.decode(val)['data']);

class InteractionResponse {
  final int? interaction_id;
  final int? user_id;
  final PostRp? post_id;
  final bool? liked;
  final String? timestamp;


  InteractionResponse({
    this.interaction_id,
    this.user_id,
    this.post_id,
    this.liked,
    this.timestamp

  });

  factory InteractionResponse.fromJson(Map<String, dynamic> data) {
    final post = PostRp.fromJson(data['postID']);
    return InteractionResponse(
          interaction_id: data["interactionid"] ?? 0,
          user_id: data["user_id"] ?? 0,
          post_id: post,
          liked: data["liked"] ?? false,
          timestamp: data["timeStamp"] ?? 0,

        );
  }

}
class PostRp {
  final int id;
  final String firstName;
  final String lastName;
  final String avatar;
  final String contentPost;
  final List<String> listAnh;

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
