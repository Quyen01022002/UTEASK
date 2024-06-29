import 'package:askute/model/PostEnity.dart';
import 'package:askute/model/PostModel.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:get/get.dart';

import '../../../controller/HomeController.dart';

class ThongKe extends StatefulWidget {
  const ThongKe({Key? key}) : super(key: key);

  @override
  _ThongKeState createState() => _ThongKeState();
}

class CountMonthOnYear{
  final int month;
  final int countPost;
  CountMonthOnYear(this.month, this.countPost);
}
class _ThongKeState extends State<ThongKe> {
  final HomeController _homeController = Get.put(HomeController());

  @override
  void initState() {
    super.initState();


  }


  Future<List<PostModel>?> fetchData() async {
    // Đây là ví dụ về việc tải dữ liệu từ cơ sở dữ liệu hoặc một API
    // Thay thế phần này bằng hàm thực sự để tải dữ liệu của bạn
    return _homeController.loadTop5OnMonth(context);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: FutureBuilder<List<PostModel>?>(
          future: fetchData(),
          builder: (context,snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              // Hiển thị màn hình chờ khi dữ liệu đang được tải
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              // Hiển thị lỗi nếu có lỗi xảy ra trong quá trình tải dữ liệu
              return Text('Error: ${snapshot.error}');
            } else if(snapshot.hasData) {
              return Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'Bài viết có độ thảo luận cao',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        _homeController.top5Month == null || _homeController.top5Month.length == 0?
                        Container(
                          child: Center(child: Text("Không có bài viết nào")),
                        )
                            : AspectRatio(
                          aspectRatio: 1.5,
                          child: LineChart(
                            LineChartData(
                              titlesData: FlTitlesData(
                                leftTitles: SideTitles(
                                  showTitles: true,
                                  interval: 20,
                                  margin: 8,
                                  reservedSize: 32,
                                  getTextStyles: (value) =>
                                  const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                  getTitles: (value) {
                                    return value.toInt().toString();
                                  },
                                ),
                                bottomTitles: SideTitles(
                                  showTitles: true,
                                  margin: 8,
                                  getTextStyles: (value) =>
                                  const TextStyle(
                                    color: Colors.black,
                                    //fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                  getTitles: (value) {
                                    int index = value.toInt();
                                    if (index >= 0 && index <
                                        _homeController.top5Month.length) {
                                      return _homeController.top5Month[index]
                                          .createBy!.firstName + ' ' +
                                          _homeController.top5Month[index]
                                              .createBy!.lastName;
                                    }
                                    return '';
                                  },
                                ),
                              ),
                              borderData: FlBorderData(
                                show: true,
                                border: Border.all(
                                    color: Colors.grey.shade300, width: 1),
                              ),
                              lineBarsData: [
                                LineChartBarData(
                                  spots: List.generate(
                                    _homeController.top5Month.length,
                                        (index) => FlSpot(index.toDouble(),
                                        _homeController.top5Month[index]
                                            .comment_count.toDouble()),
                                  ),
                                  isCurved: true,
                                  colors: [Colors.blue],
                                  barWidth: 4,
                                  isStrokeCapRound: true,
                                  belowBarData: BarAreaData(show: false),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        Text(
                          'Độ thảo luận trong năm',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        Container(

                          child: AspectRatio(
                            aspectRatio: 1.5,
                            child: LineChart(
                              LineChartData(
                                titlesData: FlTitlesData(
                                  leftTitles: SideTitles(
                                    showTitles: true,
                                    interval: 20,
                                    margin: 8,
                                    reservedSize: 32,
                                    getTextStyles: (value) =>
                                    const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                    getTitles: (value) {
                                      return value.toInt().toString();
                                    },
                                  ),
                                  bottomTitles: SideTitles(
                                    showTitles: true,
                                    margin: 8,
                                    getTextStyles: (value) =>
                                    const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                    getTitles: (value) {
                                      switch (value.toInt()) {
                                        case 0:
                                          return 'Jan';
                                        case 1:
                                          return 'Feb';
                                        case 2:
                                          return 'Mar';
                                        case 3:
                                          return 'Apr';
                                        case 4:
                                          return 'May';
                                        case 5:
                                          return 'Jun';
                                        case 6:
                                          return 'Jul';
                                        case 7:
                                          return 'Aug';
                                        case 8:
                                          return 'Sep';
                                        case 9:
                                          return 'Oct';
                                        case 10:
                                          return 'Nov';
                                        case 11:
                                          return 'Dec';
                                      }
                                      return '';
                                    },
                                  ),
                                ),
                                borderData: FlBorderData(
                                  show: true,
                                  border: Border.all(
                                      color: Colors.grey.shade300, width: 1),
                                ),
                                lineBarsData: [
                                  LineChartBarData(
                                    spots: List.generate(
                              _homeController.countMont.length,
                                    (index) => FlSpot(index.toDouble(),
                                    _homeController.countMont[index].toDouble()),
                              ),
                                    isCurved: true,
                                    colors: [Colors.green],
                                    barWidth: 4,
                                    isStrokeCapRound: true,
                                    belowBarData: BarAreaData(show: false),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(16),
                          margin: EdgeInsets.only(top: 20, left: 10, right: 10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              Text(
                                'Thống kê',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 10,),
                              Container(
                                padding: EdgeInsets.only(top: 0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment
                                            .spaceAround,
                                        children: [
                                          GestureDetector(
                                            onTap: () {},
                                            child: Container(
                                              child: Column(
                                                children: [
                                                  Text(
                                                    _homeController.countTK[0].toString(),
                                                    style: TextStyle(
                                                        fontWeight: FontWeight.bold,
                                                        fontSize: 22,
                                                        color: Colors.black54
                                                    ),
                                                  ),
                                                  SizedBox(width: 8),
                                                  Text(
                                                    'Số lượng lớp học',
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 5,),
                                          GestureDetector(
                                            onTap: () {

                                            },
                                            child: Container(
                                              child: Column(
                                                children: [
                                                  GestureDetector(
                                                    onTap: () {
                                                      // String? token= await FirebaseMessaging.instance.getToken();
                                                      // print(token);
                                                      // sendFriendRequestNotification(token);
                                                    },
                                                    child: Text(
                                                      _homeController.countTK[3].toString(),
                                                      style: TextStyle(
                                                          fontWeight: FontWeight
                                                              .bold,
                                                          fontSize: 22,
                                                          color: Colors.black54
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(width: 8),
                                                  Text(
                                                    'Đã phản hồi',
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment
                                            .spaceAround,
                                        children: [
                                          GestureDetector(
                                            onTap: () {},
                                            child: Container(
                                              child: Column(
                                                children: [
                                                  Text(
                                                    _homeController.countTK[1].toString(),
                                                    style: TextStyle(
                                                        fontWeight: FontWeight.bold,
                                                        fontSize: 22,
                                                        color: Colors.black54
                                                    ),
                                                  ),
                                                  SizedBox(width: 8),
                                                  Text(
                                                    'Câu hỏi thảo luận',
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 5,),
                                          GestureDetector(
                                            onTap: () {},
                                            child: Container(
                                              child: Column(
                                                children: [
                                                  Text(
                                                    _homeController.countTK[2].toString(),
                                                    style: TextStyle(
                                                        fontWeight: FontWeight.bold,
                                                        fontSize: 22,
                                                        color: Colors.black54
                                                    ),
                                                  ),
                                                  SizedBox(width: 8),
                                                  Text(
                                                     'Chưa phản hồi',
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),


                      ],
                    ),
                  ),
                ),
              );
            } else return Container();
          }
        ),
      ),
    );
  }
}
