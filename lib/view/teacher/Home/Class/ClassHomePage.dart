import 'package:askute/controller/Class/ClassController.dart';
import 'package:askute/model/Class.dart';
import 'package:askute/model/PostModel.dart';
import 'package:askute/view/teacher/Home/Class/ClassDetailTeacher.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:get/get.dart';
import 'package:page_transition/page_transition.dart';

class ClassHomePage extends StatefulWidget {
  const ClassHomePage({Key? key}) : super(key: key);

  @override
  _ThongKeState createState() => _ThongKeState();
}

class _ThongKeState extends State<ClassHomePage> {
  final ClassController classController = Get.put(ClassController());
  @override
  void initState() {
    super.initState();

    classController.loadClassOfTeacher();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:ListView.builder(
        itemCount: classController.classes!.length, // Assuming _homeController.groups is the list you want to iterate over
        itemBuilder: (context, index) {
          var item = classController.classes![index]; // Assuming each item in _homeController.groups is an instance of ClassItem
          return GestureDetector(
            onTap: (){
              Navigator.push(
                context,
                PageTransition(
                  type: PageTransitionType.leftToRightWithFade,
                  child: ClassDetailTeacher(classes: item,
                  ),
                ),
              );
            },
            child: ClassItem(classModel: item,

            ),
          );
        },
      )
    );
  }
}

class ClassItem extends StatefulWidget {
   final ClassModel classModel;
  const ClassItem({Key? key,required this.classModel }) : super(key: key);

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
            child: Text(widget.classModel.name!,style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500),),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8.0,65,8,8),
            child: Text(widget.classModel.teacher!.firstName.toString()+widget.classModel.teacher!.lastName.toString(),style: TextStyle(color: Colors.white,fontWeight: FontWeight.w400),),
          ),
          Container(
              margin:EdgeInsets.fromLTRB(MediaQuery.of(context).size.width*70/100, 70, 0, 20),child: ClipOval(child: Image.network(widget.classModel.teacher!.profilePicture.toString(),width: 80,height: 80,fit: BoxFit.cover,),)),
        ],
      ),
    );
  }
}
