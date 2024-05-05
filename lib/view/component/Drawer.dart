import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:page_transition/page_transition.dart';

import '../../controller/LoginController.dart';
import '../../controller/MyProfileController.dart';
import '../authen/Login_screen.dart';
import '../user/DisplayBackGroudImagePage.dart';
import '../user/DisplaySelectedImagePage.dart';
import '../user/edit_profile_user_screen.dart';
class DrawerScreen extends StatefulWidget {
  const DrawerScreen({super.key});

  @override
  State<DrawerScreen> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  MyProfileController myProfileController = Get.put(MyProfileController());
  @override
  void initState() {
    super.initState();
    myProfileController.loadMyProfile();

  }
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          Container(
            child: _buildAccount(),
          ),
          ListTile(
            leading: Icon(Icons.edit),
            title: Text('Chỉnh sửa trang cá nhân'),
            onTap: () {
              // Add navigation functionality here
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => EditProfileUserScreen()), // Thay NewPage() bằng trang mới của bạn
              ); // Close the drawer
            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Cài đặt'),
            onTap: () {
              // Add navigation functionality here
              Navigator.pop(context); // Close the drawer
            },
          ),
          ListTile(
            leading: Icon(Icons.info),
            title: Text('Đăng xuất'),
            onTap: () {
              // Add navigation functionality here
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
          ),
          // Add more items as needed
        ],
      ),
    );
  }
  Widget _buildAccount() {
    return Obx(() => Container(
      //margin: EdgeInsets.only(right: 15),
      //padding: EdgeInsets.only(top: 100, left: 20, right: 10, bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {},
            child: Stack(
              children: [
                GestureDetector(
                  onTap:(){
                    final Name = myProfileController.fisrt_name.toString() +
                        " " +
                        myProfileController.last_name.toString();
                    _pickImageBackGroud(context, ImageSource.gallery,
                        Name, myProfileController.Avatar.toString());                  },
                  child: Container(
                    height: 150,
                    child: Image.network(
                      myProfileController.BackGround.toString(),
                      fit: BoxFit.cover,
                      width: MediaQuery
                          .of(context)
                          .size
                          .width,),
                  ),
                ),
                GestureDetector(
                  onTap: (){

                    _pickImage(context, ImageSource.gallery);
                  },
                  child: Container(
                    width: 100.0,
                    height: 100.0,
                    margin: EdgeInsets.only(top: 80, left: 10),
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(
                        myProfileController.Avatar.toString(),
                      ),
                      radius: 50.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 10,),
          GestureDetector(
            onTap: () {},
            child: Container(
              margin: EdgeInsets.only(top: 15, left: 10, bottom: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    myProfileController.fisrt_name.toString() + " " +
                        myProfileController.last_name.toString(),
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    myProfileController.email.toString(),
                    style: TextStyle(
                      color: Color(0xFF4F4F4F),
                    ),
                  ),
                  SizedBox(height: 10,),
                  Text(
                    myProfileController.phone.toString(),
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
void _pickImageBackGroud(BuildContext context, ImageSource source, String Name,
    String Avatar) async {
  XFile? pickedImage = await ImagePicker().pickImage(source: source);

  if (pickedImage != null) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DisplayBackGroudImagePage(
          imagePath: pickedImage.path,
          Avatar: Avatar,
          Name: Name,
        ),
      ),
    );
  }
}
void _pickImage(BuildContext context, ImageSource source) async {
  XFile? pickedImage = await ImagePicker().pickImage(source: source);

  if (pickedImage != null) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            DisplaySelectedImagePage(imagePath: pickedImage.path),
      ),
    );
  }
}