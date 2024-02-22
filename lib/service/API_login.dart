import 'dart:async';
import 'dart:convert';

import 'package:askute/model/AuthenticationResponse.dart';
import 'package:http/http.dart' as http;

import 'const.dart';

class API_login
{

  static Future<AuthenticationResponse?> Login(String email, String password) async {
    final url = Uri.parse('$baseUrl/media/authenticate');

    final headers = {"Content-Type": "application/json"};

// Tạo một Map chứa dữ liệu người dùng
    final data = {
      "email":email,
      "password": password,
    };

    final response = await http.post(
      url,
      headers: headers,
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      final responseData = response.body;

      if (responseData.isNotEmpty) {
        final AuthenticationResponse2 = AuthenticationResponse.fromJson(json.decode(responseData));
        return AuthenticationResponse2;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }
  static void fcm(int? userid,String token,String fcm) async {
    final url = Uri.parse('$baseUrl/user/fcm/$userid');

    final headers = {
      "Content-Type": "application/json",
      'Authorization': 'Bearer $token',};

// Tạo một Map chứa dữ liệu người dùng
    final data = {
      "fcm":fcm,

    };

    await http.patch(
      url,
      headers: headers,
      body: jsonEncode(data),
    );

  }


}