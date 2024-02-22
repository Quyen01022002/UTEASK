import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:page_transition/page_transition.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double opacity = 0.0;
  bool isHeaderVisible = true;
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(slivers: [
          SliverToBoxAdapter(
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xFFF3F5F7),
              ),
              child: Column(
                children: [
                  isHeaderVisible
                      ? AnimatedOpacity(
                          duration: Duration(milliseconds: 300),
                          opacity: isHeaderVisible ? 1.0 : 0.0,
                        )
                      : SizedBox(),
                  Container(
                    padding: EdgeInsets.all(20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Hi, Đỗ Duy Hào',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                  'What would you like to learn today? \nSearch Below')
                            ],
                          ),
                        ),
                        Image.asset(
                          'assets/images/NOTIFICATIONS.png',
                          width: 60,
                          height: 60,
                        ),
                      ],
                    ),
                  ),

                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    margin: EdgeInsets.all(10),
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
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            // Xử lý khi ô search được nhấp vào
                            // Ví dụ: Navigator.push(context, MaterialPageRoute(builder: (context) => SearchScreen()));
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset('assets/images/search.png'),
                          ),
                        ),
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'Search for.....',
                              border: InputBorder.none,
                            ),
                            style: TextStyle(
                              fontSize: 18,
                              color: Color(0xFFB4BDC4), // Màu chữ B4BDC4
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset(
                            'assets/images/FILTER.png',
                            width: 30,
                            height: 30,
                          ),
                        ),
                      ],
                    ),
                  ),

                  Container(
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
                                  AssetImage('assets/images/search.png'),
                              // Hoặc sử dụng NetworkImage nếu avatar từ một URL
                              // backgroundImage: NetworkImage('URL_TO_AVATAR'),
                            ),
                            SizedBox(width: 8),
                            Text(
                              'Đỗ Duy Hào',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8),
                        Container(
                          child: Column(
                            children: [
                              Text(
                                'Nội dung của bài viết hoặc tin nhắn sẽ được đặt ở đây. Bạn có thể thay đổi độ dài và nội dung theo ý muốn.',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black87,
                                ),
                              ),
                              Image.asset('assets/images/login-back.png')
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
                                  Text('832 lượt thích')
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
                                  Text('832 bình luận')
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
                                  Text('34 lượt theo dõi')
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),

                  Container(
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
                              AssetImage('assets/images/search.png'),
                              // Hoặc sử dụng NetworkImage nếu avatar từ một URL
                              // backgroundImage: NetworkImage('URL_TO_AVATAR'),
                            ),
                            SizedBox(width: 8),
                            Text(
                              'Đỗ Duy Hào',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8),
                        Container(
                          child: Column(
                            children: [
                              Text(
                                'Nội dung của bài viết hoặc tin nhắn sẽ được đặt ở đây. Bạn có thể thay đổi độ dài và nội dung theo ý muốn.',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black87,
                                ),
                              ),
                              Image.asset('assets/images/login-back.png')
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
                                  Text('832 lượt thích')
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
                                  Text('832 bình luận')
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
                                  Text('34 lượt theo dõi')
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),


                  // Expanded(
                  //   child: Obx(
                  //         () =>
                  //         NotificationListener<ScrollNotification>(
                  //           onNotification: (scrollNotification) {
                  //             return true;
                  //           },
                  //           child: ListView.builder(
                  //             controller: _scrollController,
                  //             itemCount:3,
                  //             itemBuilder: (context, index) {
                  //               return  AnimatedOpacity(
                  //                   duration: Duration(milliseconds: 100),
                  //                   opacity: opacity,
                  //
                  //               );
                  //             },
                  //           ),
                  //         ),
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
