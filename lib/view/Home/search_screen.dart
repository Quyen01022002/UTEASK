import 'dart:async';

import 'package:askute/controller/HomeGroupController.dart';
import 'package:askute/controller/SearchController.dart';
import 'package:askute/model/GroupModel.dart';
import 'package:askute/model/PostModel.dart';
import 'package:askute/view/Home/hot_post_screen.dart';
import 'package:askute/view/user/user_proflie_other.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:page_transition/page_transition.dart';

import '../../model/Class.dart';
import '../../model/UsersEnity.dart';

class SearchResultScreen extends StatefulWidget {
  const SearchResultScreen({super.key});

  @override
  State<SearchResultScreen> createState() => _SearchResultScreenState();
}

class _SearchResultScreenState extends State<SearchResultScreen> with SingleTickerProviderStateMixin {

  final SearchPostController _searchPostController = Get.put(SearchPostController());
  final HomeGroupController _homeGroupController = Get.put(HomeGroupController());
  Stream<List<PostModel>>? listPostCurrent;
List<PostModel>? allPost;

  Stream<List<GroupModel>>? listGroupCurrent;
  List<GroupModel>? allGroupSearch;

  Stream<List<UserEnity>>? listUserCurrent;
  List<UserEnity>? allUserSearch;

  ScrollController _scrollController = ScrollController();
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
    _homeGroupController.loadGroupsOfAdmin();
    setState(() {
      _searchPostController.loadHistoryKeywords(context);
    });
_startTimer();
  }
  late Timer _timer;
  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      _searchPostController.loadListResultController(context);
      // Gọi hàm cần thiết ở đây
      listPostCurrent =_searchPostController.allSearchPostStream;
      // Đây là Stream mà bạn cần theo dõi
      listPostCurrent?.listen((List<PostModel>? updatedGroups) {
        if (updatedGroups != null) {
          setState(() {
            allPost = updatedGroups;
          });
        }
      });

      listGroupCurrent = _searchPostController.allSearchGroupStream;
      listGroupCurrent?.listen((List<GroupModel>? updatedGroups) {
        if (updatedGroups != null) {
          setState(() {
            allGroupSearch = updatedGroups;
          });
        }
      });


      listUserCurrent = _searchPostController.allSearchUserStream;
      listUserCurrent?.listen((List<UserEnity>? updatedGroups) {
        if (updatedGroups != null) {
          setState(() {
            allUserSearch = updatedGroups;
          });
        }
      });

    });
  }
  @override
  void dispose() {
    _timer.cancel();
    _tabController.dispose();
    super.dispose();
  }
  bool _shouldRebuildTabBarView = false;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: categories.length,
      child: Scaffold(
        body: NestedScrollView(
          controller: _scrollController,
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
                            hintStyle: TextStyle(
                              fontSize: 14,
                              color: Color(0xFFB4BDC4),
                            ),
                            border: InputBorder.none,
                          ),
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          // handle search icon tapped
                          final check = _searchPostController.textControllerKeyword.text;
                          if (check.trim()!= '')
                         { _searchPostController.loadListResultController(context);
                         _searchPostController.addSearchKeywords(_searchPostController.textControllerKeyword.text);
                         _searchPostController.loadHistoryKeywords(context);
                          _scrollController.animateTo(
                            0.0,
                            duration: Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                          FocusScope.of(context).unfocus();}

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
          body: _shouldRebuildTabBarView ? _buildTabBarView() : _buildTabBarView(),

        ),
      ),
    );
  }

  Widget _buildTabBarView() {
    return TabBarView(
      controller: _tabController,
      children: [
        _buildCategoryContent('Bài viết'),
        _buildCategoryContent('Khoa'),
        _buildCategoryContent('Người dùng'),
        _buildCategoryContent('Chat'),
      ],
    );
  }
  Widget _buildCategoryContent(String category) {
    // Kiểm tra loại category và trả về nội dung tương ứng
    switch (category) {
      case 'Bài viết':
        return _buildPostSearch();
      case 'Khoa':
        return _ListGroupResult();
      case 'Người dùng':
        return _ListUserResult();
      case 'Chat':
        return Text('Không khả dụng');
      default:
        return Container(); // Trả về container trống nếu không khớp với bất kỳ category nào
    }
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
                  _showFilterKhoaDialog(_homeGroupController.groups!);
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
                            fontSize: 15
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
                  child: Padding(
                    padding: const EdgeInsets.all(0.0),
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
                              fontSize: 15
                          ),
                        ),
                      ],
                    ),
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

          _ListPostResult()

        ],
      ),
    );
  }

  Widget _ListPostResult(){
    return Expanded(child: StreamBuilder<List<PostModel>>(
      stream:listPostCurrent,
        builder: (context, snapshot){
          if (snapshot.hasData && snapshot.data != null){
            return HotPostQuestionScreen(listPost: snapshot.data!);
          }
          else
            return Container(child: Text('Không có kết quả tìm kiếm phù hợp'),);
        },
    ));
  }

  Widget _ListGroupResult(){
    return Expanded(child: StreamBuilder<List<GroupModel>>(
      stream:listGroupCurrent,
      builder: (context, snapshot){
        if (snapshot.hasData && snapshot.data != null){
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              return ListTile(
                onTap: () {
                },
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(snapshot.data![index].avatar.toString()),
                ),
                title: Text(snapshot.data![index].name.toString()),
              );
            },
          );
        }
        else
          return Container(
            child: Text('Không có kết quả tìm kiếm phù hợp'),
          );
      },
    ));
  }
  Widget _ListUserResult(){
    return Expanded(child: StreamBuilder<List<UserEnity>>(
      stream:listUserCurrent,
      builder: (context, snapshot){
        if (snapshot.hasData && snapshot.data != null){
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              return ListTile(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProfileUserOther(id: snapshot.data![index].user_id)),
                  );
                },
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(snapshot.data![index].avatarUrl.toString()),
                ),
                title: Text(snapshot.data![index].first_name.toString()+ ' '+ snapshot.data![index].last_name.toString()),
              );
            },
          );
        }
        else
          return Container(child: Text('Không có kết quả tìm kiếm phù hợp'),);
      },
    ));
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
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                title: Text('Sắp xếp theo lượt thích'),
                onTap: () async {
                  // Sắp xếp danh sách theo lượt thích

                  _searchPostController.filterTheLikest.value= true;
                  _searchPostController.loadListResultController(context);
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
  void _showFilterKhoaDialog(List<GroupModel> khoaList) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Lọc theo khoa'),
          content: Container(
            width: double.maxFinite,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: khoaList.length + 1, // +1 để tính cả lựa chọn "Tất cả"
              itemBuilder: (BuildContext context, int index) {
                if (index == 0) {
                  // Nếu index là 0, hiển thị lựa chọn "Tất cả"
                  return ListTile(
                    title: Text('Tất cả'),
                    onTap: () {
                      _searchPostController.idKhoa.value = 0;
                      _searchPostController.loadListResultController(context);
                      Navigator.of(context).pop();
                    },
                  );
                } else {
                  // Hiển thị các khoa khác
                  final khoa = khoaList[index - 1]; // -1 để bỏ qua lựa chọn "Tất cả"
                  return ListTile(
                    title: Text(khoa.name.toString()), // Hiển thị tên khoa trong ListTile
                    onTap: () {
                      // Xử lý khi người dùng chọn một khoa
                      // Ví dụ: Navigator.of(context).pop(khoa);
                      _searchPostController.idKhoa.value = khoa.id!;
                      _searchPostController.loadListResultController(context);
                      Navigator.of(context).pop();
                    },
                  );
                }
              },
            ),
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
    );
  }
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