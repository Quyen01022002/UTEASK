import 'package:askute/controller/Class/ClassController.dart';
import 'package:askute/model/UsersEnity.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:page_transition/page_transition.dart';

class ItemFollow extends StatefulWidget {
  final UserEnity friends;
  final Function(UserEnity) onAddItem;
  final Function(UserEnity) onRemoteItem;
  late  bool stateFriend; // Thêm trạng thái vào ItemFollow

   ItemFollow({
    Key? key,
    required this.friends,
    required this.onAddItem,
    required this.onRemoteItem,
    required this.stateFriend, // Thêm trạng thái vào ItemFollow
  }) : super(key: key);
  @override
  State<ItemFollow> createState() => _ItemInviteState();
}

class _ItemInviteState extends State<ItemFollow> {
  final ClassController myController = Get.put(ClassController());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 5, 6, 5),
        child: Container(
          margin: EdgeInsets.only(top: 5),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                spreadRadius:  0.5,
                blurRadius: 2,
                offset: Offset(5,5),
              ),
            ],
            borderRadius: BorderRadius.circular(12),
          ),
          child: GestureDetector(
            onTap: () {
              // Navigator.push(
              //   context,
              //   PageTransition(
              //     type: PageTransitionType.rightToLeft,
              //     child: ProfileScreenOther(id: widget.friends.user_id!,),
              //   ),
              // );
            },
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 18.0),
                    child: ClipOval(
                      child: Image.network(
                        widget.friends.avatarUrl.toString(),
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.friends.first_name.toString() +
                            widget.friends.last_name.toString(),
                        style: TextStyle(fontSize: 18),
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 0.0),
                            child: widget.stateFriend == false
                                ? ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Color(0xFF8587F1),
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        widget.stateFriend = !widget.stateFriend;
                                        widget.onAddItem(widget.friends);
                                        print(widget.stateFriend);
                                      });
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          45, 10, 45, 10),
                                      child: Text(
                                        "Thêm",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ))
                                : ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Color(0xFF97979D),
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        widget.stateFriend = !widget.stateFriend;
                                        widget.onRemoteItem(widget.friends);
                                        print(widget.stateFriend);
                                      });
                                      // myController
                                      //     .unFriends(widget.friends.idFriends);
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          45, 10, 45, 10),
                                      child: Text("Hủy"),
                                    )),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
