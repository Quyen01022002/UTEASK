import 'package:askute/controller/HomeGroupController.dart';
import 'package:askute/model/GroupModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class categoryItem2 extends StatefulWidget {
  final GroupModel post;

  const categoryItem2({super.key, required this.post});

  @override
  State<categoryItem2> createState() => _categoryItemState();
}

class _categoryItemState extends State<categoryItem2> {
  late bool state = false;
  final HomeGroupController homeGroupController =
      Get.put(HomeGroupController());
  @override
  Widget build(BuildContext context) {
    return state==false
        ? Container(
      // Đặt chiều rộng cho mỗi mục
      margin: EdgeInsets.symmetric(horizontal: 5),
      child: Card(
        color: Colors.blue,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(

            onTap: () {
              homeGroupController.group_id.value = widget.post.id!;
              if (state == false) {
                homeGroupController.addMembers(context);
                print("Quyến");
                setState(() {
                  state = true;
                });
              }
            },
            child: Row(
              children: [
                Container(
                  height: 20,
                  width: 20,
                  child: ClipOval(
                    child: Image.network(widget.post.avatar.toString(),fit: BoxFit.cover),
                  ),
                ),
                SizedBox(width: 8),
                Text(
                  widget.post.name.toString(),
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    )
        : Container(

          );
  }
}

void _showDeleteConfirmationDialog(BuildContext context, int id, HomeGroupController home_postcontroller) {
  showDialog(
    context: context,
    builder: (BuildContext dialogContext) {
      return AlertDialog(
        title: Text('Xác nhận hủy theo dõi khoa '),
        content: Text('Bạn có chắc chắn muốn hủy theo dõi khoa này không?'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(dialogContext).pop(); // Đóng hộp thoại
            },
            child: Text(
              'Hủy',
              style: TextStyle(color: Colors.grey),
            ),
          ),
          TextButton(
            onPressed: () {
              home_postcontroller.group_id.value = id;
              home_postcontroller.deleteMemberOutGroup(context);
              print("Quyến");

              Navigator.of(dialogContext).pop(); // Đóng hộp thoại
            },
            child: Text(
              'Xóa',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      );
    },
  );
}
