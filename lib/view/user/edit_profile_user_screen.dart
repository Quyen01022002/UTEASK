import 'package:askute/controller/MyProfileController.dart';
import 'package:askute/view/user/update_user/update_name_user_screen.dart';
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
  final MyProfileController myProfileController = Get.put(MyProfileController());
  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  late TabController _tabController;
  bool _isPasswordVisible = false;
  @override
  void initState() {
    super.initState();
    myProfileController.loadMyProfile();

    _tabController = TabController(length: 2, vsync: this, initialIndex: 0);
    _firstNameController.text = myProfileController.fisrt_name.value;
    _lastNameController.text = 'Xin chào';

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
                        onTap: _showEditEmailDialog,
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
                        onTap: _showEditPhoneDialog,
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
                        onTap: _showEditPasswordDialog,
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
                        onTap: _showEditNameDialog,
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
                                Text('Giới tính',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold
                                  ),),
                                SizedBox(height: 10,),
                                Text('Nam',
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
  void _showEditNameDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Chỉnh sửa tên người dùng'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: myProfileController.firstNameController,
                decoration: InputDecoration(
                  labelText: 'First Name',
                ),
              ),
              SizedBox(height: 20.0),
              TextField(
                controller: myProfileController.lastNameController,
                decoration: InputDecoration(
                  labelText: 'Last Name',
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
               myProfileController.fisrt_name.value = myProfileController.firstNameController.text;
               myProfileController.last_name.value = myProfileController.lastNameController.text;
               myProfileController.updateUserProfile(context);
               Navigator.of(context).pop();
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }
  void _showEditEmailDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Chỉnh sửa Email'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: myProfileController.emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                myProfileController.email.value = myProfileController.emailController.text;
                myProfileController.updateUserProfile(context);
                Navigator.of(context).pop();
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }
  void _showEditPhoneDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Chỉnh sửa số điện thoại'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: myProfileController.phoneController,
                decoration: InputDecoration(
                  labelText: 'Số điện thoại',
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                myProfileController.phone.value = myProfileController.phoneController.text;
                myProfileController.updateUserProfile(context);
                Navigator.of(context).pop();
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }
  void _showEditPasswordDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Đổi mật khẩu'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                //  controller: resetController.textControllerPasswordConfirm,
                obscureText: _isPasswordVisible,
                decoration: InputDecoration(
                  labelText: 'Nhập mật khẩu cũ',
                  filled: true,
                  fillColor: Color(0xFFF3F5F7),
                  hintStyle: TextStyle(
                    color: Colors.grey, // Đặt màu cho hint text
                  ),
                  suffixIcon: GestureDetector(
                    onTap: () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
                    child: Icon(
                      _isPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              TextField(
                //  controller: resetController.textControllerPasswordConfirm,
                obscureText: _isPasswordVisible,
                decoration: InputDecoration(
                  labelText: 'Nhập mật khẩu mới',
                  filled: true,
                  fillColor: Color(0xFFF3F5F7),
                  hintStyle: TextStyle(
                    color: Colors.grey, // Đặt màu cho hint text
                  ),
                  suffixIcon: GestureDetector(
                    onTap: () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
                    child: Icon(
                      _isPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              TextField(
              //  controller: resetController.textControllerPasswordConfirm,
                obscureText: _isPasswordVisible,
                decoration: InputDecoration(
                  labelText: 'Nhập lại mật khẩu mới',
                  filled: true,
                  fillColor: Color(0xFFF3F5F7),
                  hintStyle: TextStyle(
                    color: Colors.grey, // Đặt màu cho hint text
                  ),
                  suffixIcon: GestureDetector(
                    onTap: () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
                    child: Icon(
                      _isPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                  ),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }
}
