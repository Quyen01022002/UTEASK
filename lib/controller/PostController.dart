import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/PostModel.dart';
import '../service/API_Post.dart';

class PostController extends GetxController {
  RxBool isliked = false.obs;
  RxBool isloaded = false.obs;
  RxInt postid = 0.obs;


Stream<PostModel> ? postState;
void loadOnePost(BuildContext context ,int id) async{
  final prefs = await SharedPreferences.getInstance();
  final adminId = prefs.getInt('id') ?? 0;
  final token = prefs.getString('token') ?? "";
  postid.value = id;
final post =await API_Post.getOnePost(postid.value, token);
if (post != null) {
  postState = Stream.fromIterable([post!]);
}
}
  void Like() async {
    try {
      final prefs = await SharedPreferences.getInstance();

      isliked(true);
      final userId = prefs.getInt('id') ?? 0;
      final token = prefs.getString('token') ?? "";
      await API_Post.Liked(token, postid.value, userId);
    } finally {
      isloaded(false);
    }
  }
}
