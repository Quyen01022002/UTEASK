import 'dart:ffi';

import 'package:askute/service/API_dangky.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../model/AuthenticationResponse.dart';
import '../../request/RegisterRequest.dart';
import '../../view/authen/SignUpdateUser.dart';
import '../../view/authen/verify_screen.dart';
import '../../view/dashboard/DashBoard.dart';

class VerifyController extends GetxController {

  final OTP = TextEditingController();

  final codeOtp = RxString('');


  void checkotp(BuildContext context) async {

 final codeOtp=OTP.text;

      final prefs = await SharedPreferences.getInstance();
      final email = prefs.getString('email') ?? "";
      final otp = prefs.getString('OTP') ?? "";
      final phone = prefs.getString('phone') ?? "";
      final pass = prefs.getString('password') ?? "";
 if(codeOtp==otp)
   {
     final AuthenticationResponse =await API_dangky.DangKy(email,pass,phone);
     if (AuthenticationResponse != null) {
       await saveLoggedInState(AuthenticationResponse);
       Future.delayed(Duration(milliseconds: 300), () {
         Navigator.pushReplacement(
           context,
           MaterialPageRoute(builder: (context) => DatePickerApp()),
         );
       });
     }
     }

   }


}
Future<void> saveLoggedInState(AuthenticationResponse user) async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setBool('isLoggedIn', true);
  prefs.setInt('id', user.id!);
  prefs.setString("email", user.email!);
  prefs.setString("token", user.token!);

}

