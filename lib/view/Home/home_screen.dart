import 'dart:async';
import 'dart:ffi';
import 'dart:ui';

import 'package:askute/model/Class.dart';
import 'package:askute/model/GroupModel.dart';
import 'package:askute/view/Home/search_screen.dart';
import 'package:askute/view/Notification/notification_screen.dart';
import 'package:askute/view/component/categoryItem.dart';
import 'package:askute/view/component/categoryItem2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:page_transition/page_transition.dart';

import '../../controller/HomeController.dart';
import '../../controller/HomeGroupController.dart';

import '../../controller/SearchController.dart';
import '../../model/PostModel.dart';
import 'hot_post_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  final HomeController _homeController = Get.put(HomeController());
  final HomeGroupController _homeGroupController =
      Get.put(HomeGroupController());
final SearchPostController _searchController = Get.put(SearchPostController());
  late TabController _tabController;
  List<String> searchSuggestions = [
    'Từ khóa gợi ý 1',
    'Từ khóa gợi ý 2',
    'Từ khóa gợi ý 3',
    // Thêm các từ khóa gợi ý khác nếu cần
  ];

  Stream<List<PostModel>>? listPostFollowing;
  List<PostModel>? listPostFollow;

  Stream<List<PostModel>>? listHotQuestion;
  List<PostModel>? listHotPost;



  double _searchBarHeight = 50.0; // Chiều cao của thanh tìm kiếm
  bool _isSearchBarExpanded = false; // Trạng thái mở rộng của thanh tìm kiếm

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
_startTimer();
      _homeController.load10HotPost(context);
      _homeGroupController.GetListPost(context);
      _homeGroupController.loadGroupsJoin();
      _homeGroupController.loadGroupsOfAdmin();

  }

  void _showSearchSuggestions() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return _buildSearchSuggestions();
      },
    );
  }
  void _toggleSearchBar() {
    setState(() {
      _isSearchBarExpanded = !_isSearchBarExpanded;
      _searchBarHeight = _isSearchBarExpanded ? 200.0 : 50.0; // Chiều cao mới của thanh tìm kiếm
    });
  }

  late Timer _timer;
  void _startTimer() {
    _timer = Timer.periodic(Duration(milliseconds: 500), (timer) {
      _homeGroupController.GetListPost(context);
      // Gọi hàm cần thiết ở đây
      listPostFollowing =_homeGroupController.allPostFollowingStream;
      // Đây là Stream mà bạn cần theo dõi
      listPostFollowing?.listen((List<PostModel>? updatedGroups) {
        if (updatedGroups != null) {
          setState(() {
            listPostFollow = updatedGroups;
          });
        }
      });

      _homeController.load10HotPost(context);
      // Gọi hàm cần thiết ở đây
      listHotQuestion =_homeController.allPostHotStream;
      // Đây là Stream mà bạn cần theo dõi
      listHotQuestion?.listen((List<PostModel>? updatedGroups) {
        if (updatedGroups != null) {
          setState(() {
            listHotPost = updatedGroups;
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
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: Colors.white,
              expandedHeight: 50,
              floating: true,
              pinned: true,
              actions: [
                GestureDetector(
                  onTap: (){
                    Navigator.push(
                      context,
                      PageTransition(
                        type: PageTransitionType.bottomToTop,
                        child: NotificationScreen(
                        ),
                      ),
                    );
                  },
                  child: Image.asset(
                    'assets/images/NOTIFICATIONS.png',
                    width: 60,
                    height: 60,
                  ),
                ),
              ],
            ),
            SliverPadding(
              padding: EdgeInsets.all(10),
              sliver: SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Hi, Trần Bửu Quyến",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                    ),
                    Text('Bạn muốn học gì hôm nay nào? \nTìm kiếm bên dưới'),
                    SizedBox(height: 10),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
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
                          Expanded(
                            child: TextField(
                              controller: _searchController.textControllerKeyword,
                              onTap: () {
                                //_showSearchSuggestions();
                              },
                              decoration: InputDecoration(
                                hintText: 'Search for.....',
                                hintStyle:  TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFFB4BDC4),
                                ),
                                border: InputBorder.none,
                              ),
                              style: TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                              onTap: () {
_searchController.loadListResultController(context);
                                Navigator.push(
                                  context,
                                  PageTransition(
                                    type: PageTransitionType.bottomToTop,
                                    child: SearchResultScreen(),
                                  ),
                                );
                              },
                              child: Icon(Icons.search,
                              size: 30),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    // Add your list view here
                    // Example:
                    Container(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            Row(
                              children:
                                  _homeGroupController.groupsJoin!.map((post) {
                                return categoryItem(post: post);
                              }).toList(),
                            ),
                            GestureDetector(
                                onTap: () {
                                  showModalBottomSheet(
                                    context: context,
                                    backgroundColor: Colors.transparent,
                                    builder: (BuildContext context) {
                                      return _buildPopup(context, _homeGroupController.groups!);
                                    },
                                  );
                                },
                                child: Icon(Icons.filter_list)),
                          ],
                        ),
                      ),
                    ),

                    SizedBox(height: 10),
                    TabBar(
                      controller: _tabController,
                      tabs: [
                        Tab(text: 'Tất cả'),
                        Tab(text: 'Nổi bật'),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SliverFillRemaining(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildFollowwing(),
                  _buildHotQuestion(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget _buildFollowwing(){
    return Expanded(child: StreamBuilder<List<PostModel>>(
      stream: listPostFollowing,
      builder: (context, snapshot){
        if (snapshot.hasData && snapshot.data != null){
          return HotPostQuestionScreen(listPost: snapshot.data!);
        }
        else
          return Container(child: Text('Vui lòng theo dõi thêm khoa để xem các bài viết'),);
      },
    ));
  }
  Widget _buildHotQuestion(){
    return Expanded(child: StreamBuilder<List<PostModel>>(
      stream: listHotQuestion,
      builder: (context, snapshot){
        if (snapshot.hasData && snapshot.data != null){
          return HotPostQuestionScreen(listPost: snapshot.data!);
        }
        else
          return Container(child: Text('Không có bài viết nội bật'),);
      },
    ));
  }


  Widget _buildSearchSuggestions() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: ListView.builder(
        itemCount: searchSuggestions.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(searchSuggestions[index]),
            onTap: () {
              // Xử lý khi người dùng chọn từ khóa gợi ý
              // Ví dụ: cập nhật giá trị của thanh tìm kiếm với từ khóa gợi ý đã chọn
            },
          );
        },
      ),
    );
  }
}
Widget _buildPopup(BuildContext context,List<GroupModel> post) {
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
            children: [
              Column(
                children:
                post.map((item) {
                  return categoryItem2(post: item);
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}