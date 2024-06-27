import 'dart:async';

import 'package:askute/model/GroupModel.dart';
import 'package:askute/view/Notification/notification_screen.dart';
import 'package:askute/view/component/post_newScreen.dart';
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

class HomeScreen3 extends StatefulWidget {
  const HomeScreen3({super.key});

  @override
  State<HomeScreen3> createState() => _HomeScreen3State();
}

class _HomeScreen3State extends State<HomeScreen3> {
  final HomeController homeController = Get.put(HomeController());
  bool isLoadingMore = false;
  final HomeGroupController homeGroupController =
  Get.put(HomeGroupController());
  final ScrollController _scrollController = ScrollController();
  List<PostModel> _posts = [];
  bool _isLoading = false;
  // final channel = IOWebSocketChannel.connect('ws://192.168.1.10:8090/data');
  String? selectedValue = 'Đang theo dõi';

  Stream<List<PostModel>>? listPostStream;
  List<PostModel>? listPost;

  void initState() {
    super.initState();
    homeGroupController.pagenumber3.value = 0;
    _posts.clear();
    _fetchPosts();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        _fetchPosts();
      }
    });
  }

  Future<void> _fetchPosts() async {
    if (_isLoading) return;
    setState(() {
      _isLoading = true;
    });
    List<PostModel>? response;
    if (selectedValue == 'Đang theo dõi')
      response = await homeGroupController.morePosts(context, homeGroupController.pagenumber3.value);
    else if (selectedValue == 'Theo lớp')
      response = await homeGroupController.morePostsClass(context);
    else
      response = await homeController.load10post(context);

    if (response!= null && response.length!=0) {
      setState(() {
        if (selectedValue == 'Đang theo dõi')
        {
          homeGroupController.pagenumber4.value = 0;
          homeGroupController.pagenumber3.value++;}
        else if (selectedValue == 'Theo lớp')
          {
            homeGroupController.pagenumber4.value++;
            homeGroupController.pagenumber3.value =0;
          }
          else
            {
              homeGroupController.pagenumber4.value = 0;
              homeGroupController.pagenumber3.value = 0;
            }
        _posts.addAll(response!);
        _isLoading = false;
      });
    } else {
      setState(() {
        _isLoading = false;
      });
      throw Exception('Failed to load posts');
    }
  }


  @override
  void dispose() {
    _scrollController.dispose();
    homeGroupController.pagenumber3.value = 0;
    homeGroupController.pagenumber4.value = 0;
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
                                                  _posts.clear();
                                                  _fetchPosts();
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
                body: _buildPost(),
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

  Widget _buildPost(){
    return Container(
      child: ListView.builder(
        controller: _scrollController,
        itemCount: _posts.length + 1,
        itemBuilder: (context, index) {
          if (index == _posts.length) {
            return _isLoading ? Center(child: CircularProgressIndicator()) : SizedBox.shrink();
          }
          return Column(
            children: [
              PostScreenNew(post: _posts[index]),
              Container(
                margin: EdgeInsets.only(top: 5),
                height: 10, // Chiều cao của thanh ngang
                width: 500, // Độ dày của thanh ngang
                color: Colors.black12,
              ),
            ],
          );
        },
      ),
    );
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
