import 'dart:async';
import 'dart:convert';
import 'dart:ffi';

import 'package:askute/model/ApiReponse.dart';
import 'package:askute/model/PostEnity.dart';
import 'package:askute/model/PostModel.dart';
import 'package:askute/service/const.dart';
import 'package:http/http.dart' as http;


class API_Post {
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
      PostEntity post, List<String> img, String token,int groupId) async {
    final url = Uri.parse('$baseUrl/post/post');

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
    };

    await http.post(
      url,
      headers: headers,
      body: jsonEncode(data),
    );
  }
  static Future<PostEntity?> upatePost(
      PostEntity post, List<String> img, String token) async {
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

  // static Future<InteractionsEntity?> Liked(String token, int postid,int userId) async {
  //   final url = Uri.parse('$baseUrl/interations?post=$postid&user=$userId');
  //   final headers = {
  //     "Content-Type": "application/json",
  //     'Authorization': 'Bearer $token',
  //   };
  //
  //   await http.post(
  //     url,
  //     headers: headers,
  //   );
  //
  // }
  //
  // static Future<CommentEntity?> Comments(
  //     int userid, int postid, String content) async {
  //   final url = Uri.parse('$baseUrl/comments');
  //   final headers = {"Content-Type": "application/json"};
  //   final Map<String, dynamic> data = {
  //     "user_id": userid,
  //     "post_id": postid,
  //     "content_post": content,
  //     "timestamp": DateTime.now().toIso8601String()
  //   };
  //
  //   final response = await http.post(
  //     url,
  //     headers: headers,
  //     body: jsonEncode(data),
  //   );
  //
  //   if (response.statusCode == 200) {
  //     final responseData = response.body;
  //
  //     if (responseData.isNotEmpty) {
  //       CommentEntity listPost =
  //           CommentEntity.fromJson(json.decode(responseData));
  //       return listPost;
  //     } else {
  //       return null;
  //     }
  //   } else {
  //     return null;
  //   }
  // }
  // static void deletePost(int? postid, String token) async {
  //   await http.delete(
  //     Uri.parse('$baseUrl/post/$postid'),
  //     headers: {
  //       'Authorization': 'Bearer $token',
  //     },
  //   );
  //
  //
  // }
}
