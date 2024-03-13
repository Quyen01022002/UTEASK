// import 'package:askute/controller/HomeGroupController.dart';
// import 'package:askute/view/component/khoaItem.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// class InitFollowUser extends StatefulWidget {
//   const InitFollowUser({super.key});
//
//   @override
//   State<InitFollowUser> createState() => _InitFollowUserState();
// }
//
// class _InitFollowUserState extends State<InitFollowUser> {
//   final HomeGroupController myController = Get.put(HomeGroupController());
//

import 'dart:async';

import 'package:askute/controller/HomeGroupController.dart';
import 'package:askute/view/authen/Login_screen.dart';
import 'package:askute/view/component/khoaItem.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../model/GroupModel.dart';

class GroupScreen extends StatefulWidget {
  const GroupScreen({super.key});

  @override
  State<GroupScreen> createState() => _GroupScreenState();
}

class Group {
  final int idgroup;
  final String name;
  final String avatar;

  Group(this.idgroup, this.name, this.avatar);
}

class _GroupScreenState extends State<GroupScreen>
    with SingleTickerProviderStateMixin {
  final HomeGroupController homeGroupController =
      Get.put(HomeGroupController());

  // final List<Group> listgroups = [
  //   Group(1,'Nhóm tự kỉ chat một mình', 'assets/images/facebook.png'),
  //   Group(1,'Nhóm tùm lum tùm la', 'assets/images/google.png'),
  //   Group(1,'Nhóm khác', 'assets/images/backgourd.png'),
  // ];

  final List<Group> listgroup = [];
  final List<Group> listgroupJoin = [];
  Stream<List<GroupModel>>? groupStream;
  Stream<List<Group>>? listgroupStream;
  Stream<List<GroupModel>>? groupJoinStream;
  Stream<List<Group>>? listgroupJoinStream;

  Future<void> _mapGroupModelToGroupClass() async {
    if (homeGroupController.groups != null) {
      homeGroupController.groups!.forEach((element) {
        Group group = Group(
            element.id ?? 0, element.name ?? '', element.description ?? '');
        listgroup.add(group);
      });
    }
    if (homeGroupController.groupsJoin != null) {
      homeGroupController.groupsJoin!.forEach((element) {
        Group group = Group(
            element.id ?? 0, element.name ?? '', element.description ?? '');
        listgroupJoin.add(group);
      });
    }
  }

  Future<void> _mapGroupModelToGroup(List<GroupModel> list) async {
    if (list != null) {
      list!.forEach((element) {
        Group group = Group(
            element.id ?? 0, element.name ?? '', element.description ?? '');
        listgroup.add(group);
      });
    }
  }

  Future<void> _mapGroupModelToGroupJoin(List<GroupModel> list) async {
    if (list != null) {
      list!.forEach((element) {
        Group group = Group(
            element.id ?? 0, element.name ?? '', element.description ?? '');
        listgroupJoin.add(group);
      });
    }
  }

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this, initialIndex: 0);
    _startTimer();
  }

  late Timer _timer;

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 2), (timer) {
      // Gọi hàm cần thiết ở đây
      homeGroupController.loadGroupsOfAdmin();
      homeGroupController.loadGroupsJoin();
      groupStream =
          homeGroupController.groupsStream; // Đây là Stream mà bạn cần theo dõi
      // Cập nhật danh sách nhóm khi Stream thay đổi
      groupStream?.listen((List<GroupModel>? updatedGroups) {
        if (updatedGroups != null) {
          setState(() {
            listgroup.clear();
            _mapGroupModelToGroup(updatedGroups);
          });
        }
      });
      groupJoinStream = homeGroupController
          .groupsJoinStream; // Đây là Stream mà bạn cần theo dõi
      // Cập nhật danh sách nhóm khi Stream thay đổi
      groupJoinStream?.listen((List<GroupModel>? updatedGroups) {
        if (updatedGroups != null) {
          setState(() {
            listgroupJoin.clear();
            _mapGroupModelToGroupJoin(updatedGroups);
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
        body: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 23 / 100,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(1500),
                  bottomRight: Radius.circular(1500),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Hãy chọn đề tại mà bạn quan tâm",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ),
            ),
            Container(
              height: 480,
              child: Padding(
                padding: const EdgeInsets.only(top: 28.0),
                child: ListView.builder(
                  itemCount:homeGroupController.groups!.length,
                  itemBuilder: (context, index) {
                    GroupModel group = homeGroupController.groups![index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: khoaItem(group: group,),
                    );
                  },
                ),
              ),
            ),
            Center(
              child: GestureDetector(
                onTap: () {
                  Future.delayed(Duration(milliseconds: 300), () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => Loginscreen(animated: false)),
                    );
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(100, 18, 100, 18),
                    child: Text(
                      "Bắt đầu",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
