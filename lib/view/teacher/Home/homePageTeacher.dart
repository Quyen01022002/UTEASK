import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomePageTeacher extends StatefulWidget {
  const HomePageTeacher({super.key});

  @override
  State<HomePageTeacher> createState() => _HomePageTeacherState();
}

class _HomePageTeacherState extends State<HomePageTeacher> {
  double _sliderValue = 0.0;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("Bài Viết Gần Đây",style: TextStyle(fontWeight: FontWeight.bold),),
        ),
        CarouselSlider(
          options: CarouselOptions(
            aspectRatio: 16 / 9,
            autoPlay: true,
            enlargeCenterPage: true,
          ),
          items: [
            // List of Widgets to display in the carousel
            Container(
              color: Colors.red,
              child: Center(child: Text('Slide 1')),
            ),
            Container(
              color: Colors.blue,
              child: Center(child: Text('Slide 2')),
            ),
            Container(
              color: Colors.green,
              child: Center(child: Text('Slide 3')),
            ),
            Container(
              color: Colors.yellow,
              child: Center(child: Text('Slide 4')),
            ),
            Container(
              color: Colors.orange,
              child: Center(child: Text('Slide 5')),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("Câu Trả lời Gần Đây",style: TextStyle(fontWeight: FontWeight.bold),),
        ),
      ],
    );
  }
}
