import 'package:askute/view/authen/Login_screen.dart';
import 'package:askute/view/authen/new_password_forgot_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../service/API_dangky.dart';
import '../service/API_login.dart';
import '../view/authen/verify_screen.dart';

class ResetPasswordController extends GetxController
{
  final textControllerEmail = TextEditingController();
  final textControllerOTP = TextEditingController();
  final textControllerPassword = TextEditingController();
  final textControllerPasswordConfirm = TextEditingController();
  //final Rx<bool> buttonSendOTP = false as Rx<bool>;

  void checkEmail(BuildContext context) async{
  final email = textControllerEmail.text;
  if (email !=""){
  print("email đã nhận là: " + email);
  //buttonSendOTP.value = true;
  final bool checkE = await API_login.checkEmail(email);
  if (checkE == true)
    {
      print("vào trong đây rồi");
      String OTP = await API_dangky.OTP(email);
      final prefs = await SharedPreferences.getInstance();
      prefs.setString('email', email!);
      prefs.setString('OTP', OTP!);
    }
  else{
    print("vào trong đây rồi");
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Thông báo"),
          content: Text("Không có tài khoản với địa chỉ email này."),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }}
  else
    {
      //buttonSendOTP.value = false;
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Thông báo"),
            content: Text("Vui lòng nhập email"),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("OK"),
              ),
            ],
          );
        },
      );
    }
  }
  void goToResetPassword(BuildContext context) async{
    final email = textControllerEmail.text;
    final OTP = textControllerOTP.text;
    final prefs = await SharedPreferences.getInstance();
    final otpXT = prefs.getString('OTP')??"";
    if (OTP == otpXT){
      Future.delayed(Duration(milliseconds: 300), () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => NewPasswordScreen(animated: false, state: false,)),
        );
      });

    }
    else{

    }
  }

  void ResetPassword(BuildContext context) async{

    final prefs = await SharedPreferences.getInstance();
    final email = prefs.getString('email') ?? "";
    final pw = textControllerPassword.text;
    final pwConfirm = textControllerPasswordConfirm.text;
    if (pw==pwConfirm) {
      await API_login.resetPassword(email, pw);

      Future.delayed(Duration(milliseconds: 300), () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => Loginscreen(animated: false,)),
        );
      });
    }
    else
      {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Thông báo"),
              content: Text("Mật khẩu không trùng khớp"),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("OK"),
                ),
              ],
            );
          },
        );
      }

  }



}