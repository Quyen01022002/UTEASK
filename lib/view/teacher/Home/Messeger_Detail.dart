import 'package:askute/view/teacher/Home/MessegerHeader.dart';
import 'package:flutter/material.dart';

class MessegerDetail extends StatelessWidget {
  const MessegerDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(

        body: MessegerHeader(),
      ),
    );
  }
}
