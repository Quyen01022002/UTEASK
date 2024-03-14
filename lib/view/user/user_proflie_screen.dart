import 'package:askute/controller/MyProfileController.dart';
import 'package:askute/view/user/edit_profile_user_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

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
    myProfileController.loadMyProfile();

  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder:(context,innerBoxIsScrolled){
return [

];
          },
          body: Container(
            decoration: BoxDecoration(color: Colors.white),
            child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildAccount(),
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
                                MaterialPageRoute(builder: (context) => EditProfileUserScreen()), // Thay NewPage() bằng trang mới của bạn
                              );
                            },
                            child: Container(
                              margin: EdgeInsets.only(left: 10, bottom: 10, top: 10),
                              width: 250,
                              alignment: Alignment.center, // Align the text to the center
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
                      margin: EdgeInsets.only(top: 20),
                      height: 10, // Chiều cao của thanh ngang
                      width: 500, // Độ dày của thanh ngang
                      color: Color(0xC0C0C0C0),
                    ),
                    _buildCreatePost(),
                    Container(
                      margin: EdgeInsets.only(top: 5),
                      height: 10, // Chiều cao của thanh ngang
                      width: 500, // Độ dày của thanh ngang
                      color: Color(0xC0C0C0C0),
                     ),

                    Expanded(
                        child: HotPostQuestionScreen(listPost: myProfileController.listPost.value)),

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
          ),
        ),
      ),
    );
  }

  Widget _buildAccount() {
    return Container(
      //margin: EdgeInsets.only(right: 15),
      //padding: EdgeInsets.only(top: 100, left: 20, right: 10, bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
            },
            child: Stack(
              children: [
                Container(
                    height: 150,
                    child: Image.network(myProfileController.BackGround.toString(),
                        fit: BoxFit.cover,
                        width: MediaQuery
                            .of(context)
                            .size
                            .width,),
                ),
                Container(
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
              ],
            ),
          ),
          SizedBox(width: 10,),
          GestureDetector(
            onTap: () {
            },
            child: Container(
              margin: EdgeInsets.only(top: 15, left: 10, bottom: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    myProfileController.fisrt_name.toString() + " " + myProfileController.last_name.toString(),
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
    );
  }
  Widget _buildCreatePost() {
    return Card(
      elevation: 3,
      margin: EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage('https://i.pinimg.com/564x/6d/9c/23/6d9c2393908ad508854ed24224682608.jpg'),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: TextFormField(
                    onTap: () {
                    },
                    decoration: InputDecoration(
                      hintText: "Bạn nghĩ gì?",
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(width: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () {
                  },
                  child: Text("Đăng"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
Widget _buildContent(){
    return Container(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(16),
            margin: EdgeInsets.all(8),
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundImage:
                      AssetImage('assets/images/search.png'),
                      // Hoặc sử dụng NetworkImage nếu avatar từ một URL
                      // backgroundImage: NetworkImage('URL_TO_AVATAR'),
                    ),
                    SizedBox(width: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Đỗ Duy Hào',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        Text(
                          'Công nghệ thông tin',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.black45,
                          ),
                        ),                              ],
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Container(
                  child: Column(
                    children: [
                      Text(
                        'Nội dung của bài viết hoặc tin nhắn sẽ được đặt ở đây. Bạn có thể thay đổi độ dài và nội dung theo ý muốn.',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black87,
                        ),
                      ),
                      Image.asset('assets/images/login-back.png')
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Color(0xFFF4F4F4),
                              border: Border.all(
                                color: Colors.grey.withOpacity(0.5), // Màu của border
                                width: 1.0, // Độ rộng của border
                              ),
                              borderRadius: BorderRadius.circular(10), // Độ bo góc của border
                            ),
                            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                            child: Row(

                                children: [
                                  Image.asset(
                                    'assets/images/like1.png',
                                    width: 15,
                                    height: 15,
                                  ),
                                  Text('Thích',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold
                                    ),),]),
                          ),
                          Text('832 lượt thích')
                        ],
                      ),
                      Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Color(0xFFF4F4F4),
                              border: Border.all(
                                color: Colors.grey.withOpacity(0.5), // Màu của border
                                width: 1.0, // Độ rộng của border
                              ),
                              borderRadius: BorderRadius.circular(10), // Độ bo góc của border
                            ),
                            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                            child: Row(

                                children: [
                                  Image.asset(
                                    'assets/images/NOTIFICATIONS.png',
                                    width: 15,
                                    height: 15,
                                  ),
                                  Text('Bình luận',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold
                                    ),),]),
                          ),
                          Text('832 bình luận')
                        ],
                      ),
                      Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Color(0xFFF4F4F4),
                              border: Border.all(
                                color: Colors.grey.withOpacity(0.5), // Màu của border
                                width: 1.0, // Độ rộng của border
                              ),
                              borderRadius: BorderRadius.circular(10), // Độ bo góc của border
                            ),
                            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                            child: Row(

                                children: [
                                  Image.asset(
                                    'assets/images/NOTIFICATIONS.png',
                                    width: 15,
                                    height: 15,
                                  ),
                                  Text('Theo dõi',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold
                                    ),),]),
                          ),
                          Text('34 lượt theo dõi')
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(16),
            margin: EdgeInsets.all(8),
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundImage:
                      AssetImage('assets/images/search.png'),
                      // Hoặc sử dụng NetworkImage nếu avatar từ một URL
                      // backgroundImage: NetworkImage('URL_TO_AVATAR'),
                    ),
                    SizedBox(width: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Đỗ Duy Hào',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        Text(
                          'Công nghệ thông tin',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.black45,
                          ),
                        ),                              ],
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Container(
                  child: Column(
                    children: [
                      Text(
                        'Nội dung của bài viết hoặc tin nhắn sẽ được đặt ở đây. Bạn có thể thay đổi độ dài và nội dung theo ý muốn.',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black87,
                        ),
                      ),
                      Image.asset('assets/images/login-back.png')
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Color(0xFFF4F4F4),
                              border: Border.all(
                                color: Colors.grey.withOpacity(0.5), // Màu của border
                                width: 1.0, // Độ rộng của border
                              ),
                              borderRadius: BorderRadius.circular(10), // Độ bo góc của border
                            ),
                            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                            child: Row(

                                children: [
                                  Image.asset(
                                    'assets/images/like1.png',
                                    width: 15,
                                    height: 15,
                                  ),
                                  Text('Thích',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold
                                    ),),]),
                          ),
                          Text('832 lượt thích')
                        ],
                      ),
                      Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Color(0xFFF4F4F4),
                              border: Border.all(
                                color: Colors.grey.withOpacity(0.5), // Màu của border
                                width: 1.0, // Độ rộng của border
                              ),
                              borderRadius: BorderRadius.circular(10), // Độ bo góc của border
                            ),
                            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                            child: Row(

                                children: [
                                  Image.asset(
                                    'assets/images/NOTIFICATIONS.png',
                                    width: 15,
                                    height: 15,
                                  ),
                                  Text('Bình luận',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold
                                    ),),]),
                          ),
                          Text('832 bình luận')
                        ],
                      ),
                      Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Color(0xFFF4F4F4),
                              border: Border.all(
                                color: Colors.grey.withOpacity(0.5), // Màu của border
                                width: 1.0, // Độ rộng của border
                              ),
                              borderRadius: BorderRadius.circular(10), // Độ bo góc của border
                            ),
                            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                            child: Row(

                                children: [
                                  Image.asset(
                                    'assets/images/NOTIFICATIONS.png',
                                    width: 15,
                                    height: 15,
                                  ),
                                  Text('Theo dõi',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold
                                    ),),]),
                          ),
                          Text('34 lượt theo dõi')
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
}
}
