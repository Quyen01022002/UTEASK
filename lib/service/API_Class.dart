

import 'dart:convert';

import 'package:askute/model/ApiReponse.dart';
import 'package:askute/model/ClassMemberRequest.dart';
import 'package:askute/model/GroupMemberRequest.dart';
import 'package:askute/model/Class.dart';
import 'package:askute/model/PostModel.dart';
import 'package:askute/model/UsersEnity.dart';
import 'package:askute/service/const.dart';
import 'package:askute/view/teacher/Home/Class/ClassDetailTeacher.dart';
import 'package:askute/view/teacher/Home/homePageTeacher.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:page_transition/page_transition.dart';


class API_Class{

  static Future<ClassModel?> addGroup(ClassModel newModel, int id, String token) async{
    final url = Uri.parse('$baseUrl/class/');
    final headers = {
      "Content-Type": "application/json",
      'Authorization': 'Bearer $token',
    };
    final Map<String, dynamic> data = {
      "name": newModel.name,
      "description": newModel.description,
      "groups":newModel.groups,
      "avatar":newModel.avatar,
      "backavatar":newModel.backAvatar
    };
    final response = await http.post(
      url,
      headers: headers,
      body: jsonEncode(data),
    );
    if (response.statusCode == 200) {
      final responseData = response.body;

      if (responseData.isNotEmpty){
        ApiReponse<ClassModel> group = ApiReponse<ClassModel>.fromJson(
          responseData,
              (dynamic json) => ClassModel.fromJson(json),
        );
        return group.payload;
      }
      else
        return null;
    } else {
      // Handle error scenarios here
      return null;
    }


  }
  static Future<List<ClassModel>?> getAllGroups(String token,int id) async {
    final url = Uri.parse('$baseUrl/class/teacher/$id');
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
        ApiReponse<List<ClassModel>> listgroup = ApiReponse<List<ClassModel>>.fromJson(utf8Data, (dynamic json) => List<ClassModel>.from(json.map((x) => ClassModel.fromJson(x))),
        );
        return listgroup.payload;
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
  static Future<String> updateAvatar(int? userid,String token,String Avatar) async {
    final url = Uri.parse('$baseUrl/class/$userid');

    final headers = {
      "Content-Type": "application/json",
      'Authorization': 'Bearer $token',};

// Tạo một Map chứa dữ liệu người dùng
    final data = {
      "avatar":Avatar,

    };

    await http.patch(
      url,
      headers: headers,
      body: jsonEncode(data),
    );
    return "Success";
  }
  static Future<List<ClassModel>?> getMembersClass(String token,int id) async {
    final url = Uri.parse('$baseUrl/class/members/$id');
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
        ApiReponse<List<ClassModel>> listgroup = ApiReponse<List<ClassModel>>.fromJson(utf8Data, (dynamic json) => List<ClassModel>.from(json.map((x) => ClassModel.fromJson(x))),
        );
        return listgroup.payload;
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
  static Future<ClassModel?> addMembersToGroup(String token, List<ClassMemberRequest> members,int? classID,BuildContext context) async{
    final url = Uri.parse('$baseUrl/class/addMembers');
    final headers = {
      "Content-Type": "application/json",
      'Authorization': 'Bearer $token',
    };

    List<Map<String, dynamic>> data = members.map((member) {
      print(member.user);
      print(member.classes);
      return {
        "user": member.user,
        "classes": member.classes
      };
    }).toList();
    await http.post(
      url,
      headers: headers,
      body: jsonEncode(data),
    );
    final ClassModel? classModel = await getClassById(classID, token);
    if (classModel != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DefaultTabController(
            initialIndex: 2,
            length: 3,
            child: ClassDetailTeacher(classes: classModel),
          ),
        ),
      );

    } else {
      // Handle the case where classModel is null
    }

  }
  static Future<ClassModel?> getClassById(int? groupId, String token) async {
    final url = Uri.parse('$baseUrl/class/$groupId'); // Endpoint to fetch a specific group by ID
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
        ApiReponse<ClassModel> group = ApiReponse<ClassModel>.fromJson(
          utf8Data,
              (dynamic json) => ClassModel.fromJson(json),
        );
        return group.payload;
      }
      else
        return null;
    } else {
      // Handle error scenarios here
      return null;
    }
  }
  static Future<void> deleteMemberOutClassById(int classMemberId,int? classID ,String token,BuildContext context) async {

    final url = Uri.parse('$baseUrl/class/members/$classMemberId');
    final headers = {
      "Content-Type": "application/json",
      'Authorization': 'Bearer $token',
    };
    await http.delete(
      url,
      headers: headers,
    );

    final ClassModel? classModel = await getClassById(classID, token);
    if (classModel != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DefaultTabController(
            initialIndex: 2,
            length: 3,
            child: ClassDetailTeacher(classes: classModel),
          ),
        ),
      );

    } else {
      // Handle the case where classModel is null
    }

  }
}
