import 'dart:ffi';

import 'package:askute/service/API_dangky.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';


import '../request/RegisterRequest.dart';
import '../view/authen/verify_screen.dart';
import '../view/dashboard/DashBoard.dart';

class SignUpController extends GetxController {
  final textControllerEmail = TextEditingController();
  final textControllerPhone = TextEditingController();
  final textControllerPass = TextEditingController();
  final textControllerRePass = TextEditingController();
  final pass = RxString('');
  final email = RxString('');
  final phone = RxString('');

  void signup(BuildContext context) async {
    final email = textControllerEmail.text;
    final phone = textControllerPhone.text;
    final pass = textControllerPass.text;
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt('id') ?? 0;
    final token = prefs.getString('token') ?? "";
    String OTP = await API_dangky.OTP(email);
    saveInState(pass, email, phone, OTP);
    Future.delayed(Duration(milliseconds: 300), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => VerifyScreen(animated: false)),
      );
    });
  }

  Future<void> saveInState(
      String password, String email, String phone, String OTP) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('password', password!);
    prefs.setString("email", email!);
    prefs.setString("phone", phone!);
    prefs.setString("OTP", OTP!);
  }
}
