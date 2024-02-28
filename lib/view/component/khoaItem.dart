import 'package:flutter/material.dart';
class khoaItem extends StatefulWidget {

  const khoaItem({super.key});

  @override
  State<khoaItem> createState() => _khoaItemState();
}

class _khoaItemState extends State<khoaItem> {
  late bool state=false;
  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap: (){
        setState(() {
          state=!state;
        });
      },
      child: state?Container( width: MediaQuery.of(context).size.width*80/100, decoration:BoxDecoration(border: Border.all(color: Colors.blue,width: 1)),
        child: Center(child: Padding(
          padding: const EdgeInsets.fromLTRB(0,10,0,10),
          child: Text("Khoa CNTT",style: TextStyle(color:Colors.blue,),),
        )),):Container( width: MediaQuery.of(context).size.width*80/100, decoration:BoxDecoration(border: Border.all(color: Colors.black,width: 1)),
        child: Center(child: Padding(
          padding: const EdgeInsets.fromLTRB(0,10,0,10),
          child: Text("Khoa CNTT"),
        )),),
    );
  }
}
