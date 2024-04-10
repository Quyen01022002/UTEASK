import 'package:askute/model/PostModel.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class ClassHomePage extends StatefulWidget {
  const ClassHomePage({Key? key}) : super(key: key);

  @override
  _ThongKeState createState() => _ThongKeState();
}

class _ThongKeState extends State<ClassHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ClassItem(),
          ClassItem(),
          ClassItem(),
        ],
      ),
    );
  }
}

class ClassItem extends StatefulWidget {
  const ClassItem({Key? key}) : super(key: key);

  @override
  _SavedPostItemState createState() => _SavedPostItemState();
}

class _SavedPostItemState extends State<ClassItem> {
  late bool stateDelete = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.0),
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20.0), // Điều chỉnh độ cong ở đây
            child: Image.asset(
              "assets/images/login.png",
              width: MediaQuery.of(context).size.width,
              height: 100,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Lớp Lập Trình Di Động",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500),),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8.0,65,8,8),
            child: Text("Nguyễn Hữu Trung",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w400),),
          ),
          Container(
              margin:EdgeInsets.fromLTRB(MediaQuery.of(context).size.width*70/100, 70, 0, 20),child: ClipOval(child: Image.asset("assets/images/login.png",width: 80,height: 80,fit: BoxFit.cover,),)),
        ],
      ),
    );
  }
}
