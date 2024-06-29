import 'package:askute/model/BotReponse.dart';
import 'package:askute/model/Class.dart';
import 'package:askute/model/PostEnity.dart';
import 'package:askute/service/API_ChatBot.dart';
import 'package:askute/service/API_Class.dart';
import 'package:askute/service/API_Group.dart';
import 'package:askute/service/API_Post.dart';
import 'package:askute/view/dashboard/DashBoard_new.dart';
import 'package:askute/view/teacher/Home/Class/ClassDetailTeacher.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/GroupModel.dart';
import '../view/dashboard/DashBoard.dart';

class ChatBoxController extends GetxController {


  Future<List<String>?> chatBot(BuildContext context,String questions) async {

    List<BotResponse>? botReponse = await API_ChatBot.questions(questions);
    List<String> listReponse = [];

    if (botReponse != null && botReponse.isNotEmpty) {
      // Collect all text fields from the list of responses
      listReponse.addAll(botReponse.map((response) => response.text ?? '').toList());

      // If you need to handle the case where only one response is expected
      if (botReponse.length == 1) {
        // Returning a list even if there's only one response for consistency
        return listReponse;
      } else {
        // Handle multiple responses as needed
        return listReponse;
      }
    } else {
      return ["Xin lỗi tôi không hiểu câu hỏi của bạn"];
    }

  }


}
