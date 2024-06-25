import 'package:askute/controller/HomeGroupController.dart';
import 'package:askute/model/PostModel.dart';
import 'package:askute/view/component/post_newScreen.dart';
import 'package:askute/view/component/post_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final HomeGroupController homeGroupController = Get.put(HomeGroupController());
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

    final response = await homeGroupController.morePosts(context,0);
    if (response!= null && response.length!=0) {
      setState(() {
        homeGroupController.pagenumber3.value++;
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

  @override
  void dispose() {
    _scrollController.dispose();
    homeGroupController.pagenumber3.value = 0;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dark Mode Infinite Scroll'),
      ),
      body: Container(
        child: ListView.builder(
          controller: _scrollController,
          itemCount: _posts.length + 1,
          itemBuilder: (context, index) {
            if (index == _posts.length) {
              return _isLoading ? Center(child: CircularProgressIndicator()) : SizedBox.shrink();
            }
            return PostScreenNew(post: _posts[index]);
          },
        ),
      ),
    );
  }
}
