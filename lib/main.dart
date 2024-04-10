import 'package:askute/view/Quetions/createQuetions.dart';
import 'package:askute/view/authen/InitFollowUser.dart';
import 'package:askute/view/authen/splash_screen.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'firebase_options.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  AwesomeNotifications().initialize(
    null,
    [
      NotificationChannel(
        channelKey: 'basic_channel',
        channelName: 'basic_channel',
        channelDescription: 'Kênh thông báo cho thông báo cơ bản',
        defaultColor: Color(0xFF9D50DD),
        ledColor: Colors.white,
      ),
    ],
  );

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print("onMessage: $message");

    AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: message.messageId.hashCode,
        channelKey: 'basic_channel',
        title: message.notification!.title,
        body: message.notification!.body,
        bigPicture: 'asset://assets/images/logo.png', // Đường dẫn tới ảnh lớn
      ),
    );
  });
  FirebaseMessaging.instance.requestPermission(
    sound: true,
    badge: true,
    alert: true,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: SplashScreen(animated: false,),
      debugShowCheckedModeBanner: false,
    );
  }
}


