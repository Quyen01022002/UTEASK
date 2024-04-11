import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:web_socket_channel/io.dart';

import '../../controller/HomeController.dart';
import '../../controller/HomeGroupController.dart';
import '../../model/GroupModel.dart';
import '../../model/PostModel.dart';
import '../component/categoryItem.dart';
import 'hot_post_screen.dart';

class HomeScreen2 extends StatefulWidget {
  const HomeScreen2({super.key});

  @override
  State<HomeScreen2> createState() => _HomeScreen2State();
}

class _HomeScreen2State extends State<HomeScreen2> {
  final HomeController _homeController = Get.put(HomeController());
  final HomeGroupController _homeGroupController =
      Get.put(HomeGroupController());

  // final channel = IOWebSocketChannel.connect('ws://192.168.1.10:8090/data');
  String? selectedValue = 'Đang theo dõi';

  Stream<List<PostModel>>? listPostStream;
  List<PostModel>? listPost;

  void initState() {
    super.initState();
    _startTimer();
    _homeController.load10HotPost(context);
    _homeGroupController.GetListPost(context);
    _homeGroupController.loadGroupsJoin();
    _homeGroupController.loadGroupsOfAdmin();
  }

  late Timer _timer;

  void _startTimer() {
    _timer = Timer.periodic(Duration(milliseconds: 500), (timer) {
      if (selectedValue == 'Đang theo dõi') {
        _homeGroupController.GetListPost(context);
        // Gọi hàm cần thiết ở đây
        listPostStream = _homeGroupController.allPostFollowingStream;
        // Đây là Stream mà bạn cần theo dõi
        listPostStream?.listen((List<PostModel>? updatedGroups) {
          if (updatedGroups != null) {
            setState(() {
              listPost = updatedGroups;
            });
          }
        });
      } else if (selectedValue == 'Nổi bật') {
        _homeController.load10HotPost(context);
        // Gọi hàm cần thiết ở đây
        listPostStream = _homeController.allPostHotStream;
        // Đây là Stream mà bạn cần theo dõi
        listPostStream?.listen((List<PostModel>? updatedGroups) {
          if (updatedGroups != null) {
            setState(() {
              listPost = updatedGroups;
            });
          }
        });
      }
    });
  }

  // streamListener() {
  //   channel.stream.listen((event) {
  //     print("đã vào trong đây");
  //     print(event);
  //   }, onError: (error) {
  //     print('Đã xảy ra lỗi khi kết nối WebSocket: $error');
  //   });
  // }

