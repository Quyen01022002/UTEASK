import 'package:askute/controller/HomeController.dart';
import 'package:askute/controller/HomeGroupController.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:get/get.dart';
import 'package:fl_chart/fl_chart.dart';

class HomePageTeacher extends StatefulWidget {
  const HomePageTeacher({super.key});

  @override
  State<HomePageTeacher> createState() => _HomePageTeacherState();
}

class _HomePageTeacherState extends State<HomePageTeacher> {
  final HomeController _homeController = Get.put(HomeController());

  @override
  void initState() {
    super.initState();
    _homeController.load10HotPost();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Bài Viết Gần Đây",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        CarouselSlider(
          options: CarouselOptions(
            aspectRatio: 16 / 9,
            autoPlay: true,
            enlargeCenterPage: true,
          ),
          items: _homeController.top10Post!.map((item) {
            print(_homeController.top10Post);
            return Builder(
              builder: (BuildContext context) {
                return Stack(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.symmetric(horizontal: 5.0),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(item.listAnh.first.toString()),
                          // Thay đổi đường dẫn tới ảnh của bạn
                          fit: BoxFit.cover, // Đảm bảo ảnh sẽ che đầy Container
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    Positioned(
                      child: Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors: [
                              Colors.black.withOpacity(0.6),
                              // Đen với độ trong suốt 60%
                              Colors.transparent,
                              // Trong suốt
                            ],
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            item.contentPost.toString(),
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            );
          }).toList(),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Câu Trả lời Gần Đây",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(16.0),
          child: LineChart(
            LineChartData(
              lineBarsData: [
                LineChartBarData(
                  spots: [
                    FlSpot(0, 1),
                    FlSpot(1, 3),
                    FlSpot(2, 2),
                    FlSpot(3, 4),
                    FlSpot(4, 3),
                  ],
                  isCurved: true,
                  colors: [Colors.blue],
                  barWidth: 4,
                  isStrokeCapRound: true,
                  belowBarData: BarAreaData(show: false),
                ),
              ],
              titlesData: FlTitlesData(
                bottomTitles: SideTitles(
                  showTitles: true,
                  getTitles: (value) {
                    if (value.toInt().toDouble() == value) {
                      switch (value.toInt()) {
                        case 0:
                          return 'A';
                        case 1:
                          return 'B';
                        case 2:
                          return 'C';
                        case 3:
                          return 'D';
                        case 4:
                          return 'E';
                      }
                    }
                    return '';
                  },
                ),
                leftTitles: SideTitles(showTitles: true),
              ),
              borderData: FlBorderData(show: true),
              minX: 0,
              maxX: 4,
              minY: 0,
              maxY: 5,
            ),
          ),
        ),
      ],
    );
  }
}
