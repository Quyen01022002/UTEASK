import 'package:askute/view/teacher/Home/Messeger_Detail.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';


class Home_Messeger extends StatelessWidget {
  const Home_Messeger({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                "Messeger",
                style: TextStyle(
                    fontSize: 25,
                    color: Colors.black,
                    decoration: TextDecoration.none),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
              child: Container(
                height: 50,
                child: TextField(
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                      borderSide: BorderSide.none,
                    ),
                    fillColor: Color(0xFFEFF6FD),
                    filled: true,
                    hintText: "Search....",
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
              child: Row(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                    child: Column(
                      children: [
                        ClipOval(
                            child: Image.asset(
                          "assets/images/login.png",
                          width: 60,
                          height: 60,
                          fit: BoxFit.cover,
                        )),
                        Container(
                            width: 70,
                            child: Text(
                              "Trần Bửu QUyến",
                              textAlign: TextAlign.center,
                            ))
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                    child: Column(
                      children: [
                        ClipOval(
                            child: Image.asset(
                          "assets/images/login.png",
                          width: 60,
                          height: 60,
                          fit: BoxFit.cover,
                        )),
                        Container(
                            width: 70,
                            child: Text(
                              "Trần Bửu QUyến",
                              textAlign: TextAlign.center,
                            ))
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 26, 0),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        PageTransition(
                          type: PageTransitionType.rightToLeft,
                          child: MessegerDetail(),
                        ),
                      );
                    },
                   child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                      child: Row(
                        children: [
                          Container(
                            margin: EdgeInsets.only(right: 10),
                            child: ClipOval(
                              child: Image.asset("assets/images/login.png",
                                  width: 60, height: 60, fit: BoxFit.cover),
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Trần Bửu Quyến",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 6,
                              ),
                              Text("Trần Bửu Quyến",
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(right: 10),
                        child: ClipOval(
                          child: Image.asset("assets/images/login.png",
                              width: 60, height: 60, fit: BoxFit.cover),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Trần Bửu Quyến",
                            style: TextStyle(fontSize: 18),
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          Text("Trần Bửu Quyến"),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
