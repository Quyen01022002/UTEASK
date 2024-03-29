import 'dart:async';
import 'dart:convert';
import 'dart:ffi';

import 'package:askute/model/ApiReponse.dart';
import 'package:askute/model/PostEnity.dart';
import 'package:askute/model/PostModel.dart';
import 'package:askute/service/const.dart';
import 'package:http/http.dart' as http;

import '../model/CommentEntity.dart';
import '../model/InteractionsEntity.dart';

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
      PostEntity post, List<String> img, String token, int groupId) async {
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

  static Future<InteractionsEntity?> Liked(
      String token, int postid, int userId) async {
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

  static Future<CommentEntity?> Comments(
      int userid, int postid, String content, String token) async {
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

  static void deletePost(int? postid, String token) async {
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

  static Future<PostModel?> getOnePost(int id, String token) async {
    final url = Uri.parse('$baseUrl/post/$id');

    final response = await http.get(
      Uri.parse('$baseUrl/post/$id'),
      headers: {
        "Content-Type": "application/json",
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
        return listPost.payload[0];
      } else {
        return null;
      }
    } else {
      return null;
    }}

  static Future<List<CommentEntity>?> getAllComment(int postid, String token) async {
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
          List<CommentEntity>.from(json.map((x) =>CommentEntity.fromJson(x))),
        );
        return listPost.payload;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }
}
