import 'dart:async';

import 'package:askute/model/MessageContent.dart';
import 'package:askute/model/MessageModel.dart';
import 'package:askute/service/SendMessage.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:askute/controller/MessageBoxController.dart';
import 'package:askute/model/MessageBoxResponse.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MessegerDetail extends StatefulWidget {
  final MessageBoxResponse message;

  const MessegerDetail({Key? key, required this.message}) : super(key: key);

  @override
  _MessegerDetailState createState() => _MessegerDetailState();
}

class _MessegerDetailState extends State<MessegerDetail> {
  Stream<List<MessageContent>>? messageStream;
  late Timer _timer;
  ScrollController _scrollController = ScrollController();
  final MessageBoxController messageBoxController =
      Get.put(MessageBoxController());
  List<MessageContent>? listMessage;
  late RxString curnetUser = "".obs;
  late RxInt idUser = 0.obs;
  late bool statecontent = false;
  void initCurrentUser() async {
    final prefs = await SharedPreferences.getInstance();
    curnetUser = (prefs.getString('Avatar') ??
            "https://inkythuatso.com/uploads/thumbnails/800/2023/03/10-anh-dai-dien-trang-inkythuatso-03-15-27-10.jpg")
        .obs;
    idUser = (prefs.getInt('id') ?? 0).obs;
    print(curnetUser);
  }

  @override
  void initState() {
    initCurrentUser();
    super.initState();
    _startTimer();
    _scrollController = ScrollController();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    });
    _scrollToBottom();
    messageBoxController.loadMessage(context, widget.message.id);
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }
  void _startTimer() {
    _timer = Timer.periodic(Duration(milliseconds: 200), (timer) {
      messageBoxController.loadMessage(context, widget.message.id);
      messageStream = messageBoxController.listMessageStream;
      messageStream?.listen((List<MessageContent>? updatedGroups) {
        if (updatedGroups != null) {
          setState(() {
            listMessage = updatedGroups;

          });
          _scrollToBottom();
        }

      });
    });
  }

  @override
  void dispose() {
    // Dispose the timer when the widget is disposed
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          title: Row(
            children: [
              CircleAvatar(
                backgroundImage: AssetImage("assets/images/login.png"),
              ),
              SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.message.name!,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Active now', // Replace with actual status
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.76,
                color: Colors.white,
                child: StreamBuilder<List<MessageContent>>(
                  stream: messageStream,
                  builder: (context, snapshot) {
                    if (snapshot.hasData && snapshot.data != null) {
                      List<MessageContent> messages = snapshot.data!;
                      return ListView.builder(
                        itemCount: messages.length,
                        controller: _scrollController,
                        itemBuilder: (context, index) {
                          MessageContent message = messages[index];
                          return message.user.id != idUser.value
                              ? Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      ClipOval(
                                        child: Image.network(
                                          message.user.profilePicture.toString(),
                                          width: 35,
                                          height: 35,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 8.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              message.user.firstName +
                                                  " " +
                                                  message.user.lastName,
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  color: Colors.grey),
                                            ),
                                            Align(
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: message.user.id ==
                                                          idUser.value
                                                      ? Colors.blue
                                                      : Colors.grey[300],
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                ),
                                                padding: EdgeInsets.all(12),
                                                child: Text(
                                                  message.content,
                                                  style: TextStyle(
                                                    color: message.user.id ==
                                                            idUser.value
                                                        ? Colors.white
                                                        : Colors.black,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              : Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Expanded(
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          // Căn phải
                                          children: [

                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 8.0),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: [
                                                  Text(
                                                    message.user.firstName +
                                                        " " +
                                                        message.user.lastName,
                                                    style: TextStyle(
                                                        fontSize: 10,
                                                        color: Colors.grey),
                                                  ),
                                                  Align(
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        color: message.user.id ==
                                                                idUser.value
                                                            ? Colors.blue
                                                            : Colors.grey[300],
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                12),
                                                      ),
                                                      padding: EdgeInsets.all(12),
                                                      child: Text(
                                                        message.content,
                                                        style: TextStyle(
                                                          color:
                                                              message.user.id ==
                                                                      idUser.value
                                                                  ? Colors.white
                                                                  : Colors.black,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            ClipOval(
                                              child: Image.network(
                                                message.user.profilePicture
                                                    .toString(),
                                                width: 35,
                                                height: 35,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                          ;
                        },
                      );
                    } else {
                      return Center(
                        child:
                            Text('Theo dõi thêm khoa để xem thêm bài viết mới'),
                      );
                    }
                  },
                ),
              ),
              Container(
                padding: EdgeInsets.all(16),
                color: Colors.white,
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        onChanged: (text) {
                          if (text == null || text.isEmpty) {
                            setState(() {
                              statecontent = false;
                            });
                          } else {
                            setState(() {
                              statecontent = true;
                            });
                          }
                        },
                        controller: messageBoxController.textControllerMess,
                        decoration: InputDecoration(
                          hintText: 'Nhắn Tin ...',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 16),
                    statecontent?IconButton(
                      icon: Icon(Icons.send,color: Colors.blue,),
                      onPressed: () {
                        messageBoxController.CreateMessage(
                            context, widget.message.id);
                        if(widget.message.messageMembersList.isNotEmpty)
                          {
                            for(MessageModel mes in widget.message.messageMembersList)
                              {
                                sendMessengerNotificationMess(mes.listMembers.fcm,mes.listMembers.firstName+mes.listMembers.lastName,messageBoxController.textControllerMess.text);
                                print("Thông báo");
                              }

                          }
                        else
                          {
                           // sendFriendRequestNotification(widget.message..fcm);

                          }

                      },
                    ):IconButton(
                      icon: Icon(Icons.send),
                      onPressed: () {

                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

