import 'package:askute/view/Quetions/createQuetions.dart';
import 'package:askute/view/setting/setting_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:page_transition/page_transition.dart';

import '../Home/home_screen.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({Key? key}) : super(key: key);

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  int currentTab = 0;
  final List<Widget> screens = [
    HomeScreen(),
    HomeScreen(),
    SettingScreen(),

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
              child: CreatePost( statepost: false,
              ),
            ),
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: SafeArea(
        child: BottomAppBar(
          shape: CircularNotchedRectangle(),
          notchMargin: 10,
          child: Container(
            height: 60,
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
                    Icons.dashboard,
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
                    Icons.notifications,
                    color: currentTab == 1 ? Colors.blue : Colors.grey,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      currentTab = 2;
                    });
                  },
                  icon: Icon(
                    Icons.menu,
                    color: currentTab == 2 ? Colors.blue : Colors.grey,
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
