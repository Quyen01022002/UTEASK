import 'package:askute/model/ClassMemberRequest.dart';
import 'package:askute/model/UsersEnity.dart';
import 'package:askute/service/API_Class.dart';
import 'package:askute/service/API_Search.dart';
import 'package:askute/view/teacher/Home/Class/ClassDetailTeacher.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';



class Search_Controller extends GetxController {
  RxList<UserEnity> listUser = List<UserEnity>.empty(growable: true).obs;
  final textControllerContent = TextEditingController();

  void loadUser() async {
    print("Loading posts...");
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt('id') ?? 0;
    final token = prefs.getString('token') ?? "";
    List<UserEnity>? result = await API_Search.Search(userId, textControllerContent.text,token);
    if (result != null) {
      listUser.clear();
      listUser.addAll(result);
      print("Updated listPost: $listUser");
      update();
    } else {
      listUser.clear();
      update();
    }
    listUser.refresh();
  }
  Future<void> addMembers(BuildContext context,List<UserEnity> list,int? classId) async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt('id') ?? 0;
    final token = prefs.getString('token') ?? "";
    List<ClassMemberRequest>? members = [];
    list.forEach((element) {
      ClassMemberRequest groupMemberRequest =
      ClassMemberRequest(user: element.user_id, classes: classId);
      members.add(groupMemberRequest);
    });


    await API_Class.addMembersToGroup(token, members,classId,context);
  }

}
