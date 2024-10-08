import 'dart:async';

import 'package:askute/model/GroupModel.dart';
import 'package:askute/view/Notification/notification_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:page_transition/page_transition.dart';
import 'package:web_socket_channel/io.dart';

import '../../controller/HomeController.dart';
import '../../controller/HomeGroupController.dart';
import '../../model/Class.dart';
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
  bool isLoadingMore = false;
  final HomeGroupController _homeGroupController =
      Get.put(HomeGroupController());
  final ScrollController _scrollController = ScrollController();

  // final channel = IOWebSocketChannel.connect('ws://192.168.1.10:8090/data');
  String? selectedValue = 'Đang theo dõi';

  Stream<List<PostModel>>? listPostStream;
  List<PostModel>? listPost;

  void initState() {
    super.initState();
    _startTimer();
    _scrollController.addListener(_scrollListener);
    _homeController.load10HotPost(context);
    _homeGroupController.GetListPost(context);
    _homeGroupController.loadGroupsJoin();
    _homeGroupController.loadGroupsOfAdmin();
  }

  late Timer _timer;

  void _startTimer() {
    _timer = Timer.periodic(Duration(milliseconds: 500), (timer) {
      if (selectedValue == 'Đang theo dõi' &&
          _homeGroupController.pagenumber.value == 0) {
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
      }
      if (selectedValue == 'Đang theo dõi' &&
          _homeGroupController.pagenumber.value != 0) {
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
      }
      if (selectedValue == 'Theo lớp' &&
          _homeGroupController.pagenumberClass.value == 0) {
        _homeGroupController.GetListPostClass(context);
        // Gọi hàm cần thiết ở đây
        listPostStream = _homeGroupController.allPostClassesStream;
        // Đây là Stream mà bạn cần theo dõi
        listPostStream?.listen((List<PostModel>? updatedGroups) {
          if (updatedGroups != null) {
            setState(() {
              listPost = updatedGroups;
            });
          }
        });
      }
      if (selectedValue == 'Theo lớp' &&
          _homeGroupController.pagenumberClass.value != 0) {
        // Gọi hàm cần thiết ở đây
        listPostStream = _homeGroupController.allPostClassesStream;
        // Đây là Stream mà bạn cần theo dõi
        listPostStream?.listen((List<PostModel>? updatedGroups) {
          if (updatedGroups != null) {
            setState(() {
              listPost = updatedGroups;
            });
          }
        });
      }
      if (selectedValue == 'Nổi bật') {
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

  void _scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      // Nếu đã đến cuối trang
      _loadMoreData(); // Gọi hàm để load thêm dữ liệu
    }
  }

  void _loadMoreData() {
    // Load thêm dữ liệu ở đây, ví dụ:
    if (selectedValue == 'Đang theo dõi') {
      _homeGroupController
          .loadMorePosts(context); // Gọi hàm để load thêm bài viết
      listPostStream = _homeGroupController.allPostFollowingStream;
      int a = 0;
    } else if (selectedValue == 'Theo lớp') {

      _homeGroupController
          .loadMorePostsClass(context); // Gọi hàm để load thêm bài viết
      listPostStream = _homeGroupController.allPostClassesStream;

    } else if (selectedValue == 'Nổi bật') {
      // _homeController.loadMoreHotPosts(); // Gọi hàm để load thêm bài viết nổi bật
    }
    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        isLoadingMore = false;
      });
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
            //controller: _scrollController,
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
                                            'Theo lớp',
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
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      PageTransition(
                                        type: PageTransitionType.bottomToTop,
                                        child: NotificationScreen(),
                                      ),
                                    );
                                  },
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
    return NotificationListener<ScrollNotification>(
        onNotification: (notification) {
          if (notification is ScrollEndNotification &&
              notification.metrics.extentAfter == 0) {
            setState(() {
              isLoadingMore =
                  true; // Đặt isLoadingMore thành true để hiển thị cử chỉ loading
            });
            _loadMoreData(); // Nếu scroll đã cuộn đến cuối trang và không cuộn thêm nữa, load thêm dữ liệu
          }
          return true;
        },
        child: selectedValue == 'Đang theo dõi'
            ? Expanded(
                child: StreamBuilder<List<PostModel>>(
                stream: listPostStream,
                builder: (context, snapshot) {
                  if (snapshot.hasData && snapshot.data != null) {
                    return Stack(
                      children: [
                        HotPostQuestionScreen(listPost: snapshot.data!),
                        if (isLoadingMore) // Hiển thị cử chỉ loading nếu đang load thêm dữ liệu
                          Center(
                            child:
                                CircularProgressIndicator(), // Hiển thị widget CircularProgressIndicator
                          ),
                      ],
                    );
                  } else
                    return Container(
                      child:
                          Text('Theo dõi thêm khoa để xem thêm bài viết mới'),
                    );
                },
              ))
            : selectedValue == 'Nổi bật'
                ? Expanded(
                    child: StreamBuilder<List<PostModel>>(
                    stream: listPostStream,
                    builder: (context, snapshot) {
                      if (snapshot.hasData && snapshot.data != null) {
                        return HotPostQuestionScreen(listPost: snapshot.data!);
                      } else
                        return Container(
                          child: Text('Đang tải ba viết nổi bật'),
                        );
                    },
                  ))
                :  Expanded(
                    child: StreamBuilder<List<PostModel>>(
                    stream: listPostStream,
                    builder: (context, snapshot) {
                      if (snapshot.hasData && snapshot.data != null) {
                        return Stack(
                          children: [
                            HotPostQuestionScreen(listPost: snapshot.data!),
                            if (isLoadingMore) // Hiển thị cử chỉ loading nếu đang load thêm dữ liệu
                              Center(
                                child:
                                    CircularProgressIndicator(), // Hiển thị widget CircularProgressIndicator
                              ),
                          ],
                        );
                      } else
                        return Container(
                          child:
                              Text('Vui lòng vào lớp để xem thêm bài viết mới'),
                        );
                    },
                  )));
  }

  Widget _buildPostold() {
    return Expanded(
        child: HotPostQuestionScreen(listPost: _homeGroupController.listPost));
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
