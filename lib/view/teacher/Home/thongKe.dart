import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class ThongKe extends StatefulWidget {
  const ThongKe({Key? key}) : super(key: key);

  @override
  _ThongKeState createState() => _ThongKeState();
}

class _ThongKeState extends State<ThongKe> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Sinh Viên',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          AspectRatio(
            aspectRatio: 1.5,
            child: LineChart(
              LineChartData(
                titlesData: FlTitlesData(
                  leftTitles: SideTitles(
                    showTitles: true,
                    interval: 20,
                    margin: 8,
                    reservedSize: 32,
                    getTextStyles: (value) => const TextStyle(
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
                    getTextStyles: (value) => const TextStyle(
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
                  border: Border.all(color: Colors.grey.shade300, width: 1),
                ),
                lineBarsData: [
                  LineChartBarData(
                    spots: [
                      FlSpot(0, 30),
                      FlSpot(1, 40),
                      FlSpot(2, 50),
                      FlSpot(3, 60),
                      FlSpot(4, 40),
                      FlSpot(5, 23),
                      FlSpot(6, 44),
                      FlSpot(7, 35),
                      FlSpot(8, 25),
                      FlSpot(9, 20),
                      FlSpot(10, 18),
                      FlSpot(11, 27),
                    ],
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
            'Câu Hỏi',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
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
                      getTextStyles: (value) => const TextStyle(
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
                      getTextStyles: (value) => const TextStyle(
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
                    border: Border.all(color: Colors.grey.shade300, width: 1),
                  ),
                  lineBarsData: [
                    LineChartBarData(
                      spots: [
                        FlSpot(0, 15),
                        FlSpot(1, 20),
                        FlSpot(2, 70),
                        FlSpot(3, 10),
                        FlSpot(4, 35),
                        FlSpot(5, 21),
                        FlSpot(6, 44),
                        FlSpot(7, 10),
                        FlSpot(8, 60),
                        FlSpot(9, 63),
                        FlSpot(10, 12),
                        FlSpot(11, 40),
                      ],
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
        ],
      ),
    );
  }
}
