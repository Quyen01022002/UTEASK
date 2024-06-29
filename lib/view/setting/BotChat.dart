import 'package:askute/controller/ChatBoxController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MaterialApp(home: BotChat()));
}

class BotChat extends StatefulWidget {
  const BotChat({super.key});

  @override
  State<BotChat> createState() => _BotChatState();
}

class _BotChatState extends State<BotChat> {
  final List<Map<String, String>> _messages = [];
  final TextEditingController _controller = TextEditingController();
  late RxString curnetUser = "".obs;
  final ChatBoxController chatBoxController = Get.put(ChatBoxController());
  Future<void> _sendMessage() async {
    if (_controller.text.isNotEmpty) {
      setState(() {
        _messages.add({"sender": "user", "message": _controller.text});
      });

      List<String>? response = await chatBoxController.chatBot(context, _controller.text);

      setState(() {
        for (var item in response!) {
          _messages.add({"sender": "bot", "message": item ?? 'No response'});
        }
        _controller.clear();
      });
    }
  }


  @override
  void initState() {
    initCurrentUser();
    super.initState();
  }

  void initCurrentUser() async {
    final prefs = await SharedPreferences.getInstance();
    curnetUser = (prefs.getString('Avatar') ??
            "https://inkythuatso.com/uploads/thumbnails/800/2023/03/10-anh-dai-dien-trang-inkythuatso-03-15-27-10.jpg")
        .obs;
    print(curnetUser);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("Chat Bot UTE"),
          ClipOval(
              child: Image.asset(
            'assets/images/bot.png',
            width: 50,
            height: 50,
            fit: BoxFit.cover,
          )),
        ],
      )),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(8.0, 0, 8, 0),
        child: Stack(
          children: [
            Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(8.0),
                    itemCount: _messages.length,
                    itemBuilder: (context, index) {
                      final msg = _messages[index];
                      final isUser = msg['sender'] == 'user';
                      return Align(
                        alignment: isUser
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                        child: Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(8.0, 8, 0, 0),
                              child: Container(
                                padding: const EdgeInsets.all(10),
                                margin: const EdgeInsets.symmetric(vertical: 5),
                                decoration: BoxDecoration(
                                  color: isUser
                                      ? Color(0xFFFE849C)
                                      : Color(0xFF849CF9),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    msg['message']!,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              right: isUser ? -10.0 : null,
                              left: isUser ? null : -10.0,
                              child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                      color: isUser
                                          ? Color(0xFFFE849C)
                                          : Color(0xFF849CF9),
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(
                                        50), // Optional: rounded corners
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: ClipOval(
                                      child: !isUser
                                          ? Image.asset(
                                              'assets/images/bot.png',
                                              width: 25,
                                              height: 25,
                                              fit: BoxFit.cover,
                                            )
                                          : Image.network(
                                              curnetUser.string,
                                              width: 25,
                                              height: 25,
                                              fit: BoxFit.cover,
                                            ),
                                    ),
                                  )),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(25),
                            border: Border.all(color: Colors.grey[300]!),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  controller: _controller,
                                  decoration: const InputDecoration(
                                    hintText: 'Aa',
                                    border: InputBorder.none,
                                  ),
                                  minLines: 1,
                                  maxLines: 5,
                                ),
                              ),
                              IconButton(
                                icon: const Icon(Icons.emoji_emotions_outlined),
                                color: Colors.grey[600],
                                onPressed: () {
                                  // Emoji picker can be added here if needed
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          icon: const Icon(Icons.send, color: Colors.white),
                          onPressed: _sendMessage,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
