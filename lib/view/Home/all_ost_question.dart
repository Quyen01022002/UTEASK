
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../model/PostModel.dart';
import '../component/post_screen.dart';

class AllPostQuestionScreen extends StatefulWidget {
  final List<PostModel> listPost;
  const AllPostQuestionScreen({Key? key, required this.listPost}) : super(key: key);

  @override
  State<AllPostQuestionScreen> createState() => _AllPostQuestionScreenState();
}

class _AllPostQuestionScreenState extends State<AllPostQuestionScreen> {
  @override
  Widget build(BuildContext context) {
    return Obx(() => Center(
      child: widget.listPost == []
          ? Image.asset("assets/images/khongbaiviet.png")
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
    ));
  }
}
