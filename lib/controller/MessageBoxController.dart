

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/MessageBoxResponse.dart';
import '../model/MessageModel.dart';
import '../model/UserProfile.dart';
import '../service/API_Message.dart';
import '../service/API_Profile.dart';

class MessageBoxController extends GetxController{
  RxInt user_id = 0.obs;
  RxInt friend_id = 0.obs;
  final textControllerMess = TextEditingController();
  Future<void> CreateMessage(BuildContext context,int friendId) async {

    final prefs = await SharedPreferences.getInstance();
    user_id.value = prefs.getInt('id') ?? 0;
    friend_id.value = friendId;
    final token = prefs.getString('token') ?? "";
    final contentMessage = textControllerMess.text;
    MessageModel message = MessageModel(
        id: 0,
        userId: user_id.value,
        friendId: friendId,
        content: contentMessage,
        createdDate: DateTime.now());
    MessageModel? messageModel = await API_Message.createMessage(
        token, message);
    textControllerMess.text = "";
    loadMessage(friendId, context);

  }
  UserProfile? friend;
  UserProfile? user;
  List<MessageModel>? messageModels;
  Stream<List<MessageModel>>? listMessageStream;
  Future<void> loadMessage(int friendId, BuildContext context) async{
    final prefs = await SharedPreferences.getInstance();
    user_id.value = prefs.getInt('id') ?? 0;
    friend_id.value = friendId;
    final token = prefs.getString('token') ?? "";
    final token2 = "eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJkb2R1eWhhbzc2NDBAZ21haWwuY29tIiwiaWF0IjoxNzAzMjg0NjMxLCJleHAiOjE3MDMyODYwNzF9.EofDhQPMJXcTuHDKjSbnDeRiomCe7t7R6SHvkpSfkGhZcQZEhrY7qIeSN3pSY0PuWZ3bFs97cUymEWSV0Zy6DA";
    List<MessageModel>? listMessage = await API_Message.getMessage(token, user_id.value, friendId);
    friend = await API_Profile.profile(friendId, token);
    user = await API_Profile.profile(user_id.value, token);
    listMessageStream = Stream.fromIterable([listMessage!]);
  }

  Stream<List<MessageBoxResponse>>? listMessageBoxStream;
  Future<void> loadMessageScreen(BuildContext context) async{
    final prefs = await SharedPreferences.getInstance();
    user_id.value = prefs.getInt('id') ?? 0;
    final token = prefs.getString('token') ?? "";
    List<MessageBoxResponse>? listMessage = await API_Message.getMessageBox(token, user_id.value);
    listMessageBoxStream = Stream.fromIterable([listMessage!]);
  }





}