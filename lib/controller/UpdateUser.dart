import 'package:askute/controller/MyProfileController.dart';
import 'package:askute/service/API_Profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../view/dashboard/DashBoard.dart';

class UpdateUserController extends GetxController {
  final textControllerContent = TextEditingController();
  RxString imagePath = ''.obs;
  final contentpost = RxString('');
  final MyProfileController myProfileController = Get.put(MyProfileController());
  void UpdateUser(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt('id') ?? 0;
    final token = prefs.getString('token') ?? "";
    await API_Profile.updateAvatar(userId,token,imagePath.value);
  myProfileController.loadMyProfile();

  }
  void UpdateBack(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt('id') ?? 0;
    final token = prefs.getString('token') ?? "";
    await API_Profile.updateBackGround(userId,token,imagePath.value);


  }
}
