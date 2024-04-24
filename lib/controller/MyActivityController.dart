

import 'package:askute/model/InteractionsResponse.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/CommentEntity.dart';
import '../model/CommentResponse.dart';
import '../model/PostModel.dart';
import '../service/API_Post.dart';

class MyActivityController extends GetxController{
  RxList<PostModel> top10Post = List<PostModel>.empty(growable: true).obs;
  RxInt userid = 0.obs;
  RxString tokenString = ''.obs;
  Stream<List<CommentResponse>>? listCommentStream;
  RxList<List<CommentResponse>> cmtList = List<List<CommentResponse>>.empty(growable: true).obs;
  RxList<List<InteractionResponse>> likeList = List<List<InteractionResponse>>.empty(growable: true).obs;
  void loadAllComment(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    final adminId = prefs.getInt('id') ?? 0;
    userid.value = adminId;
    final token = prefs.getString('token') ?? "";
    tokenString.value = token;
    final listComment = await API_Post.getAllMyComment(adminId, token);
    if (listComment != null) {
      List<List<CommentResponse>> Comments = [];
      List<CommentResponse> rowDay = [];
      for (int i = 0; i<listComment.length; i++){
        if (i==0){
          rowDay.add(listComment[i]);
          print('hàng 1: '+listComment[i].comment_id.toString());
        }
        else if(listComment[i].timestamp == listComment[i-1].timestamp){
          rowDay.add(listComment[i]);
          print('hàng ${Comments.length+1}: '+listComment[i].comment_id.toString());
        }
        else {
          Comments.add(List.from(rowDay));
          print(rowDay);
          print(Comments);
          rowDay.clear();
          rowDay.add(listComment[i]);
          print('hàng ${Comments.length+1}: '+listComment[i].comment_id.toString());
        }
        if (i == (listComment.length - 1))
        {
          Comments.add(List.from(rowDay));
        }
      }
    cmtList.value = Comments;


      listCommentStream = Stream.fromIterable([listComment!]);
    }
  }

  Stream<List<InteractionResponse>>? listLikeStream;
  void loadAllMyLike(BuildContext context) async
  {
    final prefs = await SharedPreferences.getInstance();
    final adminId = prefs.getInt('id') ?? 0;
    userid.value = adminId;
    final token = prefs.getString('token') ?? "";
    tokenString.value = token;
    final listLike = await API_Post.getAllMyLike(adminId, token);
    if (listLike != null) {
      List<List<InteractionResponse>> Likes = [];
      List<InteractionResponse> rowDay = [];
      for (int i = 0; i<listLike.length; i++){
        if (i==0){
          rowDay.add(listLike[i]);
          print('hàng 1: '+listLike[i].post_id!.id.toString());
        }
        else if(listLike[i].timestamp == listLike[i-1].timestamp){
          rowDay.add(listLike[i]);
          print('hàng ${Likes.length+1}: '+listLike[i].post_id!.id.toString());
        }
        else {
          Likes.add(List.from(rowDay));
          print(rowDay);
          print(Likes);
          rowDay.clear();
          rowDay.add(listLike[i]);
          print('hàng ${Likes.length+1}: '+listLike[i].post_id!.id.toString());
        }
        if (i == (listLike.length - 1))
        {
          Likes.add(List.from(rowDay));
        }
      }
      likeList.value = Likes;


      listLikeStream = Stream.fromIterable([listLike!]);
    }
  }



}