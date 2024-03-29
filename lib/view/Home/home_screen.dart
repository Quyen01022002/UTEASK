import 'dart:async';
import 'dart:ffi';
import 'dart:ui';

import 'package:askute/model/GroupModel.dart';
import 'package:askute/view/Notification/notification_screen.dart';
import 'package:askute/view/component/categoryItem.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:page_transition/page_transition.dart';

import '../../controller/HomeController.dart';
import '../../controller/HomeGroupController.dart';
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

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);

      _homeController.load10HotPost();
      _homeGroupController.GetListPost(context);
      _homeGroupController.loadGroupsJoin();
      _homeGroupController.loadGroupsOfAdmin();

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
                          GestureDetector(
                            onTap: () {
                              // handle search icon tapped
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(Icons.search),
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
                                color: Color(0xFFB4BDC4),
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
                  HotPostQuestionScreen(
                      listPost: _homeGroupController.listPost),
                  HotPostQuestionScreen(listPost: _homeController.top10Post),
                ],
              ),
            ),
          ],
        ),
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
                  return categoryItem(post: item);
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}