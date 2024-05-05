import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/MessageBoxController.dart';
import '../../model/MessageBoxResponse.dart';
import 'one_mess_screen.dart';


class HomeMess extends StatefulWidget {
  const HomeMess({super.key});

  @override
  State<HomeMess> createState() => _HomeMessState();
}
class UserMess{
  final int id;
  final String name;
  final String avatar;
  final String newest_mess;
  final bool status_mess;
  UserMess(this.id, this.name, this.avatar, this.newest_mess, this.status_mess);
}


class _HomeMessState extends State<HomeMess> {
  final MessageBoxController messageBoxController = Get.put(MessageBoxController());
  List<UserMess> usersTest = [
    UserMess(
      1,
      'John Doe',
      'https://example.com/avatar1.jpg',
      'Hello, how are you?',
      true,
    ),
    UserMess(
      2,
      'Jane Smith',
      'https://example.com/avatar2.jpg',
      'Hi there!',
      false,
    ),
    UserMess(
      3,
      'Bob Johnson',
      'https://example.com/avatar3.jpg',
      'Lorem ipsum dolor sit amet.',
      true,
    ),
    // Thêm nhiều đối tượng UserMess khác nếu cần
  ];
  List<UserMess> searchResults = [];

  void onSearch(String keyword) {
    searchResults.clear();
    if (keyword.isNotEmpty) {
      searchResults.addAll(users.where((user) =>
          user.name.toLowerCase().contains(keyword.toLowerCase())
      ));
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _startTimer();

  }
  List<UserMess> users  = [];
  Future<void> _mapMessageBoxResponseToUserMess(List<MessageBoxResponse> list) async{
    if (list!= null){
      list!.forEach((element) {
        // if (element.userId == messageBoxController.user_id.value){
        //   UserMess userMess = UserMess(element.friendId!, element.friendName!, element.friendAvatar!, element.content!, true);
        //   users.add(userMess);}
        // else{
        //   UserMess userMess = UserMess(element.userId!, element.friendName!, element.friendAvatar!, element.content!, true);
        //   users.add(userMess);}

      });
    }


  }
  late String key;

  late Timer _timer;
  Stream<List<MessageBoxResponse>>? messageBoxStream;
  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 2), (timer) {
      // Gọi hàm cần thiết ở đây
      // messageBoxController.loadMessageScreen(context);
      // messageBoxStream = messageBoxController.listMessageBoxStream;
      // Cập nhật danh sách nhóm khi Stream thay đổi
      messageBoxStream?.listen((List<MessageBoxResponse>? updatedGroups) {
        if (updatedGroups != null) {
          setState(() {
            users.clear();
            _mapMessageBoxResponseToUserMess(updatedGroups);
          });
        }
      });
      onSearch(key);
    });
  }
  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SafeArea(
          child: Scaffold(
              body: StreamBuilder<List<MessageBoxResponse>>(
                  stream: messageBoxStream,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      // Lấy dữ liệu từ Stream và cập nhật UI
                      List<MessageBoxResponse>? updatedGroups = snapshot.data;
                      users.clear();
                      _mapMessageBoxResponseToUserMess(updatedGroups!);
                    }
                    return CustomScrollView(
                      slivers: [
                        SliverAppBar(
                          backgroundColor: Color(0xFF8587F1),
                          title: Text('Hộp thư của tôi'),
                        ),
                        SliverToBoxAdapter(
                          child: Column(
                            children: [
                              // Container(
                              //   padding: EdgeInsets.only(top: 20, bottom: 20, left:20, right: 20),
                              //   child: Text(
                              //     'Wow! Hãy xem các phần tử có các gương mặt sáng mà bạn đã liệt kê vào đây ',
                              //     style: TextStyle(
                              //       fontSize: 18,
                              //     ),
                              //   ),
                              // ),
                              Padding(
                                padding: EdgeInsets.all(16.0),
                                child: TextField(

                                  decoration: InputDecoration(
                                    hintText: 'Tìm kiếm người dùng',
                                  ),
                                  onChanged: (text) {
                                    key = text;
                                    onSearch(text);
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        SliverList(
                          delegate: SliverChildBuilderDelegate(
                                (BuildContext context, int index) {
                              bool isChecked = false; // Giá trị `isChecked` riêng lẻ cho mỗi phần tử
                              if (true == true)
                                return Column(
                                  children: [
                                    ListTile(
                                      onTap: () {
                                        // Gọi hàm xử lý sự kiện khi nhấn vào hàng UserMess ở đây
                                        // messageBoxController.loadMessage(users[index].id, context);
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context) => MessScreen()),
                                        );
                                      },
                                      leading: CircleAvatar(
                                        backgroundImage: NetworkImage(
                                          searchResults.isEmpty
                                              ? users[index].avatar
                                              : searchResults[index].avatar,
                                        ),
                                      ),
                                      title: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            searchResults.isEmpty
                                                ? users[index].name
                                                : searchResults[index].name,
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            searchResults.isEmpty
                                                ? users[index].newest_mess
                                                : searchResults[index].newest_mess,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              fontWeight: searchResults.isEmpty
                                                  ? users[index].status_mess
                                                  ? FontWeight.normal
                                                  : FontWeight.bold
                                                  : searchResults[index].status_mess
                                                  ? FontWeight.normal
                                                  : FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 15),
                                  ],
                                );
                              else
                                return Column(
                                  children: [
                                    ListTile(
                                      leading: CircleAvatar(
                                        backgroundImage: NetworkImage(searchResults.isEmpty
                                            ? users[index].avatar
                                            : searchResults[index].avatar),
                                      ),
                                      title: Text(
                                        searchResults.isEmpty
                                            ? users[index].name
                                            : searchResults[index].name,
                                      ),
                                    ),
                                    SizedBox(height: 15),
                                  ],
                                );
                            },
                            childCount: searchResults.isEmpty
                                ? users.length
                                : searchResults.length,
                          ),
                        ),
                      ],
                    );}
              )
          ),
        ),
      ],
    );
  }
  void _showConfirmationDialog(BuildContext context, int idMember) {
    showDialog(
      context: context,

      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Xác nhận'),
          content: Text('Giao quyền admin cho người này'),
          actions: [
            TextButton(
              onPressed: () {
                // Đóng hộp thoại và thực hiện tác vụ khi người dùng chọn Yes
                Navigator.of(context).pop();
                // Thực hiện tác vụ khi người dùng chọn Yes ở đây
              },
              child: Text('Không'),
            ),
            TextButton(
              onPressed: () {
                Future.delayed(Duration(milliseconds: 100), () {
                  int count =0;
                  Navigator.of(context).popUntil((_) => count++ >= 2);
                });
              },
              child: Text('Chắc chăn'),
            ),
          ],
        );
      },

    );
  }

}
