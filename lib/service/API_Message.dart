
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import '../model/ApiReponse.dart';
import '../model/MessageBoxResponse.dart';
import '../model/MessageModel.dart';
import 'const.dart';

class API_Message{
  static Future<MessageModel?> createMessage(String token, String content ,int? message) async{
    final url = Uri.parse('$baseUrl/message/add');
    final headers = {
      "Content-Type": "application/json",
      'Authorization': 'Bearer $token',
    };
    final Map<String, dynamic> data = {
      "content": content,
      "messageBox": message,
    };
    final response = await http.post(
        url,
        headers: headers,
        body: jsonEncode(data)
    );
    if (response.statusCode == 200) {
      final responseData = response.body;
      if (responseData.isNotEmpty){
        ApiReponse<MessageModel> listMessage =
        ApiReponse<MessageModel>.fromJson(responseData,
              (dynamic json) =>
              MessageModel.fromJson(json),);
        return listMessage.payload;
      }
      else
      {
        return null;
      }
    } else {
      // Handle error scenarios here
      return null;
    }


  }
  static Future<MessageBoxResponse?> createMessageSingle(String token, String name ,String? avatar,int myId, int? otherId) async{
    final url = Uri.parse('$baseUrl/message/single?id1=$myId&id=$otherId');
    final headers = {
      "Content-Type": "application/json",
      'Authorization': 'Bearer $token',
    };
    final Map<String, dynamic> data = {
      "name": name,
      "avatar": avatar,
    };
    final response = await http.post(
        url,
        headers: headers,
        body: jsonEncode(data)
    );
    if (response.statusCode == 200) {
      final responseData = response.body;
      if (responseData.isNotEmpty){
        String utf8Data = utf8.decode(responseData.runes.toList());
        ApiReponse<MessageBoxResponse> listMessage =
        ApiReponse<MessageBoxResponse>.fromJson(utf8Data,
              (dynamic json) =>
                  MessageBoxResponse.fromJson(json),);
        return listMessage.payload;
      }
      else
      {
        return null;
      }
    } else {
      // Handle error scenarios here
      return null;
    }


  }
  //
  // static Future<MessageModel?> createFirstMessage(String token, int friendId) async{
  //   final url = Uri.parse('$baseUrl/message/firstmessage?friendshipid=$friendId');
  //   final headers = {
  //     "Content-Type": "application/json",
  //     'Authorization': 'Bearer $token',
  //   };
  //   final response = await http.post(
  //       url,
  //       headers: headers
  //   );
  //   if (response.statusCode == 200) {
  //     final responseData = response.body;
  //     if (responseData.isNotEmpty){
  //       ApiReponse<MessageModel> listMessage =
  //       ApiReponse<MessageModel>.fromJson(responseData,
  //             (dynamic json) =>
  //             MessageModel.fromJson(json),);
  //       return listMessage.payload;
  //     }
  //     else
  //     {
  //       return null;
  //     }
  //   } else {
  //     // Handle error scenarios here
  //     return null;
  //   }
  // }
  //
  static Future<List<MessageBoxResponse>?> getMessage(String token, int userId) async{
    final url = Uri.parse('$baseUrl/message/$userId');
    final headers = {
      "Content-Type": "application/json",
      'Authorization': 'Bearer $token',
    };
    final response = await http.get(
      url,
      headers: headers,
    );
    if (response.statusCode == 200) {
      final responseData = response.body;
      if (responseData.isNotEmpty){
        String utf8Data = utf8.decode(responseData.runes.toList());
        ApiReponse<List<MessageBoxResponse>> listMessage =
        ApiReponse<List<MessageBoxResponse>>.fromJson(utf8Data,
              (dynamic json) =>
          List<MessageBoxResponse>
              .from(json.map((x) =>
              MessageBoxResponse.fromJson(x))),);
        return listMessage.payload;
      }
      else
      {
        return null;
      }
    } else {
      // Handle error scenarios here
      return null;
    }

  }
  static Future<MessageBoxResponse?> getOneMessage(String token, int? messageId) async{
    final url = Uri.parse('$baseUrl/message/one/$messageId');
    final headers = {
      "Content-Type": "application/json",
      'Authorization': 'Bearer $token',
    };
    final response = await http.get(
      url,
      headers: headers,
    );
    if (response.statusCode == 200) {
      final responseData = response.body;
      if (responseData.isNotEmpty){
        String utf8Data = utf8.decode(responseData.runes.toList());
        ApiReponse<MessageBoxResponse> listMessage =
        ApiReponse<MessageBoxResponse>.fromJson(utf8Data,
              (dynamic json) =>
                  MessageBoxResponse.fromJson(json),);
        return listMessage.payload;
      }
      else
      {
        return null;
      }
    } else {
      // Handle error scenarios here
      return null;
    }


  }
  // static Future<List<MessageBoxResponse>?> getMessageBox(String token, int userId) async{
  //   final url = Uri.parse('$baseUrl/message/$userId');
  //   final headers = {
  //     "Content-Type": "application/json",
  //     'Authorization': 'Bearer $token',
  //   };
  //   final response = await http.get(
  //     url,
  //     headers: headers,
  //   );
  //   if (response.statusCode == 200) {
  //     final responseData = response.body;
  //     if (responseData.isNotEmpty){
  //       String utf8Data = utf8.decode(responseData.runes.toList());
  //       ApiReponse<List<MessageBoxResponse>> listMessage =
  //       ApiReponse<List<MessageBoxResponse>>.fromJson(utf8Data,
  //             (dynamic json) =>
  //         List<MessageBoxResponse>
  //             .from(json.map((x) =>
  //             MessageBoxResponse.fromJson(x))),);
  //       return listMessage.payload;
  //     }
  //     else
  //     {
  //       return null;
  //     }
  //   } else {
  //     // Handle error scenarios here
  //     return null;
  //   }
  //
  // }

}