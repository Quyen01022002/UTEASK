import 'package:askute/controller/LoginController.dart';
import 'package:askute/view/authen/Login_screen.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class DrawerScreen extends StatefulWidget {
  const DrawerScreen({super.key});

  @override
  State<DrawerScreen> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            onTap: () {
              // Add navigation functionality here
              Navigator.pop(context); // Close the drawer
            },
          ),
          ListTile(
            leading: Icon(Icons.info),
            title: Text('About'),
            onTap: () {
              LoginController.Logout();
              Navigator.push(
                  context,
                  PageTransition(
                    type: PageTransitionType.rightToLeft,
                    child: Loginscreen(
                      animated: false,
                    ),
                  ));
              // Close the drawer
            },
          ),
          // Add more items as needed
        ],
      ),
    );
  }
}
