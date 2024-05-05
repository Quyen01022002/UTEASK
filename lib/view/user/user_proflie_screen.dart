import 'package:askute/controller/MyProfileController.dart';
import 'package:askute/model/UserProfile.dart';
import 'package:askute/view/user/DisplayBackGroudImagePage.dart';
import 'package:askute/view/user/DisplaySelectedImagePage.dart';
import 'package:askute/view/user/edit_profile_user_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../Home/hot_post_screen.dart';
import '../component/post_screen.dart';

class ProfileUserScreen extends StatefulWidget {
  const ProfileUserScreen({super.key});

  @override
  State<ProfileUserScreen> createState() => _ProfileUserScreenState();
}

class _ProfileUserScreenState extends State<ProfileUserScreen> {
  MyProfileController myProfileController = Get.put(MyProfileController());

  @override
  void initState() {
    super.initState();
   // fetchData();
    if (myProfileController.ortherId.value != 0)
      myProfileController.loadOtherProfile(myProfileController.ortherId.value);
    else
      myProfileController.loadMyProfile();
  }

  Future<UserProfile?> fetchData() async {
    // Đây là ví dụ về việc tải dữ liệu từ cơ sở dữ liệu hoặc một API
    // Thay thế phần này bằng hàm thực sự để tải dữ liệu của bạn
    if (myProfileController.myId.value == myProfileController.ortherId.value)
      return myProfileController.loadUserOther(myProfileController.myId.value);
    else
    return myProfileController
        .loadUserOther(myProfileController.ortherId.value);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [];
          },
          body: FutureBuilder<UserProfile?>(
            future: fetchData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                // Hiển thị màn hình chờ khi dữ liệu đang được tải
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                // Hiển thị lỗi nếu có lỗi xảy ra trong quá trình tải dữ liệu
                return Text('Error: ${snapshot.error}');
              } else {
                return Container(
                  decoration: BoxDecoration(color: Colors.white),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildAccount(snapshot.data!),
                      myProfileController.myId.value == myProfileController.ortherId.value ?
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      10), // Điều chỉnh góc bo tròn
                                ),
                                backgroundColor: Color(0xFFFFFFFF),
                                fixedSize: Size(300, 50),
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          EditProfileUserScreen()), // Thay NewPage() bằng trang mới của bạn
                                );
                              },
                              child: Container(
                                margin: EdgeInsets.only(
                                    left: 10, bottom: 10, top: 10),
                                width: 250,
                                alignment: Alignment.center,
                                // Align the text to the center
                                child: Text(
                                  'Chỉnh sửa thông tin cá nhân',
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ) : Container(),

                      Container(
                        margin: EdgeInsets.only(top: 5),
                        height: 10, // Chiều cao của thanh ngang
                        width: 500, // Độ dày của thanh ngang
                        color: Color(0xC0C0C0C0),
                      ),

                      Obx(
                        () => Expanded(
                            child: HotPostQuestionScreen(
                                listPost: myProfileController.listPost.value)),
                      ),

                      // Container(child: Center(
                      //   child: ListView.builder(
                      //     itemCount: myProfileController.listPost.length,
                      //     itemBuilder: (context, index) {
                      //       final post = myProfileController.listPost[index];
                      //       return AnimatedOpacity(
                      //         duration: Duration(milliseconds: 100),
                      //         opacity: 1,
                      //         child: PostScreen(post: post),
                      //       );
                      //     },
                      //   ),
                      // ))
                    ],
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildAccount(UserProfile pro) {
    return Container(
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
                      onTap: () {
                        final Name = pro.first_name.toString() +
                            " " +
                            pro.last_name.toString();
                        _pickImageBackGroud(context, ImageSource.gallery, Name,
                            pro.avatarUrl.toString());
                      },
                      child: Container(
                        height: 150,
                        child: Image.network(
                          pro.backGround.toString(),
                          fit: BoxFit.cover,
                          width: MediaQuery.of(context).size.width,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        _pickImage(context, ImageSource.gallery);
                      },
                      child: Container(
                        width: 100.0,
                        height: 100.0,
                        margin: EdgeInsets.only(top: 80, left: 10),
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(
                            pro.avatarUrl.toString(),
                          ),
                          radius: 50.0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 10,
              ),
              GestureDetector(
                onTap: () {},
                child: Container(
                  margin: EdgeInsets.only(top: 15, left: 10, bottom: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        pro.first_name.toString() +
                            " " +
                            pro.last_name.toString(),
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        pro.email.toString(),
                        style: TextStyle(
                          color: Color(0xFF4F4F4F),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        pro.phone.toString(),
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
