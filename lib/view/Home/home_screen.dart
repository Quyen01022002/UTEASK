import 'dart:ffi';
import 'dart:ui';

import 'package:askute/controller/HomeGroupController.dart';
import 'package:askute/view/component/post_screen.dart';
import 'package:flutter/cupertino.dart';
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
  bool _isLoading = false;
  int _visibleItems = 10;
  final HomeGroupController homeGroupController =
      Get.put(HomeGroupController());
  int heigth = 150;
  late ScrollController _scrollController;
  List<String> imageUrls1 = [
    'https://royalceramic.com.vn/wp-content/uploads/2022/12/anh-khi-12-con-giap-trend-tiktok-sieu-dep-800x800.jpg',
  ];
  List<String> imageUrls2 = [
    'https://royalceramic.com.vn/wp-content/uploads/2022/12/anh-khi-12-con-giap-trend-tiktok-sieu-dep-800x800.jpg',
    'https://royalceramic.com.vn/wp-content/uploads/2022/12/anh-khi-12-con-giap-trend-tiktok-sieu-dep-800x800.jpg',
  ];
  List<String> imageUrls3 = [
    'https://royalceramic.com.vn/wp-content/uploads/2022/12/anh-khi-12-con-giap-trend-tiktok-sieu-dep-800x800.jpg',
    'https://royalceramic.com.vn/wp-content/uploads/2022/12/anh-khi-12-con-giap-trend-tiktok-sieu-dep-800x800.jpg',
    'https://royalceramic.com.vn/wp-content/uploads/2022/12/anh-khi-12-con-giap-trend-tiktok-sieu-dep-800x800.jpg',
  ];
  List<String> imageUrls4 = [
    'https://royalceramic.com.vn/wp-content/uploads/2022/12/anh-khi-12-con-giap-trend-tiktok-sieu-dep-800x800.jpg',
    'https://royalceramic.com.vn/wp-content/uploads/2022/12/anh-khi-12-con-giap-trend-tiktok-sieu-dep-800x800.jpg',
    'https://royalceramic.com.vn/wp-content/uploads/2022/12/anh-khi-12-con-giap-trend-tiktok-sieu-dep-800x800.jpg',
    'https://royalceramic.com.vn/wp-content/uploads/2022/12/anh-khi-12-con-giap-trend-tiktok-sieu-dep-800x800.jpg',
  ];
  List<String> imNull = [];

  @override
  void initState() {
    super.initState();
    homeGroupController.GetListPost(context);
    homeGroupController.loadGroupsJoin();

    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    final delta = 100.0;

    if (maxScroll - currentScroll <= delta && !_isLoading) {
      _loadMore();
    }
  }

  Future<void> _loadMore() async {
    setState(() {
      _isLoading = true;
    });

    // Simulate loading delay
    await Future.delayed(Duration(seconds: 2));

    setState(() {
      _visibleItems += 10; // Ví dụ, tải thêm 10 mục
      _isLoading = false;
    });
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
                    height: 50,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: homeGroupController.groupsJoin?.length,
                      itemBuilder: (context, index) {
                        final post = homeGroupController.groupsJoin?[index];
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: 150.0,
                            color: Colors.blue,
                            child: Center(
                              child: Text(post!.name.toString(),
                                  style: TextStyle(color: Colors.white)),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Container(
                    height: 450,
                    margin: EdgeInsets.only(top: 10),
                    child: ListView.builder(
                      itemCount: _visibleItems + (_isLoading ? 1 : 0),
                      controller: _scrollController,
                      itemBuilder: (context, index) {
                        if (index < _visibleItems) {
                          final post = homeGroupController.listPost[index];
                          return AnimatedOpacity(
                            duration: Duration(milliseconds: 100),
                            opacity: 1,
                            child: PostScreen(),
                          );
                        } else {
                          return _buildProgressIndicator();
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }
  Widget _buildProgressIndicator() {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget _buildPost0() {
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
                backgroundImage: AssetImage('assets/images/search.png'),
                // Hoặc sử dụng NetworkImage nếu avatar từ một URL
                // backgroundImage: NetworkImage('URL_TO_AVATAR'),
              ),
              SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Đỗ Duy Hào',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Công nghệ thông tin',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.black45,
                    ),
                  ),
                ],
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
                _buildImages(imNull),
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
                        borderRadius:
                            BorderRadius.circular(10), // Độ bo góc của border
                      ),
                      padding:
                          EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                      child: Row(children: [
                        Image.asset(
                          'assets/images/like1.png',
                          width: 15,
                          height: 15,
                        ),
                        Text(
                          'Thích',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ]),
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
                        borderRadius:
                            BorderRadius.circular(10), // Độ bo góc của border
                      ),
                      padding:
                          EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                      child: Row(children: [
                        Image.asset(
                          'assets/images/NOTIFICATIONS.png',
                          width: 15,
                          height: 15,
                        ),
                        Text(
                          'Bình luận',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ]),
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
                        borderRadius:
                            BorderRadius.circular(10), // Độ bo góc của border
                      ),
                      padding:
                          EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                      child: Row(children: [
                        Image.asset(
                          'assets/images/NOTIFICATIONS.png',
                          width: 15,
                          height: 15,
                        ),
                        Text(
                          'Theo dõi',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ]),
                    ),
                    Text('34 lượt theo dõi')
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildPost() {
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
                backgroundImage: AssetImage('assets/images/search.png'),
                // Hoặc sử dụng NetworkImage nếu avatar từ một URL
                // backgroundImage: NetworkImage('URL_TO_AVATAR'),
              ),
              SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Đỗ Duy Hào',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Công nghệ thông tin',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.black45,
                    ),
                  ),
                ],
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
                _buildImages(imageUrls1),
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
                        borderRadius:
                            BorderRadius.circular(10), // Độ bo góc của border
                      ),
                      padding:
                          EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                      child: Row(children: [
                        Image.asset(
                          'assets/images/like1.png',
                          width: 15,
                          height: 15,
                        ),
                        Text(
                          'Thích',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ]),
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
                        borderRadius:
                            BorderRadius.circular(10), // Độ bo góc của border
                      ),
                      padding:
                          EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                      child: Row(children: [
                        Image.asset(
                          'assets/images/NOTIFICATIONS.png',
                          width: 15,
                          height: 15,
                        ),
                        Text(
                          'Bình luận',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ]),
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
                        borderRadius:
                            BorderRadius.circular(10), // Độ bo góc của border
                      ),
                      padding:
                          EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                      child: Row(children: [
                        Image.asset(
                          'assets/images/NOTIFICATIONS.png',
                          width: 15,
                          height: 15,
                        ),
                        Text(
                          'Theo dõi',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ]),
                    ),
                    Text('34 lượt theo dõi')
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildPost2() {
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
                backgroundImage: AssetImage('assets/images/search.png'),
                // Hoặc sử dụng NetworkImage nếu avatar từ một URL
                // backgroundImage: NetworkImage('URL_TO_AVATAR'),
              ),
              SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Đỗ Duy Hào',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Công nghệ thông tin',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.black45,
                    ),
                  ),
                ],
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
                _buildImages(imageUrls2),
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
                        borderRadius:
                            BorderRadius.circular(10), // Độ bo góc của border
                      ),
                      padding:
                          EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                      child: Row(children: [
                        Image.asset(
                          'assets/images/like1.png',
                          width: 15,
                          height: 15,
                        ),
                        Text(
                          'Thích',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ]),
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
                        borderRadius:
                            BorderRadius.circular(10), // Độ bo góc của border
                      ),
                      padding:
                          EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                      child: Row(children: [
                        Image.asset(
                          'assets/images/NOTIFICATIONS.png',
                          width: 15,
                          height: 15,
                        ),
                        Text(
                          'Bình luận',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ]),
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
                        borderRadius:
                            BorderRadius.circular(10), // Độ bo góc của border
                      ),
                      padding:
                          EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                      child: Row(children: [
                        Image.asset(
                          'assets/images/NOTIFICATIONS.png',
                          width: 15,
                          height: 15,
                        ),
                        Text(
                          'Theo dõi',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ]),
                    ),
                    Text('34 lượt theo dõi')
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildPost3() {
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
                backgroundImage: AssetImage('assets/images/search.png'),
                // Hoặc sử dụng NetworkImage nếu avatar từ một URL
                // backgroundImage: NetworkImage('URL_TO_AVATAR'),
              ),
              SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Đỗ Duy Hào',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Công nghệ thông tin',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.black45,
                    ),
                  ),
                ],
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
                _buildImages(imageUrls3),
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
                        borderRadius:
                            BorderRadius.circular(10), // Độ bo góc của border
                      ),
                      padding:
                          EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                      child: Row(children: [
                        Image.asset(
                          'assets/images/like1.png',
                          width: 15,
                          height: 15,
                        ),
                        Text(
                          'Thích',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ]),
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
                        borderRadius:
                            BorderRadius.circular(10), // Độ bo góc của border
                      ),
                      padding:
                          EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                      child: Row(children: [
                        Image.asset(
                          'assets/images/NOTIFICATIONS.png',
                          width: 15,
                          height: 15,
                        ),
                        Text(
                          'Bình luận',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ]),
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
                        borderRadius:
                            BorderRadius.circular(10), // Độ bo góc của border
                      ),
                      padding:
                          EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                      child: Row(children: [
                        Image.asset(
                          'assets/images/NOTIFICATIONS.png',
                          width: 15,
                          height: 15,
                        ),
                        Text(
                          'Theo dõi',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ]),
                    ),
                    Text('34 lượt theo dõi')
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildPost4() {
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
                backgroundImage: AssetImage('assets/images/search.png'),
                // Hoặc sử dụng NetworkImage nếu avatar từ một URL
                // backgroundImage: NetworkImage('URL_TO_AVATAR'),
              ),
              SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Đỗ Duy Hào',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Công nghệ thông tinnè',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.black45,
                    ),
                  ),
                ],
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
                _buildImages(imageUrls4),
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
                        borderRadius:
                            BorderRadius.circular(10), // Độ bo góc của border
                      ),
                      padding:
                          EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                      child: Row(children: [
                        Image.asset(
                          'assets/images/like1.png',
                          width: 15,
                          height: 15,
                        ),
                        Text(
                          'Thích',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ]),
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
                        borderRadius:
                            BorderRadius.circular(10), // Độ bo góc của border
                      ),
                      padding:
                          EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                      child: Row(children: [
                        Image.asset(
                          'assets/images/NOTIFICATIONS.png',
                          width: 15,
                          height: 15,
                        ),
                        Text(
                          'Bình luận',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ]),
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
                        borderRadius:
                            BorderRadius.circular(10), // Độ bo góc của border
                      ),
                      padding:
                          EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                      child: Row(children: [
                        Image.asset(
                          'assets/images/NOTIFICATIONS.png',
                          width: 15,
                          height: 15,
                        ),
                        Text(
                          'Theo dõi',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ]),
                    ),
                    Text('34 lượt theo dõi')
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
      height: 302,
      width: 302,
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
      height: 302,
      width: 302,
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
              child: _buildFirstImage(imageUrls[0])),
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
                  builder: (context) => ImageDetail(
                    index: 0,
                    listAnh: imageUrls,
                  ),
                ));
              },
              child: _buildFirstImage(imageUrls[0])),
          Container(
            height: 302,
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
      height: 302,
      width: 302,
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
          Container(
            height: 302,
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
                        height: 150,
                        width: 150,
                        color: Colors.black
                            .withOpacity(0.5), // Độ mờ ở đây, giả sử 0.5
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
