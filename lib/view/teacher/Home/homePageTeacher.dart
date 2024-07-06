import 'package:askute/controller/HomeController.dart';
import 'package:askute/controller/HomeGroupController.dart';
import 'package:askute/controller/LoginController.dart';
import 'package:askute/controller/PostController.dart';
import 'package:askute/model/UserProgress.dart';
import 'package:askute/view/component/one_comment.dart';
import 'package:askute/view/user/user_proflie_other.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:page_transition/page_transition.dart';

import '../../Quetions/QuestionDetail.dart';

class HomePageTeacher extends StatefulWidget {
  const HomePageTeacher({super.key});

  @override
  State<HomePageTeacher> createState() => _HomePageTeacherState();
}

class _HomePageTeacherState extends State<HomePageTeacher> {
  final HomeController _homeController = Get.put(HomeController());
final PostController _postController = Get.put(PostController());
final LoginController _loginController = Get.put(LoginController());
  @override
  void initState() {
    super.initState();
    fetchData();
    _homeController.load10HotPost(context);
  //  _homeController.load10HotPostOnAllClassOfTeacher(context);
    _homeController.loadPostNotReply(context);
    _homeController.loadCommentByMe(context);
  }

  List<ContentComment> parseContent(String contentString) {
    List<String> parts = contentString.split(', ');
    List<ContentComment> contentList = [];
    for (String part in parts) {
      List<String> pair = part.split('][');
      if (pair.length == 2) {
        String type = pair[0].replaceAll('[', '');
        String content = pair[1].replaceAll(']', '');
        contentList.add(ContentComment(type, content));
      }
    }

    return contentList;
  }

