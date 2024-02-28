import 'package:askute/controller/VerifyController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:page_transition/page_transition.dart';



class VerifyScreen extends StatefulWidget {
  final bool animated;

  const VerifyScreen({Key? key, required this.animated}) : super(key: key);

  @override
  State<VerifyScreen> createState() => _VerifyScreenState();
}

class _VerifyScreenState extends State<VerifyScreen> {
  final VerifyController myController = Get.put(VerifyController());
  late List<TextEditingController> _controllers;
  int _currentIndex = 0;

  void _onChanged(String value) {
    if (value.length == 1) {
      // Update the corresponding controller
      _controllers[_currentIndex].text = value;

      // Move to the next TextField
      if (_currentIndex < 5) {
        _currentIndex++;
        FocusScope.of(context).nextFocus();
      }
    } else {
      // Update the corresponding controller
      _controllers[_currentIndex].text = '';

      // Move to the previous TextField
      if (_currentIndex > 0) {
        _currentIndex--;
        FocusScope.of(context).previousFocus();
      }
    }

    // Collect the OTP from the controllers
    String otp = _controllers.map((controller) => controller.text).join();
    myController.OTP.text=otp;
  }

  late bool animated;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(6, (index) => TextEditingController());
    animated = widget.animated;
    startAnimation();
  }


  @override
  Widget build(BuildContext context) {
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
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 560,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(25),
                  topLeft: Radius.circular(25),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(30, 20, 30, 0),
                child: Column(
                  children: [
                    Text(
                      "Xác Thực",
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.blue,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.blue[50],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                        child: Text(
                          "Mã xác nhận đã được gửi về mail của bạn",
                          style: TextStyle(fontSize: 16),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 36,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: List.generate(
                        6,
                        (index) => SizedBox(
                          width: 50,
                          child: TextField(
                            controller: _controllers[index],
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.number,
                            obscureText: false,
                            onChanged: _onChanged,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 36),
                    Text(
                      "Đừng Chia Sẽ Đoạn Mã Của Bạn",
                      style: TextStyle(color: Color(0xFF606060), fontSize: 16),
                    ),
                    const SizedBox(height: 26),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              100.0), // Điều chỉnh góc bo tròn
                        ),
                        backgroundColor: Color(0xFF8587F1),
                      ),
                      onPressed: () {
                        myController.checkotp(context);
                      },
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(100, 18, 100, 18),
                        child: Text(
                          'Xác Thực',
                          style: TextStyle(
                            color: Colors.white, // Màu chữ
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 66),
                    Image.asset(
                      'assets/images/bottom_backgroud.png',
                      fit: BoxFit.cover,
                    ),
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
