import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:photo_view/photo_view.dart';

class MessScreen extends StatefulWidget {
  const MessScreen({super.key});

  @override
  State<MessScreen> createState() => _MessScreenState();
}

class Message {
  final int id; // Định danh người gửi
  final String text;
  final String type;
  final bool isMe; // Kiểm tra xem tin nhắn có phải của bạn không
  final String avatarUrl;

  Message(
      {required this.id,
      required this.text,
        required this.type,
      required this.isMe,
      required this.avatarUrl});
}

class _MessScreenState extends State<MessScreen> {
  final ScrollController _scrollController = ScrollController();
  //final List<Message> messages = [];
  final List<Message> messages = [
    Message(
      id: 1,
      text: 'Hello there!',
      type: 'text',
      isMe: false,
      avatarUrl: 'https://i.pinimg.com/564x/6d/9c/23/6d9c2393908ad508854ed24224682608.jpg',
    ),
    Message(
      id: 2,
      text: 'Hi! How are you?',
      type: 'text',
      isMe: true,
      avatarUrl: 'https://i.pinimg.com/564x/c3/fd/3c/c3fd3c38fc0e0d314e10bec86fb10eeb.jpg',
    ),
    Message(
      id: 3,
      text: 'https://i.pinimg.com/564x/06/30/2d/06302d229c1b7010c56374880ffde046.jpg',
      type: 'image',
      isMe: false,
      avatarUrl: 'https://i.pinimg.com/564x/6d/9c/23/6d9c2393908ad508854ed24224682608.jpg',
    ),
    Message(
      id: 4,
      text: 'Bạn thân tao đẹp không?',
      type: 'text',
      isMe: false,
      avatarUrl: 'https://i.pinimg.com/564x/6d/9c/23/6d9c2393908ad508854ed24224682608.jpg',
    ),
    Message(
      id: 5,
      text: 'Wow, cô ấy thật là đẹp',
      type: 'text',
      isMe: true,
      avatarUrl: 'https://i.pinimg.com/564x/c3/fd/3c/c3fd3c38fc0e0d314e10bec86fb10eeb.jpg',
    ),
    // Thêm tin nhắn khác nếu cần
  ];

  @override
  void initState() {
    super.initState();

    // _startTimer();
  }
  @override
  void dispose() {
   // _timer.cancel();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF6A9EF5),
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://i.pinimg.com/564x/6d/9c/23/6d9c2393908ad508854ed24224682608.jpg'),
            ),
            SizedBox(width: 8.0), // Khoảng trống giữa avatar và tiêu đề
            Text('Duy Hào'),
          ],
        ),
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[

            SizedBox(height: 8.0),
        Expanded(
        child: ListView.builder(
          controller: _scrollController,
          itemCount: messages.length + 1,
          itemBuilder: (context, index) {
            if (index == 0) {
              return _buildUserInfoContainer();
            } else {
              final message = messages[index - 1];
              return message.isMe
                  ? _buildSentMessage(message)
                  : _buildReceivedMessage(message);
            }
          },
        ),
      ),
            _buildInputField(),
          ],
        ),
      ),
    );
  }

  Widget _buildSentMessage(Message message) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        padding: EdgeInsets.only(left: 10, right: 10),
        child: Row(
          children: [
            Spacer(), // Dịch sang phải để căn lề bên phải

            _buildMessageContainer(message),
            CircleAvatar(
              backgroundImage: NetworkImage(message.avatarUrl.toString()),
            ), // Khoảng trống giữa tin nhắn và avatar
          ],
        ),
      ),
    );
  }

  Widget _buildUserInfoContainer() {
    return Container(
      padding: EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 10.0),
          Container(

            width: 100.0, // Đặt chiều rộng của hình ảnh
            height: 100.0, // Đặt chiều cao của hình ảnh
            child: CircleAvatar(
              backgroundImage: NetworkImage('https://i.pinimg.com/564x/6d/9c/23/6d9c2393908ad508854ed24224682608.jpg'),
              radius: 50.0, // Đặt bán kính của hình tròn (đội với chiều rộng/cao để đảm bảo hình tròn)
            ),
          ),
          SizedBox(height: 8.0), // Khoảng trống giữa avatar và tên người dùng
          Text(
            'Duy Hào', // Thay thế bằng tên người dùng thực tế
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            '@weihao.7640', // Thay thế bằng tên người dùng thực tế
            style: TextStyle(
              color: Color(0xFF4F4F4F),
            ),

          ),
        ],
      ),
    );
  }
  Widget _buildInputField() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              //controller: messageBoxController.textControllerMess,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.add_to_photos_rounded,
                color: Color(0xFF6A9EF5),), // Thêm biểu tượng ở đây
                hintText: 'Type a message...',
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.send,
            color: Color(0xFF6A9EF5),),
            onPressed: () {
              //_sendMessage();
            },
          ),
        ],
      ),
    );
  }


  Widget _buildMessageContainer(Message message) {
    if (message.type == 'text') {
      return Container(
        margin: EdgeInsets.all(8.0),
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: message.isMe ? Color(0xFF6A9EF5) : Colors.grey,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Text(
          message.text,
          style: TextStyle(
            color: message.isMe ? Colors.white : Colors.black,
          ),
        ),
      );
    } else if (message.type == 'image') {
      return Expanded(
        child: Container(
          padding: EdgeInsets.all(8.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.network(
              message.text,
              fit: BoxFit.contain, // Tùy chỉnh theo nhu cầu của bạn
            ),
          ),
        ),
      );
    } else {
      // Xử lý các loại tin nhắn khác nếu cần
      return Container();
    }
  }


  Widget _buildReceivedMessage(Message message) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.only(left: 10, right: 10),
        child: Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(message.avatarUrl.toString()),
            ),
            SizedBox(width: 8.0), // Khoảng trống giữa avatar và tin nhắn
             _buildMessageContainer(message),
          ],
        ),
      ),
    );
  }
}
