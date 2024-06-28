import 'dart:async';

import 'package:askute/controller/MessageBoxController.dart';
import 'package:askute/model/MessageBoxResponse.dart';
import 'package:askute/view/teacher/Home/Messeger_Detail.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:page_transition/page_transition.dart';

import '../../component/post_screen.dart';

class Home_Messeger extends StatefulWidget {
  const Home_Messeger({Key? key}) : super(key: key);

  @override
  _Home_MessegerState createState() => _Home_MessegerState();
}

class _Home_MessegerState extends State<Home_Messeger> {
  final MessageBoxController messageBoxController =
      Get.put(MessageBoxController());
  bool isLoadingMore = false;
  late String formattedTime = '';
  Stream<List<MessageBoxResponse>>? messageModelStream;
  late Timer _timer;
  List<MessageBoxResponse>? listMessage;

  @override
  void initState() {
    super.initState();
    _startTimer();
    messageBoxController.loadMessageScreen(context);
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(milliseconds: 200), (timer) {
      messageBoxController.loadMessageScreen(context);
      messageModelStream = messageBoxController.listMessageBoxStream;
      messageModelStream?.listen((List<MessageBoxResponse>? updatedGroups) {
        if (updatedGroups != null) {
          setState(() {
            listMessage = updatedGroups;
          });
        }
      });
    });
  }

  @override
  void dispose() {
    // Dispose the timer when the widget is disposed
    _timer.cancel();
    listMessage?.clear();
    messageModelStream = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text('Tin nhắn'),
          actions: [
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                showSearch(
                  context: context,
                  delegate: MessageSearchDelegate(),
                );
              },
            ),
          ],
        ),
        body: Container(
            color: Colors.white,
            child: StreamBuilder<List<MessageBoxResponse>>(
              stream: messageModelStream,
              builder: (context, snapshot) {
                if (snapshot.hasData && snapshot.data != null) {
                  List<MessageBoxResponse> messages = snapshot.data!;
                  return ListView.builder(
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      MessageBoxResponse message = messages[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            PageTransition(
                              type: PageTransitionType.rightToLeft,
                              child: MessegerDetail(message: message),
                            ),
                          );
                        },
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          child: Row(
                            children: [
                              CircleAvatar(
                                backgroundImage:
                                    NetworkImage(message.Avatar.toString()),
                                radius: 24,
                              ),
                              SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      message.name!,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                      message.messagesList.isNotEmpty
                                          ? message.messagesList[message.messagesList.length-1]!.content
                                          : "Hãy nhắn gì đó !",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                              Text(
                                  message.messagesList.isNotEmpty
                                      ?  formattedTime = formatTimeDifference(message.messagesList[message.messagesList.length-1]!.createdAt)
                                      : "Hãy nhắn gì đó !", // Replace with message timestamp
                                style: TextStyle(
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                } else {
                  return Center(
                    child: Text('Theo dõi thêm lớp học để tham gia nhóm chat'),
                  );
                }
              },
            )),
      ),
    );
  }
}

class MessageSearchDelegate extends SearchDelegate<String> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Implement search results
    return Center(
      child: Text('Search results for: $query'),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Implement search suggestions
    return Center(
      child: Text('Enter search query'),
    );
  }
}
