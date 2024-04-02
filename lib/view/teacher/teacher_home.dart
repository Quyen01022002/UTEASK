import 'package:askute/view/teacher/Home/homePageTeacher.dart';
import 'package:flutter/material.dart';
class HomeTeacher extends StatefulWidget {
  const HomeTeacher({super.key});

  @override
  State<HomeTeacher> createState() => _HomeTeacherState();
}

class _HomeTeacherState extends State<HomeTeacher> {
  int _selectedIndex = 0;

  static const List<Widget> _pages = <Widget>[
    HomePageTeacher(),
    Text('Chat Page'),
    Text('Call Page'),
    Text('Settings Page'),
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

        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Teacher"),
            Row(

              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(8.0,0,8,0),
                  child: Icon(Icons.add_circle_outline,size: 30,),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8.0,0,8,0),
                  child: Icon(Icons.notifications_none_outlined,size: 30,),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8.0,0,8,0),
                  child: ClipOval(child: Image.asset("assets/images/login.png",width: 25,height: 25,fit: BoxFit.cover,),),
                )
              ],
            )
          ],
        ),
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

            icon: Icon(Icons.chat),
            label: 'Chat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.call),
            label: 'Call',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
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
