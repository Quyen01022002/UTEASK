import 'dart:async';
import 'dart:convert';

import 'package:askute/service/const.dart';
import 'package:http/http.dart' as http;



import '../model/ApiReponse.dart';
import '../model/UserProfile.dart';
import '../model/UsersEnity.dart';
class API_Search
{

  static Future<List<UserEnity>?> Search( int userId,String key,String token) async {
    final response = await http.get(
      Uri.parse('$baseUrl/user/search/$userId?key=$key'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final responseData = response.body;

      if (responseData.isNotEmpty) {
        String utf8Data = utf8.decode(responseData.runes.toList());
        ApiReponse<List<UserEnity>> listPost = ApiReponse<List<UserEnity>>.fromJson(
          utf8Data,
              (dynamic json) => List<UserEnity>.from(json.map((x) => UserEnity.fromJson(x))),
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