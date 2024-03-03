import 'package:flutter/material.dart';

class ProfileUserScreen extends StatefulWidget {
  const ProfileUserScreen({super.key});

  @override
  State<ProfileUserScreen> createState() => _ProfileUserScreenState();
}

class _ProfileUserScreenState extends State<ProfileUserScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child:  Column(
                    children: [Container(
                      decoration: BoxDecoration(color: Color(0xFFF3F5F7)),
                      child: Stack(
                        children: [



                        ],
                      ),
                    ),]
                ),
              )
            ]
        ),
      ),
    );
  }
}
