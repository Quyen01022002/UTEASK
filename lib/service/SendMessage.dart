import 'dart:convert';
import 'package:http/http.dart' as http;

Future<void> sendFriendRequestNotification(String? friendFCMToken) async {
  final String serverKey = 'AAAAfWn1pT8:APA91bHF-r0Rfj4wNlMOq-iP9tpBZz4Saw6TPA-A5uDirIy2QnGGnburet_XySbeh5TliV382gt_ygnVb18HE7SX5FiIn8nIQw_qq09M98OXdRRRPij-oO9zZ7zkMhxCc9Wy4Zc_l4Cd';

  final String url = 'https://fcm.googleapis.com/fcm/send';

  final Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Authorization': 'key=$serverKey',
  };

  final Map<String, dynamic> notification = {
    'body': 'Có người đã bình luận nội dung của bạn',
    'title': 'Bình Luận',
    'sound': 'default',
    'priority': 'high',
  };

  final Map<String, dynamic> data = {
    'click_action': 'FLUTTER_NOTIFICATION_CLICK',
    'id': '1',
    'status': 'done',
  };

  final Map<String, dynamic> bodyData = {
    'to': friendFCMToken,
    'notification': notification,
    'data': data,
  };

  final http.Response response = await http.post(
    Uri.parse(url),
    headers: headers,
    body: jsonEncode(bodyData),
  );

  if (response.statusCode == 200) {
    print('Notification sent successfully');
  } else {
    print('Failed to send notification. Error: ${response.reasonPhrase}');
  }
}
Future<void> sendMessengerNotificationMess(String? friendFCMToken, String senderName, String message) async {
  final String serverKey = 'AAAAfWn1pT8:APA91bHF-r0Rfj4wNlMOq-iP9tpBZz4Saw6TPA-A5uDirIy2QnGGnburet_XySbeh5TliV382gt_ygnVb18HE7SX5FiIn8nIQw_qq09M98OXdRRRPij-oO9zZ7zkMhxCc9Wy4Zc_l4Cd';

  final String url = 'https://fcm.googleapis.com/fcm/send';

  final Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Authorization': 'key=$serverKey',
  };

  final Map<String, dynamic> notification = {
    'body': message,
    'title': senderName,
    'sound': 'default',
    'priority': 'high',
  };

  final Map<String, dynamic> data = {
    'click_action': 'FLUTTER_NOTIFICATION_CLICK',
    'id': '1',
    'status': 'done',
    'senderName': senderName,
    'message': message,
  };

  final Map<String, dynamic> bodyData = {
    'to': friendFCMToken,
    'notification': notification,
    'data': data,
  };

  final http.Response response = await http.post(
    Uri.parse(url),
    headers: headers,
    body: jsonEncode(bodyData),
  );

  if (response.statusCode == 200) {
    print('Notification sent successfully');
  } else {
    print('Failed to send notification. Error: ${response.reasonPhrase}');
  }
}
