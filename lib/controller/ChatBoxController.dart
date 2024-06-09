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


  Future<String?> chatBot(BuildContext context,String questions) async {

    List<BotReponse>? botReponse=await API_ChatBot.questions(questions);
    print(botReponse);
    if(botReponse!.isNotEmpty&&botReponse!.length==1)
      {
        return botReponse[0].text;
      }
    else
      {
        return "Xin lỗi tôi không hiểu câu hỏi của bạn";
      }


  }


}
