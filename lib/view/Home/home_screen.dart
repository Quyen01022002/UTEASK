import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:page_transition/page_transition.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}
class _HomeScreenState extends State<HomeScreen> {

  double opacity = 0.0;
  bool isHeaderVisible = true;
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xFFF3F5F7),
        ),
        child: Column(
          children: [
            isHeaderVisible
                ?  AnimatedOpacity(
              duration: Duration(milliseconds: 300),
              opacity: isHeaderVisible ? 1.0 : 0.0,
            ): SizedBox(),
            Expanded(
              child: Obx(
                    () =>
                    NotificationListener<ScrollNotification>(
                      onNotification: (scrollNotification) {
                        return true;
                      },
                      child: ListView.builder(
                        controller: _scrollController,
                        itemCount:3,
                        itemBuilder: (context, index) {
                          return  AnimatedOpacity(
                              duration: Duration(milliseconds: 100),
                              opacity: opacity,

                          );
                        },
                      ),
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}