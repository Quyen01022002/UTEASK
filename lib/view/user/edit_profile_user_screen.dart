import 'package:askute/controller/MyProfileController.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class EditProfileUserScreen extends StatefulWidget {
  const EditProfileUserScreen({super.key});

  @override
  State<EditProfileUserScreen> createState() => _EditProfileUserScreenState();
}

class _EditProfileUserScreenState extends State<EditProfileUserScreen> with SingleTickerProviderStateMixin {
  MyProfileController myProfileController = Get.put(MyProfileController());

  late TabController _tabController;
  @override
  void initState() {
    myProfileController.loadMyProfile();
    super.initState();
    _tabController = TabController(length: 2, vsync: this, initialIndex: 0);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Chỉnh sửa thông tin tài khoản'),
        ),
        body: Container(
                child: Column(
                  children: [
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildImage(),
                          Container(
                            margin: EdgeInsets.only(top: 20),
                            height: 2, // Chiều cao của thanh ngang
                            width: 500, // Độ dày của thanh ngang
                            color: Color(0xC0C0C0C0),
                          ),
                          SizedBox(height: 5,),
                          Padding(
                            padding:const EdgeInsets.all(10),
                            child: Container(
                              color: Colors.white,
                              child: TabBar(
                                controller: _tabController,
                                tabs: [
                                  _buildTab('Giới thiệu'),
                                  _buildTab('Thông tin'),
                                ],
                                indicator: BoxDecoration(
                                  color: Color(0xFFF1F1FE),
                                  borderRadius: BorderRadius.circular(12),
                                  shape: BoxShape.rectangle,
                                ),
                                labelColor: Color(0xFF2F80ED),
                                unselectedLabelColor: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    Expanded(child: TabBarView(
                      controller: _tabController,
                      children: <Widget>[
                        // Tab 1 content
                        _buildInfomationAccountSimple(),
                        _buildInfomationAccount()
                      ],
                    ),)
                  ],
                ),
              ),
      ),
    );
  }

  Widget _buildImage(){
    return Container(
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
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
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
              SizedBox(width: 10,),
              Container(
                width: 200,
                child: Text('(Nhấp vào ảnh đại diện hoặc ảnh bìa để cập nhật ảnh mới)',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold
                ),),
              ),
            ],
          ),
        ],
      ),
    );
  }
  Widget _buildInfomationAccount(){
    return Container(
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.all(10),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Image.asset(
                              'assets/images/email_edit.png',
                              width: 30,
                              height: 30,
                            ),
                            SizedBox(width: 15,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 5,),
                                Text('Email',
                                  style: TextStyle(
                                    fontSize: 16,
                                      fontWeight: FontWeight.bold
                                  ),),
                                SizedBox(height: 10,),
                                Text(myProfileController.email.toString(),
                                  style: TextStyle(
                                    color: Color(0xFF4F4F4F),
                                  ),),
                              ],
                            ),]),
                      GestureDetector(
                        onTap: () {
                        },
                        child: Text(
                          'Chỉnh sửa',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold, // Màu sắc của Text khi chưa được nhấn
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.all(10),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Image.asset(
                              'assets/images/phone_edit.png',
                              width: 30,
                              height: 30,
                            ),
                            SizedBox(width: 15,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 5,),
                                Text('Số điện thoại',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold
                                  ),),
                                SizedBox(height: 10,),
                                Text(myProfileController.phone.toString(),
                                  style: TextStyle(
                                    color: Color(0xFF4F4F4F),
                                  ),),
                              ],
                            ),]),
                      GestureDetector(
                        onTap: () {
                        },
                        child: Text(
                          'Chỉnh sửa',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold, // Màu sắc của Text khi chưa được nhấn
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.all(10),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Image.asset(
                              'assets/images/pw_edit.png',
                              width: 30,
                              height: 30,
                            ),
                            SizedBox(width: 15,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 5,),
                                Text('Mật khẩu',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold
                                  ),),
                                SizedBox(height: 10,),
                                Text('Chạm để thay đổi mật khẩu',
                                  style: TextStyle(
                                    color: Color(0xFF4F4F4F),
                                  ),),
                              ],
                            ),]),
                      GestureDetector(
                        onTap: () {
                        },
                        child: Text(
                          'Chỉnh sửa',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold, // Màu sắc của Text khi chưa được nhấn
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.all(10),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Image.asset(
                              'assets/images/payment_edit.png',
                              width: 30,
                              height: 30,
                            ),
                            SizedBox(width: 15,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 5,),
                                Text('Phương thức thanh toán',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold
                                  ),),
                                SizedBox(height: 10,),
                                Text('ZaloPay',
                                  style: TextStyle(
                                    color: Color(0xFF4F4F4F),
                                  ),),
                              ],
                            ),]),
                      GestureDetector(
                        onTap: () {
                        },
                        child: Text(
                          'Chỉnh sửa',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold, // Màu sắc của Text khi chưa được nhấn
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  Widget _buildInfomationAccountSimple(){
    return Container(
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.all(10),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Image.asset(
                              'assets/images/email_edit.png',
                              width: 30,
                              height: 30,
                            ),
                            SizedBox(width: 15,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 5,),
                                Text('Tên người dùng',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold
                                  ),),
                                SizedBox(height: 10,),
                                Text(myProfileController.fisrt_name.toString()+' '+ myProfileController.last_name.toString(),
                                  style: TextStyle(
                                    color: Color(0xFF4F4F4F),
                                  ),),
                              ],
                            ),]),
                      GestureDetector(
                        onTap: () {
                        },
                        child: Text(
                          'Chỉnh sửa',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold, // Màu sắc của Text khi chưa được nhấn
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.all(10),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Image.asset(
                              'assets/images/phone_edit.png',
                              width: 30,
                              height: 30,
                            ),
                            SizedBox(width: 15,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 5,),
                                Text('Tag người dùng',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold
                                  ),),
                                SizedBox(height: 10,),
                                Text('@duyhao.7640',
                                  style: TextStyle(
                                    color: Color(0xFF4F4F4F),
                                  ),),
                              ],
                            ),]),
                      GestureDetector(
                        onTap: () {
                        },
                        child: Text(
                          'Chỉnh sửa',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold, // Màu sắc của Text khi chưa được nhấn
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.all(10),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Image.asset(
                              'assets/images/pw_edit.png',
                              width: 30,
                              height: 30,
                            ),
                            SizedBox(width: 15,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 5,),
                                Text('Lời giới thiệu',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold
                                  ),),
                                SizedBox(height: 10,),
                                Text('Hãy trở về nơi đã bắt đầu',
                                  style: TextStyle(
                                    color: Color(0xFF4F4F4F),
                                  ),),
                              ],
                            ),]),
                      GestureDetector(
                        onTap: () {
                        },
                        child: Text(
                          'Chỉnh sửa',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold, // Màu sắc của Text khi chưa được nhấn
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),


    );
  }
  Widget _buildTab(String title) {
    return Tab(
      child: Container(
        padding: EdgeInsets.all(0),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
        child: Text(
          title,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }
}
