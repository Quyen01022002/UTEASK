import 'dart:convert';

import 'package:http/http.dart' as http;

import '../model/AuthenticationResponse.dart';
import 'const.dart';

class API_dangky {
  static Future<AuthenticationResponse?> DangKy(String email, String password,
      String phone) async {
    final url = Uri.parse('$baseUrl/media/register');

    final headers = {"Content-Type": "application/json"};

// Tạo một Map chứa dữ liệu người dùng
    final data = {
      "email": email,
      "phone": phone,
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
        final AuthenticationResponse2 = AuthenticationResponse.fromJson(
            json.decode(responseData));
        return AuthenticationResponse2;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  static Future<String> OTP(String email) async {
    final url = Uri.parse('$baseUrl/media/sendEmail?email=$email');
    final response = await http.get(
      url,

    );
    if (response.statusCode == 200) {
      final responseData = response.body;

      if (responseData.isNotEmpty) {
        final String OTP = json.decode(responseData).toString();
        return OTP;
      } else {
        return "Fail";
      }
    } else {
      return "Fail";
    }
  }

  static Future<String?> UpdateFisrt(String token,String firstName,String lastName,String Address,String date,String gender,int id) async {
    final url = Uri.parse('$baseUrl/user/$id');

    final headers = {
    "Content-Type": "application/json",
    'Authorization': 'Bearer $token',};

// Tạo một Map chứa dữ liệu người dùng
    final data = {
    "firstName":firstName,
    "lastName":lastName,
    "address": Address,
    "DoB": date,
    "gender": gender,

    };

    final response = await http.put(
    url,
    headers: headers,
    body: jsonEncode(data),
    );

    if (response.statusCode == 200) {

    return "Success";
    } else {
    return null;
    }
    }
  }
