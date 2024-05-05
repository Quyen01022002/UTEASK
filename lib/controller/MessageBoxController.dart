

import 'package:askute/model/MessageContent.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rxdart/rxdart.dart';
import '../model/MessageBoxResponse.dart';
import '../model/MessageModel.dart';
import '../model/UserProfile.dart';
import '../service/API_Message.dart';
import '../service/API_Profile.dart';

class MessageBoxController extends GetxController{
  RxInt user_id = 0.obs;
  RxInt friend_id = 0.obs;
  final textControllerMess = TextEditingController();
  Future<void> CreateMessage(BuildContext context,int? message) async {

    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? "";
    // final contentMessage = textControllerMess.text;
    MessageModel? messageModel = await API_Message.createMessage(
        token, textControllerMess.value.text,message);
    textControllerMess.text = "";


  }
  Future<MessageBoxResponse?> CreateMessageSingle(BuildContext context, String name, String Avatar,int? idUser) async {

    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? "";
    final id=prefs.getInt('id') ?? 0;
    // final contentMessage = textControllerMess.text;
    MessageBoxResponse? messageModel = await API_Message.createMessageSingle(
        token, name,Avatar,id,idUser);
    return messageModel;



  }
  // UserProfile? friend;
  // UserProfile? user;
  // List<MessageModel>? messageModels;
  // Stream<List<MessageModel>>? listMessageStream;
  // Future<void> loadMessage(int friendId, BuildContext context) async{
  //   final prefs = await SharedPreferences.getInstance();
  //   user_id.value = prefs.getInt('id') ?? 0;
  //   friend_id.value = friendId;
  //   final token = prefs.getString('token') ?? "";
  //   final token2 = "eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJkb2R1eWhhbzc2NDBAZ21haWwuY29tIiwiaWF0IjoxNzAzMjg0NjMxLCJleHAiOjE3MDMyODYwNzF9.EofDhQPMJXcTuHDKjSbnDeRiomCe7t7R6SHvkpSfkGhZcQZEhrY7qIeSN3pSY0PuWZ3bFs97cUymEWSV0Zy6DA";
  //   List<MessageModel>? listMessage = await API_Message.getMessage(token, user_id.value, friendId);
  //   friend = await API_Profile.profile(friendId, token);
  //   user = await API_Profile.profile(user_id.value, token);
  //   listMessageStream = Stream.fromIterable([listMessage!]);
  // }
  //
  Stream<List<MessageBoxResponse>>? listMessageBoxStream;
  Future<void> loadMessageScreen(BuildContext context) async{
    final prefs = await SharedPreferences.getInstance();
    user_id.value = prefs.getInt('id') ?? 0;
    final token = prefs.getString('token') ?? "";
    List<MessageBoxResponse>? listMessage = await API_Message.getMessage(token, user_id.value);
    listMessageBoxStream = Stream.fromIterable([listMessage!]);

  }
  Stream<List<MessageContent>>? listMessageStream;
  final BehaviorSubject<List<MessageContent>> _messageStreamController = BehaviorSubject<List<MessageContent>>();

  Future<void> loadMessage(BuildContext context, int? messageID) async {
    final prefs = await SharedPreferences.getInstance();
    user_id.value = prefs.getInt('id') ?? 0;
    final token = prefs.getString('token') ?? "";

    MessageBoxResponse? listMessage = await API_Message.getOneMessage(token, messageID);

    listMessageStream = _messageStreamController.stream;

    // Only add data to the stream if there's new data to add
    if (listMessage?.messagesList != null) {
      _messageStreamController.add(listMessage!.messagesList!);
    }
  }





}