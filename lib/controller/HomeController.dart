import 'dart:ffi';

import 'package:askute/model/CommentResponse.dart';
import 'package:askute/model/UserProgress.dart';
import 'package:askute/service/API_Profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/PostModel.dart';
import '../service/API_Post.dart';

class HomeController extends GetxController {
  static HomeController instance = Get.find();
  RxList<PostModel> listPost = List<PostModel>.empty(growable: true).obs;
  RxList<PostModel> top10Post = List<PostModel>.empty(growable: true).obs;
  RxList<PostModel> top10PostClass = List<PostModel>.empty(growable: true).obs;
  RxList<PostModel> listPostNotReply = List<PostModel>.empty(growable: true).obs;
  RxList<PostModel> top5Month = List<PostModel>.empty(growable: true).obs;
  RxList<int> countMont = List<int>.empty(growable: true).obs;
  RxList<int> countTK = List<int>.empty(growable: true).obs;
  RxList<CommentResponse> listComment = List<CommentResponse>.empty(growable: true).obs;
  RxBool isloaded = false.obs;
  RxBool isliked = false.obs;
  RxInt postid = 0.obs;
  RxInt myId = 0.obs;


  void loadPost() async
  {
    try {
      final prefs = await SharedPreferences.getInstance();
      isloaded(true);
      final userId = prefs.getInt('id') ?? 0;
      myId.value = userId;
      final token = prefs.getString('token') ?? "";
      List<PostModel>? result = await API_Post.LoadMainHome(userId, token);
      if (result != null) {
        listPost.clear();
        listPost.addAll(result);
        update();
      }
    }
    finally {
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
      await API_Post.Liked(token, postid.value, userId);
    }
    finally {
      isloaded(false);
    }
  }
  void Saved() async
  {
    try {
      final prefs = await SharedPreferences.getInstance();

      final token = prefs.getString('token') ?? "";
      final userId = prefs.getInt('id') ?? 0;
      await API_Post.Saved(token,userId, postid.value);
    }
    finally {
      isloaded(false);
    }
  }
  void Delete() async
  {
    try {
      final prefs = await SharedPreferences.getInstance();

      final token = prefs.getString('token') ?? "";
      final userId = prefs.getInt('id') ?? 0;
      await API_Post.Delete(token,userId, postid.value);
    }
    finally {
      isloaded(false);
    }
  }
  // void DeletePost() async
  // {
  //   try {
  //     final prefs = await SharedPreferences.getInstance();
  //     final userId = prefs.getInt('id') ?? 0;
  //     final token = prefs.getString('token') ?? "";
  //     API_Post.deletePost(postid.value, token);
  //   }
  //   finally {
  //     isloaded(false);
  //   }
  // }

  Stream<List<PostModel>>? allPostHotStream;
  void load10HotPost(BuildContext context) async
  {
    try {
      final prefs = await SharedPreferences.getInstance();
      isloaded(true);
      print("load");
      final userId = prefs.getInt('id') ?? 0;
      myId.value = userId;
      final token = prefs.getString('token') ?? "";
      List<PostModel>? result = await API_Post.LoadTop10(userId, token);
      if (result != null) {
        top10Post.clear();
        top10Post.addAll(result);
        update();
      }
      allPostHotStream = Stream.fromIterable([result!]);
    }
    finally {
      isloaded(false);
    }
  }
  Future<List<PostModel>?> load10post(BuildContext context) async
  {
      final prefs = await SharedPreferences.getInstance();
      isloaded(true);
      print("load");
      final userId = prefs.getInt('id') ?? 0;
      myId.value = userId;
      final token = prefs.getString('token') ?? "";
      return await API_Post.LoadTop10(userId, token);
  }
  RxInt pagenumberHotPost = 0.obs;
  Future<List<PostModel>?> loadHotPost(BuildContext context) async
  {
    final prefs = await SharedPreferences.getInstance();
    isloaded(true);
    print("load");
    final userId = prefs.getInt('id') ?? 0;
    myId.value = userId;
    final token = prefs.getString('token') ?? "";
    return await API_Post.LoadHotPost(userId, pagenumberHotPost.value, token);
  }

