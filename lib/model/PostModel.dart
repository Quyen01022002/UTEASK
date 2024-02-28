import 'dart:convert';

List<PostModel> postModelListFromJson(String jsonString) {
  final jsonData = json.decode(jsonString) as List;
  return jsonData.map((item) => PostModel.fromJson(item)).toList();
}

class PostModel {
  final int id;
  final String contentPost;
  final String timeStamp;
  final bool status;
  final int comment_count;
  final int like_count;
  final bool user_liked;
  final List<Picture> listAnh;
  final CreateBy createBy;

  PostModel({
    required this.id,
    required this.contentPost,
    required this.timeStamp,
    required this.status,
    required this.comment_count,
    required this.like_count,
    required this.user_liked,
    required this.createBy,
    required this.listAnh,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) {
    final createBy = CreateBy.fromJson(json['createBy']);
    final listImg = (json['listAnh'] as List)
        .map((item) => Picture.fromJson(item))
        .toList();

    return PostModel(
        id: json['id'] ?? 0,
        contentPost: json['contentPost'] ?? "",
        timeStamp: json['timeStamp'] ?? "",
        status: json['status'] == "true",
        comment_count: json['comment_count'] ?? 0,
        like_count: json['like_count'] ?? 0,
        user_liked: json["user_liked"] ?? false,
        listAnh: listImg,
        createBy: createBy
    );
  }
}

class CreateBy {
final int id;
final String firstName;
final String lastName;
final String phone;
final String email;
final String profilePicture;

CreateBy({
required this.id,
required this.firstName,
required this.lastName,
required this.phone,
required this.email,
required this.profilePicture,
});

factory CreateBy.fromJson(Map<String, dynamic> json) {
return CreateBy(
id: json['id'] ?? 0,
firstName: json['firstName'] ?? "",
lastName: json['lastName'] ?? "",
phone: json['phone'] ?? "" ,
email: json['email'] ?? "",
profilePicture: json['profilePicture'] ?? "",
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
