import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomeSector extends StatefulWidget {
  const HomeSector({super.key});

  @override
  State<HomeSector> createState() => _HomeSectorState();
}

class UserSEC {
  final String avatarUrl;
  final String name;
  final double progress;
  final int questionsReceived;
  final int questionsCompleted;

  UserSEC({
    required this.avatarUrl,
    required this.name,
    required this.progress,
    required this.questionsReceived,
    required this.questionsCompleted,
  });
}
class _HomeSectorState extends State<HomeSector> {

  final List<UserSEC> users = [
    UserSEC(
      avatarUrl: 'https://i.pravatar.cc/150?img=1',
      name: 'Nguyen Van A',
      progress: 0.8,
      questionsReceived: 20,
      questionsCompleted: 16,
    ),
    UserSEC(
      avatarUrl: 'https://i.pravatar.cc/150?img=2',
      name: 'Tran Thi B',
      progress: 0.5,
      questionsReceived: 10,
      questionsCompleted: 5,
    ),
    UserSEC(
      avatarUrl: 'https://i.pravatar.cc/150?img=3',
      name: 'Le Van C',
      progress: 0.9,
      questionsReceived: 15,
      questionsCompleted: 13,
    ),
    UserSEC(
      avatarUrl: 'https://i.pravatar.cc/150?img=1',
      name: 'Nguyen Van A',
      progress: 0.8,
      questionsReceived: 20,
      questionsCompleted: 16,
    ),
    UserSEC(
      avatarUrl: 'https://i.pravatar.cc/150?img=2',
      name: 'Tran Thi B',
      progress: 0.5,
      questionsReceived: 10,
      questionsCompleted: 5,
    ),
    UserSEC(
      avatarUrl: 'https://i.pravatar.cc/150?img=3',
      name: 'Le Van C',
      progress: 0.9,
      questionsReceived: 15,
      questionsCompleted: 13,
    ),
    UserSEC(
      avatarUrl: 'https://i.pravatar.cc/150?img=1',
      name: 'Nguyen Van A',
      progress: 0.8,
      questionsReceived: 20,
      questionsCompleted: 16,
    ),
    UserSEC(
      avatarUrl: 'https://i.pravatar.cc/150?img=2',
      name: 'Tran Thi B',
      progress: 0.5,
      questionsReceived: 10,
      questionsCompleted: 5,
    ),
    UserSEC(
      avatarUrl: 'https://i.pravatar.cc/150?img=3',
      name: 'Le Van C',
      progress: 0.9,
      questionsReceived: 15,
      questionsCompleted: 13,
    ),
    UserSEC(
      avatarUrl: 'https://i.pravatar.cc/150?img=1',
      name: 'Nguyen Van A',
      progress: 0.8,
      questionsReceived: 20,
      questionsCompleted: 16,
    ),
    UserSEC(
      avatarUrl: 'https://i.pravatar.cc/150?img=2',
      name: 'Tran Thi B',
      progress: 0.5,
      questionsReceived: 10,
      questionsCompleted: 5,
    ),
    UserSEC(
      avatarUrl: 'https://i.pravatar.cc/150?img=3',
      name: 'Le Van C',
      progress: 0.9,
      questionsReceived: 15,
      questionsCompleted: 13,
    ),
    UserSEC(
      avatarUrl: 'https://i.pravatar.cc/150?img=1',
      name: 'Nguyen Van A',
      progress: 0.8,
      questionsReceived: 20,
      questionsCompleted: 16,
    ),
    UserSEC(
      avatarUrl: 'https://i.pravatar.cc/150?img=2',
      name: 'Tran Thi B',
      progress: 0.5,
      questionsReceived: 10,
      questionsCompleted: 5,
    ),
    UserSEC(
      avatarUrl: 'https://i.pravatar.cc/150?img=3',
      name: 'Le Van C',
      progress: 0.9,
      questionsReceived: 15,
      questionsCompleted: 13,
    ),
    UserSEC(
      avatarUrl: 'https://i.pravatar.cc/150?img=1',
      name: 'Nguyen Van A',
      progress: 0.8,
      questionsReceived: 20,
      questionsCompleted: 16,
    ),
    UserSEC(
      avatarUrl: 'https://i.pravatar.cc/150?img=2',
      name: 'Tran Thi B',
      progress: 0.5,
      questionsReceived: 10,
      questionsCompleted: 5,
    ),
    UserSEC(
      avatarUrl: 'https://i.pravatar.cc/150?img=3',
      name: 'Le Van C',
      progress: 0.9,
      questionsReceived: 15,
      questionsCompleted: 13,
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Số lượng tab
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [

            ];
          },
          body: ListView(
            children: [
              _buildKhoa(),
              SizedBox(height: 10),
              _buildViewer(),
              SizedBox(height: 10),
              TabBar(
                tabs: [
                  Tab(text: 'Bảng Tin'),
                  Tab(text: 'Tiến độ'),
                ],
              ),
              Container(
                height: 400, // Chiều cao của TabBarView
                child: TabBarView(
                  children: [
                    Center(child: Text('Nội dung của Bảng Tin')),
                    _buildUserList()
                  ],
                ),
              ),

            ],
          ),
        ),
      ),

    );
  }


  Widget _buildContent(){
    return Column(
      children: [
        TabBar(
          tabs: [
            Tab(text: 'Bảng Tin'),
            Tab(text: 'Tiến độ'),
          ],
        ),
        Container(
          height: 400, // Chiều cao của TabBarView
          child: TabBarView(
            children: [
              Center(child: Text('Nội dung của Bảng Tin')),
              SingleChildScrollView(child: _buildUserList()),
            ],
          ),
        ),
      ],
    );
  }
  Widget _buildViewer(){
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            height: 50,
            width: MediaQuery.of(context).size.width*0.45,
            margin: EdgeInsets.symmetric(horizontal: 5.0),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                    'https://i.pinimg.com/564x/ce/bb/2f/cebb2f79b8fd7836864b7556bd8b6beb.jpg'),
                // Thay đổi đường dẫn tới ảnh của bạn
                fit: BoxFit.cover, // Đảm bảo ảnh sẽ che đầy Container
              ),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '6',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    ' Lĩnh vực',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: 50,
            width: MediaQuery.of(context).size.width*0.45,
            margin: EdgeInsets.symmetric(horizontal: 5.0),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                    'https://i.pinimg.com/564x/ce/bb/2f/cebb2f79b8fd7836864b7556bd8b6beb.jpg'),
                // Thay đổi đường dẫn tới ảnh của bạn
                fit: BoxFit.cover, // Đảm bảo ảnh sẽ che đầy Container
              ),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '14',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    ' Giảng viên',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
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
  Widget _buildKhoa(){
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 120,
      margin: EdgeInsets.symmetric(horizontal: 5.0),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(
              'https://i.pinimg.com/564x/ce/bb/2f/cebb2f79b8fd7836864b7556bd8b6beb.jpg'),
          // Thay đổi đường dẫn tới ảnh của bạn
          fit: BoxFit.cover, // Đảm bảo ảnh sẽ che đầy Container
        ),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Center(
        child: Text(
          'Công nghệ thông tin',
          style: TextStyle(
            color: Colors.white,
            fontSize: 28.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
  Widget _buildUserList() {
    return ListView.builder(
      shrinkWrap: true,
      // physics: NeverScrollableScrollPhysics(),
      itemCount: users.length,
      itemBuilder: (context, index) {
        return _buildUserItem(users[index]);
      },
    );
  }
  Widget _buildUserItem(UserSEC user) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(user.avatarUrl),
      ),
      title: Text(user.name),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LinearProgressIndicator(
            value: user.progress,
            backgroundColor: Colors.grey[300],
            color: Colors.blue,
          ),
          SizedBox(height: 5),
          Text('Câu hỏi nhận được: ${user.questionsReceived}'),
          Text('Câu hỏi đã hoàn thành: ${user.questionsCompleted}'),
        ],
      ),
    );
  }

}
