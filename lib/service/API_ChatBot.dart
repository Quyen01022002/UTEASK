import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/BotReponse.dart';

class API_ChatBot {
  static Future<List<BotResponse>> questions(String question) async {
    final response = await http.post(
      Uri.parse('http://192.168.60.92:5002/webhook'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({"message": question}),
    );

    if (response.statusCode == 200) {
      final responseData = response.body;
      if (responseData.isNotEmpty) {
        final List<dynamic> jsonData = jsonDecode(responseData);
        // Convert JSON list to List<BotResponse>
        return BotResponse.listFromJson(jsonData);
      } else {
        return []; // Return empty list if response data is empty
      }
    } else {
      throw Exception('Failed to load messages');
    }
  }
}
