import 'package:askute/view/Quetions/createQuetions.dart';
import 'package:askute/view/authen/InitFollowUser.dart';
import 'package:askute/view/authen/splash_screen.dart';
import 'package:flutter/material.dart';

void main() {
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
    );
  }
}


