import 'package:askute/controller/Class/ClassController.dart';
import 'package:askute/model/UsersEnity.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:page_transition/page_transition.dart';


class ItemFollow extends StatefulWidget {
  final UserEnity friends;
  final Function(UserEnity) onAddItem;
  final Function(UserEnity) onRemoteItem;

  const ItemFollow({Key? key, required this.friends, required this.onAddItem,required this.onRemoteItem}) : super(key: key);

  @override
  State<ItemFollow> createState() => _ItemInviteState();
}

class _ItemInviteState extends State<ItemFollow> {
  late bool stateFriend = false;
  final ClassController myController = Get.put(ClassController());
  @override
  void initState() {
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 5, 6, 5),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(12),
        ),
        child: GestureDetector(
          onTap: ()
          {
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
                          child: stateFriend==false
                              ? ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Color(0xFF8587F1),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      stateFriend = true;
                                      widget.onAddItem(widget.friends);
                                      print(stateFriend);
                                    });
                                   // // sendFriendRequestNotification("dAJ6qbMRS32nP4rYUgDcqZ:APA91bHNsRXeb3jCcIR1DepEZRKqMPznbZqknhk0xIL_iAul3sRlR-HNk7tD446nJdxL1ddSXBeH6XteS1B62C0cFiGIgghKsfnzLyk3PcvQWUBNA_zgmui0uo5iGXCATT7ufpJ1ji8K");
                                   //  myController
                                   //      .addFriends(widget.friends.user_id);
                                  },
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(45, 10, 45, 10),
                                    child: Text("Thêm",style: TextStyle(color:Colors.white),),
                                  ))
                              : ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Color(0xFF97979D),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      stateFriend = false;
                                      widget.onRemoteItem(widget.friends);
                                      print(stateFriend);
                                    });
                                    // myController
                                    //     .unFriends(widget.friends.idFriends);
                                  },
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(45, 10, 45, 10),
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
    );
  }
}
