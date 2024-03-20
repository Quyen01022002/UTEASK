import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/PostController.dart';
import '../../model/PostModel.dart';

class QuestionDetailScreen extends StatefulWidget {

  final PostModel post;

  const QuestionDetailScreen({Key? key, required this.post}) : super(key: key);

  @override
  State<QuestionDetailScreen> createState() => _QuestionDetailScreenState();
}

class _QuestionDetailScreenState extends State<QuestionDetailScreen> {
  List<String> imageUrls1 = [
    'https://i.pinimg.com/564x/1b/75/0a/1b750a6aa0f7e26b690ca2b5a0b7960d.jpg',
    'https://i.pinimg.com/736x/24/b7/7a/24b77a1dea1d8bf37163052828f97310.jpg',
    'https://i.pinimg.com/564x/fa/e9/3d/fae93d5d8bc6062038bb01dc243fde5d.jpg',
    'https://i.pinimg.com/564x/83/9f/ca/839fca5eb345e0a4024e961e9b52fa81.jpg',
    'https://i.pinimg.com/564x/c6/ed/e9/c6ede95f6d1aae1937703a39b8e3148d.jpg'
  ];
  List<String> imageUrls2 = [
    'https://i.pinimg.com/564x/1b/75/0a/1b750a6aa0f7e26b690ca2b5a0b7960d.jpg',
    'https://i.pinimg.com/736x/24/b7/7a/24b77a1dea1d8bf37163052828f97310.jpg',
  ];


