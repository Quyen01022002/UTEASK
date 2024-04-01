import 'package:askute/controller/SearchController.dart';
import 'package:askute/view/Home/hot_post_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:page_transition/page_transition.dart';

class SearchResultScreen extends StatefulWidget {
  const SearchResultScreen({super.key});

  @override
  State<SearchResultScreen> createState() => _SearchResultScreenState();
}

class _SearchResultScreenState extends State<SearchResultScreen> with SingleTickerProviderStateMixin {

  final SearchPostController _searchPostController = Get.put(SearchPostController());
  List<String> categories = [
    'Bài viết',
    'Khoa',
    'Người dùng',
    'Chat',
  ];
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this, initialIndex: 0);

  }

  void _updateListSearchPost(){
    setState(() {
      _searchPostController.topSearch;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: categories.length,
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                pinned: true,
                title: Container(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    children: [

                      Expanded(
                        child: TextField(
                          controller: _searchPostController.textControllerKeyword,
                          onTap: () {
                            // _showSearchSuggestions();
                          },
                          decoration: InputDecoration(
                            hintText: 'Search for.....',
                            border: InputBorder.none,
                          ),
                          style: TextStyle(
                            fontSize: 18,
                            color: Color(0xFFB4BDC4),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          // handle search icon tapped
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(Icons.search),
                        ),
                      ),
                    ],
                  ),
                ),
                bottom: TabBar(
                  controller: _tabController,
                  tabs: [
                    _buildTab('Bài viết'),
                    _buildTab('Khoa'),
                    _buildTab('Người dùng'),_buildTab('Chat'),

                  ],
                ),
              ),
            ];
          },
          body:Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildCategoryContent('Bài viết'),
                _buildCategoryContent('Bài viết'),
                _buildCategoryContent('Người dùng'),
                _buildCategoryContent('Chat'),
              ]
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryContent(String category) {
    // Kiểm tra loại category và trả về nội dung tương ứng
    switch (category) {
      case 'Bài viết':
        return _buildPostSearch();
      case 'Khoa':
        return _buildInfomationAccount();
      case 'Người dùng':
        return _buildInfomationAccount();
      case 'Chat':
        return _buildInfomationAccount();
      default:
        return Container(); // Trả về container trống nếu không khớp với bất kỳ category nào
    }
  }

  List<Widget> _buildTabs() {
    return categories.map((title) => _buildTab(title)).toList();
  }

  Widget _buildTab(String title) {
    return Tab(
      child: Container(
        padding: EdgeInsets.all(2),
        alignment: Alignment.center,
        child: Text(
          title,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.bold,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }
  Widget _buildInfomationAccount(){
    return Container(
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.all(10),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Image.asset(
                              'assets/images/email_edit.png',
                              width: 30,
                              height: 30,
                            ),
                            SizedBox(width: 15,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 5,),
                                Text('Email',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold
                                  ),),
                                SizedBox(height: 10,),
                                Text('myProfileController.email.toString()',
                                  style: TextStyle(
                                    color: Color(0xFF4F4F4F),
                                  ),),
                              ],
                            ),]),
                      GestureDetector(
                        //onTap: _showEditEmailDialog,
                        child: Text(
                          'Chỉnh sửa',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold, // Màu sắc của Text khi chưa được nhấn
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.all(10),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Image.asset(
                              'assets/images/phone_edit.png',
                              width: 30,
                              height: 30,
                            ),
                            SizedBox(width: 15,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 5,),
                                Text('Số điện thoại',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold
                                  ),),
                                SizedBox(height: 10,),
                                Text('myProfileController.phone.toString()',
                                  style: TextStyle(
                                    color: Color(0xFF4F4F4F),
                                  ),),
                              ],
                            ),]),
                      GestureDetector(
                        //onTap: _showEditPhoneDialog,
                        child: Text(
                          'Chỉnh sửa',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold, // Màu sắc của Text khi chưa được nhấn
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.all(10),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Image.asset(
                              'assets/images/pw_edit.png',
                              width: 30,
                              height: 30,
                            ),
                            SizedBox(width: 15,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 5,),
                                Text('Mật khẩu',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold
                                  ),),
                                SizedBox(height: 10,),
                                Text('Chạm để thay đổi mật khẩu',
                                  style: TextStyle(
                                    color: Color(0xFF4F4F4F),
                                  ),),
                              ],
                            ),]),
                      GestureDetector(
                     //   onTap: _showEditPasswordDialog,
                        child: Text(
                          'Chỉnh sửa',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold, // Màu sắc của Text khi chưa được nhấn
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.all(10),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Image.asset(
                              'assets/images/payment_edit.png',
                              width: 30,
                              height: 30,
                            ),
                            SizedBox(width: 15,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 5,),
                                Text('Phương thức thanh toán',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold
                                  ),),
                                SizedBox(height: 10,),
                                Text('ZaloPay',
                                  style: TextStyle(
                                    color: Color(0xFF4F4F4F),
                                  ),),
                              ],
                            ),]),
                      GestureDetector(
                        onTap: () {
                        },
                        child: Text(
                          'Chỉnh sửa',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold, // Màu sắc của Text khi chưa được nhấn
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPostSearch(){
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  _showFilterKhoaDialog();
                },
                child: Container(
                  margin: EdgeInsets.all(8),
                  padding: EdgeInsets.all(4),
                  height: 30,
                  width: 100,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
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
                      Image.asset(
                        'assets/images/FILTER.png',
                        width: 18,
                        height: 18,
                      ),
                      SizedBox(width: 10,),
                      Text('Bộ lọc',
                        style: TextStyle(
                            fontSize: 18
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  _showFilterSapXepDialog();
                },
                child: Container(
                  margin: EdgeInsets.all(8),
                  padding: EdgeInsets.all(4),
                  height: 30,
                  width: 100,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
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
                      Image.asset(
                        'assets/images/FILTER.png',
                        width: 18,
                        height: 18,
                      ),
                      SizedBox(width: 10,),
                      Text('Sắp xếp',
                        style: TextStyle(
                            fontSize: 18
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.only(top: 5),
            height: 1, // Chiều cao của thanh ngang
            width: 500, // Độ dày của thanh ngang
            color: Color(0xC0C0C0C0),
            alignment: Alignment.center,
          ),
          Expanded(child: HotPostQuestionScreen(listPost: _searchPostController.topSearch)),


        ],
      ),




    );
  }
  void _showFilterSapXepDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Bộ lọc và sắp xếp'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Text('Sắp xếp theo thời gian gần nhất'),
                onTap: () {
                  // Sắp xếp danh sách theo thời gian gần nhất
                  _searchPostController.filterTheLikest.value= false;
                  _searchPostController.loadListResultController(context);
                 // HotPostQuestionScreen(listPost: _searchPostController.topSearch,);
                  _updateListSearchPost();
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                title: Text('Sắp xếp theo lượt thích'),
                onTap: () {
                  // Sắp xếp danh sách theo lượt thích
                  _searchPostController.filterTheLikest.value= true;
                  _searchPostController.loadListResultController(context);
               //   HotPostQuestionScreen(listPost: _searchPostController.topSearch,);
                _updateListSearchPost();
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Đóng'),
            ),
          ],
        );
      },
    );}
  void _showFilterKhoaDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Lọc theo khoa'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Text('Sắp xếp theo thời gian gần nhất'),
                onTap: () {
                  // Sắp xếp danh sách theo thời gian gần nhất

                },
              ),
              ListTile(
                title: Text('Sắp xếp theo lượt thích'),
                onTap: () {
                  // Sắp xếp danh sách theo lượt thích

                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Đóng'),
            ),
          ],
        );
      },
    );}

  // List<Widget> _buildTabs() {
  //   return categories
  //       .map(
  //         (title) => _buildTab(title),
  //   )
  //       .toList()
  //       .getRange(0, _tabController.length)
  //       .toList();
  // }

  // Widget _buildTab(String title) {
  //   return Tab(
  //     child: Container(
  //       padding: EdgeInsets.all(0),
  //       decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
  //       child: Text(
  //         title,
  //         style: TextStyle(
  //           fontSize: 14,
  //           fontWeight: FontWeight.bold,
  //           overflow: TextOverflow.ellipsis,
  //         ),
  //       ),
  //     ),
  //   );
  // }
  Widget _toolSearch() {
    return Container(
      child: TextField(
        onTap: () {
          //_showSearchSuggestions();
        },
        decoration: InputDecoration(
          hintText: 'Search for.....',
          border: InputBorder.none,
        ),
        style: TextStyle(
          fontSize: 18,
          color: Color(0xFFB4BDC4),
        ),
      ),
    );
  }
}
Widget _buildPopup(BuildContext context, List<String> categories) {
  return Container(
    margin: EdgeInsets.only(bottom: 350),
    child: AnimatedOpacity(
      opacity: 1.0,
      duration: Duration(milliseconds: 600),
      child: SlideTransition(
        position: Tween<Offset>(
          begin: Offset(0, -1),
          end: Offset.zero,
        ).animate(CurvedAnimation(
          parent: ModalRoute.of(context)!.animation!,
          curve: Curves.easeInOut,
        )),
        child: Container(
          height: 200,
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(20),
            ),
          ),
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: categories.map((category) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: ElevatedButton(
                  onPressed: () {
                    // Xử lý khi người dùng chọn một danh mục
                  },
                  child: Text(category),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    ),
  );
}