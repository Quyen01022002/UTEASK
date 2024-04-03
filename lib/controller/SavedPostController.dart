import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';


import '../model/PostModel.dart';
import '../service/API_Post.dart';


class SavedPostController extends GetxController {
  RxList<PostModel> listPost = List<PostModel>.empty(growable: true).obs;
  RxBool isloaded = false.obs;
  RxBool isliked = false.obs;
  RxInt postid = 0.obs;


  void loadPost() async
  {
    try {
      final prefs = await SharedPreferences.getInstance();
      isloaded(true);
      final userId = prefs.getInt('id') ?? 0;
      final token = prefs.getString('token') ?? "";
      List<PostModel>? result = await API_Post.LoadSavedPost(userId,token);
      if (result != null) {

        listPost.clear();
        listPost.addAll(result);
        update();
      }
    }
    finally
    {
      isloaded(false);
    }
  }
  void Like() async
  {

    try {
      final prefs = await SharedPreferences.getInstance();

      isliked(true);
      final userId = prefs.getInt('id') ?? 0;
      final token = prefs.getString('token') ?? "";
     await API_Post.Liked(token,postid.value,userId);
    }
    finally
    {
      isloaded(false);
    }
  }
  void DeletePost() async
  {

    try {
      final prefs = await SharedPreferences.getInstance();
      final userId = prefs.getInt('id') ?? 0;
      final token = prefs.getString('token') ?? "";
      API_Post.deletePost(postid.value,token);
    }
    finally
    {
      isloaded(false);
    }
  }
}