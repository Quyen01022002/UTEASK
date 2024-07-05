import 'dart:convert';

List<PostModel> postModelListFromJson(String jsonString) {
  if (jsonString.isEmpty) {
    return [];
  }

  final jsonData = json.decode(jsonString) as List<dynamic>;
  return jsonData
      .map((item) => PostModel.fromJson(item as Map<String, dynamic>))
      .toList();
}

class PostModel {
  final int id;
  final String contentPost;
  final String timeStamp;
  final bool status;
  final int comment_count;
  final int like_count;
  final int save_count;
  final bool user_liked;
  final bool user_saved;
  final List<String>? listAnh;
  final CreateBy? createBy;
  final int groupid;
  final String name_group;
  final String statusViewPostEnum;
  final String statusCmtPostEnum;

  PostModel({
    required this.id,
    required this.contentPost,
    required this.timeStamp,
    required this.status,
    required this.comment_count,
    required this.like_count,
    required this.save_count,
    required this.user_liked,
    required this.user_saved,
    this.createBy,
    this.listAnh,
    required this.groupid,
    required this.name_group,
    required this.statusViewPostEnum,
    required this.statusCmtPostEnum,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) {
    final createBy = json['createBy'] != null
        ? CreateBy.fromJson(json['createBy'] as Map<String, dynamic>)
        : null;

    final listImg = json['listAnh'] != null
        ? (json['listAnh'] as List<dynamic>)
        .map((item) => item['linkPicture'].toString())
        .toList()
        : null;

    return PostModel(
      id: json['id'] ?? 0,
      contentPost: json['contentPost'] ?? '',
      timeStamp: json['timeStamp'] ?? '',
      status: json['status'] == true,
      comment_count: json['comment_count'] ?? 0,
      like_count: json['like_count'] ?? 0,
      save_count: json['save_count']?? 0,
      user_liked: json['user_liked'] ?? false,
      user_saved: json['user_saved'] ?? false,
      listAnh: listImg,
      createBy: createBy,
      groupid: json['groupid'] ?? 0,
      name_group: json['groupname'] ?? '',
      statusViewPostEnum: json['statusViewPostEnum'] ?? '',
      statusCmtPostEnum: json['statusCmtPostEnum'] ?? '',
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

  factory CreateBy.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return CreateBy(
        id: 0,
        firstName: "",
        lastName: "",
        phone: "",
        email: "",
        profilePicture: "",
      );
    }
    return CreateBy(
      id: json['id'] ?? 0,
      firstName: json['firstName'] ?? "",
      lastName: json['lastName'] ?? "",
      phone: json['phone'] ?? "",
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

  factory Picture.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return Picture(
        id: 0,
        link_picture: "",
      );
    }
    return Picture(
      id: json['id'] ?? 0,
      link_picture: json['linkPicture'] ?? "",
    );
  }
}