  @override
  void dispose() {
    //channel.sink.close();
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                SliverAppBar(
                  toolbarHeight: 50,
                  pinned: true,
                  floating: false,
                  stretch: true,
                  automaticallyImplyLeading: false,
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  title: Container(
                    padding: EdgeInsets.zero,
                    child: Stack(
                      children: [
                        Container(
                          margin: EdgeInsets.only(bottom: 20, left: 20),
                          height: 50,
                          //color: Colors.red,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/images/SHAPE.png'),
                              // Đường dẫn đến hình ảnh
                              fit: BoxFit
                                  .cover, // Cách hình ảnh được sắp xếp trong container
                            ),
                          ),
                          // decoration: BoxDecoration(
                          //   gradient: LinearGradient(
                          //     begin: Alignment.topCenter,
                          //     end: Alignment.bottomCenter,
                          //     colors: [
                          //       Colors.blue, // Màu đầu tiên
                          //       Colors.green, // Màu thứ hai
                          //     ],
                          //   ),
                          // ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(flex: 2, child: Container()),
                              Expanded(
                                flex: 5,
                                child: Column(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.only(top: 15),
                                      child: DropdownButtonHideUnderline(
                                        child: DropdownButton<String>(
                                          value: selectedValue,
                                          // Giá trị được chọn
                                          items: <String>[
                                            //'Tất cả',
                                            'Đang theo dõi',
                                            'Nổi bật'
                                          ].map((String value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(
                                                value,
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  // Kích thước của văn bản
                                                  color: Colors.black,
                                                  // Màu văn bản
                                                  fontWeight: FontWeight
                                                      .bold, // Độ đậm của văn bản
                                                  // Các thuộc tính khác nếu cần
                                                ),
                                              ),
                                            );
                                          }).toList(),
                                          onChanged: (String? newValue) {
                                            // Cập nhật giá trị được chọn khi người dùng chọn một tùy chọn mới
                                            setState(() {
                                              selectedValue = newValue;
                                            });
                                          },
                                          isExpanded: true,
                                          icon: Icon(Icons.arrow_drop_down),
                                          iconSize: 30,
                                          isDense: true,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(flex: 2, child: Container()),
                              Expanded(
                                flex: 1,
                                child: GestureDetector(
                                  onTap: () {},
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      padding: EdgeInsets.only(top: 10),
                                      child: Icon(
                                        Icons.notifications,
                                        color: Colors.blueAccent,
                                        size: 30,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ];
            },
            body: selectedValue == 'Đang theo dõi'
                ? Column(
                    children: [
                      // Container(
                      //   margin: EdgeInsets.only(left: 80, right: 15),
                      //   height: 50,
                      //   child: Expanded(
                      //     child: ListView.builder(
                      //       scrollDirection: Axis.horizontal,
                      //       itemCount: 10, // Số lượng hình ảnh avatar
                      //       itemBuilder: (BuildContext context, int index) {
                      //         // Trả về một widget avatar
                      //         return GestureDetector(
                      //           onTap: (){
                      //
                      //           },
                      //           child: Padding(
                      //             padding: const EdgeInsets.all(8.0), // Khoảng cách giữa các avatar
                      //             child: CircleAvatar(
                      //               backgroundImage: NetworkImage('https://i.pinimg.com/736x/46/93/87/469387400be3d2adc12f68167032985a.jpg'),  // Thay đổi đường dẫn tùy thuộc vào index
                      //               radius: 30, // Bán kính của avatar
                      //             ),
                      //           ),
                      //         );
                      //       },
                      //     ),
                      //   ),
                      // ),
                      Container(
                        margin: EdgeInsets.only(left: 60, right: 15),
                        child: Row(
                          children: [
                            GestureDetector(
                                onTap: () {
                                  showModalBottomSheet(
                                    context: context,
                                    backgroundColor: Colors.transparent,
                                    builder: (BuildContext context) {
                                      return _buildPopup(context,
                                          _homeGroupController.groups!);
                                    },
                                  );
                                },
                                child: Icon(Icons.filter_list)),
                            Expanded(
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: [
                              
                                    Row(
                                      children: _homeGroupController.groupsJoin!
                                          .map((post) {
                                        return categoryItem(post: post);
                                      }).toList(),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      _buildPost(),
                    ],
                  )
                : _buildPost(),
          ),
          Positioned(
            top: -20,
            left: -20,
            child: ClipRect(
              child: Expanded(
                child: Container(
                  padding: EdgeInsets.only(bottom: 5, right: 5),
                  color: Colors.transparent,
                  height: 100,
                  width: 100,
                  child: Stack(
                    children: [
                      Image.asset(
                        'assets/images/SHAPE.png',
                        width: 100, // Đổi kích thước tùy ý
                        height: 100,
                        fit: BoxFit.cover, // Đổi kích thước tùy ý
                      ),
                      Positioned(
                          top: 40,
                          left: 40,
                          child: Row(
                            children: [
                              Text(
                                'U',
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'T',
                                style: TextStyle(
                                    color: Colors.green,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'E',
                                style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          )),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    ));
  }

  Widget _buildPost() {
    return Expanded(
        child: StreamBuilder<List<PostModel>>(
      stream: listPostStream,
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data != null) {
          return HotPostQuestionScreen(listPost: snapshot.data!);
        } else
          return Container(
            child: Text('Vui lòng theo dõi thêm khoa để xem các bài viết'),
          );
      },
    ));
  }
}

Widget _buildPopup(BuildContext context, List<GroupModel> post) {
  return Container(
    margin: EdgeInsets.only(bottom: 350),
    child: AnimatedOpacity(
      opacity: 1.0,
      duration: Duration(milliseconds: 600),
      child: SlideTransition(
        position: Tween<Offset>(
          begin: Offset(0, -1),
          end: Offset.zero,
        ).animate(CurvedAnimation(
          parent: ModalRoute.of(context)!.animation!,
          curve: Curves.easeInOut,
        )),
        child: Container(
          height: 200,
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(20),
            ),
          ),
          child: ListView(
            children: [
              Column(
                children: post.map((item) {
                  return categoryItem(post: item);
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
