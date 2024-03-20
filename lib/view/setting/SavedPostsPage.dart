import 'package:flutter/material.dart';

class SavedPostsPage extends StatelessWidget {
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
  @override
  Widget build(BuildContext context) {
    // You can replace this with your actual data retrieval logic
    List<Post> savedPosts = getSavedPosts();

    return ListView.builder(
      itemCount: savedPosts.length,
      itemBuilder: (context, index) {
        Post post = savedPosts[index];
        return SavedPostItem(post: post);
      },
    );
  }

  List<Post> getSavedPosts() {
    // Replace this with your data retrieval logic
    // This is just a placeholder
    return List.generate(
      10,
      (index) => Post(
        title: 'Saved Post $index',
        content: 'This is the content of the saved post $index',
      ),
    );
  }
}

class SavedPostItem extends StatelessWidget {
  final Post post;

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
            Text(
              post.title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(post.content),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Author: ${post.author}', // Replace with your author data
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

class Post {
  final String title;
  final String content;
  final String author;

  Post({
    required this.title,
    required this.content,
    this.author = 'Anonymous',
  });
}
