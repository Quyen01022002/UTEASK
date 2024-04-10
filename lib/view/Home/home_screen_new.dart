import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_socket_channel/io.dart';

import '../../controller/HomeController.dart';
import 'hot_post_screen.dart';

class HomeScreen2 extends StatefulWidget {
  const HomeScreen2({super.key});

  @override
  State<HomeScreen2> createState() => _HomeScreen2State();
}

class _HomeScreen2State extends State<HomeScreen2> {
  final HomeController _homeController = Get.put(HomeController());

  final channel = IOWebSocketChannel.connect('ws://192.168.1.10:8090/data');

  void initState() {
    super.initState();
    _homeController.load10HotPost(context);
    print('bắt đầu tới channel');
    streamListener();

  }

  streamListener(){
    channel.stream.listen((event) {
      print("đã vào trong đây");
    print(event);
    }, onError: (error) {
      print('Đã xảy ra lỗi khi kết nối WebSocket: $error');
    });

  }
  @override
  void dispose() {
    channel.sink.close();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          body: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                SliverAppBar(
                  pinned: true,
                  title: Container(
                    padding: EdgeInsets.all(10),
                    child: Row(
                      children: [

                        Expanded(
                          child: TextField(
                          //  controller: _searchPostController.textControllerKeyword,
                            onTap: () {
                              // _showSearchSuggestions();
                            },
                            decoration: InputDecoration(
                              hintText: 'Search for.....',
                              border: InputBorder.none,
                            ),
                            style: TextStyle(
                              fontSize: 18,
                              color: Color(0xFFB4BDC4),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {

                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(Icons.search),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ];
            },
            body: HotPostQuestionScreen(listPost: _homeController.top10Post),

          ),
        ));
  }
}
