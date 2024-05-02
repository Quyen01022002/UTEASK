import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../Class/createClass.dart';
class HeaderTeacher extends StatefulWidget {
  const HeaderTeacher({super.key});

  @override
  State<HeaderTeacher> createState() => _HeaderTeacherState();
}

class _HeaderTeacherState extends State<HeaderTeacher> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("Teacher"),
        Row(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  PageTransition(
                    type: PageTransitionType.bottomToTop,
                    child: CreateClass(
                      statepost: false,
                    ),
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8.0, 0, 8, 0),
                child: Icon(
                  Icons.add_circle_outline,
                  size: 30,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 0, 8, 0),
              child: Icon(
                Icons.notifications_none_outlined,
                size: 30,
              ),
            ),
            GestureDetector(
              onTap: () {
                Scaffold.of(context).openEndDrawer();
                },
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8.0, 0, 8, 0),
                child: ClipOval(
                  child: Image.asset(
                    "assets/images/login.png",
                    width: 25,
                    height: 25,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            )
          ],
        )
      ],
    );
  }
}
