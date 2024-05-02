import 'dart:ffi';

import 'package:askute/controller/Class/ClassController.dart';
import 'package:askute/model/Class.dart';
import 'package:askute/model/GroupModel.dart';
import 'package:askute/view/Class/createQuetionsClasses.dart';
import 'package:askute/view/component/Drawer.dart';
import 'package:askute/view/component/headerTeacher.dart';
import 'package:askute/view/component/post_screen.dart';
import 'package:askute/view/teacher/Home/Class/AddMemberScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../Class/createClass.dart';

class ClassDetailTeacher extends StatefulWidget {
  final ClassModel classes;

  const ClassDetailTeacher({super.key, required this.classes});

  @override
  State<ClassDetailTeacher> createState() => _ClassDetailTeacherState();
}

class _ClassDetailTeacherState extends State<ClassDetailTeacher> {
  late RxString curnetUser = "".obs;
  @override
  void initState() {
    super.initState();

    initCurrentUser();
  }

  void initCurrentUser() async {
    final prefs = await SharedPreferences.getInstance();
    curnetUser = (prefs.getString('Avatar') ??
            "https://inkythuatso.com/uploads/thumbnails/800/2023/03/10-anh-dai-dien-trang-inkythuatso-03-15-27-10.jpg")
        .obs;
    print(curnetUser);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: HeaderTeacher(),
          automaticallyImplyLeading: false,
          bottom: TabBar(
            tabs: [
              Tab(text: 'Bảng Tin'),
              Tab(text: 'Mọi Người'),
            ],

          ),

        ),
        endDrawer: Drawer(
          child: DrawerScreen(),
        ),
        body: TabBarView(
          children: [
            Tab1(
              curentUser: curnetUser,
              classes: widget.classes,
            ),
            Tab3(
              classes: widget.classes,
            ),
          ],
        ),
      ),
    );
  }
}

class Tab1 extends StatelessWidget {
  final RxString curentUser;
  final ClassModel classes;

  const Tab1({required this.curentUser, required this.classes});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(15.0),
                // Điều chỉnh độ cong ở đây
                child: Image.asset(
                  "assets/images/login.png",
                  width: MediaQuery.of(context).size.width,
                  height: 150,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8.0, 100, 0, 0),
                child: Text(
                  "Lớp A",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 25),
                ),
              ),
              Positioned(
                top: 10,
                left: (MediaQuery.of(context).size.width - 8) * 0.6,
                child: Container(
                  decoration: BoxDecoration(
                      color: Color(0xFFE2EEE6),
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(12.0, 8, 12, 8),
                    child: Row(
                      children: [
                        Icon(
                          Icons.settings,
                          color: Colors.blue,
                        ),
                        Text(
                          "Tùy Chỉnh",
                          style: TextStyle(
                              color:  Colors.blue,
                              fontWeight: FontWeight.w400,
                              fontSize: 15),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
          Card(
            surfaceTintColor: Colors.white,
            elevation: 3,
            margin: EdgeInsets.all(8),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(this.curentUser.value),
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: TextFormField(
                          onTap: () {
                            Navigator.push(
                              context,
                              PageTransition(
                                type: PageTransitionType.bottomToTop,
                                child: CreateClassPost(
                                  statepost: false,
                                  classes: this.classes,
                                ),
                              ),
                            );
                          },
                          decoration: InputDecoration(
                            fillColor:Colors.white,
                            hintText: "Bạn nghĩ gì?",
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: classes.listPost!.length,
              itemBuilder: (context, index) {
                var item = classes.listPost![index];
                print(item);
                return PostScreen(post: item);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class Tab2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Tab 2 Content'),
    );
  }
}

class Tab3 extends StatelessWidget {
  final ClassModel classes;

  const Tab3({required this.classes});

  @override
  Widget build(BuildContext context) {
    final ClassController classController = Get.put(ClassController());
    return SingleChildScrollView(
      child: Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color:  Colors.blue,
                      width: 2.0,
                    ),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 16, 0, 16),
                      child: Text(
                        "Giáo Viên",
                        style: TextStyle(
                          color:  Colors.blue,
                          fontSize: 25,
                        ),
                      ),
                    ),
                    Icon(
                      Icons.person_add_outlined,
                      size: 30,
                      color:  Colors.blue,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    ClipOval(
                      child: Image.network(
                        classes.teacher!.profilePicture,
                        width: 32,
                        height: 32,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        classes.teacher!.firstName.toString() +
                            classes.teacher!.lastName,
                        style: TextStyle(
                          fontSize: 18,
                          color: Color(0xFF646368),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color:  Colors.blue,
                          width: 2.0,
                        ),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 16, 0, 16),
                          child: Text(
                            "Sinh Viên",
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: 25,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              PageTransition(
                                type: PageTransitionType.leftToRightWithFade,
                                child: AddMemberScreen(
                                  classes: classes,
                                ),
                              ),
                            );
                          },
                          child: Icon(
                            Icons.person_add_outlined,
                            size: 30,
                            color:  Colors.blue,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: classes.listMembers.map((post) {
                      print(classes.listMembers);
                      return GestureDetector(
                        onLongPress: ()
                        {

                          _showBottomSheet(context,post,classController,this.classes);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              ClipOval(
                                child: Image.network(
                                  post.profilePicture,
                                  width: 32,
                                  height: 32,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Text(
                                  post.firstName + post.lastName,
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Color(0xFF646368),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void _showBottomSheet(BuildContext context,UserMember classID, ClassController classController,ClassModel classModel) {
  showModalBottomSheet(
    context: context,
    builder: (BuildContext builderContext) {
      return Container(
        child: Wrap(
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.delete),
              title: Text('Xóa thành viên'),
              onTap: () {
               classController.deleteMemberOutGroup(context, classID.idMembers,classModel.id);
              },
            ),
            ListTile(
              leading: Icon(Icons.message),
              title: Text('Liên Hệ'),
              onTap: () {

              },
            ),
            // Add more items as needed
          ],
        ),
      );
    },
  );
}
