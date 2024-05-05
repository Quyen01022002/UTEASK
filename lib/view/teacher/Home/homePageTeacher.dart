import 'package:askute/controller/HomeController.dart';
import 'package:askute/controller/HomeGroupController.dart';
import 'package:askute/view/component/one_comment.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:get/get.dart';
import 'package:fl_chart/fl_chart.dart';

import '../../Quetions/QuestionDetail.dart';

class HomePageTeacher extends StatefulWidget {
  const HomePageTeacher({super.key});

  @override
  State<HomePageTeacher> createState() => _HomePageTeacherState();
}

class _HomePageTeacherState extends State<HomePageTeacher> {
  final HomeController _homeController = Get.put(HomeController());

  @override
  void initState() {
    super.initState();
    _homeController.load10HotPost(context);
    _homeController.load10HotPostOnAllClassOfTeacher(context);
    _homeController.loadCommentClasses(context);

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
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Bài Viết Gần Đây",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        CarouselSlider(
          options: CarouselOptions(
            aspectRatio: 16 / 9,
            autoPlay: true,
            enlargeCenterPage: true,
          ),
          items: _homeController.top10PostClass!.map((item) {
            print(_homeController.top10Post);
            return Builder(
              builder: (BuildContext context) {
                return Stack(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.symmetric(horizontal: 5.0),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(item.listAnh.first.toString()),
                          // Thay đổi đường dẫn tới ảnh của bạn
                          fit: BoxFit.cover, // Đảm bảo ảnh sẽ che đầy Container
                        ),
                        borderRadius: BorderRadius.circular(10.0),
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
                  ],
                );
              },
            );
          }).toList(),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Câu Trả lời Gần Đây",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        _buildListCommnetClasses()
        // Padding(
        //   padding: const EdgeInsets.all(8.0),
        //   child: Container(
        //     decoration: BoxDecoration(
        //       color: Colors.white,
        //       borderRadius: BorderRadius.circular(20),
        //       boxShadow: [
        //         BoxShadow(
        //           color: Colors.grey.withOpacity(0.5),
        //           spreadRadius: 5,
        //           blurRadius: 7,
        //           offset: Offset(0, 3), // Điều chỉnh vị trí của bóng
        //         ),
        //       ],
        //     ),
        //     width: MediaQuery.of(context).size.width * 90 / 100,
        //     child: Column(
        //       crossAxisAlignment: CrossAxisAlignment.start,
        //       children: [
        //         Padding(
        //           padding: const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 0),
        //           child: Row(
        //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //             children: [
        //               Text(
        //                 "Content",
        //                 style: TextStyle(
        //                   fontWeight: FontWeight.bold,
        //                   fontSize: 16,
        //                 ),
        //               ),
        //               Image.asset(
        //                 "assets/images/login.png",
        //                 width: 100,
        //                 height: 60,
        //                 fit: BoxFit.cover,
        //               ),
        //             ],
        //           ),
        //         ),
        //         Padding(
        //           padding: const EdgeInsets.fromLTRB(12.0, 8.0, 12.0, 12.0),
        //           child: Row(
        //             crossAxisAlignment: CrossAxisAlignment.start,
        //             children: [
        //               ClipOval(
        //                 child: Image.asset(
        //                   "assets/images/login.png",
        //                   width: 25,
        //                   height: 25,
        //                   fit: BoxFit.cover,
        //                 ),
        //               ),
        //               SizedBox(width: 8),
        //               Expanded(
        //                 child: Column(
        //                   crossAxisAlignment: CrossAxisAlignment.start,
        //                   children: [
        //                     Text(
        //                       "Trần Bửu Quyến",
        //                       style: TextStyle(
        //                         fontWeight: FontWeight.bold,
        //                         fontSize: 14,
        //                       ),
        //                     ),
        //                     SizedBox(height: 4),
        //                     Text(
        //                       "Đây là câu hỏi nè",
        //                       style: TextStyle(
        //                         fontSize: 14,
        //                       ),
        //                     ),
        //                   ],
        //                 ),
        //               ),
        //             ],
        //           ),
        //         ),
        //       ],
        //     ),
        //   ),
        // ),
        // Padding(
        //   padding: const EdgeInsets.all(8.0),
        //   child: Container(
        //     decoration: BoxDecoration(
        //       color: Colors.white,
        //       borderRadius: BorderRadius.circular(20),
        //       boxShadow: [
        //         BoxShadow(
        //           color: Colors.grey.withOpacity(0.5),
        //           spreadRadius: 5,
        //           blurRadius: 7,
        //           offset: Offset(0, 3), // Điều chỉnh vị trí của bóng
        //         ),
        //       ],
        //     ),
        //     width: MediaQuery.of(context).size.width * 90 / 100,
        //     child: Column(
        //       crossAxisAlignment: CrossAxisAlignment.start,
        //       children: [
        //         Padding(
        //           padding: const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 0),
        //           child: Row(
        //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //             children: [
        //               Text(
        //                 "Content",
        //                 style: TextStyle(
        //                   fontWeight: FontWeight.bold,
        //                   fontSize: 16,
        //                 ),
        //               ),
        //               Image.asset(
        //                 "assets/images/login.png",
        //                 width: 100,
        //                 height: 60,
        //                 fit: BoxFit.cover,
        //               ),
        //             ],
        //           ),
        //         ),
        //         Padding(
        //           padding: const EdgeInsets.fromLTRB(12.0, 8.0, 12.0, 12.0),
        //           child: Row(
        //             crossAxisAlignment: CrossAxisAlignment.start,
        //             children: [
        //               ClipOval(
        //                 child: Image.asset(
        //                   "assets/images/login.png",
        //                   width: 25,
        //                   height: 25,
        //                   fit: BoxFit.cover,
        //                 ),
        //               ),
        //               SizedBox(width: 8),
        //               Expanded(
        //                 child: Column(
        //                   crossAxisAlignment: CrossAxisAlignment.start,
        //                   children: [
        //                     Text(
        //                       "Trần Bửu ",
        //                       style: TextStyle(
        //                         fontWeight: FontWeight.bold,
        //                         fontSize: 14,
        //                       ),
        //                     ),
        //                     SizedBox(height: 4),
        //                     Text(
        //                       "Sự khác nhau giữa List và ArrayList là gì ",
        //                       style: TextStyle(
        //                         fontSize: 14,
        //                       ),
        //                     ),
        //                   ],
        //                 ),
        //               ),
        //             ],
        //           ),
        //         ),
        //       ],
        //     ),
        //   ),
        // ),


      ],
    );
  }

  Widget _buildListCommnetClasses(){
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
                        Container(
                          width: 100,
                          height: 100,
                          child: Text(
                            cmt.post_id!.contentPost,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        Container(
                          width: 100,
                          height: 100,
                          child: Image.network(
                            cmt.post_id!.listAnh[0],
                            width: 100,
                            height: 60,
                            fit: BoxFit.cover,
                          ),
                        ),
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
                                cmt.first_name! + ' '+ cmt.last_name!,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                              SizedBox(height: 4),
                              content[0].type=='TEXT'?Text(
                                content[0].content,
                                style: TextStyle(
                                  fontSize: 14,
                                ),
                                overflow: TextOverflow.ellipsis, // Giới hạn và cắt bớt nội dung
                                maxLines: 1,
                              ) :Text(
                                'Đã bình luận bằng hình ảnh',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold
                                ),
                                overflow: TextOverflow.ellipsis, // Giới hạn và cắt bớt nội dung
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
