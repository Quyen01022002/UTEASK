import 'dart:async';
import 'dart:convert';
import 'dart:ffi';

import 'package:askute/model/ApiReponse.dart';
import 'package:askute/model/Class.dart';
import 'package:askute/model/CommentResponse.dart';
import 'package:askute/model/GroupModel.dart';
import 'package:askute/model/InteractionsResponse.dart';
import 'package:askute/model/PostEnity.dart';
import 'package:askute/model/PostModel.dart';
import 'package:askute/model/ReportPostResponse.dart';
import 'package:askute/model/UserProgress.dart';
import 'package:askute/service/API_Class.dart';
import 'package:askute/service/API_Group.dart';
import 'package:askute/service/const.dart';
import 'package:askute/view/teacher/Home/Class/ClassDetailTeacher.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../model/CommentEntity.dart';
import '../model/InteractionsEntity.dart';

class API_Post {
  static Future<List<PostModel>?> LoadSavedPost(int userid,
      String token) async {
    final response = await http.get(
      Uri.parse('$baseUrl/save/$userid'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final responseData = response.body;

      if (responseData.isNotEmpty) {
        String utf8Data = utf8.decode(responseData.runes.toList());
        ApiReponse<List<PostModel>> listPost =
        ApiReponse<List<PostModel>>.fromJson(
          utf8Data,
              (dynamic json) =>
          List<PostModel>.from(json.map((x) => PostModel.fromJson(x))),
        );
        return listPost.payload;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  static Future<String?> DeliverKhoa(String questions) async {
    final response = await http.post(
      Uri.parse('http://192.168.60.92:8081/classify'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        "question": questions
      }),
    );

    print("api");
    print(response.statusCode);
    if (response.statusCode == 200) {
      print("success");
      final responseData = response.body;

      if (responseData.isNotEmpty) {
        final responseData = jsonDecode(response.body);
        //String utf8Data = utf8.decode(responseData.runes.toList());
        String khoa = responseData['khoa'];
        print(khoa);

        return khoa;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }
  static Future<String?> CommunicateRules(String questions) async {
    final response = await http.post(
      Uri.parse('http://192.168.60.92:5000/predict'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        "questions": questions
      }),
    );

    print("api");
    print(response.statusCode);
    if (response.statusCode == 200) {
      print("success");
      final responseData = response.body;

      if (responseData.isNotEmpty) {
        final responseData = jsonDecode(response.body);
        //String utf8Data = utf8.decode(responseData.runes.toList());
        String khoa = responseData['label'];
        print(khoa);

        return khoa;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  static Future<List<PostModel>?> LoadMainHome(int userid, String token) async {
    final response = await http.get(
      Uri.parse('$baseUrl/post/$userid'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final responseData = response.body;

      if (responseData.isNotEmpty) {
        String utf8Data = utf8.decode(responseData.runes.toList());
        ApiReponse<List<PostModel>> listPost =
        ApiReponse<List<PostModel>>.fromJson(
          utf8Data,
              (dynamic json) =>
          List<PostModel>.from(json.map((x) => PostModel.fromJson(x))),
        );
        return listPost.payload;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  static Future<PostEntity?> post(
      PostEntity post,
      List<String> img,
      String token,
      int groupId,
      int sector,
      String sttview,
      String sttcmt,
      bool status
      ) async {
    final url = Uri.parse('$baseUrl/post/post');

    final headers = {
      "Content-Type": "application/json",
      'Authorization': 'Bearer $token',
    };

    List<Map<String, String>> listAnh = img.map((imageUrl) => {'linkPicture': imageUrl}).toList();

    final Map<String, dynamic> data = {
      "groups": groupId,
      "contentPost": post.content_post,
      "listAnh": listAnh,
      "status": status,
      "statusViewPostEnum": sttview,
      "statusCmtPostEnum": sttcmt,
      "sector": sector,
    };

    final response = await http.post(
      url,
      headers: headers,
      body: jsonEncode(data),
    );
    if (response.statusCode == 200) {
      final responseData = response.body;

      if (responseData.isNotEmpty) {
        String utf8Data = utf8.decode(responseData.runes.toList());
        ApiReponse<PostEntity> listPost =
        ApiReponse<PostEntity>.fromJson(
          utf8Data,
              (dynamic json) =>
              PostEntity.fromJson(json),
        );
        return listPost.payload;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }


  static Future<PostEntity?> postClass(PostEntity post, List<String> img,
      String token, int groupId, BuildContext context) async {
    final url = Uri.parse('$baseUrl/post/post/class');

    final headers = {
      "Content-Type": "application/json",
      'Authorization': 'Bearer $token',
    };
    List<Map<String, String>> listAnh =
    img.map((imageUrl) => {'linkPicture': imageUrl}).toList();

    final Map<String, dynamic> data = {
      "classes": groupId,
      "contentPost": post.content_post,
      "listAnh": listAnh,
    };

    await http.post(
      url,
      headers: headers,
      body: jsonEncode(data),
    );
    final ClassModel? classModel = await API_Class.getClassById(groupId, token);
    if (classModel != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              DefaultTabController(
                initialIndex: 2,
                length: 3,
                child: ClassDetailTeacher(classes: classModel),
              ),
        ),
      );
    } else {
      // Handle the case where classModel is null
    }
  }

  static Future<PostEntity?> postHotPost(PostEntity post, List<String> img,
      String token, int groupId, int hotday, BuildContext context) async {
    final url = Uri.parse('$baseUrl/post/post/important');

    final headers = {
      "Content-Type": "application/json",
      'Authorization': 'Bearer $token',
    };
    List<Map<String, String>> listAnh =
    img.map((imageUrl) => {'linkPicture': imageUrl}).toList();

    final Map<String, dynamic> data = {
      "groups": groupId,
      "contentPost": post.content_post,
      "listAnh": listAnh,
      "hotinday": hotday,
    };

    await http.post(
      url,
      headers: headers,
      body: jsonEncode(data),
    );
    final GroupModel? classModel = await API_Group.loadGroupMeDepartment(post.user_id!, token);
    if (classModel != null) {
      Navigator.of(context).pop();
    } else {
      // Handle the case where classModel is null
    }
  }

  static Future<PostEntity?> upatePost(PostEntity post, List<String> img,
      String token) async {
    final url = Uri.parse('$baseUrl/post/update');

    final headers = {
      "Content-Type": "application/json",
      'Authorization': 'Bearer $token',
    };
    List<Map<String, String>> listAnh =
    img.map((imageUrl) => {'linkPicture': imageUrl}).toList();

    final Map<String, dynamic> data = {
      "contentPost": post.content_post,
      "listAnh": listAnh,
    };

    await http.put(
      url,
      headers: headers,
      body: jsonEncode(data),
    );
  }
  static Future<PostEntity?> bloakCmtOfPost(int postid,
      String token) async {
    final url = Uri.parse('$baseUrl/post/$postid/blockCmt');

    final headers = {
      "Content-Type": "application/json",
      'Authorization': 'Bearer $token',
    };
    await http.put(
      url,
      headers: headers,
    );
  }
  static Future<PostEntity?> unblockCmtOfPost(int postid,
      String token) async {
    final url = Uri.parse('$baseUrl/post/$postid/unblockCmt');

    final headers = {
      "Content-Type": "application/json",
      'Authorization': 'Bearer $token',
    };
    await http.put(
      url,
      headers: headers,
    );
  }

  static Future<InteractionsEntity?> Liked(String token, int postid,
      int userId) async {
    final url = Uri.parse('$baseUrl/interations?post=$postid&user=$userId');
    final headers = {
      "Content-Type": "application/json",
      'Authorization': 'Bearer $token',
    };

    await http.post(
      url,
      headers: headers,
    );
  }

  static Future<InteractionsEntity?> Saved(String token, int userid,
      int postid) async {
    final url = Uri.parse('$baseUrl/save/add?userId=$userid&postId=$postid');
    final headers = {
      "Content-Type": "application/json",
      'Authorization': 'Bearer $token',
    };

    await http.post(
      url,
      headers: headers,
    );
  }

  static Future<InteractionsEntity?> Delete(String token, int userid,
      int postid) async {
    final url = Uri.parse('$baseUrl/save?userId=$userid&postId=$postid');
    final headers = {
      "Content-Type": "application/json",
      'Authorization': 'Bearer $token',
    };

    await http.delete(
      url,
      headers: headers,
    );
  }

  static Future<CommentEntity?> Comments(int userid, int postid, String content,
      String token) async {
    final url = Uri.parse('$baseUrl/comments/cmt2');
    final headers = {"Content-Type": "application/json",
      'Authorization': 'Bearer $token',
    };
    final Map<String, dynamic> data = {
      "user_id": userid,
      "post_id": postid,
      "content_post": content,
      "timeStamp": DateTime.now().toIso8601String()
    };

    final response = await http.post(
      url,
      headers: headers,
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      final responseData = response.body;

      if (responseData.isNotEmpty) {
        CommentEntity listPost =
        CommentEntity.fromJson(json.decode(responseData));
        return listPost;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }
  static Future<CommentEntity?> ReplyComments(int userid, int comment_id, String content,
      String token) async {
    final url = Uri.parse('$baseUrl/comments/$comment_id/reply');
    final headers = {"Content-Type": "application/json",
      'Authorization': 'Bearer $token',
    };
    final Map<String, dynamic> data = {
      "userid": userid,
      "cmtReply": content,
    };

    final response = await http.post(
      url,
      headers: headers,
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      final responseData = response.body;

      if (responseData.isNotEmpty) {
        CommentEntity listPost =
        CommentEntity.fromJson(json.decode(responseData));
        return listPost;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  static Future<void> deletePost(int? postid, String token) async {
    await http.delete(
      Uri.parse('$baseUrl/post/$postid'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
  }

  static Future<List<PostModel>?> LoadTop10(int userid, String token) async {
    final response = await http.get(
      Uri.parse('$baseUrl/post/$userid/top10'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final responseData = response.body;

      if (responseData.isNotEmpty) {
        String utf8Data = utf8.decode(responseData.runes.toList());
        ApiReponse<List<PostModel>> listPost =
        ApiReponse<List<PostModel>>.fromJson(
          utf8Data,
              (dynamic json) =>
          List<PostModel>.from(json.map((x) => PostModel.fromJson(x))),
        );
        return listPost.payload;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }
  static Future<List<PostModel>?> LoadHotPost(int userid, int pagenumber, String token) async {
    final response = await http.get(
      Uri.parse('$baseUrl/group/follow/posts/hot/${userid}/${pagenumber}'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final responseData = response.body;

      if (responseData.isNotEmpty) {
        String utf8Data = utf8.decode(responseData.runes.toList());
        ApiReponse<List<PostModel>> listPost =
        ApiReponse<List<PostModel>>.fromJson(
          utf8Data,
              (dynamic json) =>
          List<PostModel>.from(json.map((x) => PostModel.fromJson(x))),
        );
        return listPost.payload;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  static Future<List<PostModel>?> LoadTop10onClass(int userid,
      String token) async {
    final response = await http.get(
      Uri.parse('$baseUrl/post/teacher/$userid/top10'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final responseData = response.body;

      if (responseData.isNotEmpty) {
        String utf8Data = utf8.decode(responseData.runes.toList());
        ApiReponse<List<PostModel>> listPost =
        ApiReponse<List<PostModel>>.fromJson(
          utf8Data,
              (dynamic json) =>
          List<PostModel>.from(json.map((x) => PostModel.fromJson(x))),
        );
        return listPost.payload;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  static Future<List<PostModel>?> LoadPostNotReply(int userid,
      String token) async {
    final response = await http.get(
      Uri.parse('$baseUrl/post/teacher/$userid/notReply/'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final responseData = response.body;

      if (responseData.isNotEmpty) {
        String utf8Data = utf8.decode(responseData.runes.toList());
        ApiReponse<List<PostModel>> listPost =
        ApiReponse<List<PostModel>>.fromJson(
          utf8Data,
              (dynamic json) =>
          List<PostModel>.from(json.map((x) => PostModel.fromJson(x))),
        );
        return listPost.payload;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }
  static Future<List<PostModel>?> LoadPostInGroupNotUserReply(int groupid, int pagenumber,
      String token) async {
    final response = await http.get(
      Uri.parse('$baseUrl/post/notUserReply/$groupid/$pagenumber'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final responseData = response.body;

      if (responseData.isNotEmpty) {
        String utf8Data = utf8.decode(responseData.runes.toList());
        ApiReponse<List<PostModel>> listPost =
        ApiReponse<List<PostModel>>.fromJson(
          utf8Data,
              (dynamic json) =>
          List<PostModel>.from(json.map((x) => PostModel.fromJson(x))),
        );
        return listPost.payload;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  static Future<List<PostModel>?> Load5OnMonth(int userid, String token) async {
    final response = await http.get(
      Uri.parse('$baseUrl/post/classes/top5/$userid'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final responseData = response.body;

      if (responseData.isNotEmpty) {
        String utf8Data = utf8.decode(responseData.runes.toList());
        ApiReponse<List<PostModel>> listPost =
        ApiReponse<List<PostModel>>.fromJson(
          utf8Data,
              (dynamic json) =>
          List<PostModel>.from(json.map((x) => PostModel.fromJson(x))),
        );
        return listPost.payload;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  static Future<String?> LoadCountOfYear(int userid, String token) async {
    final response = await http.get(
      Uri.parse('$baseUrl/post/classes/countYear/$userid'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final responseData = response.body;

      if (responseData.isNotEmpty) {
        Map<String, dynamic> data = jsonDecode(responseData);
        String payload = data['payload'];

        return payload;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  static Future<String?> LoadCountThongKe(int userid, String token) async {
    final response = await http.get(
      Uri.parse('$baseUrl/class/thongke/$userid'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final responseData = response.body;

      if (responseData.isNotEmpty) {
        Map<String, dynamic> data = jsonDecode(responseData);
        String payload = data['payload'];

        return payload;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  static Future<List<PostModel>?> searchPost(int userid, String token,
      String keyword) async {
    final response = await http.get(
      Uri.parse('$baseUrl/post/$userid/search?q=$keyword&pagenumber=0'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final responseData = response.body;

      if (responseData.isNotEmpty) {
        String utf8Data = utf8.decode(responseData.runes.toList());
        ApiReponse<List<PostModel>> listPost =
        ApiReponse<List<PostModel>>.fromJson(
          utf8Data,
              (dynamic json) =>
          List<PostModel>.from(json.map((x) => PostModel.fromJson(x))),
        );
        return listPost.payload;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }
  static Future<List<PostModel>?> searchPost2(int userid, int page, String token,
      String keyword) async {
    final response = await http.get(
      Uri.parse('$baseUrl/post/$userid/search?q=$keyword&pagenumber=$page'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final responseData = response.body;

      if (responseData.isNotEmpty) {
        String utf8Data = utf8.decode(responseData.runes.toList());
        ApiReponse<List<PostModel>> listPost =
        ApiReponse<List<PostModel>>.fromJson(
          utf8Data,
              (dynamic json) =>
          List<PostModel>.from(json.map((x) => PostModel.fromJson(x))),
        );
        return listPost.payload;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  static Future<List<PostModel>?> getAllLikePost(int userid,
      String token) async {
    final response = await http.get(
      Uri.parse('$baseUrl/post/$userid/allMyLike'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final responseData = response.body;

      if (responseData.isNotEmpty) {
        String utf8Data = utf8.decode(responseData.runes.toList());
        ApiReponse<List<PostModel>> listPost =
        ApiReponse<List<PostModel>>.fromJson(
          utf8Data,
              (dynamic json) =>
          List<PostModel>.from(json.map((x) => PostModel.fromJson(x))),
        );
        return listPost.payload;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  static Future<PostModel?> getOnePost(int id, int iduser, String token) async {
    final url = Uri.parse('$baseUrl/post/get/$iduser/$id');

    final response = await http.get(
      url,
      headers: {
        "Content-Type": "application/json",
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final responseData = response.body;

      if (responseData.isNotEmpty) {
        String utf8Data = utf8.decode(responseData.runes.toList());
        ApiReponse<PostModel> listPost =
        ApiReponse<PostModel>.fromJson(
          utf8Data,
              (dynamic json) =>
              PostModel.fromJson(json),
        );
        return listPost.payload;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  static Future<List<CommentEntity>?> getAllComment(int postid,
      String token) async {
    final response = await http.get(
      Uri.parse('$baseUrl/comments/$postid/getcmnt'),
      headers: {
        "Content-Type": "application/json",
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final responseData = response.body;

      if (responseData.isNotEmpty) {
        String utf8Data = utf8.decode(responseData.runes.toList());
        ApiReponse<List<CommentEntity>> listPost =
        ApiReponse<List<CommentEntity>>.fromJson(
          utf8Data,
              (dynamic json) =>
          List<CommentEntity>.from(json.map((x) => CommentEntity.fromJson(x))),
        );
        return listPost.payload;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  static Future<List<CommentResponse>?> getAllMyComment(int userid,
      String token) async {
    final response = await http.get(
      Uri.parse('$baseUrl/comments/$userid/getAllComment'),
      headers: {
        "Content-Type": "application/json",
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final responseData = response.body;

      if (responseData.isNotEmpty) {
        String utf8Data = utf8.decode(responseData.runes.toList());
        ApiReponse<List<CommentResponse>> listPost =
        ApiReponse<List<CommentResponse>>.fromJson(
          utf8Data,
              (dynamic json) =>
          List<CommentResponse>.from(
              json.map((x) => CommentResponse.fromJson(x))),
        );
        return listPost.payload;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  static Future<List<CommentResponse>?> getAllCommentClasses(int userid,
      String token, int pagenumber) async {
    final response = await http.get(
      Uri.parse('$baseUrl/comments/classes/$userid/getAllComment/$pagenumber'),
      headers: {
        "Content-Type": "application/json",
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final responseData = response.body;

      if (responseData.isNotEmpty) {
        String utf8Data = utf8.decode(responseData.runes.toList());
        ApiReponse<List<CommentResponse>> listPost =
        ApiReponse<List<CommentResponse>>.fromJson(
          utf8Data,
              (dynamic json) =>
          List<CommentResponse>.from(
              json.map((x) => CommentResponse.fromJson(x))),
        );
        return listPost.payload;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  static Future<List<CommentResponse>?> getAllCommentByMe(int userid,
      String token, int pagenumber) async {
    final response = await http.get(
      Uri.parse('$baseUrl/comments/group/$userid/getAllComment/$pagenumber'),
      headers: {
        "Content-Type": "application/json",
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final responseData = response.body;

      if (responseData.isNotEmpty) {
        String utf8Data = utf8.decode(responseData.runes.toList());
        ApiReponse<List<CommentResponse>> listPost =
        ApiReponse<List<CommentResponse>>.fromJson(
          utf8Data,
              (dynamic json) =>
          List<CommentResponse>.from(
              json.map((x) => CommentResponse.fromJson(x))),
        );
        return listPost.payload;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  static Future<List<InteractionResponse>?> getAllMyLike(int userid,
      String token) async {
    final response = await http.get(
      Uri.parse('$baseUrl/interations/$userid/activity'),
      headers: {
        "Content-Type": "application/json",
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final responseData = response.body;

      if (responseData.isNotEmpty) {
        String utf8Data = utf8.decode(responseData.runes.toList());
        ApiReponse<List<InteractionResponse>> listPost =
        ApiReponse<List<InteractionResponse>>.fromJson(
          utf8Data,
              (dynamic json) =>
          List<InteractionResponse>.from(
              json.map((x) => InteractionResponse.fromJson(x))),
        );
        return listPost.payload;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  static Future<List<PostModel>?> LoadPostOfGroup(int groupid, int page,
      int userid, String token) async {
    final response = await http.get(
      Uri.parse('$baseUrl/group/$groupid/allpost?page=$page&userid=$userid'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final responseData = response.body;

      if (responseData.isNotEmpty) {
        String utf8Data = utf8.decode(responseData.runes.toList());
        ApiReponse<List<PostModel>> listPost =
        ApiReponse<List<PostModel>>.fromJson(
          utf8Data,
              (dynamic json) =>
          List<PostModel>.from(json.map((x) => PostModel.fromJson(x))),
        );
        return listPost.payload;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  static Future<List<UserProgress>?> LoadTeacherProgress(int groupid, int page,
      int userid, String token) async {
    final response = await http.get(
      Uri.parse('$baseUrl/group/$groupid/loadProgress/$userid'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final responseData = response.body;

      if (responseData.isNotEmpty) {
        String utf8Data = utf8.decode(responseData.runes.toList());
        ApiReponse<List<UserProgress>> listPost =
        ApiReponse<List<UserProgress>>.fromJson(
          utf8Data,
              (dynamic json) =>
          List<UserProgress>.from(json.map((x) => UserProgress.fromJson(x))),
        );
        return listPost.payload;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }
  static Future<List<UserProgress>?> LoadTeacherSectorProgress(int groupid, int sectorid, int page,
      int userid, String token) async {
    final response = await http.get(
      Uri.parse('$baseUrl/group/$groupid/$sectorid/loadProgress/$userid'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final responseData = response.body;

      if (responseData.isNotEmpty) {
        String utf8Data = utf8.decode(responseData.runes.toList());
        ApiReponse<List<UserProgress>> listPost =
        ApiReponse<List<UserProgress>>.fromJson(
          utf8Data,
              (dynamic json) =>
          List<UserProgress>.from(json.map((x) => UserProgress.fromJson(x))),
        );
        return listPost.payload;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }


  static Future<CommentEntity?> setAnswer(int cmt, String token) async {
    final url = Uri.parse('$baseUrl/comments/setAnswer/$cmt');
    final headers = {
      "Content-Type": "application/json",
      'Authorization': 'Bearer $token',
    };
    final response = await http.put(
        url,
        headers: headers
    );

    if (response.statusCode == 200) {
      final responseData = response.body;

      if (responseData.isNotEmpty) {
        String utf8Data = utf8.decode(responseData.runes.toList());
        ApiReponse<CommentEntity> group = ApiReponse<CommentEntity>.fromJson(
          utf8Data,
              (dynamic json) => CommentEntity.fromJson(json),
        );
        return group.payload;
      }
      else
        return null;
    } else {
      // Handle error scenarios here
      return null;
    }
  }


  static Future<CommentEntity?> setAnswerToCmt(int cmt, String token) async {
    final url = Uri.parse('$baseUrl/comments/setAnswerToCmt/$cmt');
    final headers = {
      "Content-Type": "application/json",
      'Authorization': 'Bearer $token',
    };
    final response = await http.put(
        url,
        headers: headers
    );

    if (response.statusCode == 200) {
      final responseData = response.body;

      if (responseData.isNotEmpty) {
        String utf8Data = utf8.decode(responseData.runes.toList());
        ApiReponse<CommentEntity> group = ApiReponse<CommentEntity>.fromJson(
          utf8Data,
              (dynamic json) => CommentEntity.fromJson(json),
        );
        return group.payload;
      }
      else
        return null;
    } else {
      // Handle error scenarios here
      return null;
    }
  }

  static Future<void> deleteComment(int cmt, String token) async {
    final url = Uri.parse('$baseUrl/comments/$cmt');
    final headers = {
      "Content-Type": "application/json",
      'Authorization': 'Bearer $token',
    };
    await http.delete(
        url,
        headers: headers
    );
  }

  static Future<String?> reportPost(int iduser, int? idpost, String reason,
      String token) async {
    final url = Uri.parse('$baseUrl/report/posts/$idpost');
    final headers = {
      "Content-Type": "application/json",
      'Authorization': 'Bearer $token',
    };

    final Map<String, dynamic> data = {
      "createById": iduser,
      "content_report": reason,
    };

    final response = await http.post(
      url,
      headers: headers,
      body: jsonEncode(data),
    );
    if (response.statusCode == 200) {
      final responseData = response.body;

      if (responseData.isNotEmpty) {
        Map<String, dynamic> data = jsonDecode(responseData);
        String payload = data['payload'];

        return payload;
      } else {
        return null;
      }
    } else {
      return null;
    }

  }

  static Future<ReportPostResponse?> DuyetPost(int idreport, String token) async {
    final url = Uri.parse('$baseUrl/report/${idreport}/duyet');
    final headers = {
      "Content-Type": "application/json",
      'Authorization': 'Bearer $token',
    };
    final response = await http.put(
        url,
        headers: headers
    );

    if (response.statusCode == 200) {
      final responseData = response.body;

      if (responseData.isNotEmpty) {
        String utf8Data = utf8.decode(responseData.runes.toList());
        ApiReponse<ReportPostResponse> group = ApiReponse<ReportPostResponse>.fromJson(
          utf8Data,
              (dynamic json) => ReportPostResponse.fromJson(json),
        );
        return group.payload;
      }
      else
        return null;
    } else {
      // Handle error scenarios here
      return null;
    }
  }
  static Future<void> PhanCongPost(int idpost, int iduser, int sectorid, String token) async {
    final url = Uri.parse('$baseUrl/post/$idpost/phancong/$sectorid/$iduser');
    final headers = {
      "Content-Type": "application/json",
      'Authorization': 'Bearer $token',
    };
    final response = await http.put(
        url,
        headers: headers
    );
    int a = 0;
  }
  static Future<ReportPostResponse?> CamPost(int idreport, String token) async {
    final url = Uri.parse('$baseUrl/report/${idreport}/cam');
    final headers = {
      "Content-Type": "application/json",
      'Authorization': 'Bearer $token',
    };
    final response = await http.put(
        url,
        headers: headers
    );

    if (response.statusCode == 200) {
      final responseData = response.body;

      if (responseData.isNotEmpty) {
        String utf8Data = utf8.decode(responseData.runes.toList());
        ApiReponse<ReportPostResponse> group = ApiReponse<ReportPostResponse>.fromJson(
          utf8Data,
              (dynamic json) => ReportPostResponse.fromJson(json),
        );
        return group.payload;
      }
      else
        return null;
    } else {
      // Handle error scenarios here
      return null;
    }
  }
  static Future<bool> NotSectorMe(int postid, String token) async {
    final url = Uri.parse('$baseUrl/post/$postid/notSectorMe');
    final headers = {
      "Content-Type": "application/json",
      'Authorization': 'Bearer $token',
    };
    final response = await http.put(
        url,
        headers: headers
    );

    if (response.statusCode == 200) {
        return true;
    } else {
      // Handle error scenarios here
      return false;
    }
  }
}