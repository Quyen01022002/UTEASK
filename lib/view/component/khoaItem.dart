import 'package:askute/controller/HomeGroupController.dart';
import 'package:askute/model/Class.dart';
import 'package:askute/model/GroupModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class khoaItem extends StatefulWidget {
final GroupModel group;
  const khoaItem({super.key,required this.group});

  @override
  State<khoaItem> createState() => _khoaItemState();
}

class _khoaItemState extends State<khoaItem> {
  late bool state=false;
  final HomeGroupController homeGroupController= Get.put(HomeGroupController());
  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap: (){
        setState(() {

          homeGroupController.group_id.value=widget.group.id!;
          if(state==false)
            {
              homeGroupController.addMembers(context);
              print("Quyến");
            }
          state=!state;
        });
      },
      child: state?Container( width: MediaQuery.of(context).size.width*80/100, decoration:BoxDecoration(border: Border.all(color: Colors.blue,width: 1)),
        child: Center(child: Padding(
          padding: const EdgeInsets.fromLTRB(0,10,0,10),
          child: Text(widget.group.name.toString(),style: TextStyle(color:Colors.blue,),),
        )),):Container( width: MediaQuery.of(context).size.width*80/100, decoration:BoxDecoration(border: Border.all(color: Colors.black,width: 1)),
        child: Center(child: Padding(
          padding: const EdgeInsets.fromLTRB(0,10,0,10),
          child: Text(widget.group.name.toString()),
        )),),
    );
  }
}
