import 'package:askute/model/UsersEnity.dart';
import 'package:askute/service/API_Profile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/GroupModel.dart';
import '../model/PostModel.dart';
import '../model/UserProfile.dart';
import '../service/API_Group.dart';
import '../service/API_Post.dart';

class SearchPostController extends GetxController{
  RxBool isloaded = false.obs;
  RxList<PostModel> topSearch = List<PostModel>.empty(growable: true).obs;
  final textControllerKeyword = TextEditingController();
  RxBool filterTheLikest = false.obs;
  RxInt idKhoa = 0.obs;
  Stream<List<PostModel>>? allSearchPostStream;
  Stream<List<GroupModel>>? allSearchGroupStream;
  Stream<List<UserEnity>>? allSearchUserStream;
void loadListResultController(BuildContext context) async{
  try {
    final prefs = await SharedPreferences.getInstance();
    isloaded(true);
    final userId = prefs.getInt('id') ?? 0;
    final token = prefs.getString('token') ?? "";
    final keyword = textControllerKeyword.text;
    //addSearchKeywords(textControllerKeyword.text);
    List<PostModel>? result = await API_Post.searchPost(userId, token, keyword);
    List<GroupModel>? resultKhoa = await API_Group.searchGroup(token, keyword);
    List<UserEnity>? resultUser = await API_Profile.Search(userId, keyword, token);
    if (result != null) {
      if (filterTheLikest.value == false && idKhoa.value == 0){
      topSearch.clear();
      topSearch.addAll(result);
      update();}
      else if (filterTheLikest.value == false && idKhoa.value != 0){
        List<PostModel> sortedResult = sortResultByKhoa(result, idKhoa.value);
        topSearch.clear();
        topSearch.addAll(sortedResult);
        update();}
      else if (filterTheLikest.value == true && idKhoa.value == 0){
        List<PostModel> sortedResult = sortResultByCountLike(result);
        topSearch.clear();
        topSearch.addAll(sortedResult);
        update();
      }
      else if (filterTheLikest.value == true && idKhoa.value !=0){
        List<PostModel> sortedResult = sortResultByCountLike(result);
        sortedResult = sortResultByKhoa(sortedResult, idKhoa.value);
        topSearch.clear();
        topSearch.addAll(sortedResult);
        update();
      }
    }
    allSearchPostStream= Stream.fromIterable([topSearch.value]);
    allSearchGroupStream = Stream.fromIterable([resultKhoa!]);
    allSearchUserStream = Stream.fromIterable([resultUser!]);

  }
  finally {
    isloaded(false);
  }
}





  List<PostModel> sortResultByCountLike(List<PostModel> originalList) {
    // Sao chép danh sách ban đầu để tránh ảnh hưởng đến danh sách gốc
    List<PostModel> sortedList = List.from(originalList);

    // Sắp xếp danh sách sao chép theo số lượng count_like giảm dần
    sortedList.sort((a, b) => b.comment_count.compareTo(a.comment_count));

    return sortedList;
  }
  List<PostModel> sortResultByKhoa(List<PostModel> originalList, int idkhoa) {
    // Sao chép danh sách ban đầu để tránh ảnh hưởng đến danh sách gốc
    List<PostModel> filteredList = List.from(originalList);

    // Lọc danh sách theo idKhoa
    filteredList = filteredList.where((post) => post.groupid == idkhoa).toList();

    return filteredList;
  }



  Future<void> addSearchKeywords(String newKeywords) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> currentKeywords = prefs.getStringList('search_keywords') ?? [];
    if (currentKeywords.contains(newKeywords)) {
      // Nếu từ khóa đã tồn tại, loại bỏ nó khỏi danh sách
      currentKeywords.remove(newKeywords);
    }
    currentKeywords.add(newKeywords);
    prefs.setStringList('search_keywords', currentKeywords);
  }
  List<String> lastFiveKeywords = [];
  Future<void> loadHistoryKeywords(context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs = await SharedPreferences.getInstance();
    List<String> historyKeywords =
        prefs.getStringList('search_keywords') ?? [];
    // Lấy 5 từ khóa cuối cùng từ danh sách lịch sử
    lastFiveKeywords = historyKeywords.length > 5
        ? historyKeywords.sublist(historyKeywords.length - 5).reversed.toList()
        : historyKeywords.reversed.toList();
  }

}
