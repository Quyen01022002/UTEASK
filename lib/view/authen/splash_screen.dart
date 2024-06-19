import 'package:askute/view/authen/Login_screen.dart';
import 'package:askute/view/dashboard/DashBoard.dart';
import 'package:askute/view/mess/one_mess_screen.dart';
import 'package:askute/view/report/report_user_screen.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../Home/home_screen.dart';
import '../mess/home_mess_screen.dart';

class SplashScreen extends StatefulWidget {
  final bool animated;

  const SplashScreen({Key? key, required this.animated}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late bool animated;

  @override
  void initState() {
    super.initState();
    animated = widget.animated;
    startAnimation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(color: Colors.blue),
            ),
            AnimatedPositioned(
              duration: const Duration(milliseconds: 800),
              top: animated ? 220 : 0,
              left: animated ? 60 : 0,
              child: Transform.rotate(
                angle: 0,
                child: Center(
                  child: Image.asset(
                    'assets/images/SHAPE.png',
                    width: 300, // Đổi kích thước tùy ý
                    height: 350, // Đổi kích thước tùy ý
                  ),
                ),
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height / 2 -40, // 40 là nửa chiều cao của mỗi chữ
              left: MediaQuery.of(context).size.width / 2 - 45, // 15 là nửa chiều rộng của mỗi chữ
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: AnimatedOpacity(
                      duration: Duration(milliseconds: 1000),
                      opacity: animated ? 1.0 : 0.0,
                      child: Text(
                        'U',
                        style: TextStyle(
                          fontSize: 40,
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: AnimatedOpacity(
                      duration: Duration(milliseconds: 1500),
                      opacity: animated ? 1.0 : 0.0,
                      child: Text(
                        'T',
                        style: TextStyle(
                          fontSize: 40,
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: AnimatedOpacity(
                      duration: Duration(milliseconds: 2000),
                      opacity: animated ? 1.0 : 0.0,
                      child: Text(
                        'E',
                        style: TextStyle(
                          fontSize: 40,
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> startAnimation() async {
    await Future.delayed(Duration(milliseconds: 1000));
    setState(() {
      animated = true;
    });
    Future.delayed(Duration(milliseconds: 600), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Loginscreen(animated: false)),
      );
    });
  }
}
