import 'dart:convert';

import 'package:askute/controller/Class/ClassController.dart';
import 'package:askute/controller/CreatePost.dart';
import 'package:askute/controller/HomeGroupController.dart';
import 'package:askute/model/PostModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:page_transition/page_transition.dart';
import 'package:carousel_slider/carousel_slider.dart';

class CreateClass extends StatefulWidget {
  final bool statepost;

  const CreateClass({Key? key, required this.statepost}) : super(key: key);

  @override
  State<CreateClass> createState() => _CreatePostState();
}

class _CreatePostState extends State<CreateClass> {
  List<XFile> _images = [];
  late bool statepost;
  late bool statecontent = false;
  late int? groupid=0;
  final HomeGroupController _homeController = Get.put(HomeGroupController());
  ClassController postController = new ClassController();

  @override
  void initState() {
    super.initState();
    statepost = widget.statepost;
    _homeController.loadGroupsOfAdmin();
  }






  @override
  Widget build(BuildContext context) {
    FocusNode _focusNode = FocusNode();
    FocusNode _focusNode2 = FocusNode();
    return statepost == false
        ? Scaffold(
            resizeToAvoidBottomInset: false,
            body: GestureDetector(
              child: SafeArea(
                child: SingleChildScrollView(
                  child: Container(
                    decoration: BoxDecoration(color: Colors.white),
                    child: Column(
                      children: [
                        Container(
                          height: 60,
                          decoration: BoxDecoration(),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 26.0),
                                child: Icon(Icons.arrow_back_ios),
                              ),
                              Text(
                                "Đặt câu hỏi",
                                style: TextStyle(
                                    color: Colors.black,
                                    decoration: TextDecoration.none,
                                    fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(right: 15),
                                child: statecontent == true
                                    ? ElevatedButton(
                                    onPressed: () async {
                                      setState(() {
                                        statepost = true;
                                      });


                                      postController.CreateGroup(context,groupid);
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.blue,
                                    ),
                                    child: Text("Đăng"))
                                    : ElevatedButton(
                                    onPressed: () async {},
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.grey,
                                    ),
                                    child: Text("Đăng")),
                              )
                            ],
                          ),
                        ),
                        CarouselSlider(
                          options: CarouselOptions(
                            height: 100.0,
                            viewportFraction: 0.8,
                            enlargeCenterPage: true,
                            onPageChanged: (index, reason) {
                              setState(() {
                                groupid=  _homeController.groups![index].id; // Update groupid with item.id
                                print(groupid);
                              });
                            },
                          ),
                          items: _homeController.groups!.map((item) {
                            return Builder(
                              builder: (BuildContext context) {
                                return Container(
                                  width: MediaQuery.of(context).size.width,
                                  margin: EdgeInsets.symmetric(horizontal: 5.0),
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage(item.avatar.toString()), // Thay đổi đường dẫn tới ảnh của bạn
                                      fit: BoxFit.cover, // Đảm bảo ảnh sẽ che đầy Container
                                    ),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: Center(
                                    child: Text(
                                      item.name.toString(),
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 24.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          }).toList(),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(22.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Tên Lớp Học:",style: TextStyle(fontWeight: FontWeight.bold),),
                              const SizedBox(height: 6,),
                              Container(
                                padding: EdgeInsets.all(16.0),
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 5,
                                      blurRadius: 7,
                                      offset: Offset(0, 3), // Độ dịch chuyển của bóng
                                    ),
                                  ],
                                  borderRadius: BorderRadius.circular(20.0), // Bo góc
                                  color: Colors.white,
                                ),
                                child: TextField(
                                  focusNode: _focusNode2,
                                  autofocus: false,
                                  controller: postController.textControllerNameGroup,
                                  maxLines: 2,
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
                                  decoration: InputDecoration(
                                    hintText: "Tên Lớp Học Của Bạn?",
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Text("Mô tả:",style: TextStyle(fontWeight: FontWeight.bold),),
                              const SizedBox(height: 6,),

                              Container(
                                padding: EdgeInsets.all(16.0),
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 5,
                                      blurRadius: 7,
                                      offset: Offset(0, 3), // Độ dịch chuyển của bóng
                                    ),
                                  ],
                                  borderRadius: BorderRadius.circular(20.0), // Bo góc
                                  color: Colors.white,
                                ),
                                child: TextField(
                                  focusNode: _focusNode,
                                  autofocus: false,
                                  controller: postController.textControllerMota,
                                  maxLines: 4,
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
                                  decoration: InputDecoration(
                                    hintText: "Tên Lớp Học Của Bạn?",
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                            ],
                          ),
                        ),


                      ],
                    ),
                  ),
                ),
              ),
            ),
          )
        : Center(
            child: SpinKitFoldingCube(
              color: Colors.blue,
              size: 50.0,
            ),
          );
  }
}
