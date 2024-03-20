import 'dart:async';
import 'dart:convert';
import 'dart:ffi';

import 'package:askute/model/ApiReponse.dart';
import 'package:askute/model/NoticationsModel.dart';
import 'package:askute/service/const.dart';
import 'package:http/http.dart' as http;


class API_Notications {
  static Future<List<NoticationsModel>?> LoadNotications(int userid, String token) async {
    final response = await http.get(
      Uri.parse('$baseUrl/notifications/$userid'),
      headers: {
        'Authorization': 'Bearer $token',
        'Accept-Charset': 'UTF-8',
      },
    );

    if (response.statusCode == 200) {
      final responseData = response.body;

      if (responseData.isNotEmpty) {
        String utf8Data = utf8.decode(responseData.runes.toList());
        ApiReponse<List<NoticationsModel>> listPost =
            ApiReponse<List<NoticationsModel>>.fromJson(
              utf8Data,
          (dynamic json) =>
              List<NoticationsModel>.from(json.map((x) => NoticationsModel.fromJson(x))),
        );
        return listPost.payload;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }
  static Future<List<NoticationsModel>?> LoadNoticationsRead(int userid, String token) async {
    final response = await http.get(
      Uri.parse('$baseUrl/notifications/reads/$userid'),
      headers: {
        'Authorization': 'Bearer $token',
        'Accept-Charset': 'UTF-8',
      },
    );

    if (response.statusCode == 200) {
      final responseData = response.body;

      if (responseData.isNotEmpty) {
        String utf8Data = utf8.decode(responseData.runes.toList());

        ApiReponse<List<NoticationsModel>> listPost =
        ApiReponse<List<NoticationsModel>>.fromJson(
          utf8Data,
              (dynamic json) => List<NoticationsModel>.from(
              json.map((x) => NoticationsModel.fromJson(x))),
        );

        return listPost.payload;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }
  static void readNotification(int? notiId, String token) async {
    await http.post(
      Uri.parse('$baseUrl/notifications/read/$notiId'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );


  }
}