  final PostController postController = Get.put(PostController());
  Stream<PostModel>? postCurrent;
  PostModel? post;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  late Timer _timer;

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      // Gọi hàm cần thiết ở đây
      _loadData();
      postCurrent =
          postController.postState; // Đây là Stream mà bạn cần theo dõi
      // Cập nhật danh sách nhóm khi Stream thay đổi
      postCurrent?.listen((PostModel? currentGroup) {
        if (currentGroup != null) {
          setState(() {
            post = currentGroup;
          });
        }
      });
    });
  }

  void _loadData() async {
    await postController.loadOnePost;
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              title: Text('Bài thảo luận của Duy Hào'),
            ),
            SliverToBoxAdapter(
              child: StreamBuilder<PostModel>(
                  stream: postCurrent,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildOwnerUser(),
                          _buildContent(),
                          _buildIInteraction(),
                          Container(
                            margin: EdgeInsets.only(top: 20),
                            height: 5, // Chiều cao của thanh ngang
                            width: 400, // Độ dày của thanh ngang
                            color: Color(0xC0C0C0C0),
                          ),
                        ],
                      );
                    }
                   else {
              return Container();
              }}),


            ),
            SliverFillRemaining(
              hasScrollBody: true,
              child: _buildComment(),
            )

          ],
        )

    ));
  }

  Widget _buildContent() {
    return Container(
      padding: EdgeInsets.only(top: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [Text(widget.post.contentPost,
          style: TextStyle(
            fontSize: 18,

          ),
        ),
          _buildImages(widget.post.listAnh),
        ],
      ),
    );
  }

  Widget _buildIInteraction() {
    return Container(
      margin: EdgeInsets.only(top: 10, bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {},
                child: Container(
                  width: 100,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Color(0xFFF4F4F4),
                    border: Border.all(
                      color: Colors.grey.withOpacity(0.5), // Màu của border
                      width: 1.0, // Độ rộng của border
                    ),
                    borderRadius: BorderRadius.circular(
                        10), // Độ bo góc của border
                  ),
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                  child: Row(

                      children: [
                        Image.asset(
                          'assets/images/like1.png',
                          width: 15,
                          height: 15,
                        ),

                        Text(widget.post.user_liked ? 'Đã thích' : 'Thích',
                          style: TextStyle(
                              fontWeight: FontWeight.bold
                          ),),
                      ]),
                ),
              ),
              Text(widget.post.like_count.toString() + ' lượt thích')
            ],
          ),
          Column(
            children: [
              GestureDetector(
                onTap: () {

                },
                child: Container(
                  width: 100,
                  decoration: BoxDecoration(
                    color: Color(0xFFF4F4F4),
                    border: Border.all(
                      color: Colors.grey.withOpacity(0.5), // Màu của border
                      width: 1.0, // Độ rộng của border
                    ),
                    borderRadius: BorderRadius.circular(
                        10), // Độ bo góc của border
                  ),
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                  child: Row(

                      children: [
                        Image.asset(
                          'assets/images/NOTIFICATIONS.png',
                          width: 15,
                          height: 15,
                        ),
                        Text('Theo dõi',
                          style: TextStyle(
                              fontWeight: FontWeight.bold
                          ),),
                      ]),
                ),
              ),
              Text('Không khả dụng')
            ],
          ),
        ],
      ),
    );
  }


  Widget _buildOwnerUser() {
    return Container(
      padding: EdgeInsets.only(left: 10),
      alignment: Alignment.center,
      child: Center(

        child: Row(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundImage:
              NetworkImage(widget.post.createBy.profilePicture),
              // Hoặc sử dụng NetworkImage nếu avatar từ một URL
              // backgroundImage: NetworkImage('URL_TO_AVATAR'),
            ),
            SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(width: 10,),
                Text(
                  widget.post.createBy.firstName + ' ' +
                      widget.post.createBy.lastName,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(width: 10,),
            Text(
              'cách đây 2 phút',
              style: TextStyle(
                fontSize: 10,
                color: Color(0xFFCECECE),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildComment() {
    return Column(
      children: [
        Expanded(
          child: ListView(
            children: [
              _buildOneComment(),
              SizedBox(height: 10.0,),
              _buildOneComment()
            ],


          ),),
      ],
    );
  }

  Widget _buildOneComment() {
    return Container(
      margin: EdgeInsets.all(5.0),
      child: Column(
        children: [
          _buildUserComment(),
          SizedBox(height: 5,),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                  flex: 2,
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/images/FILTER.png',
                        width: 30,
                        height: 30,
                      ),
                      Text('8',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),),
                      Image.asset(
                        'assets/images/FILTER.png',
                        width: 30,
                        height: 30,
                      ),
                      SizedBox(height: 10,),
                      Image.asset(
                        'assets/images/FILTER.png',
                        width: 30,
                        height: 40,
                      ),
                    ],
                  )),
              Expanded(
                  flex: 8,
                  child: Column(
                    children: [
                      Text(
                          'Now everything works fine when I run it but I keep getting the error (Name non-constant identifiers using lowerCamelCase.)'),
                      Image.network(
                          'https://i.pinimg.com/564x/fa/e9/3d/fae93d5d8bc6062038bb01dc243fde5d.jpg'),

                    ],
                  ))
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildUserComment() {
    return Container(
      child: Row(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundImage:
            NetworkImage(
                'https://i.pinimg.com/564x/fa/e9/3d/fae93d5d8bc6062038bb01dc243fde5d.jpg'),
            // Hoặc sử dụng NetworkImage nếu avatar từ một URL
            // backgroundImage: NetworkImage('URL_TO_AVATAR'),
          ),
          SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Trần Bửu Quến',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),

              Text(
                'buuquen2002',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.black45,
                ),
              ),
            ],
          ),
          Text(
            'cách đây 2 phút',
            style: TextStyle(
              fontSize: 10,
              color: Color(0xFFCECECE),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImages(List<String> images) {
    int imageCount = images.length;

    if (imageCount == 1) {
      return _buildSingleImage(images);
    } else if (imageCount == 2) {
      return _buildTwoImages(images);
    } else if (imageCount == 3) {
      return _buildThreeImages(images);
    }
    else if (imageCount == 0) {
      return Container();
    } else {
      // Xử lý cho trường hợp có nhiều hơn 3 ảnh
      return _buildFourImages(
          images); // Thay bằng xử lý tùy thuộc vào số lượng ảnh cần hiển thị
    }
  }

  Widget _buildSingleImage(List<String> list) {
    //Nếu list ảnh chỉ có một hình ảnh
    return Container(
      height: MediaQuery
          .of(context)
          .size
          .width * 0.99,
      width: MediaQuery
          .of(context)
          .size
          .width * 0.99,
      child: GestureDetector(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => ImageDetail(index: 0, listAnh: list,),
            ));
          },
          child: _buildFirstImage(list[0])),
    );
  }

  Widget _buildTwoImages(List<String> imageUrls) {
    //nếu list ảnh có 2 hình ảnh
    return Container(
      height: MediaQuery
          .of(context)
          .size
          .width * 0.99,
      width: MediaQuery
          .of(context)
          .size
          .width * 0.99,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) =>
                      ImageDetail(index: 0, listAnh: imageUrls,),
                ));
              },
              child: _buildFirstImage(imageUrls[0])),

          GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) =>
                      ImageDetail(index: 0, listAnh: imageUrls,),
                ));
              },
              child: _buildFirstImage(imageUrls[0])),
        ],
      ),
    );
  }

  Widget _buildThreeImages(List<String> imageUrls) {
    // nếu list ảnh có 3 hình ảnh
    return Container(
      height: MediaQuery
          .of(context)
          .size
          .width * 0.985,
      width: MediaQuery
          .of(context)
          .size
          .width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) =>
                      ImageDetail(index: 0, listAnh: imageUrls,),
                ));
              },
              child: Container(
                  width: MediaQuery
                      .of(context)
                      .size
                      .width * 0.5 * 0.99,
                  height: MediaQuery
                      .of(context)
                      .size
                      .height * 0.99,
                  child: _buildFirstImage(imageUrls[0]))),
          Container(
            height: MediaQuery
                .of(context)
                .size
                .height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            ImageDetail(index: 1, listAnh: imageUrls,),
                      ));
                    },
                    child: _buildSecondImage(imageUrls[1])),
                GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            ImageDetail(index: 2, listAnh: imageUrls,),
                      ));
                    },
                    child: _buildSecondImage(imageUrls[2])),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFourImages(List<String> imageUrls) {
    //nếu list ảnh có 4 hình ảnh trở lên
    return Container(
      height: MediaQuery
          .of(context)
          .size
          .width * 0.985,
      width: MediaQuery
          .of(context)
          .size
          .width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) =>
                      ImageDetail(index: 0, listAnh: imageUrls,),
                ));
              },
              child: Container(
                  width: MediaQuery
                      .of(context)
                      .size
                      .width * 0.5 * 0.99,
                  height: MediaQuery
                      .of(context)
                      .size
                      .height * 0.99,
                  child: _buildFirstImage(imageUrls[0]))),
          Container(
            height: MediaQuery
                .of(context)
                .size
                .height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            ImageDetail(index: 1, listAnh: imageUrls,),
                      ));
                    },
                    child: _buildSecondImage(imageUrls[1])),

                Stack(
                  children: [
                    _buildSecondImage(imageUrls[2]),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              ImageDetail(index: 2, listAnh: imageUrls,),
                        ));
                      },
                      child: Container(
                        height: MediaQuery
                            .of(context)
                            .size
                            .height * 0.25 * 0.99,
                        width: MediaQuery
                            .of(context)
                            .size
                            .width * 0.5 * 0.99,
                        color: Colors.black.withOpacity(
                            0.5), // Độ mờ ở đây, giả sử 0.5
                      ),
                    ),

                    Positioned.fill(
                      child: Center(
                        child: Text(
                          '+' + (imageUrls.length - 2).toString(),
                          style: TextStyle(
                            fontSize: 30,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),


              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFirstImage(String imageUrl) {
    //xây dựng khung ảnh đầu tiên của bộ đôi, bộ ba ảnh
    return Image.network(
      imageUrl,
      width: MediaQuery
          .of(context)
          .size
          .width * 0.985 * 0.5,
      height: MediaQuery
          .of(context)
          .size
          .height * 0.99,
      fit: BoxFit.cover,
    );
  }

  Widget _buildSecondImage(String imageUrl) {
    //xây dựng khung ảnh thứ 2,3 của bộ ba ảnh trở lên
    return Image.network(
      imageUrl,
      width: MediaQuery
          .of(context)
          .size
          .width * 0.5 * 0.99,
      height: MediaQuery
          .of(context)
          .size
          .height * 0.25 * 0.99,
      fit: BoxFit.cover,
    );
  }
}

class ImageDetail extends StatelessWidget {
  //Phóng to ảnh
  final int index;
  final List<String> listAnh;

  ImageDetail({required this.index, required this.listAnh});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: PageView.builder(
          itemCount: listAnh.length,
          controller: PageController(initialPage: index),
          itemBuilder: (context, pageIndex) {
            return Hero(
              tag: pageIndex.toString(),
              child: Image.network(
                listAnh[pageIndex], // Thay thế URL hình ảnh của bạn
                fit: BoxFit.contain,
              ),
            );
          },
        ),
      ),
    );
  }
}
