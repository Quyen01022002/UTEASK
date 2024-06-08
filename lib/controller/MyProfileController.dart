import 'dart:ffi';

import 'package:askute/model/UserProfile.dart';
import 'package:askute/model/UsersEnity.dart';
import 'package:askute/service/API_Profile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/PostModel.dart';

class MyProfileController extends GetxController {
  RxInt myId = 0.obs;
  RxInt ortherId = 0.obs;
  RxString myToken = "".obs;
  RxInt follow = 0.obs;
  RxInt following = 0.obs;
  RxInt post = 0.obs;
  RxInt idFriends = 0.obs;
  RxString fisrt_name = "".obs;
  RxString last_name = "".obs;
  RxString phone = "".obs;
  RxString email = "".obs;
  RxString Address = "".obs;
  RxString Avatar = "".obs;
  RxString BackGround = "".obs;
  RxBool isFriend = true.obs;
  RxList<PostModel> listPost = List<PostModel>.empty(growable: true).obs;
  RxList<UserEnity> listFriends = List<UserEnity>.empty(growable: true).obs;


  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final oldPasswordController = TextEditingController();
  final passwordController = TextEditingController();
  final newPasswordController = TextEditingController();

  void loadMyProfile() async {
    final prefs = await SharedPreferences.getInstance();
    myId.value = prefs.getInt('id')!;
    ortherId.value=0;
    myToken.value = prefs.getString('token')!;
    try {
      final userProfile = await API_Profile.profile(myId.value, myToken.value);
      if (userProfile != null) {
        listPost.value = userProfile.listpost!;
        follow.value = userProfile.friends!.length!;
        post.value = userProfile.listpost!.length!;
        fisrt_name.value = userProfile.first_name!;
        last_name.value = userProfile.last_name!;
        email.value = userProfile.email!;
        phone.value = userProfile.phone!;
        Avatar.value = userProfile.avatarUrl!;
        BackGround.value = userProfile.backGround!;
        isFriend.value = userProfile.isFriends!;
        firstNameController.text = userProfile.first_name!;
        lastNameController.text = userProfile.last_name!;
        emailController.text = userProfile.email!;
        phoneController.text = userProfile.phone!;
        print(userProfile.isFriends);
        update();
      }
    } catch (e) {
      print("Lỗi: $e");
    }
  }
  void loadOtherProfile(int? id) async {
    final prefs = await SharedPreferences.getInstance();
    myToken.value = prefs.getString('token')!;
    try {
      final userProfile = await API_Profile.profile(id, myToken.value);
      if (userProfile != null) {
        ortherId.value = userProfile.id!;
        listPost.value = userProfile.listpost!;
        follow.value = userProfile.friends!.length!;
        post.value = userProfile.listpost!.length!;
        fisrt_name.value = userProfile.first_name!;
        last_name.value = userProfile.last_name!;
        email.value = userProfile.email!;
        phone.value = userProfile.phone!;
        Avatar.value = userProfile.avatarUrl!;
        BackGround.value = userProfile.backGround!;
        isFriend.value = userProfile.isFriends!;
        firstNameController.text = userProfile.first_name!;
        lastNameController.text = userProfile.last_name!;
        emailController.text = userProfile.email!;
        phoneController.text = userProfile.phone!;
        print(userProfile.isFriends);
        update();
      }
    } catch (e) {
      print("Lỗi: $e");
    }
  }

  Future<UserProfile?> loadUserOther(int id, BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    myToken.value = prefs.getString('token')!;
    return await API_Profile.profile(id, myToken.value);
  }




  void loadthongtin() async {
    final prefs = await SharedPreferences.getInstance();
    int userid = prefs.getInt('id') ?? 0;
    String token = prefs.getString('token') ?? "";
    print("load");

    try {
      final userProfile = await API_Profile.profile(userid, token);
      if (userProfile != null) {
        listPost.value = userProfile.listpost!;
        listFriends.value = userProfile.friends!;
        follow.value = userProfile.friends!.length!;
        post.value = userProfile.listpost!.length!;
        fisrt_name.value = userProfile.first_name!;
        last_name.value = userProfile.last_name!;
        Avatar.value = userProfile.avatarUrl!;
        BackGround.value = userProfile.backGround!;
        isFriend.value=userProfile.isFriends!;
        print(userProfile.isFriends);
      }
    } catch (e) {
      print("Error loading profile: $e");
    }
    // Trigger reactive update
    listPost.refresh();
    listFriends.refresh();
  }
  void loadthongtinOther(int id) async {
    final prefs = await SharedPreferences.getInstance();
    int userid = prefs.getInt('id') ?? 0;
    String token = prefs.getString('token') ?? "";
    print("load");

    try {
      final userProfile = await API_Profile.profile(id, token);
      if (userProfile != null) {
        listPost.value = userProfile.listpost!;
        follow.value = userProfile.friends!.length!;
        post.value = userProfile.listpost!.length!;
        fisrt_name.value = userProfile.first_name!;
        last_name.value = userProfile.last_name!;
        Avatar.value = userProfile.avatarUrl!;
        idFriends.value = userProfile.idFriends!;
      }
    } catch (e) {
      print("Error loading profile: $e");
    }
    // Trigger reactive update
    listPost.refresh();
  }


  void updateUserProfile(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt('id') ?? 0;
    final token = prefs.getString('token') ?? "";
    await API_Profile.UpdatePro(token,fisrt_name.value,last_name.value,email.value, phone.value,Avatar.value, BackGround.value ,userId);
    loadMyProfile();
  }


  void updateNewPassword(BuildContext context) async{
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt('id') ?? 0;
    final email= prefs.getString('email') ?? '';
    final token = prefs.getString('token') ?? "";
    final rs = API_Profile.updatePw(userId,email, passwordController.text, token);


  }

  RxBool checkold = false.obs;
  void loadChangePw(BuildContext context) async {
    bool isOldPasswordValid = await checkOldPassword(context);

    if (isOldPasswordValid && passwordController.text == newPasswordController.text) {
      int a =0;
      updateNewPassword(context);
      oldPasswordController.text = '';
      passwordController.text = '';
      newPasswordController.text = '';
      _showErrorDialog(context, 'Đổi mật khẩu thành công');

    } else {
      _showErrorDialog(context, 'Mật khẩu cũ không đúng hoặc mật khẩu mới không khớp');
    }

  }

  Future<bool> checkOldPassword(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt('id') ?? 0;
    final email = prefs.getString('email') ?? '';
    final token = prefs.getString('token') ?? "";

    final check = await API_Profile.checkOldPassword(userId,email, oldPasswordController.text,token);

    if (check!= null)
      {
        checkold.value = true;
      return true;}
    else {
      checkold.value = false;
    return false;}
  }

  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Lỗi'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
