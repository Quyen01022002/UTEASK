import 'package:askute/controller/HomeGroupController.dart';
import 'package:askute/controller/LoginController.dart';
import 'package:askute/model/GroupModel.dart';
import 'package:askute/model/PostModel.dart';
import 'package:askute/view/component/post_newScreen.dart';
import 'package:askute/view/component/post_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomeGroup extends StatefulWidget {

  final GroupModel? groupModel;
  const HomeGroup({super.key, required this.groupModel});
  @override
  _HomeGroupState createState() => _HomeGroupState();
}

class _HomeGroupState extends State<HomeGroup> {

  final HomeGroupController homeGroupController = Get.put(HomeGroupController());
  final LoginController _loginController = Get.put(LoginController());
  List<PostModel> _posts = [];
  bool _isLoading = false;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
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

    final response = await homeGroupController.loadPostOfGroupView(widget.groupModel!.id!,context);
    if (response!= null && response.length!=0) {
      setState(() {
        homeGroupController.numberGroupPage.value++;
        _posts.addAll(response);
        _isLoading = false;
      });
    } else {
      setState(() {
        _isLoading = false;
      });
      throw Exception('Failed to load posts');
    }
  }
  void _refreshPage(){
    setState(() {
      homeGroupController.numberGroupPage.value = 0;
      _posts.clear();
      _isLoading = false;
      _fetchPosts();
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    homeGroupController.numberGroupPage.value = 0;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text('${widget.groupModel!.name!}'),
            Spacer(),
            homeGroupController.checkUserInGroup(_loginController.idMe.value,widget.groupModel!, context) == true ?
            PopupMenuButton<String>(
              icon: Icon(Icons.more_vert),
              onSelected: (String value){
                if (value == 'Hủy theo dõi') {
                  homeGroupController.unfollowGroup(_loginController.idMe.value, widget.groupModel!.id!, context);
                  Navigator.of(context).pop();

                } else if (value == 'Khác') {
                  // Hành động khi chọn "Báo cáo"
                }
              },
              itemBuilder: (BuildContext context) {
                return {'Hủy theo dõi'}.map((String choice) {
                  return PopupMenuItem<String>(
                    value: choice,
                    child: Text(choice),
                  );
                }).toList();
              },
            ) : Container(),
          ],
        ),
      ),
      body: Container(
        child:
        homeGroupController.checkUserInGroup(_loginController.idMe.value,widget.groupModel!, context) == true
        ? ListView.builder(
          controller: _scrollController,
          itemCount: _posts.length + 1,
          itemBuilder: (context, index) {
            if (index == _posts.length) {
              return _isLoading ? Center(child: CircularProgressIndicator()) : SizedBox.shrink();
            }
            return Column(
              children: [
                PostScreenNew(post: _posts[index],
                  onReportAction: _refreshPage,),
                Container(
                  margin: EdgeInsets.only(top: 5),
                  height: 10, // Chiều cao của thanh ngang
                  width: 500, // Độ dày của thanh ngang
                  color: Colors.black12,
                ),
              ],
            );
          },
        ) : Center(
          child: Column(
            children: [
              Text("Vui lòng theo dõi để xem nội dung!"),
              ElevatedButton(
                onPressed: () async {
                  // Hành động khi nhấn nút thứ hai
                  homeGroupController.followGroup(_loginController.idMe.value,widget.groupModel!.id!, context);

                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(
                      horizontal: 20, vertical: 4),
                  backgroundColor: Colors.blueAccent,
                ),
                child: Text(
                  "Theo dõi",
                  style:
                  TextStyle(fontSize: 15, color: Colors.black),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
