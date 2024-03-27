import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/CommentEntity.dart';
import '../model/PostModel.dart';
import '../service/API_Post.dart';
import '../view/Quetions/QuestionDetail.dart';

class PostController extends GetxController {
  RxBool isliked = false.obs;
  RxBool isloaded = false.obs;
  RxInt postid = 0.obs;
    RxInt userid = 0.obs;
    RxString tokenString =''.obs;
Stream<PostModel> ? postState;
Stream<List<CommentEntity>> ? listCommentStream;
void loadOnePost(BuildContext context ,int id) async{
  final prefs = await SharedPreferences.getInstance();
  final adminId = prefs.getInt('id') ?? 0;
  userid.value=adminId;
  final token = prefs.getString('token') ?? "";
  tokenString.value = token;
  postid.value = id;
final post =await API_Post.getOnePost(postid.value, token);
  final listComment =await API_Post.getAllComment(postid.value, token);
if (post != null) {
  postState = Stream.fromIterable([post!]);
  listCommentStream = Stream.fromIterable([listComment!]);
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
  void CommentToQuestion(BuildContext context, List<ContentComment> list) async {
    //final prefs = await SharedPreferences.getInstance();
String content = "";
    for (int i = 0; i<list.length; i++){
      content= content +"[${list[i].type}][${list[i].content}], ";
    }
    await API_Post.Comments(userid.value, postid.value, content, tokenString.value);
  }
}
