import 'package:flutter/material.dart';

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
  List<UserMess> users = [
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
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SafeArea(
          child: Scaffold(
              body: CustomScrollView(
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
                    )
          ),
        ),
      ],
    );
  }
}
