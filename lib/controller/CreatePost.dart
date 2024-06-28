import 'package:askute/model/Class.dart';
import 'package:askute/model/PostEnity.dart';
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

class CreatePostController extends GetxController {
  final textControllerContent = TextEditingController();
  RxList<GroupModel> deliverGroup = List<GroupModel>.empty(growable: true).obs;
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
    await API_Post.post(userEnity, imagePaths.value, token, 0);

    Future.delayed(Duration(milliseconds: 100), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => DashBoard()),
      );
    });
  }

  Future<String> createpostGroup(BuildContext context, int id) async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt('id') ?? 0;

    PostEntity userEnity = PostEntity(
        user_id: userId,
        content_post: textControllerContent.text,
        timestamp: DateTime.now(),
        status: "");
    final token = prefs.getString('token') ?? "";
    String? rules=await API_Post.CommunicateRules(textControllerContent.text);
    print(rules);
    if(rules=="VP")
      {
        final adminId = prefs.getInt('id') ?? 0;
        final token = prefs.getString('token') ?? "";
        String reason2 = "Vi phạm quy tắc cộng đồng";
        PostEntity? postEntity = await API_Post.post(userEnity, imagePaths.value, token, id);

        if (postEntity != null) {
          await API_Post.reportPost(adminId, postEntity.post_id, reason2, token);
        } else {
          // Handle the case where postEntity is null
          print('Failed to create post');
        }

        return "VP";
      }
    else
      {
        await API_Post.post(userEnity, imagePaths.value, token, id);
        Future.delayed(Duration(milliseconds: 100), () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => DashBoardVer2()),
          );
        });
        print("HL");
        return "HL";
      }

  }

  void DeliverKhoa(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    String? key = await API_Post.DeliverKhoa(textControllerContent.text);
    final token = prefs.getString('token') ?? "";
    List<GroupModel>? result= await API_Group.searchGroup(token, key!);
    if(result != null)
      {
        deliverGroup.addAll(result);
      }
    print("Controlelr");
  }

  void createpostClass(BuildContext context, int id, ClassModel classes) async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt('id') ?? 0;

    PostEntity userEnity = PostEntity(
        user_id: userId,
        content_post: textControllerContent.text,
        timestamp: DateTime.now(),
        status: "");
    final token = prefs.getString('token') ?? "";
    await API_Post.postClass(userEnity, imagePaths.value, token, id, context);
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
    await API_Post.upatePost(userEnity, imagePaths.value, token);

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
