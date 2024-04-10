import 'package:flutter/material.dart';

class MessegerHeader extends StatelessWidget {
  const MessegerHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(

              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Icon(Icons.arrow_back),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 4.0),
                  child: ClipOval(child: Image.asset("assets/images/login.png",width: 50,height: 50,fit: BoxFit.cover,)),
                ),
                Text("Quyến",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),)
              ],
            ),
            Icon(Icons.settings),
          ],

        ),
      ),

    );
  }
}
