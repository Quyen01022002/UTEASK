
import 'package:askute/view/Class/createClass.dart';
import 'package:askute/view/component/Drawer.dart';
import 'package:askute/view/teacher/Home/Home_Messeger.dart';
import 'package:askute/view/teacher/Home/homePageTeacher.dart';
import 'package:askute/view/teacher/Home/thongKe.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../component/headerTeacher.dart';
import 'Home/Class/ClassHomePage.dart';

class HomeTeacher extends StatefulWidget {
  const HomeTeacher({super.key});

  @override
  State<HomeTeacher> createState() => _HomeTeacherState();
}

class _HomeTeacherState extends State<HomeTeacher> {
  int _selectedIndex = 0;

  static const List<Widget> _pages = <Widget>[
    HomePageTeacher(),
    ThongKe(),
    ClassHomePage(),
    Home_Messeger(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: HeaderTeacher(),
        automaticallyImplyLeading: false,
      ),
      endDrawer: Drawer(
        child: DrawerScreen(),
      ),
      body: Center(
        child: _pages.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.trending_up_rounded),
            label: 'Thống Kê',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_book_sharp),
            label: 'Lớp',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.telegram_outlined),
            label: 'Nhắn Tin',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.greenAccent,
        onTap: _onItemTapped,
      ),
    );
  }
}
