import 'package:askute/view/Home/home_page_new.dart';
import 'package:askute/view/Home/search_screen.dart';
import 'package:askute/view/mess/home_mess_screen.dart';
import 'package:askute/view/search/HomeSearchScreen.dart';
import 'package:askute/view/teacher/Home/Home_Messeger.dart';
import 'package:flutter/material.dart';
import 'package:askute/view/Quetions/createQuetions.dart';
import 'package:askute/view/setting/setting_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:page_transition/page_transition.dart';

import '../Home/home_screen.dart';
import '../Home/home_screen_new.dart';

class DashBoardVer2 extends StatefulWidget {
  const DashBoardVer2({Key? key}) : super(key: key);

  @override
  State<DashBoardVer2> createState() => _DashBoardVer2State();
}

class _DashBoardVer2State extends State<DashBoardVer2> {
  int currentTab = 0;
  final List<Widget> screens = [
    HomeScreen3(),

    // Add two more screens here
    HomeSearchScreen(), // Example screen
    Home_Messeger(),
    SettingScreen(),// Example screen
  ];
  final PageStorageBucket bucket = PageStorageBucket();

  @override
  Widget build(BuildContext context) {
    Widget currentScreen = screens[currentTab];

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: PageStorage(
        child: currentScreen,
        bucket: bucket,
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            PageTransition(
              type: PageTransitionType.bottomToTop,
              child: CreatePost(
                statepost: false,
              ),
            ),
          );
        },
        heroTag: null,
          mini: true,
        shape: CircleBorder(),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: SafeArea(
        child: BottomAppBar(
          height: 50,
          padding: EdgeInsets.only(bottom: 8),
          shape: CircularNotchedRectangle(),
          shadowColor: Color.fromRGBO(0,0,0,0),
          clipBehavior: Clip.none,
          notchMargin: 5,
          child: Container(
            height: 40,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                      IconButton(
                        onPressed: () {
                          setState(() {
                            currentTab = 0;
                          });
                        },
                        icon: Icon(
                          Icons.home,
                          color: currentTab == 0 ? Colors.blue : Colors.grey,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            currentTab = 1;
                          });
                        },
                        icon: Icon(
                          Icons.search,
                          color: currentTab == 1 ? Colors.blue : Colors.grey,
                        ),
                      ),
                      Container(
                        width: 30,
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            currentTab = 2;
                          });
                        },
                        icon: Icon(
                          Icons.message,
                          color: currentTab == 2 ? Colors.blue : Colors.grey,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            currentTab = 3;
                          });
                        },
                        icon: Icon(
                          Icons.dashboard,
                          color: currentTab == 3 ? Colors.blue : Colors.grey,
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),

    );
  }
}
