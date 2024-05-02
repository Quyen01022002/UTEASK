import 'package:askute/controller/SettingController.dart';
import 'package:askute/service/SendMessage.dart';
import 'package:askute/view/setting/SavedPostsPage.dart';
import 'package:askute/view/user/activity/ActivityScreen.dart';
import 'package:askute/view/user/user_proflie_screen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:page_transition/page_transition.dart';

import '../../controller/LoginController.dart';
import '../../controller/MyProfileController.dart';
import '../authen/Login_screen.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
    final SettingController settingController =Get.put(SettingController());
    MyProfileController myProfileController = Get.put(MyProfileController());
    @override
    void initState() {
      super.initState();
      settingController.loadthongtin();
    }

    @override
    void dispose() { // Hủy bỏ timer khi widget được hủy
      super.dispose();
    }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(slivers: [
          SliverToBoxAdapter(
            child: Column(children: [
              Container(
                decoration: BoxDecoration(color: Color(0xFFF3F5F7)),
                child: Stack(
                  children: [
                    _buildOption(),
                    _buildAccount(),
                    //_buildAdvertising(),
                  ],
                ),
              ),
            ]),
          )
        ]),
      ),
    );
  }

  Widget _buildAccount() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(20.0),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      height: 150,
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              myProfileController.loadMyProfile();
              sendFriendRequestNotification("dAJ6qbMRS32nP4rYUgDcqZ:APA91bHNsRXeb3jCcIR1DepEZRKqMPznbZqknhk0xIL_iAul3sRlR-HNk7tD446nJdxL1ddSXBeH6XteS1B62C0cFiGIgghKsfnzLyk3PcvQWUBNA_zgmui0uo5iGXCATT7ufpJ1ji8K");

              Navigator.push(
                context,
                PageTransition(
                  type: PageTransitionType.rightToLeft,
                  child: ProfileUserScreen(),
                ),
              );
            },
            child: Container(
              width: 100.0,
              height: 100.0,
              child: CircleAvatar(
                backgroundImage: NetworkImage(
                  settingController.avatar.value,
                ),
                radius: 50.0,
              ),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          GestureDetector(
            onTap: () {
              myProfileController.loadMyProfile();
              Navigator.push(
                context,
                PageTransition(
                  type: PageTransitionType.rightToLeft,
                  child: ProfileUserScreen(),
                ),
              );
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  settingController.first_name.value+' '+ settingController.last_name.value,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  settingController.email.value,
                  style: TextStyle(
                    color: Color(0xFF4F4F4F),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOption() {
    return Container(
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.only(top: 20, left: 10, right: 10),
      height: 500,
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
      child: Container(
        padding: EdgeInsets.only(top: 150),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        PageTransition(
                          type: PageTransitionType.rightToLeft,
                          child: SavedPostsPage(),
                        ),
                      );
                    },
                    child: Container(
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 20,
                            backgroundImage:
                                AssetImage('assets/images/luu.png'),
                            // Hoặc sử dụng NetworkImage nếu avatar từ một URL
                            // backgroundImage: NetworkImage('URL_TO_AVATAR'),
                          ),
                          SizedBox(width: 8),
                          Text(
                            'Đã Lưu',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {

                    },
                    child: Container(
                      child: Column(
                        children: [
                           GestureDetector(
                             onTap: (){
                               // String? token= await FirebaseMessaging.instance.getToken();
                               // print(token);
                               // sendFriendRequestNotification(token);
                             },
                             child: CircleAvatar(
                              radius: 20,
                              backgroundImage:
                                  AssetImage('assets/images/NOTIFICATIONS.png'),
                              // Hoặc sử dụng NetworkImage nếu avatar từ một URL
                              // backgroundImage: NetworkImage('URL_TO_AVATAR'),
                                                       ),
                           ),
                          SizedBox(width: 8),
                          Text(
                            'Thông báo',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                    },
                    child: Container(
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 20,
                            backgroundImage:
                                AssetImage('assets/images/NOTIFICATIONS.png'),
                            // Hoặc sử dụng NetworkImage nếu avatar từ một URL
                            // backgroundImage: NetworkImage('URL_TO_AVATAR'),
                          ),
                          SizedBox(width: 8),
                          Text(
                            'Danh sách đen',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        PageTransition(
                          type: PageTransitionType.rightToLeft,
                          child: ActivityScreen(),
                        ),
                      );
                    },
                    child: Container(
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 20,
                            backgroundImage:
                                AssetImage('assets/images/NOTIFICATIONS.png'),
                            // Hoặc sử dụng NetworkImage nếu avatar từ một URL
                            // backgroundImage: NetworkImage('URL_TO_AVATAR'),
                          ),
                          SizedBox(width: 8),
                          Text(
                            'Hoạt động',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                    },
                    child: Container(
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 20,
                            backgroundImage:
                                AssetImage('assets/images/NOTIFICATIONS.png'),
                            // Hoặc sử dụng NetworkImage nếu avatar từ một URL
                            // backgroundImage: NetworkImage('URL_TO_AVATAR'),
                          ),
                          SizedBox(width: 8),
                          Text(
                            'Option 4',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      LoginController.Logout();
                    Navigator.push(
                      context,
                      PageTransition(
                        type: PageTransitionType.rightToLeft,
                        child: Loginscreen(
                          animated: false,
                        ),
                      ),
                    );
                    },
                    child: Container(
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 20,
                            backgroundImage:
                                AssetImage('assets/images/NOTIFICATIONS.png'),
                            // Hoặc sử dụng NetworkImage nếu avatar từ một URL
                            // backgroundImage: NetworkImage('URL_TO_AVATAR'),
                          ),
                          SizedBox(width: 8),
                          Text(
                            'Đăng xuất',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAdvertising() {
    return Container(
      padding: EdgeInsets.all(2),
      margin: EdgeInsets.only(top: 180),
      decoration: BoxDecoration(
        color: Colors.blueAccent,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 220,
            child: Text(
              'Để trải nghiệm các tính năng tiện lợi khác, đăng ký Prerirum',
              style: TextStyle(
                fontSize: 12,
              ),
            ),
          ),
          Container(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(5), // Điều chỉnh góc bo tròn
                ),
                backgroundColor: Color(0xFFFFFFFF),
              ).copyWith(
                fixedSize: MaterialStateProperty.all(Size(
                    100, 20)), // Điều chỉnh kích thước theo nhu cầu của bạn
              ),
              onPressed: () {},
              child: Container(
                padding: EdgeInsets.all(0), // Alig// n the text to the center
                child: Text(
                  'Buy Prerium',
                  style: TextStyle(
                    fontSize: 10,
                    color: Color(0xFF4C6ED7),
                  ),
                  softWrap: false,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
