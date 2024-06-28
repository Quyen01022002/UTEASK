import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/BotReponse.dart';

class API_ChatBot {
  static Future<List<BotReponse>> questions(String question) async {
    final response = await http.post(
      Uri.parse('http://192.168.230.92:5002/webhook'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({"message": question}),
    );

    if (response.statusCode == 200) {
      final responseData = response.body;
      if (responseData.isNotEmpty) {
        final List<dynamic> jsonData = jsonDecode(responseData);
        // Ensure to handle the response if it's a list
        return jsonData.map((json) => BotReponse.fromJson(json)).toList();
      } else {
        return [];
      }
    } else {
      throw Exception('Failed to load messages');
    }
  }
}