  Future<UserProgress?> fetchData() async {
    // Đây là ví dụ về việc tải dữ liệu từ cơ sở dữ liệu hoặc một API
    // Thay thế phần này bằng hàm thực sự để tải dữ liệu của bạn
    await _homeController.loadCommentByMe(context);
    await _homeController.loadPostNotReplyValue(context);
    return await _homeController.loadMyProgress(context);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fetchData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Hiển thị màn hình chờ khi dữ liệu đang được tải
          return Center(child: Container(
              child: CircularProgressIndicator()));
        }
        else if (snapshot.hasError) {
          // Hiển thị lỗi nếu có lỗi xảy ra trong quá trình tải dữ liệu
          return Text('Error: ${snapshot.error} ${snapshot.data!}' );
        }
        else {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Tiến độ cá nhân",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    LinearProgressIndicator(
                      value: snapshot.data!.countAllPostReply == 0? 1 : snapshot.data!.countPostRelied!/snapshot.data!.countAllPostReply!,
                      backgroundColor: Colors.grey[300],
                      color: Colors.blue,
                    ),
                    SizedBox(height: 5),
                    Text('Câu hỏi nhận được: ${snapshot.data!.countAllPostReply}'),
                    Text('Câu hỏi đã hoàn thành: ${snapshot.data!.countPostRelied}'),
                    SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Center(
                        child: Text(
                          "Xem chi tiết...",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.blue),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Bài viết chưa phản hồi",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            _homeController.listPostNotReply.length != 0 ?
            CarouselSlider(
              options: CarouselOptions(
                aspectRatio: 16 / 9,
                autoPlay: true,
                enlargeCenterPage: true,
              ),
              items: _homeController.listPostNotReply!.map((item) {
                print(_homeController.listPostNotReply);
                return Builder(
                  builder: (BuildContext context) {
                    return Stack(
                      children: [
                        item.listAnh!.length != 0
                            ? GestureDetector(
                          onTap: (){
                            Navigator.push(
                              context,
                              PageTransition(
                                type: PageTransitionType.rightToLeft,
                                child: QuestionDetailScreen(post: item,checkUserReply: _loginController.idMe.value,),
                              ),
                            ).then((_) {
                              // This block runs when returning to this page
                              // Place your reload logic here
                              setState(() {
                                // Call the method to reload the page
                                fetchData();
                                build(context);
                              });
                            });
                          },
                              child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  margin: EdgeInsets.symmetric(horizontal: 5.0),
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image:
                                          NetworkImage(item.listAnh!.first.toString()),
                                      // Thay đổi đường dẫn tới ảnh của bạn
                                      fit: BoxFit
                                          .cover, // Đảm bảo ảnh sẽ che đầy Container
                                    ),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                            )
                            : GestureDetector(
                          onTap: (){
                            Navigator.push(
                              context,
                              PageTransition(
                                type: PageTransitionType.rightToLeft,
                                child: QuestionDetailScreen(post: item,checkUserReply: _loginController.idMe.value,),
                              ),
                            ).then((_) {
                              // This block runs when returning to this page
                              // Place your reload logic here
                              setState(() {
                                // Call the method to reload the page
                                fetchData();
                                build(context);
                              });
                            });
                          },
                              child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  margin: EdgeInsets.symmetric(horizontal: 5.0),
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage("assets/images/login.png"),
                                      // Thay đổi đường dẫn tới ảnh của bạn
                                      fit: BoxFit
                                          .cover, // Đảm bảo ảnh sẽ che đầy Container
                                    ),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                            ),
                        Positioned(
                          child: Container(
                            height: 50,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                                colors: [
                                  Colors.black.withOpacity(0.6),
                                  // Đen với độ trong suốt 60%
                                  Colors.transparent,
                                  // Trong suốt
                                ],
                              ),
                            ),
                            child: GestureDetector(
                              onTap: (){
                                Navigator.push(
                                  context,
                                  PageTransition(
                                    type: PageTransitionType.rightToLeft,
                                    child: QuestionDetailScreen(post: item,checkUserReply: _loginController.idMe.value,),
                                  ),
                                ).then((_) {
                                  // This block runs when returning to this page
                                  // Place your reload logic here
                                  setState(() {
                                    // Call the method to reload the page
                                    fetchData();
                                    build(context);
                                  });
                                });
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  item.contentPost.toString(),
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0, // Đặt vị trí chồng lên dưới cùng
                          left: 0,
                          right: 0, // Đặt vị trí chồng lên bên phải
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                PageTransition(
                                  type: PageTransitionType.rightToLeft,
                                  child: ProfileUserOther(
                                    id: item.createBy!.id,
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10.0, vertical: 5.0),
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    backgroundImage: NetworkImage(
                                        item.createBy!.profilePicture.toString()),
                                    radius: 35.0, // Bán kính của avatar
                                  ),
                                  SizedBox(width: 10.0),
                                  Expanded(
                                    child: Text(
                                      "${item.createBy!.firstName} ${item.createBy!.lastName}",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                );
              }).toList(),
            ) : Container(
              child: Center(
                child: Text("Chưa có câu hỏi nào dành cho bạn"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Câu Trả lời Gần Đây",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            _buildListCommnetClasses()
          ],
        );}
      }
    );
  }

  Widget _buildListCommnetClasses() {
    return Expanded(
      child: ListView.builder(
        itemCount: _homeController.listComment.length,
        itemBuilder: (context, index) {
          final cmt = _homeController.listComment[index];
          List<ContentComment> content = parseContent(cmt.content_cmt!);

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3), // Điều chỉnh vị trí của bóng
                  ),
                ],
              ),
              width: MediaQuery.of(context).size.width * 90 / 100,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () async {
                            final post = await _postController.loadAPost(context, cmt.post_id!.id!);
                            Navigator.push(
                              context,
                              PageTransition(
                                type: PageTransitionType.rightToLeft,
                                child: QuestionDetailScreen(post: post!,checkUserReply: _loginController.idMe.value),
                              ),
                            ).then((_) {
                              // This block runs when returning to this page
                              // Place your reload logic here
                              setState(() {
                                // Call the method to reload the page
                                fetchData();
                                build(context);
                              });
                            });
                          },
                          child: Container(
                            width: cmt.post_id!.listAnh.length!=0 ? 100 : 300,
                            height: cmt.post_id!.listAnh.length!=0? 100: 50,
                            child: Text(
                              cmt.post_id!.contentPost,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                        cmt.post_id!.listAnh.length!=0 ?   Container(
                          width: 100,
                          height: 100,
                          child: Image.network(
                             cmt.post_id!.listAnh[0],
                            width: 100,
                            height: 60,
                            fit: BoxFit.cover,
                          ),
                        ) : Container(),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(12.0, 8.0, 12.0, 12.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipOval(
                          child: Image.network(
                            cmt.avatar!,
                            width: 25,
                            height: 25,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(width: 8),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                cmt.first_name! + ' ' + cmt.last_name!,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                              SizedBox(height: 4),
                              content[0].type == 'TEXT'
                                  ? Text(
                                      content[0].content,
                                      style: TextStyle(
                                        fontSize: 14,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                      // Giới hạn và cắt bớt nội dung
                                      maxLines: 1,
                                    )
                                  : Text(
                                      'Đã bình luận bằng hình ảnh',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                      overflow: TextOverflow.ellipsis,
                                      // Giới hạn và cắt bớt nội dung
                                      maxLines: 1,
                                    ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
