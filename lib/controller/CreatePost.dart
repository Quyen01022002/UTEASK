import 'package:askute/controller/HomeGroupController.dart';
import 'package:askute/model/Class.dart';
import 'package:askute/model/PostEnity.dart';
import 'package:askute/model/PostModel.dart';
import 'package:askute/model/SectorResponse.dart';
import 'package:askute/service/API_Class.dart';
import 'package:askute/service/API_Group.dart';
import 'package:askute/service/API_Post.dart';
import 'package:askute/view/Quetions/createQuetions.dart';
import 'package:askute/view/dashboard/DashBoard_new.dart';
import 'package:askute/view/teacher/Home/Class/ClassDetailTeacher.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/GroupModel.dart';
import '../view/dashboard/DashBoard.dart';

class CreatePostController extends GetxController {
  HomeGroupController homeGroupController = Get.put(HomeGroupController());
  final textControllerContent = TextEditingController();
  RxList<GroupModel> deliverGroup = List<GroupModel>.empty(growable: true).obs;
  RxList<String> imagePaths = <String>[].obs;
  final contentpost = RxString('');
  RxList<SectorResponse> listSt = List<SectorResponse>.empty(growable: true).obs;
  void createpost(BuildContext context, String statusView, String statusCmt) async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt('id') ?? 0;

    PostEntity userEnity = PostEntity(
        user_id: userId,
        content_post: textControllerContent.text,
        timestamp: DateTime.now(),
        status: true);
    final token = prefs.getString('token') ?? "";
    await API_Post.post(userEnity, imagePaths.value, token, 0, 1, statusView,statusCmt,true);
    await Future.delayed(Duration(milliseconds: 100), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => DashBoardVer2()),
      );
    });
    Navigator.of(context).pop();
  }

  Future<String> createpostGroup(BuildContext context, int id, int sector, String sttview, String sttcmt) async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt('id') ?? 0;

    PostEntity userEnity = PostEntity(
        user_id: userId,
        content_post: textControllerContent.text,
        timestamp: DateTime.now(),
        status: true,);
    final token = prefs.getString('token') ?? "";
    String? rules=await API_Post.CommunicateRules(textControllerContent.text);
    print(rules);
    if(rules=="VP")
      {
        final adminId = prefs.getInt('id') ?? 0;
        final token = prefs.getString('token') ?? "";
        String reason2 = "Vi phạm quy tắc cộng đồng";
        PostEntity? postEntity =await API_Post.post(userEnity, imagePaths.value, token, id, sector, sttview, sttcmt,false);
        if (postEntity != null) {
          await API_Post.reportPost(adminId, postEntity.post_id, reason2, token);
        } else {
          print('Failed to create post');
        }
        return "VP";
      }
    else
      {
        await API_Post.post(userEnity, imagePaths.value, token, id, sector, sttview, sttcmt,true);
        update();
        Navigator.of(context).pop();

        await Future.delayed(Duration(milliseconds: 100), () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => DashBoardVer2()),
          );
        });
        print("HL");
        return "HL";
      }
  }

  void DeliverKhoa(BuildContext context, String content) async {
    final prefs = await SharedPreferences.getInstance();
    String? key = await API_Post.DeliverKhoa(content);
    final token = prefs.getString('token') ?? "";
    List<GroupModel>? result= await API_Group.searchGroup(token, key!);
    if(result != null)
      {

        final list = await API_Group.getListSector(result[0].id!, token);
        if(list!.length != 0)
        {listSt.clear();
        listSt.addAll(list!);}
        else
          listSt.value = [];
        deliverGroup.clear();
        deliverGroup.addAll(result);
        update();

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
        status: true);
    final token = prefs.getString('token') ?? "";
    await API_Post.postClass(userEnity, imagePaths.value, token, id, context);
  }
  void createHotPost(BuildContext context, int groupid, int hotday) async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt('id') ?? 0;

    PostEntity userEnity = PostEntity(
        user_id: userId,
        content_post: textControllerContent.text,
        timestamp: DateTime.now(),
        status: true);
    final token = prefs.getString('token') ?? "";
    await API_Post.postHotPost(userEnity, imagePaths.value, token, groupid, hotday, context);
  }

  void updatePost(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt('id') ?? 0;

    PostEntity userEnity = PostEntity(
        user_id: userId,
        content_post: textControllerContent.text,
        timestamp: DateTime.now(),
        status: true);
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

  Future<List<SectorResponse>?> loadSector(BuildContext context, int grid) async
  {
    try {
      final prefs = await SharedPreferences.getInstance();
      final adminId = prefs.getInt('id') ?? 0;
      final token = prefs.getString('token') ?? "";

      final rs = await API_Group.getListSector(grid, token);
      if (rs!=null)
        {
          listSt.clear();
          listSt.addAll(rs);
        }
      return rs;

    }
    finally {

    }
  }
}
