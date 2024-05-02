import 'package:askute/model/Class.dart';
import 'package:askute/model/PostEnity.dart';
import 'package:askute/service/API_Class.dart';
import 'package:askute/service/API_Post.dart';
import 'package:askute/view/dashboard/DashBoard_new.dart';
import 'package:askute/view/teacher/Home/Class/ClassDetailTeacher.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../view/dashboard/DashBoard.dart';

class CreatePostController extends GetxController {
  final textControllerContent = TextEditingController();
  RxList<String> imagePaths = <String>[].obs;
  final contentpost = RxString('');

  void createpost(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt('id') ?? 0;

    PostEntity userEnity = PostEntity(
        user_id: userId,
        content_post: textControllerContent.text,
        timestamp: DateTime.now(),
        status: "");
    final token = prefs.getString('token') ?? "";
   await API_Post.post(userEnity,imagePaths.value,token,0);

    Future.delayed(Duration(milliseconds: 100), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => DashBoard()),
      );
    });
  }
  void createpostGroup(BuildContext context,int id) async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt('id') ?? 0;

    PostEntity userEnity = PostEntity(
        user_id: userId,
        content_post: textControllerContent.text,
        timestamp: DateTime.now(),
        status: "");
    final token = prefs.getString('token') ?? "";
    await API_Post.post(userEnity,imagePaths.value,token,id);

    Future.delayed(Duration(milliseconds: 100), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => DashBoardVer2()),
      );
    });
  } void createpostClass(BuildContext context,int id,ClassModel classes) async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt('id') ?? 0;

    PostEntity userEnity = PostEntity(
        user_id: userId,
        content_post: textControllerContent.text,
        timestamp: DateTime.now(),
        status: "");
    final token = prefs.getString('token') ?? "";
    await API_Post.postClass(userEnity,imagePaths.value,token,id,context);

  }
  void updatePost(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt('id') ?? 0;

    PostEntity userEnity = PostEntity(
        user_id: userId,
        content_post: textControllerContent.text,
        timestamp: DateTime.now(),
        status: "");
    final token = prefs.getString('token') ?? "";
   await API_Post.upatePost(userEnity,imagePaths.value,token);

    Future.delayed(Duration(milliseconds: 100), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => DashBoard()),
      );
    });
  }
  void delete(int? postId) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? "";
   // API_Post.deletePost(postId, token);
  }
}
