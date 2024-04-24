import 'dart:async';

import 'package:askute/controller/Class/SearchController.dart';
import 'package:askute/model/Class.dart';
import 'package:askute/model/UsersEnity.dart';
import 'package:askute/view/teacher/Home/Class/AddItem.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddMemberScreen extends StatefulWidget {
  final ClassModel classes;
  const AddMemberScreen({super.key, required this.classes});
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<AddMemberScreen> {
  final Search_Controller myController = Get.put(Search_Controller());
  List<UserEnity> _searchResults = [];
  List<UserEnity> _ChooseResults = [];
  late bool stateFriend = true;

  Future<void> _searchData(String query) async {
    myController.loadUser();
    setState(() {
      _searchResults = myController.listUser;
    });
  }

  Future<List<String>> fetchSearchResultsFromApi(String query) async {
    await Future.delayed(Duration(seconds: 2));
    return List.generate(5, (index) => 'Result $index for "$query"');
  }
  void addItemToChooseResults(UserEnity item) {
    setState(() {
      _ChooseResults.add(item);
    });
  }
  void removeItemToChooseResults(UserEnity item) {
    setState(() {
      _ChooseResults.remove(item);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: double.infinity,
                height: 50,
                child: TextField(
                  controller: myController.textControllerContent,
                  onChanged: (query) {
                    _searchData(query);
                  },
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide: BorderSide.none,
                    ),
                    fillColor: Colors.white,
                    filled: true,
                    hintText: "Search....",
                  ),
                ),
              ),
            ),
            Container(
              height: 50,
              child: Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: ()
                        {
                          myController.addMembers(context,_ChooseResults,widget.classes.id);
                        },
                        child: Container( decoration: BoxDecoration(color: Colors.blue,borderRadius: BorderRadius.circular(5)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Mời",style: TextStyle(color: Colors.white),),
                          ),),
                      ),
                      Row(
                        children: _ChooseResults.map((post) {
                          return Container(
                            margin:EdgeInsets.fromLTRB(10, 0, 10, 0),
                              decoration:
                                  BoxDecoration(color: Color(0xFF6E6ECF),
                                    borderRadius: BorderRadius.circular(10)
                                  ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Text(post.first_name.toString() +
                                        post.last_name.toString()),
                                    Icon(Icons.close),
                                  ],
                                ),
                              ));
                        }).toList(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: _buildSearchResults(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchResults() {
    return SingleChildScrollView(
        child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        key: ValueKey(_searchResults),
        children: _searchResults
            .map((item) => ItemFollow(friends: item, onAddItem: addItemToChooseResults,onRemoteItem: removeItemToChooseResults,))
            .toList(),
      ),
    ));
  }
}
