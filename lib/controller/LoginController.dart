import 'package:askute/model/AuthenticationResponse.dart';
import 'package:askute/service/API_login.dart';
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
      await saveLoggedInState(AuthenticationResponse);
     stateLogin.value ="Đăng nhập thành công";
     // String? fcmToken = await _firebaseMessaging.getToken();
     //  API_login.fcm(AuthenticationResponse.id,AuthenticationResponse.token!,fcmToken!);
settingController.loadthongtin();
      Future.delayed(Duration(milliseconds: 500), () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => DashBoard()),
        );
      });
    } else {

      stateLogin.value = 'Đăng nhập thất bại';
    }
  }
  Future<void> saveLoggedInState(AuthenticationResponse user) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('isLoggedIn', true);
    prefs.setInt('id', user.id!);
    prefs.setString("email", user.email!);
    prefs.setString("firstName", user.firstName!);
    prefs.setString("lastName", user.lastName!);
    prefs.setString("Avatar", user.Avatar!);
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