  Stream<List<PostModel>>? allPostHotClassStream;
  void load10HotPostOnAllClassOfTeacher(BuildContext context) async
  {
    try {
      final prefs = await SharedPreferences.getInstance();
      isloaded(true);
      print("load");
      final userId = prefs.getInt('id') ?? 0;
      myId.value = userId;
      final token = prefs.getString('token') ?? "";
      List<PostModel>? result = await API_Post.LoadTop10onClass(userId, token);
      if (result != null) {
        top10PostClass.clear();
        top10PostClass.addAll(result);
        update();
      }
      allPostHotClassStream = Stream.fromIterable([result!]);
    }
    finally {
      isloaded(false);
    }
  }
  Future<UserProgress?> loadMyProgress(BuildContext context) async{
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt('id') ?? 0;
    myId.value = userId;
    final token = prefs.getString('token') ?? "";
    return await API_Profile.LoadMyProgress(userId, token);
  }

  void loadPostNotReply(BuildContext context) async
  {
    try {
      final prefs = await SharedPreferences.getInstance();
      isloaded(true);
      print("load");
      final userId = prefs.getInt('id') ?? 0;
      myId.value = userId;
      final token = prefs.getString('token') ?? "";
      List<PostModel>? result = await API_Post.LoadPostNotReply(userId, token);
      if (result != null) {
        listPostNotReply.clear();
        listPostNotReply.addAll(result);
        update();
      }
    }
    finally {
      isloaded(false);
    }
  }
  Future<List<PostModel>?> loadPostNotReplyValue(BuildContext context) async
  {
    try {
      final prefs = await SharedPreferences.getInstance();
      isloaded(true);
      print("load");
      final userId = prefs.getInt('id') ?? 0;
      myId.value = userId;
      final token = prefs.getString('token') ?? "";
      List<PostModel>? result = await API_Post.LoadPostNotReply(userId, token);
      if (result != null) {
        listPostNotReply.clear();
        listPostNotReply.addAll(result);
        update();
      }
      return result;
    }
    finally {
      isloaded(false);
    }
  }

  Future<List<PostModel>?> loadTop5OnMonth(BuildContext context) async
  {
    try {
      final prefs = await SharedPreferences.getInstance();
      isloaded(true);
      print("load");
      final userId = prefs.getInt('id') ?? 0;
      myId.value = userId;
      final token = prefs.getString('token') ?? "";
      String? rs = await API_Post.LoadCountOfYear(userId, token);
      if (rs != null){
        List<String> listCountMont = rs.split(',');
        List<int> integerList = listCountMont.map(int.parse).toList();
        countMont.clear();
        countMont.addAll(integerList);
        update();
      }
      String? kt = await API_Post.LoadCountThongKe(userId, token);
      if (kt != null){
        List<String> listCountMont = kt.split(',');
        List<int> integerList = listCountMont.map(int.parse).toList();
        countTK.clear();
        countTK.addAll(integerList);
        update();
      }

      List<PostModel>? result = await API_Post.Load5OnMonth(userId, token);
      if (result != null) {
        top5Month.clear();
        top5Month.addAll(result);
        update();
      }
      return result;

    }
    finally {
      isloaded(false);
    }
  }

  RxInt pagenumberCmt = 0.obs;
  Future<void> loadCommentClasses(BuildContext context) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      isloaded(true);
      final userId = prefs.getInt('id') ?? 0;
      myId.value = userId;
      final token = prefs.getString('token') ?? "";
      List<CommentResponse>? result = await API_Post.getAllCommentClasses(userId, token, pagenumberCmt.value);
      if (result != null) {
        listComment.clear();
        listComment.addAll(result);
        update();
      }
      //allPostHotClassStream = Stream.fromIterable([result!]);
    }
    finally {
      isloaded(false);
    }
  }
  Future<void> loadCommentByMe(BuildContext context) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      isloaded(true);
      final userId = prefs.getInt('id') ?? 0;
      myId.value = userId;
      final token = prefs.getString('token') ?? "";
      List<CommentResponse>? result = await API_Post.getAllCommentByMe(userId, token, pagenumberCmt.value);
      if (result != null) {
        listComment.clear();
        listComment.addAll(result);
        update();
      }
      //allPostHotClassStream = Stream.fromIterable([result!]);
    }
    finally {
      isloaded(false);
    }
  }
}