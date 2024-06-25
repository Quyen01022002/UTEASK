import 'package:askute/controller/HomeGroupController.dart';
import 'package:askute/model/PostModel.dart';
import 'package:askute/model/UserProgress.dart';
import 'package:askute/view/Home/hot_post_screen.dart';
import 'package:askute/view/Home/list_post_screen.dart';
import 'package:askute/view/teacher/Home/Sector/ListSector.dart';
import 'package:askute/view/teacher/Home/Sector/ListTeacherInGroup.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:page_transition/page_transition.dart';

import '../../../../model/GroupModel.dart';

class HomeSector extends StatefulWidget {
  const HomeSector({super.key});

  @override
  State<HomeSector> createState() => _HomeSectorState();
}

class UserSEC {
  final String avatarUrl;
  final String name;
  final double progress;
  final int questionsReceived;
  final int questionsCompleted;

  UserSEC({
    required this.avatarUrl,
    required this.name,
    required this.progress,
    required this.questionsReceived,
    required this.questionsCompleted,
  });
}

class _HomeSectorState extends State<HomeSector> {
  final HomeGroupController homeGroupController =
      Get.put(HomeGroupController());
  final List<UserSEC> users = [
    UserSEC(
      avatarUrl: 'https://i.pravatar.cc/150?img=1',
      name: 'Nguyen Van A',
      progress: 0.8,
      questionsReceived: 20,
      questionsCompleted: 16,
    ),
    UserSEC(
      avatarUrl: 'https://i.pravatar.cc/150?img=2',
      name: 'Tran Thi B',
      progress: 0.5,
      questionsReceived: 10,
      questionsCompleted: 5,
    ),
    UserSEC(
      avatarUrl: 'https://i.pravatar.cc/150?img=3',
      name: 'Le Van C',
      progress: 0.9,
      questionsReceived: 15,
      questionsCompleted: 13,
    ),
    UserSEC(
      avatarUrl: 'https://i.pravatar.cc/150?img=1',
      name: 'Nguyen Van A',
      progress: 0.8,
      questionsReceived: 20,
      questionsCompleted: 16,
    ),
    UserSEC(
      avatarUrl: 'https://i.pravatar.cc/150?img=2',
      name: 'Tran Thi B',
      progress: 0.5,
      questionsReceived: 10,
      questionsCompleted: 5,
    ),
    UserSEC(
      avatarUrl: 'https://i.pravatar.cc/150?img=3',
      name: 'Le Van C',
      progress: 0.9,
      questionsReceived: 15,
      questionsCompleted: 13,
    ),
    UserSEC(
      avatarUrl: 'https://i.pravatar.cc/150?img=1',
      name: 'Nguyen Van A',
      progress: 0.8,
      questionsReceived: 20,
      questionsCompleted: 16,
    ),
    UserSEC(
      avatarUrl: 'https://i.pravatar.cc/150?img=2',
      name: 'Tran Thi B',
      progress: 0.5,
      questionsReceived: 10,
      questionsCompleted: 5,
    ),
    UserSEC(
      avatarUrl: 'https://i.pravatar.cc/150?img=3',
      name: 'Le Van C',
      progress: 0.9,
      questionsReceived: 15,
      questionsCompleted: 13,
    ),
    UserSEC(
      avatarUrl: 'https://i.pravatar.cc/150?img=1',
      name: 'Nguyen Van A',
      progress: 0.8,
      questionsReceived: 20,
      questionsCompleted: 16,
    ),
    UserSEC(
      avatarUrl: 'https://i.pravatar.cc/150?img=2',
      name: 'Tran Thi B',
      progress: 0.5,
      questionsReceived: 10,
      questionsCompleted: 5,
    ),
    UserSEC(
      avatarUrl: 'https://i.pravatar.cc/150?img=3',
      name: 'Le Van C',
      progress: 0.9,
      questionsReceived: 15,
      questionsCompleted: 13,
    ),
    UserSEC(
      avatarUrl: 'https://i.pravatar.cc/150?img=1',
      name: 'Nguyen Van A',
      progress: 0.8,
      questionsReceived: 20,
      questionsCompleted: 16,
    ),
    UserSEC(
      avatarUrl: 'https://i.pravatar.cc/150?img=2',
      name: 'Tran Thi B',
      progress: 0.5,
      questionsReceived: 10,
      questionsCompleted: 5,
    ),
    UserSEC(
      avatarUrl: 'https://i.pravatar.cc/150?img=3',
      name: 'Le Van C',
      progress: 0.9,
      questionsReceived: 15,
      questionsCompleted: 13,
    ),
    UserSEC(
      avatarUrl: 'https://i.pravatar.cc/150?img=1',
      name: 'Nguyen Van A',
      progress: 0.8,
      questionsReceived: 20,
      questionsCompleted: 16,
    ),
    UserSEC(
      avatarUrl: 'https://i.pravatar.cc/150?img=2',
      name: 'Tran Thi B',
      progress: 0.5,
      questionsReceived: 10,
      questionsCompleted: 5,
    ),
    UserSEC(
      avatarUrl: 'https://i.pravatar.cc/150?img=3',
      name: 'Le Van C',
      progress: 0.9,
      questionsReceived: 15,
      questionsCompleted: 13,
    ),
  ];
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (_scrollController.offset >= 120) {
      // Nếu vị trí cuộn lớn hơn hoặc bằng chiều cao của tiêu đề,
      // thì dừng cuộn bằng cách đặt vị trí của ScrollController về vị trí tương ứng
      _scrollController.jumpTo(120);
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  Future<GroupModel?> fetchData() async {
    // Đây là ví dụ về việc tải dữ liệu từ cơ sở dữ liệu hoặc một API
    // Thay thế phần này bằng hàm thực sự để tải dữ liệu của bạn
    return homeGroupController.loadGroup(context);
  }
  Future<List<PostModel>?> fetchDataPost() async {
    // Đây là ví dụ về việc tải dữ liệu từ cơ sở dữ liệu hoặc một API
    // Thay thế phần này bằng hàm thực sự để tải dữ liệu của bạn
    return homeGroupController.loadPostOfGroup(context);
  }

  Future<List<UserProgress>?> fetchDataProgress() async {
    // Đây là ví dụ về việc tải dữ liệu từ cơ sở dữ liệu hoặc một API
    // Thay thế phần này bằng hàm thực sự để tải dữ liệu của bạn
    return homeGroupController.loadTeacherProgress(context);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Số lượng tab
      child: Scaffold(
        body: FutureBuilder<GroupModel?>(
            future: fetchData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                // Hiển thị màn hình chờ khi dữ liệu đang được tải
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                // Hiển thị lỗi nếu có lỗi xảy ra trong quá trình tải dữ liệu
                return Text('Error: ${snapshot.error}');
              } else if (snapshot.hasData) {
                return CustomScrollView(
                    controller: _scrollController,
                    slivers: [
                      SliverAppBar(
                        automaticallyImplyLeading: false,
                        pinned: true,
                        floating: true,
                        title: Text(
                          snapshot.data!.name!,
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        expandedHeight: 120,
                        // Đặt pinned thành true
                        flexibleSpace: FlexibleSpaceBar(
                          background: Image.network(
                            snapshot.data!.avatar!,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SliverPadding(
                        padding: EdgeInsets.all(10),
                        sliver: SliverList(
                          delegate: SliverChildListDelegate(
                            [
                              _buildViewer(),
                              SizedBox(height: 10),
                              TabBar(
                                tabs: [
                                  Tab(text: 'Bảng Tin'),
                                  Tab(text: 'Tiến độ'),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      SliverFillRemaining(
                        child: TabBarView(
                          children: [
                            FutureBuilder<List<PostModel>?>(
                                future: fetchDataPost(),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    // Hiển thị màn hình chờ khi dữ liệu đang được tải
                                    return Center(child: CircularProgressIndicator());
                                  } else if (snapshot.hasError) {
                                    // Hiển thị lỗi nếu có lỗi xảy ra trong quá trình tải dữ liệu
                                    return Text('Error: ${snapshot.error}');
                                  } else if (snapshot.hasData) {
                                    return Center(
                                      child: HotPostQuestionScreen(
                                        listPost: snapshot.data!,
                                      ),
                                    );
                                  } else
                                    return Container();
                                }),
                            _buildUserList(),
                          ],
                        ),
                      ),
                    ]);
              } else {
                return Container();
              }
            }),
      ),
    );
  }

  Widget _buildProgess() {
    return _buildUserList();
  }

  Widget _buildViewer() {
    return GetBuilder<HomeGroupController>(builder: (controller) {
      return Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  PageTransition(
                    type: PageTransitionType.rightToLeft,
                    child: GroupSector(),
                  ),
                );
              },
              child: Container(
                height: 50,
                width: MediaQuery.of(context).size.width * 0.40,
                margin: EdgeInsets.symmetric(horizontal: 5.0),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image:
                        AssetImage('assets/images/backgroud_profile_page.png'),
                    // Thay đổi đường dẫn tới ảnh của bạn
                    fit: BoxFit.cover, // Đảm bảo ảnh sẽ che đầy Container
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        controller.countSec.toString(),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        ' Lĩnh vực',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  PageTransition(
                    type: PageTransitionType.rightToLeft,
                    child: GroupTeacher(),
                  ),
                );
              },
              child: Container(
                height: 50,
                width: MediaQuery.of(context).size.width * 0.40,
                margin: EdgeInsets.symmetric(horizontal: 5.0),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image:
                        AssetImage('assets/images/backgroud_profile_page.png'),
                    fit: BoxFit.cover, // Đảm bảo ảnh sẽ che đầy Container
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        controller.countTeac.toString(),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        ' Giảng viên',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget _buildKhoa() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 120,
      margin: EdgeInsets.symmetric(horizontal: 5.0),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(
              'https://i.pinimg.com/564x/ce/bb/2f/cebb2f79b8fd7836864b7556bd8b6beb.jpg'),
          // Thay đổi đường dẫn tới ảnh của bạn
          fit: BoxFit.cover, // Đảm bảo ảnh sẽ che đầy Container
        ),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Center(
        child: Text(
          'Công nghệ thông tin',
          style: TextStyle(
            color: Colors.white,
            fontSize: 28.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildUserList() {
    return FutureBuilder(
      future: fetchDataProgress(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Hiển thị màn hình chờ khi dữ liệu đang được tải
          return Center(child: Container(
              child: CircularProgressIndicator()));
        }
        else if (snapshot.hasError) {
          // Hiển thị lỗi nếu có lỗi xảy ra trong quá trình tải dữ liệu
          return Text('Error: ${snapshot.error} ${snapshot.data!}' );
        }
        else if (snapshot.hasData && snapshot.data!.length == 0){
          return Text("Chưa có giảng viên nào trong Khoa");
        }
        else {
        return ListView.builder(
          //shrinkWrap: true,
          // physics: AlwaysScrollableScrollPhysics(),
          itemCount: snapshot.data!.length,
          itemBuilder: (context, index) {
            return _buildUserItem(snapshot.data![index]);
          },
        );}
      }
    );
  }

  Widget _buildUserItem(UserProgress user) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(user.userProfile!.avatarUrl!),
      ),
      title: Text('${user.userProfile!.first_name!} ${user.userProfile!.last_name!}'),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LinearProgressIndicator(
            value: user.countAllPostReply == 0? 1 : user.countPostRelied!/user.countAllPostReply!,
            backgroundColor: Colors.grey[300],
            color: Colors.blue,
          ),
          SizedBox(height: 5),
          Text('Câu hỏi nhận được: ${user.countAllPostReply}'),
          Text('Câu hỏi đã hoàn thành: ${user.countPostRelied}'),
        ],
      ),
    );
  }
}
