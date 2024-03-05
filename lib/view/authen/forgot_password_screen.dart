import 'dart:async';

import 'package:another_flushbar/flushbar.dart';
import 'package:askute/view/authen/new_password_forgot_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:page_transition/page_transition.dart';

import '../../controller/LoginController.dart';
import 'Login_screen.dart';

class ForgotPasswordScreen extends StatefulWidget {
  final bool animated;
  final bool state;
  const ForgotPasswordScreen({Key? key, required this.animated,required this.state}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final LoginController myController = Get.put(LoginController());

  late bool animated;
  late bool state = false;
  bool _isPasswordVisible = false;
  bool isCountingDown = false;
  int secondsRemaining = 60;
  late Timer timer;
  @override
  void initState() {
    super.initState();
    animated = widget.animated;
    startAnimation();
  }
  @override
  void dispose() {
    timer.cancel(); // Hủy bỏ timer khi widget được hủy
    super.dispose();
  }
  void startCountdown() {
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (secondsRemaining > 0) {
        setState(() {
          secondsRemaining--;
        });
      } else {
        // Hết thời gian đếm ngược, đặt lại trạng thái và hủy timer
        setState(() {
          isCountingDown = false;
        });
        timer.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'assets/images/login.png',
            width: MediaQuery
                .of(context)
                .size
                .width,
            height: MediaQuery
                .of(context)
                .size
                .height,
            fit: BoxFit.cover,
          ),

          AnimatedPositioned(
            duration: const Duration(milliseconds: 500),
            bottom: animated ? 0 : -200,
            child: Container(
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              height: 440,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(25),
                  topLeft: Radius.circular(25),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(30, 40, 30, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8.0,0,0,16),
                      child: Text("Quên mật khẩu"),
                    ),
                    TextField(
                      controller: myController.textControllerEmail,
                      decoration: const InputDecoration(
                        labelText: 'Nhập email đăng nhập',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(50.0),
                          ),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Color(0xFFF3F5F7),
                        hintStyle: TextStyle(
                          color: Colors.grey, // Đặt màu cho hint text
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: myController.textControllerPass,
                      obscureText: _isPasswordVisible,
                      decoration: InputDecoration(
                        labelText: 'Nhập OTP',
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(50.0),
                          ),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Color(0xFFF3F5F7),
                        hintStyle: TextStyle(
                          color: Colors.grey,
                        ),
                        suffixIcon: isCountingDown
                            ? null
                            : ElevatedButton(
                          onPressed: () {
                            // Thực hiện hành động khi nút "Gửi OTP" được nhấn
                            setState(() {
                              isCountingDown = true;
                              secondsRemaining = 60;
                            });
                            startCountdown();
                          },
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                          ),
                          child: Text(
                            'Gửi OTP',
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 16,
                            ),

                          ),
                        ),
                      ),
                    ),
                    if (isCountingDown)
                      Text(
                        'Đợi ${secondsRemaining}s để gửi lại OTP',
                        style: TextStyle(color: Colors.red),
                      ),
                    const SizedBox(height: 36),

                    Center(
                      child: ElevatedButton(
                        onPressed: ()  {
                          Navigator.push(
                            context,
                            PageTransition(
                              type: PageTransitionType.rightToLeft,
                              child: NewPasswordScreen(animated: false, state: false,),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                          backgroundColor: Color(0xFF8587F1),
                          minimumSize: Size(500, 50),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(10, 18, 10, 18),
                          child: Text('Xác nhận OTP',style: TextStyle(color: Colors.white),),
                        ),
                      ),
                    ),
                    const SizedBox(height: 36),
                    Column(
                      children: [

                        const SizedBox(height: 16),
                        Center(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                PageTransition(
                                  type: PageTransitionType.rightToLeft,
                                  child: Loginscreen(animated: false),
                                ),
                              );
                            },
                            child: RichText(
                              text: TextSpan(
                                text: "Nhớ ra mật khẩu rồi! Trở về trang ",
                                style: TextStyle(color: Color(0xFF606060), fontSize: 14),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: 'Đăng Nhập',
                                    style: TextStyle(
                                      color: Colors.blue,
                                      fontSize: 14,
                                    ),
                                  ),

                                ],
                              ),
                            ),),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> startAnimation() async {
    await Future.delayed(Duration(milliseconds: 500));
    setState(() {
      animated = true;
    });
  }


}