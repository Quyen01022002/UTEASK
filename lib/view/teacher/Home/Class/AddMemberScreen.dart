import 'dart:async';

import 'package:askute/controller/Class/SearchController.dart';
import 'package:askute/model/Class.dart';
import 'package:askute/model/GroupModel.dart';
import 'package:askute/model/UsersEnity.dart';
import 'package:askute/view/teacher/Home/Class/AddItem.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
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
  late bool stateMoi = false;

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
    if (_ChooseResults.contains(item)) {
      print("Đã tồn tại");
    } else {
      setState(() {
        _ChooseResults.add(item);
      });
    }
  }
 bool checkItem(UserEnity item) {
   late bool found = false;
   for (UserMember member in widget.classes.listMembers)
   { if (member.id == item.user_id) {
     found = true;
     break;
   }}
  return found;

 }

  void updateFollowState(UserEnity friend, bool newState) {
    setState(() {
      // Tìm vị trí của friend trong _ChooseResults
      int index = _ChooseResults.indexWhere((item) => item == friend);
      if (index != -1) {
        _ChooseResults[index].isFriends = newState;
      }
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
      child: stateMoi == false
          ? Scaffold(
              appBar: AppBar(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Thêm Sinh Viên'),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          stateMoi = !stateMoi;
                        });
                        for (UserMember member in widget.classes.listMembers) {
                          if (_ChooseResults.contains(member)) {
                            print("Tìm thấy phần tử giống nhau: $member");
                            break;
                          }
                        }
                        myController.addMembers(
                            context, _ChooseResults, widget.classes.id);
                      },
                      child: Container(
                        width: 50,
                        height: 30,
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(5)),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(0.0),
                            child: Text(
                              "Mời",
                              style:
                                  TextStyle(fontSize: 13, color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              body: Container(
                decoration:
                    BoxDecoration(color: Colors.black.withOpacity(0.05)),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: double.infinity,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              spreadRadius: 0.5,
                              blurRadius: 2,
                              offset: Offset(2, 5),
                            ),
                          ],
                        ),
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
                      margin: EdgeInsets.only(top: 5),
                      child: Expanded(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: _ChooseResults.map((post) {
                                  return Container(
                                      margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                      decoration: BoxDecoration(
                                          color: Colors.blue,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              post.first_name.toString() +
                                                  post.last_name.toString(),
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  _ChooseResults.remove(post);
                                                });
                                              },
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 8.0),
                                                child: Icon(
                                                  Icons.close,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
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
            )
          : Center(
              child: SpinKitFoldingCube(
                color: Colors.blue,
                size: 50.0,
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
            .map((item) => ItemFollow(
                  friends: item,
                  onAddItem: addItemToChooseResults,
                  onRemoteItem: removeItemToChooseResults,
                  stateFriend: _ChooseResults.contains(item) || checkItem(item),
                ))
            .toList(),
      ),
    ));
  }
}
