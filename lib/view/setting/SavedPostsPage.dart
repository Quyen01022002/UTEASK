import 'package:askute/controller/SavedPostController.dart';
import 'package:askute/model/PostModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../controller/HomeController.dart';


  class SavedPostsPage extends StatefulWidget {
  const SavedPostsPage({Key? key}) : super(key: key);

  @override
  State<SavedPostsPage> createState() => _HomeScreenState();
  }
  class _HomeScreenState extends State<SavedPostsPage>
  with SingleTickerProviderStateMixin {
  final SavedPostController _savedPostController = Get.put(SavedPostController());
  @override
  void initState() {
    super.initState();
   _savedPostController.loadPost();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Saved Posts'),
      ),
      body: SavedPostsList(),
    );
  }


}

class SavedPostsList extends StatelessWidget {
  final SavedPostController _savedPostController = Get.put(SavedPostController());
  @override
  Widget build(BuildContext context) {
    // You can replace this with your actual data retrieval logic


    return ListView.builder(
      itemCount: _savedPostController.listPost.length,
      itemBuilder: (context, index) {
        PostModel post = _savedPostController.listPost[index];
        return SavedPostItem(post: post);
      },
    );
  }

}

class SavedPostItem extends StatelessWidget {
  final PostModel post;

  const SavedPostItem({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.0),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(post.listAnh.first.toString(),width: 80,height: 80,fit: BoxFit.cover,),
            Text(post.contentPost),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Tác giả: ${post.createBy.firstName} ${post.createBy.lastName}', // Replace with your author data
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.more_vert),
                  onPressed: () {
                    // Handle overflow button tap (e.g., show options menu)
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}


