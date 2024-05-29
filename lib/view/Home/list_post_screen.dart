import 'package:flutter/material.dart';

import '../../model/PostModel.dart';
import '../component/post_screen.dart';

class ListPostScreen extends StatefulWidget {
  final List<PostModel> listPost;
  const ListPostScreen({Key? key, required this.listPost})
      : super(key: key);

  @override
  State<ListPostScreen> createState() => _ListPostScreenState();
}

class _ListPostScreenState extends State<ListPostScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: widget.listPost == []
          ? Container(child:Text("Hãy Theo Dõi Thêm Chủ đề"),)
          : Column(
        children: List.generate(
          widget.listPost.length,
              (index) => Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: PostScreen(post: widget.listPost[index])
          ),
        ),
      )
    );
  }
}
