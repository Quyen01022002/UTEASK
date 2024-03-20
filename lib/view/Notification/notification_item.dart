import 'package:askute/controller/NoticationsController.dart';
import 'package:askute/model/NoticationsModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';


class NotificationItem extends StatefulWidget {
  final NoticationsModel noticationsModel;

  NotificationItem({
    required this.noticationsModel,
  });

  @override
  _NotificationItemState createState() => _NotificationItemState();
}

class _NotificationItemState extends State<NotificationItem> {
  final NoticationsController myController = Get.put(NoticationsController());
  late String formattedTime;
  late bool isRead=false;

  @override
  void initState() {
    super.initState();
    formattedTime = formatTimeDifference(widget.noticationsModel.timeStamp);
    isRead=widget.noticationsModel.isRead;
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.all(10),
      leading: CircleAvatar(
        radius: 25,
        backgroundColor: Colors.blue, // You can customize the color
        child: Icon(
          Icons.notifications,
          color: Colors.white,
        ),
      ),
      title: GestureDetector(

        onTap: ()
        {
          print(widget.noticationsModel.isRead);
          myController.readNotifications(widget.noticationsModel.id);
          setState(() {
            isRead=true;
          });
        },
        child: Text(
          widget.noticationsModel.contentNotications,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: isRead ? Colors.black : Colors.blue,
          ),
        ),
      ),
      subtitle: Text(
        "Kiểm tra bạn bè của bạn",
        style: TextStyle(
          color: isRead ? Colors.grey : Colors.black,
        ),
      ),
      trailing: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            formattedTime,
            style: TextStyle(
              color: isRead ? Colors.grey : Colors.blue,
            ),
          ),
          if (isRead==false)
            Container(
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Text(
                'New',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
        ],
      ),
      onTap: () {
        // Add your logic for handling tap on the notification item
      },
    );
  }
}
String formatTimeDifference(String timeStamp) {
  DateTime dateTime = DateTime.parse(timeStamp);
  DateTime now = DateTime.now();
  Duration difference = now.difference(dateTime);

  if (difference.inDays > 30) {
    return DateFormat('dd/MM/yyyy HH:mm').format(dateTime);
  } else if (difference.inDays >= 1) {
    return '${difference.inDays} ngày trước';
  } else if (difference.inHours > 0) {
    if (difference.inMinutes > 0) {
      return '${difference.inHours} giờ';
    } else {
      return '${difference.inHours} giờ trước';
    }
  } else if (difference.inMinutes > 0) {
    return '${difference.inMinutes} phút trước';
  } else {
    return "Bây giờ";
  }
}
