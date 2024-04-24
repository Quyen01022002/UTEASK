import 'package:askute/model/AuthenticationResponse.dart';
import 'package:askute/service/API_login.dart';
import 'package:askute/view/dashboard/DashBoard_new.dart';
import 'package:askute/view/teacher/teacher_home.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../view/dashboard/DashBoard.dart';
import 'SettingController.dart';

class LoginController extends GetxController
{
  final SettingController settingController =Get.put(SettingController());
  final textControllerEmail = TextEditingController();
  final textControllerPass = TextEditingController();

  final pass = RxString('');
  final email = RxString('');
  RxString stateLogin=('').obs;
  void login(BuildContext context) async {
    final email = textControllerEmail.text;
    final password = textControllerPass.text;
    print("trong");
    final AuthenticationResponse = await API_login.Login(email, password);

    if (AuthenticationResponse != null) {
      if (AuthenticationResponse.roleEnum == RoleEnum.USER) {
        print(AuthenticationResponse.roleEnum);
        await saveLoggedInState(AuthenticationResponse);
        stateLogin.value = "Đăng nhập thành công";
        String? fcmtoken= await FirebaseMessaging.instance.getToken();
          API_login.fcm(AuthenticationResponse.id,AuthenticationResponse.token!,fcmtoken!);
        settingController.loadthongtin();
        Future.delayed(Duration(milliseconds: 500), () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => DashBoardVer2()),
          );
        });
      } else {
        stateLogin.value = 'Không có quyền truy cập';
      }
    }
    else
      {
        stateLogin.value = 'Đăng nhập thất bại';
      }
  }
  void loginTeacher(BuildContext context) async {
    final email = textControllerEmail.text;
    final password = textControllerPass.text;
    print("trong");
    final AuthenticationResponse = await API_login.Login(email, password);

    if (AuthenticationResponse != null) {
      if (AuthenticationResponse.roleEnum == RoleEnum.TEACHER) {
        await saveLoggedInState(AuthenticationResponse);
        stateLogin.value = "Đăng nhập thành công";
        // String? fcmToken = await _firebaseMessaging.getToken();
        //  API_login.fcm(AuthenticationResponse.id,AuthenticationResponse.token!,fcmToken!);
        settingController.loadthongtin();
        Future.delayed(Duration(milliseconds: 500), () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => HomeTeacher()),
          );
        });
      } else {

        stateLogin.value='Tài khoản không có quyền truy cập';
      }
    }
    else
      {
        stateLogin.value = 'Đăng nhập thất bại';
      }
  }
  void updateUserfcm(BuildContext context,String? fcm) async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt('id') ?? 0;
    final token = prefs.getString('token') ?? "";
    API_login.fcm(userId,token,fcm!);

  }
  Future<void> saveLoggedInState(AuthenticationResponse user) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('isLoggedIn', true);
    prefs.setInt('id', user.id!);
    prefs.setString("email", user.email!);
    prefs.setString("firstName", user.firstName!);
    prefs.setString("lastName", user.lastName!);
    prefs.setString("Avatar", user.avatar!);
    prefs.setString("token", user.token!);

  }
  static Future<void> Logout() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('isLoggedIn', false);
    prefs.remove('id');
    prefs.remove('email');
    prefs.remove('firstName');
    prefs.remove('lastName');
    prefs.remove('Avatar');
    prefs.remove('token');

  }

}
