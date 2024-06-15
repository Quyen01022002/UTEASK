import 'package:askute/controller/PostController.dart';
import 'package:askute/model/PostModel.dart';
import 'package:askute/view/Quetions/QuestionDetail.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';



class ReportPost extends StatefulWidget {
  final PostModel post;
  const ReportPost({super.key, required this.post});

  @override
  State<ReportPost> createState() => _ReportPostState();
}

class _ReportPostState extends State<ReportPost> {
  final PostController postController = Get.put(PostController());
  String selectedReason = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF6A9EF5),
        title: Row(
          children: [
            SizedBox(width: 8.0),
            Text('Báo cáo bài đăng câu hỏi'),
          ],
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(left: 10, top: 20, bottom: 10),
                    child: Text(
                      'Báo cáo bài viết',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  _buildPostInfoContainer(),
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.only(left: 12),
                          child: Text(
                            'Nội dung báo cáo:',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        RadioListTile(
                          dense: true, // Set dense to true to reduce vertical spacing
                          title: Text(
                            'Người dùng đăng nội dung phản cảm',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          value: 'Người dùng đăng nội dung phản cảm',
                          groupValue: selectedReason,
                          onChanged: (value) {
                            setState(() {
                              selectedReason = 'Người dùng đăng nội dung phản cảm';
                            });
                          },
                        ),
                        RadioListTile(
                          dense: true,
                          title: Text(
                            'Tải khoản giả mạo',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          value: 'Tải khoản giả mạo',
                          groupValue: selectedReason,
                          onChanged: (value) {
                            setState(() {
                              selectedReason = 'Tải khoản giả mạo';
                            });
                          },
                        ),
                        RadioListTile(
                          dense: true,
                          title: Text(
                            'Tài khoản vi phạm bản quyền',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          value: 'Tài khoản vi phạm bản quyền',
                          groupValue: selectedReason,
                          onChanged: (value) {
                            setState(() {
                              selectedReason = 'Tài khoản vi phạm bản quyền';
                            });
                          },
                        ),
                        RadioListTile(
                          dense: true,
                          title: Text(
                            'Khác',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          value: 'Khác',
                          groupValue: selectedReason,
                          onChanged: (value) {
                            setState(() {
                              selectedReason = 'Khác';
                            });
                          },
                        ),
                        // Visibility widget to show/hide input field based on option selection
                        Visibility(
                          visible: selectedReason == 'Khác',
                          child: Container(
                            margin: EdgeInsets.only(left: 16, right: 16),
                            padding: EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey, // You can set the border color
                                width: 1.0, // You can set the border width
                              ),
                              borderRadius: BorderRadius.circular(8.0), // Set the border radius
                            ),
                            child: TextFormField(
                              controller: postController.reasonText,
                              decoration: InputDecoration(
                                hintText: 'Nhập lý do khác',
                                border: InputBorder.none, // Remove the default border
                              ),
                            ),
                          ),
                        ),

                      ],
                    ),
                  ),
                  SizedBox(height: 10.0),

                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  20), // Điều chỉnh góc bo tròn
                            ),
                            backgroundColor: Color(0xFF8587F1),
                          ),
                          onPressed: () {

                            postController.reportPost(BuildContext, widget.post.id,selectedReason);
                            Navigator.of(context).pop();

                          },
                          child: Container(
                            margin: EdgeInsets.all(10),
                            padding: EdgeInsets.all(10),
                            width: 250,
                            alignment: Alignment.center, // Align the text to the center
                            child: Text(
                              'Báo cáo bài viết',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],

              ),
            ),

          ),

        ],
      ),

    );
  }

  Widget _buildPostInfoContainer() {
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
          _buildOwnerUser(),
          SizedBox(height: 8),
          _buildContent(),
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
              radius: 25,
              backgroundImage:
              NetworkImage(widget.post.createBy.profilePicture),
              // Hoặc sử dụng NetworkImage nếu avatar từ một URL
              // backgroundImage: NetworkImage('URL_TO_AVATAR'),
            ),
            SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 10,
                ),
                Text(
                  widget.post.createBy.firstName +
                      ' ' +
                      widget.post.createBy.lastName,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
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
          ],
        ),
      ),
    );
  }

  Widget _buildContent() {
    return Container(
      padding: EdgeInsets.only(top: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.post.contentPost,
            style: TextStyle(
              fontSize: 18,
            ),
          ),
          _buildImages(widget.post.listAnh),
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
    } else if (imageCount == 0) {
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
      height: MediaQuery.of(context).size.width * 0.99,
      width: MediaQuery.of(context).size.width * 0.99,
      child: GestureDetector(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => ImageDetail(
                index: 0,
                listAnh: list,
              ),
            ));
          },
          child: _buildFirstImage(list[0])),
    );
  }

  Widget _buildTwoImages(List<String> imageUrls) {
    //nếu list ảnh có 2 hình ảnh
    return Container(
      height: MediaQuery.of(context).size.width * 0.99,
      width: MediaQuery.of(context).size.width * 0.99,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ImageDetail(
                    index: 0,
                    listAnh: imageUrls,
                  ),
                ));
              },
              child: _buildFirstImage(imageUrls[0])),
          GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ImageDetail(
                    index: 0,
                    listAnh: imageUrls,
                  ),
                ));
              },
              child: _buildFirstImage(imageUrls[1])),
        ],
      ),
    );
  }

  Widget _buildThreeImages(List<String> imageUrls) {
    // nếu list ảnh có 3 hình ảnh
    return Container(
      height: MediaQuery.of(context).size.width * 0.985,
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ImageDetail(
                    index: 0,
                    listAnh: imageUrls,
                  ),
                ));
              },
              child: Container(
                  width: MediaQuery.of(context).size.width * 0.5 * 0.99,
                  height: MediaQuery.of(context).size.height * 0.99,
                  child: _buildFirstImage(imageUrls[0]))),
          Container(
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ImageDetail(
                          index: 1,
                          listAnh: imageUrls,
                        ),
                      ));
                    },
                    child: _buildSecondImage(imageUrls[1])),
                GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ImageDetail(
                          index: 2,
                          listAnh: imageUrls,
                        ),
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
      height: MediaQuery.of(context).size.width * 0.985,
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ImageDetail(
                    index: 0,
                    listAnh: imageUrls,
                  ),
                ));
              },
              child: Container(
                  width: MediaQuery.of(context).size.width * 0.5 * 0.99,
                  height: MediaQuery.of(context).size.height * 0.99,
                  child: _buildFirstImage(imageUrls[0]))),
          Container(
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ImageDetail(
                          index: 1,
                          listAnh: imageUrls,
                        ),
                      ));
                    },
                    child: _buildSecondImage(imageUrls[1])),
                Stack(
                  children: [
                    _buildSecondImage(imageUrls[2]),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ImageDetail(
                            index: 2,
                            listAnh: imageUrls,
                          ),
                        ));
                      },
                      child: Container(
                        height:
                        MediaQuery.of(context).size.height * 0.25 * 0.99,
                        width: MediaQuery.of(context).size.width * 0.5 * 0.99,
                        color: Colors.black
                            .withOpacity(0.5), // Độ mờ ở đây, giả sử 0.5
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
      width: MediaQuery.of(context).size.width * 0.985 * 0.5,
      height: MediaQuery.of(context).size.height * 0.99,
      fit: BoxFit.cover,
    );
  }

  Widget _buildSecondImage(String imageUrl) {
    //xây dựng khung ảnh thứ 2,3 của bộ ba ảnh trở lên
    return Image.network(
      imageUrl,
      width: MediaQuery.of(context).size.width * 0.5 * 0.99,
      height: MediaQuery.of(context).size.height * 0.25 * 0.99,
      fit: BoxFit.cover,
    );
  }
}
