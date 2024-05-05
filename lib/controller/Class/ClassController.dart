import 'package:askute/controller/HomeGroupController.dart';
import 'package:askute/model/Class.dart';
import 'package:askute/model/ClassMemberRequest.dart';
import 'package:askute/service/API_Class.dart';
import 'package:askute/view/teacher/Home/Class/ClassHomePage.dart';
import 'package:askute/view/teacher/Home/homePageTeacher.dart';
import 'package:askute/view/teacher/teacher_home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../service/API_Group.dart';

class ClassController extends GetxController{
  final textControllerMota = TextEditingController();
  final textControllerNameGroup = TextEditingController();
  final desc = RxString('');
  final nameGroup = RxString('');
  List<ClassModel>? classes = [];

  HomeGroupController homeGroupController = Get.put(HomeGroupController());
  void CreateGroup(BuildContext context,int? groups) async{
    final description = textControllerMota.text;
    final name_group = textControllerNameGroup.text;
    final prefs = await SharedPreferences.getInstance();


    ClassModel newGroup = ClassModel(
        name: name_group,
        id: 0,
        createdDate: DateTime.now(),
        description: description,
        updatedDate: DateTime.now(),
        listMembers: [],
        listPost: [],
        groups: groups,
        backAvatar: '',
        avatar: ''

    );

    final token = prefs.getString('token')??"";
    ClassModel? groupModel = await API_Class.addGroup(newGroup, token);
    Future.delayed(Duration(milliseconds: 100), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeTeacher()),
      );
    });
    //homeGroupController.GetOneGroup(context, 9);


  }


  Future<void> loadClassOfTeacher() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt('id') ?? 0;
    final token = prefs.getString('token') ?? "";
    List<ClassModel>? result = await API_Class.getAllGroups(token,userId);
    if (result != null) classes = result;
  }
  Future<void> loadClassOfMembers() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt('id') ?? 0;
    final token = prefs.getString('token') ?? "";
    List<ClassModel>? result = await API_Class.getMembersClass(token,userId);
    if (result != null) classes = result;
  }

  Future<void> deleteMemberOutGroup(BuildContext context,int idMembers,int? classID) async {
    final prefs = await SharedPreferences.getInstance();

    final token = prefs.getString('token') ?? "";


    await API_Class.deleteMemberOutClassById(idMembers, classID,token,context);
  }



}