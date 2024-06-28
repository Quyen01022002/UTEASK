import 'dart:async';

import 'package:askute/controller/HomeController.dart';
import 'package:askute/controller/HomeGroupController.dart';
import 'package:askute/controller/LoginController.dart';
import 'package:askute/controller/MyProfileController.dart';
import 'package:askute/controller/PostController.dart';
import 'package:askute/model/PostModel.dart';
import 'package:askute/model/ReportPostResponse.dart';
import 'package:askute/view/Notification/notification_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PostReportItem extends StatefulWidget {
  final ReportPostResponse reportPostResponse;
  final VoidCallback onReportAction;
  const PostReportItem({Key? key, required this.reportPostResponse, required this.onReportAction})
      : super(key: key);

  @override
  State<PostReportItem> createState() => _PostReportItemState();
}

class _PostReportItemState extends State<PostReportItem> {
  late String formattedTime = '';
  final PostController postController = Get.put(PostController());
  final HomeController homeController = Get.put(HomeController());
  MyProfileController myProfileController = Get.put(MyProfileController());
  final HomeGroupController homeGroupController =
  Get.put(HomeGroupController());
  LoginController loginController = Get.put(LoginController());
  late bool statelike = false;
  late int contlike = 0;
  late RxInt curnetUser = 0.obs;
  Stream<PostModel>? postCurren;
  PostModel? postHT;

  @override
  void initState() {
    super.initState();
    formattedTime = formatTimeDifference(widget.reportPostResponse.timeStamp);
  }

  void initCurrentUser() async {
    final prefs = await SharedPreferences.getInstance();
    curnetUser = (prefs.getInt('id') ?? 0).obs;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
            child: GestureDetector(
              onTap: () {},
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {},
                    child: CircleAvatar(
                      radius: 20,
                      backgroundImage: NetworkImage(
                          widget.reportPostResponse.reporter.profilePicture),
                      // Hoặc sử dụng NetworkImage nếu avatar từ một URL
                      // backgroundImage: NetworkImage('URL_TO_AVATAR'),
                    ),
                  ),
                  SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {},
                        child: Text(
                          "${widget.reportPostResponse.reporter.firstName} ${widget.reportPostResponse.reporter.lastName}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Text(
                        "Báo cáo vào ${formattedTime}",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.black45,
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                ],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(top:0, bottom: 5, right: 10, left: 30),
            child: Text("${widget.reportPostResponse.reason}"),
          ),
          SizedBox(height: 2,),
          Center(
            child: GestureDetector(
              onTap: (){

              },
              child: Container(
                padding: EdgeInsets.all(8),
                height: widget.reportPostResponse.postModel.listAnh.length == 0
                    ? 110
                    : 150,
                width: 300,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black12,
                    // You can set the border color
                    width: 1.0, // You can set the border width
                  ),
                  borderRadius:
                      BorderRadius.circular(8.0), // Set the border radius
                ),
                child: widget.reportPostResponse.postModel.listAnh.length == 0
                    ? Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () {},
                              child: Container(
                                padding: EdgeInsets.only(left: 5),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        GestureDetector(
                                          onTap: () {},
                                          child: CircleAvatar(
                                            radius: 15,
                                            backgroundImage: NetworkImage(widget
                                                .reportPostResponse
                                                .postModel.createBy
                                                .profilePicture),
                                            // Hoặc sử dụng NetworkImage nếu avatar từ một URL
                                            // backgroundImage: NetworkImage('URL_TO_AVATAR'),
                                          ),
                                        ),
                                        SizedBox(width: 8),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            GestureDetector(
                                              onTap: () {},
                                              child: Text(
                                                "${widget.reportPostResponse.postModel.createBy.firstName} ${widget.reportPostResponse.postModel.createBy.lastName}",
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Spacer(),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      padding: EdgeInsets.all(5.0),
                                      child: Text(
                                        widget.reportPostResponse.postModel
                                            .contentPost,
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.black87,
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    : Row(
                        children: [
                          Expanded(
                            flex: 6,
                            child: GestureDetector(
                              onTap: () {},
                              child: Container(
                                padding: EdgeInsets.only(left: 5),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        GestureDetector(
                                          onTap: () {},
                                          child: CircleAvatar(
                                            radius: 15,
                                            backgroundImage: NetworkImage(widget
                                                .reportPostResponse
                                                .postModel.createBy
                                                .profilePicture),
                                            // Hoặc sử dụng NetworkImage nếu avatar từ một URL
                                            // backgroundImage: NetworkImage('URL_TO_AVATAR'),
                                          ),
                                        ),
                                        SizedBox(width: 8),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            GestureDetector(
                                              onTap: () {},
                                              child: Text(
                                                "${widget.reportPostResponse.postModel.createBy.firstName} ${widget.reportPostResponse.postModel.createBy.lastName}",
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Spacer(),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      padding: EdgeInsets.all(5.0),
                                      child: Text(
                                        widget.reportPostResponse.postModel
                                            .contentPost,
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.black87,
                                        ),
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 4,
                            child: GestureDetector(
                                onTap: () {},
                                child: Stack(
                                  children: [
                                    Container(
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        // Bo góc ảnh nếu cần
                                        child: Image.network(
                                          widget.reportPostResponse.postModel
                                              .listAnh[0],
                                          fit: BoxFit.cover,
                                          width: double.infinity,
                                          // Đảm bảo ảnh chiếm toàn bộ chiều rộng của Stack
                                          height:
                                              200, // Đặt chiều cao cụ thể cho ảnh
                                        ),
                                      ),
                                    ),
                                    widget.reportPostResponse.postModel.listAnh
                                                .length ==
                                            1
                                        ? Container()
                                        : Positioned(
                                            bottom: 5,
                                            right: 5,
                                            child: Container(
                                              width: 40,
                                              height: 40,
                                              decoration: BoxDecoration(
                                                color: Colors.black54,
                                                // Màu đen xám với độ trong suốt
                                                shape: BoxShape.circle,
                                              ),
                                              child: Center(
                                                child: Text(
                                                  "+${(widget.reportPostResponse.postModel.listAnh.length - 1).toString()}",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                  ],
                                )),
                          ),
                        ],
                      ),
              ),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Container(
            padding: EdgeInsets.fromLTRB(150, 0, 0, 0),
            child: Row(
              children: [
                ElevatedButton(
                    onPressed: () async {
                      // Hành động khi nhấn nút thứ nhất
                      postController.CamPost(context, widget.reportPostResponse.id);
                      homeGroupController.pageReport.value = 0;
                      await homeGroupController.loadListReportPost(context);
                      widget.onReportAction();
                    },
                    style: ElevatedButton.styleFrom(
                      padding:
                          EdgeInsets.symmetric(horizontal: 22, vertical: 4),
                    ),
                    child: Text(
                      'Cấm',
                    )),
                SizedBox(width: 15), // Khoảng cách giữa hai nút
                ElevatedButton(
                  onPressed: () async{
                    // Hành động khi nhấn nút thứ hai
                    postController.DuyetPost(context, widget.reportPostResponse.id);
                    homeGroupController.pageReport.value = 0;
                   await homeGroupController.loadListReportPost(context);
                    widget.onReportAction();
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                    backgroundColor: Colors.blueAccent,
                  ),
                  child: Text(
                    "Duyệt",
                    style: TextStyle(fontSize: 15, color: Colors.black),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
