import 'package:askute/model/UserProfile.dart';
import 'package:askute/model/UsersEnity.dart';
import 'package:askute/service/API_Profile.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/PostModel.dart';

class MyProfileController extends GetxController {
  RxInt myId = 0.obs;
  RxString myToken = "".obs;
  RxInt follow = 0.obs;
  RxInt following = 0.obs;
  RxInt post = 0.obs;
  RxInt idFriends = 0.obs;
  RxString fisrt_name = "".obs;
  RxString last_name = "".obs;
  RxString phone = "".obs;
  RxString email = "".obs;
  RxString Avatar = "".obs;
  RxString BackGround = "".obs;
  RxBool isFriend = true.obs;
  RxList<PostModel> listPost = List<PostModel>.empty(growable: true).obs;
  RxList<UserEnity> listFriends = List<UserEnity>.empty(growable: true).obs;
  void loadMyProfile() async {
    final prefs = await SharedPreferences.getInstance();
    myId.value = prefs.getInt('id')!;
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
        print(userProfile.isFriends);
      }
    } catch (e) {
      print("Lỗi: $e");
    }
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
}
