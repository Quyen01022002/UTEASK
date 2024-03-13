import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../model/PostModel.dart';
import '../component/post_screen.dart';

class HotPostQuestionScreen extends StatefulWidget {
  final List<PostModel> listPost;

  const HotPostQuestionScreen({Key? key, required this.listPost})
      : super(key: key);

  @override
  State<HotPostQuestionScreen> createState() => _HotPostQuestionScreenState();
}

class _HotPostQuestionScreenState extends State<HotPostQuestionScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: widget.listPost == []
          ? Container(child:Text("Hãy Theo Dõi Thêm Chủ đề"),)
          : ListView.builder(

        itemCount: widget.listPost.length,
        itemBuilder: (context, index) {
          final post = widget.listPost[index];
          return AnimatedOpacity(
            duration: Duration(milliseconds: 100),
            opacity: 1,
            child: PostScreen(post: post),
          );
        },
      ),
    );
  }
}

