import 'package:askute/controller/LoginController.dart';
import 'package:askute/controller/MyProfileController.dart';
import 'package:askute/model/PostModel.dart';
import 'package:askute/model/UserProfile.dart';
import 'package:askute/view/component/post_newScreen.dart';
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
  final int? id;
  const ProfileUserScreen({super.key, required this.id});

  @override
  State<ProfileUserScreen> createState() => _ProfileUserScreenState();
}

class _ProfileUserScreenState extends State<ProfileUserScreen> {
  final MyProfileController myProfileController = Get.put(MyProfileController());

  LoginController loginController = Get.put(LoginController());
  final ScrollController _scrollController = ScrollController();
  List<PostModel> _posts = [];
  bool _isLoading = false;

  void initState() {
    super.initState();
    myProfileController.pagenumber.value = 0;
    _posts.clear();
   _fetchPosts();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        _fetchPosts();
      }
    });

      //myProfileController.loadMyProfile();
  }

  Future<UserProfile?> fetchData() async {
    // Đây là ví dụ về việc tải dữ liệu từ cơ sở dữ liệu hoặc một API
    // Thay thế phần này bằng hàm thực sự để tải dữ liệu của bạn

      return myProfileController.loadUserOther(loginController.idMe.value, context);
  }
  Future<void> _fetchPosts() async {
    if (_isLoading) return;
    setState(() {
      _isLoading = true;
    });
    List<PostModel>? response;
    response = await myProfileController.loadMyPost(context);
    if (response!= null && response.length!=0) {
      setState(() {
        myProfileController.pagenumber.value++;
        _posts.addAll(response!);
        _isLoading = false;
      });
    } else {
      setState(() {
        _isLoading = false;
      });
      throw Exception('Failed to load posts');
    }
  }
  @override
  void dispose() {
    _scrollController.dispose();
    myProfileController.pagenumber.value = 0;
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
            child: FutureBuilder<UserProfile?>(
              future: fetchData(),
              builder: (context, snapshot) {
                if (snapshot.data != null && snapshot.connectionState == ConnectionState.waiting) {
                  // Hiển thị màn hình chờ khi dữ liệu đang được tải
                  return Center(child: CircularProgressIndicator());
                }
                else if (snapshot.hasError) {
                  // Hiển thị lỗi nếu có lỗi xảy ra trong quá trình tải dữ liệu
                  return Text('Error: ${snapshot.error} ${snapshot.data!}' );
                }
                else if (snapshot.hasData) {
                  return Container(
                    decoration: BoxDecoration(color: Colors.white),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildAccount(snapshot.data!),
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
                        ),

                        Container(
                          margin: EdgeInsets.only(top: 5),
                          height: 10, // Chiều cao của thanh ngang
                          width: 500, // Độ dày của thanh ngang
                          color: Color(0xC0C0C0C0),
                        ),

                        _buildPost(),

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
                } else return Container();
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
                      // Text(
                      //   pro.phone.toString(),
                      //   style: TextStyle(
                      //     fontSize: 14,
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
  }
  Widget _buildPost(){
    return ListView.builder(
      controller: _scrollController,
      itemCount: _posts.length + 1,
      shrinkWrap: true, // Đảm bảo ListView.builder chỉ chiếm không gian cần thiết
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        if (index == _posts.length) {
          return _isLoading ? Center(child: CircularProgressIndicator()) : SizedBox.shrink();
        }
        return Column(
          children: [
            PostScreenNew(post: _posts[index]),
            Container(
              margin: EdgeInsets.only(top: 5),
              height: 10, // Chiều cao của thanh ngang
              width: 500, // Độ dày của thanh ngang
              color: Colors.black12,
            ),
          ],
        );
      },
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
