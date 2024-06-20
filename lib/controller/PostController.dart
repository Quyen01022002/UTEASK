import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/CommentEntity.dart';
import '../model/PostModel.dart';
import '../service/API_Post.dart';
import '../service/SendMessage.dart';
import '../view/Quetions/QuestionDetail.dart';

class PostController extends GetxController {
  RxBool isliked = false.obs;
  RxBool isloaded = false.obs;
  RxInt postid = 0.obs;
  RxInt userid = 0.obs;
  RxString tokenString = ''.obs;
  Stream<PostModel>? postState;
  Stream<List<CommentEntity>>? listCommentStream;

  void loadOnePost(BuildContext context, int id) async {
    final prefs = await SharedPreferences.getInstance();
    final adminId = prefs.getInt('id') ?? 0;
    userid.value = adminId;
    final token = prefs.getString('token') ?? "";
    tokenString.value = token;
    postid.value = id;
    final post = await API_Post.getOnePost(id, adminId, token);
    final listComment = await API_Post.getAllComment(postid.value, token);
    if (post != null) {
      postState = Stream.fromIterable([post!]);
      listCommentStream = Stream.fromIterable([listComment!]);
    }
  }

  Future<PostModel?> loadAPost(BuildContext context, int id) async {
    final prefs = await SharedPreferences.getInstance();
    final adminId = prefs.getInt('id') ?? 0;
    userid.value = adminId;
    final token = prefs.getString('token') ?? "";
    tokenString.value = token;
    postid.value = id;
     return await API_Post.getOnePost(id, adminId, token);
  }

  void Like(int postid) async {
    try {
      final prefs = await SharedPreferences.getInstance();

      isliked(true);
      final userId = prefs.getInt('id') ?? 0;
      final token = prefs.getString('token') ?? "";
      await API_Post.Liked(token, postid, userId);
    } finally {
      isloaded(false);
    }
  }

  void CommentToQuestion(
      BuildContext context, List<ContentComment> list, bool reply, int idCmt) async {
    //final prefs = await SharedPreferences.getInstance();
    String content = "";
    for (int i = 0; i < list.length; i++) {
      content = content + "[${list[i].type}][${list[i].content}], ";
    }
    String? token= await FirebaseMessaging.instance.getToken();
    print(token);
    sendFriendRequestNotification(token);
    if (reply == false)
    await API_Post.Comments(
        userid.value, postid.value, content, tokenString.value);
    else
      await API_Post.ReplyComments(
          userid.value, idCmt, content, tokenString.value);
  }


  void setAnswer(BuildContext, int cmt) async{
    final prefs = await SharedPreferences.getInstance();
    final adminId = prefs.getInt('id') ?? 0;
    userid.value = adminId;
    final token = prefs.getString('token') ?? "";
    final cmt2 = await API_Post.setAnswer(cmt, token);
  }
  void setAnswerToCmt(BuildContext, int cmt) async{
    final prefs = await SharedPreferences.getInstance();
    final adminId = prefs.getInt('id') ?? 0;
    userid.value = adminId;
    final token = prefs.getString('token') ?? "";
    final cmt2 = await API_Post.setAnswerToCmt(cmt, token);
  }

  void deleteCmt(BuildContext, int cmt) async{
    final prefs = await SharedPreferences.getInstance();
    final adminId = prefs.getInt('id') ?? 0;
    userid.value = adminId;
    final token = prefs.getString('token') ?? "";
    await API_Post.deleteComment(cmt, token);
  }

  final reasonText = TextEditingController();
  void reportPost(BuildContext, int idpost, String reason) async {
    final prefs = await SharedPreferences.getInstance();
    final adminId = prefs.getInt('id') ?? 0;
    userid.value = adminId;
    final token = prefs.getString('token') ?? "";
    print("nội dung lý do: " + reason);

    String reason2 = "";
    if (reason =="Khác")
      reason2 = reasonText.text.trim();
    else
      reason2 = reason;
    await API_Post.reportPost(adminId, idpost, reason2, token);
  reasonText.text = "";
  }




}
