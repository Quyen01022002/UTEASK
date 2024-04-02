import 'package:another_flushbar/flushbar.dart';
import 'package:askute/view/authen/forgot_password_screen.dart';
import 'package:askute/view/authen/signUpScreen.dart';
import 'package:askute/view/authen/verify_screen.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:page_transition/page_transition.dart';

import '../../controller/LoginController.dart';

class Loginscreen extends StatefulWidget {
  final bool animated;

  const Loginscreen({Key? key, required this.animated}) : super(key: key);

  @override
  State<Loginscreen> createState() => _LoginscreenState();
}

class _LoginscreenState extends State<Loginscreen> {
  final LoginController myController = Get.put(LoginController());

  late bool animated;
  late bool stateUser;
  bool _isPasswordVisible = false;


  @override
  void initState() {
    super.initState();
    animated = widget.animated;
    startAnimation();
    stateUser = true;
  }

  @override
  Widget build(BuildContext context) {
    Color originalColor = Color(0xFF27316E);

    Color reducedContrastColor = originalColor.withOpacity(0.6);
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'assets/images/login.png',
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            fit: BoxFit.cover,
          ),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 500),
            bottom: animated ? 0 : -200,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          stateUser = !stateUser;
                        });
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width / 2,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.white ,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(25),
                          ),
                        ),
                        child: Center(
                            child: Text("Sinh Viên",
                                style: TextStyle(
                                  color:
                                       Colors.black,
                                ))),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          stateUser = !stateUser;
                        });
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width / 2,
                        height: 40,
                        decoration: BoxDecoration(
                          color: reducedContrastColor,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(25),
                          ),
                        ),
                        child: Center(
                            child: Text("Giảng Viên",
                                style: TextStyle(
                                  color:
                                  Colors.white,
                                ))),
                      ),

                    ),
                  ],
                ),
                stateUser?Container(
                  width: MediaQuery.of(context).size.width,
                  height: 440,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(

                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(30, 40, 30, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(8.0, 0, 0, 16),
                          child: Text("Đăng Nhập Sinh Viên"),
                        ),
                        TextField(
                          controller: myController.textControllerEmail,
                          decoration: const InputDecoration(
                            labelText: 'Email',
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
                            labelText: 'Password',
                            border: const OutlineInputBorder(
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
                            suffixIcon: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _isPasswordVisible = !_isPasswordVisible;
                                });
                              },
                              child: Icon(
                                _isPasswordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 36),
                        Center(
                          child: ElevatedButton(
                            onPressed: () {
                              myController.email.value =
                                  myController.textControllerEmail.text;
                              myController.pass.value =
                                  myController.textControllerPass.text;
                              myController.login(context);

                              Future.delayed(Duration(milliseconds: 500), () {
                                if (myController.stateLogin != null &&
                                    myController.stateLogin != "") {
                                  Flushbar(
                                    flushbarPosition: FlushbarPosition.TOP,
                                    title: "Đăng nhập",
                                    duration: Duration(seconds: 2),
                                    icon: myController.stateLogin ==
                                            "Đăng nhập thất bại"
                                        ? Icon(
                                            Icons.close,
                                            size: 30,
                                            color: Colors.red,
                                          )
                                        : Icon(
                                            Icons.check_circle,
                                            size: 30,
                                            color: Colors.green,
                                          ),
                                    message: myController.stateLogin.toString(),
                                  )..show(context);
                                }
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                              ),
                              backgroundColor: Color(0xFF8587F1),
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(100, 18, 100, 18),
                              child: Text(
                                'Đăng Nhập',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 36),
                        Column(
                          children: [
                            const SizedBox(height: 10),
                            Center(
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    PageTransition(
                                      type: PageTransitionType.rightToLeft,
                                      child: SignUpScreeen(
                                        animated: false,
                                        state: false,
                                      ),
                                    ),
                                  );
                                },
                                child: RichText(
                                  text: const TextSpan(
                                    text: "Bạn chưa có tài khoản?",
                                    style: TextStyle(
                                        color: Color(0xFF606060), fontSize: 14),
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: 'Đăng Ký',
                                        style: TextStyle(
                                          color: Colors.blue,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Center(
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    PageTransition(
                                      type: PageTransitionType.rightToLeft,
                                      child: ForgotPasswordScreen(
                                        animated: false,
                                        state: false,
                                      ),
                                    ),
                                  );
                                },
                                child: RichText(
                                  text: const TextSpan(
                                    style: TextStyle(
                                        color: Color(0xFF606060), fontSize: 14),
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: 'Quên mật khẩu?',
                                        style: TextStyle(
                                          color: Colors.blue,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ):Container(
                  width: MediaQuery.of(context).size.width,
                  height: 440,
                  decoration: BoxDecoration(
                    color: reducedContrastColor,
                    borderRadius: BorderRadius.only(

                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(30, 40, 30, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(8.0, 0, 0, 16),
                          child: Text("Đăng Nhập",style: TextStyle(color: Colors.white),),
                        ),
                        TextField(
                          controller: myController.textControllerEmail,
                          decoration: const InputDecoration(
                            labelText: 'Email',
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
                            labelText: 'Password',
                            border: const OutlineInputBorder(
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
                            suffixIcon: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _isPasswordVisible = !_isPasswordVisible;
                                });
                              },
                              child: Icon(
                                _isPasswordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 36),
                        Center(
                          child: ElevatedButton(
                            onPressed: () {
                              myController.email.value =
                                  myController.textControllerEmail.text;
                              myController.pass.value =
                                  myController.textControllerPass.text;
                              myController.loginTeacher(context);

                              Future.delayed(Duration(milliseconds: 500), () {
                                if (myController.stateLogin != null &&
                                    myController.stateLogin != "") {
                                  Flushbar(
                                    flushbarPosition: FlushbarPosition.TOP,
                                    title: "Đăng nhập",
                                    duration: Duration(seconds: 2),
                                    icon: myController.stateLogin ==
                                        "Đăng nhập thất bại"
                                        ? Icon(
                                      Icons.close,
                                      size: 30,
                                      color: Colors.red,
                                    )
                                        : Icon(
                                      Icons.check_circle,
                                      size: 30,
                                      color: Colors.green,
                                    ),
                                    message: myController.stateLogin.toString(),
                                  )..show(context);
                                }
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                              ),
                              backgroundColor: Color(0xFFE84D6C),
                            ),
                            child: Padding(
                              padding:
                              const EdgeInsets.fromLTRB(100, 18, 100, 18),
                              child: Text(
                                'Đăng Nhập',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 36),
                        Column(
                          children: [
                            const SizedBox(height: 10),
                            Center(
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    PageTransition(
                                      type: PageTransitionType.rightToLeft,
                                      child: SignUpScreeen(
                                        animated: false,
                                        state: false,
                                      ),
                                    ),
                                  );
                                },
                                child: RichText(
                                  text: const TextSpan(
                                    text: "Bạn chưa có tài khoản?",
                                    style: TextStyle(
                                        color: Color(0xFFFFFFFF), fontSize: 14),
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: 'Đăng Ký',
                                        style: TextStyle(
                                          color: Colors.blue,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Center(
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    PageTransition(
                                      type: PageTransitionType.rightToLeft,
                                      child: ForgotPasswordScreen(
                                        animated: false,
                                        state: false,
                                      ),
                                    ),
                                  );
                                },
                                child: RichText(
                                  text: const TextSpan(
                                    style: TextStyle(
                                        color: Color(0xFF606060), fontSize: 14),
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: 'Quên mật khẩu?',
                                        style: TextStyle(
                                          color: Colors.blue,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
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
