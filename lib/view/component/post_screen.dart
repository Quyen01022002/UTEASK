import 'package:flutter/material.dart';

import '../../model/PostModel.dart';

class PostScreen extends StatefulWidget {
  //const PostScreen({super.key});
  final PostModel post;
  const PostScreen({Key? key, required this.post}) : super(key: key);

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  List<String> imageUrls1 = [
    'https://royalceramic.com.vn/wp-content/uploads/2022/12/anh-khi-12-con-giap-trend-tiktok-sieu-dep-800x800.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundImage:
                NetworkImage(widget.post.createBy.profilePicture),
                // Hoặc sử dụng NetworkImage nếu avatar từ một URL
                // backgroundImage: NetworkImage('URL_TO_AVATAR'),
              ),
              SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.post.createBy.firstName+" " + widget.post.createBy.lastName,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  Text(
                    widget.post.createBy.email,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.black45,
                    ),
                  ),                              ],
              ),
            ],
          ),
          SizedBox(height: 8),
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 8),
                Text(
                  widget.post.contentPost,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 5),
                _buildImages(widget.post.listAnh),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Color(0xFFF4F4F4),
                        border: Border.all(
                          color: Colors.grey.withOpacity(0.5), // Màu của border
                          width: 1.0, // Độ rộng của border
                        ),
                        borderRadius: BorderRadius.circular(10), // Độ bo góc của border
                      ),
                      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                      child: Row(

                          children: [
                            Image.asset(
                              'assets/images/like1.png',
                              width: 15,
                              height: 15,
                            ),
                            Text('Thích',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold
                              ),),]),
                    ),
                    Text(widget.post.like_count.toString()+' lượt thích')
                  ],
                ),
                Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Color(0xFFF4F4F4),
                        border: Border.all(
                          color: Colors.grey.withOpacity(0.5), // Màu của border
                          width: 1.0, // Độ rộng của border
                        ),
                        borderRadius: BorderRadius.circular(10), // Độ bo góc của border
                      ),
                      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                      child: Row(

                          children: [
                            Image.asset(
                              'assets/images/NOTIFICATIONS.png',
                              width: 15,
                              height: 15,
                            ),
                            Text('Bình luận',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold
                              ),),]),
                    ),
                    Text(widget.post.comment_count.toString()+  ' bình luận')
                  ],
                ),
                Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Color(0xFFF4F4F4),
                        border: Border.all(
                          color: Colors.grey.withOpacity(0.5), // Màu của border
                          width: 1.0, // Độ rộng của border
                        ),
                        borderRadius: BorderRadius.circular(10), // Độ bo góc của border
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
                              ),),]),
                    ),
                    Text('Không khả dụng')
                  ],
                ),
              ],
            ),
          )
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
      return _buildFourImages(images); // Thay bằng xử lý tùy thuộc vào số lượng ảnh cần hiển thị
    }
  }
  Widget _buildSingleImage(List<String> list) {
    //Nếu list ảnh chỉ có một hình ảnh
    return Container(
      height: 302,
      width: 302,
      child: GestureDetector(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => ImageDetail(index: 0, listAnh: list,),
            ));
          },
          child:  _buildFirstImage(list[0])),
    );
  }
  Widget _buildTwoImages(List<String> imageUrls) {
    //nếu list ảnh có 2 hình ảnh
    return Container(
      height: 302,
      width: 302,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ImageDetail(index: 0, listAnh: imageUrls,),
                ));
              },
              child:  _buildFirstImage(imageUrls[0])),

          GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ImageDetail(index: 0, listAnh: imageUrls,),
                ));
              },
              child:  _buildFirstImage(imageUrls[0])),
        ],
      ),
    );
  }
  Widget _buildThreeImages(List<String> imageUrls) {
    // nếu list ảnh có 3 hình ảnh
    return Container(
      height: 302,
      width: 302,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ImageDetail(index: 0, listAnh: imageUrls,),
                ));
              },
              child:  _buildFirstImage(imageUrls[0])),
          Container(
            height: 302,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ImageDetail(index: 1, listAnh: imageUrls,),
                      ));
                    },
                    child:  _buildSecondImage(imageUrls[1])),
                GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ImageDetail(index: 2, listAnh: imageUrls,),
                      ));
                    },
                    child:  _buildSecondImage(imageUrls[2])),
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
      height: 302,
      width: 302,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ImageDetail(index: 0, listAnh: imageUrls,),
                ));
              },
              child:  _buildFirstImage(imageUrls[0])),
          Container(
            height: 302,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ImageDetail(index: 1, listAnh: imageUrls,),
                      ));
                    },
                    child:  _buildSecondImage(imageUrls[1])),

                Stack(
                  children: [
                    _buildSecondImage(imageUrls[2]),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ImageDetail(index: 2, listAnh: imageUrls,),
                        ));
                      },
                      child: Container(
                        height: 150,
                        width: 150,
                        color: Colors.black.withOpacity(0.5), // Độ mờ ở đây, giả sử 0.5
                      ),
                    ),

                    Positioned.fill(
                      child: Center(
                        child: Text(
                          '+1',
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
      width: 150,
      height: 302,
      fit: BoxFit.cover,
    );

  }
  Widget _buildSecondImage(String imageUrl) {
    //xây dựng khung ảnh thứ 2,3 của bộ ba ảnh trở lên
    return Image.network(
      imageUrl,
      width: 150,
      height: 150,
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
