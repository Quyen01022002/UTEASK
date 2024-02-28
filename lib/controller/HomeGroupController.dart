import 'package:askute/model/GroupMemberRequest.dart';
import 'package:askute/model/GroupModel.dart';
import 'package:askute/model/PostModel.dart';
import 'package:askute/model/UsersEnity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../service/API_Group.dart';

class HomeGroupController extends GetxController{
  RxString nameGroup = "".obs;
  RxString descriptionGroup = "".obs;
  RxInt group_id = 0.obs;
  RxBool isAdmin = false.obs;
  List<UserMember>? listUserMembers=[];
  List<PostModel> listPost=[];
  final textControllerMota = TextEditingController();
  final textControllerNameGroup = TextEditingController();
  final desc = RxString('');
  final name_Group = RxString('');


  void CreateGroup(BuildContext context) async{
    final description = textControllerMota.text;
    final name_group = textControllerNameGroup.text;
    final prefs = await SharedPreferences.getInstance();
    final adminId = prefs.getInt('id')??0;

    GroupModel newGroup = GroupModel(
        name: name_group,
        id: 0,
        createdDate: DateTime.now(),
        description: description,
        updatedDate: DateTime.now(),
        listMembers: [],
        listPost: []
    );

    final token = prefs.getString('token')??"";
    GroupModel? groupModel = await API_Group.addGroup(newGroup, token);
    GroupMemberRequest groupMemberRequest = GroupMemberRequest(
        user_id: adminId,
        group_id: groupModel?.id);
    List<GroupMemberRequest>? members = [];
    members.add(groupMemberRequest);
    await API_Group.addMembersToGroup(token, members);
    group_id.value = groupMemberRequest.group_id!;
      Future.delayed(Duration(milliseconds: 100), () {
        int count = 0;
        Navigator.of(context).popUntil((_) => count++ >= 1);
        GetOneGroup(context, group_id.value);
      });
  }

  Stream<GroupModel>? groupCurrent;
  void GetOneGroup(BuildContext context, int idgroup) async{
    final prefs = await SharedPreferences.getInstance();
    final adminId = prefs.getInt('id')??0;
    final token = prefs.getString('token')??"";
    group_id.value = idgroup;
    final groupModel = await API_Group.getGroupById(idgroup, token);
    if (groupModel !=  null)
      {
        nameGroup.value = groupModel.name ?? "";
        descriptionGroup.value = groupModel.description ?? "";
        listUserMembers= groupModel.listMembers;
        listPost= groupModel.listPost;
        if (groupModel.listMembers[0].id == adminId){
          isAdmin.value = true;
        }
        else
          isAdmin.value = false;
      }
    groupCurrent = Stream.fromIterable([groupModel!]);
  }

  void addlistMembers(List<int> listuserid){



  }
  List<UserMember>? users = [];

  // Future<void> loadFriends(BuildContext context) async {
  //   users = [];
  //   final prefs = await SharedPreferences.getInstance();
  //   final userId = prefs.getInt('id') ?? 0;
  //   final token = prefs.getString('token') ?? "";
  //   List<UserEnity>? result = await API_Friend.LoadListFriends(userId, token);
  //
  //   if (result != null) {
  //     // Sử dụng vòng lặp forEach để truy cập từng phần tử trong danh sách
  //     result!.forEach((userEntity) {
  //       UserMember user = UserMember(id: userEntity.user_id ?? 0,
  //           firstName: userEntity.first_name ?? "",
  //           lastName: userEntity.last_name ?? "",
  //           phone: userEntity.phone ?? "",
  //           email: userEntity.email ?? "",
  //           profilePicture: userEntity.avatarUrl ?? "");
  //
  //       users?.add(user);
  //     });
  //   }
  //
  //
  //   Future.delayed(Duration(milliseconds: 300), () {
  //     Navigator.push(
  //       context,
  //       MaterialPageRoute(builder: (context) => AddMembersGroup()),
  //     );
  //   });
  //
  //
  // }
  List<GroupModel>? groups = [];
  List<GroupModel>? groupsJoin = [];
  Stream<List<GroupModel>>? groupsStream;
  Stream<List<GroupModel>>? groupsJoinStream;
  Future<void> loadGroupsOfAdmin() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt('id') ?? 0;
    final token = prefs.getString('token') ?? "";
    List<GroupModel>? result = await API_Group.getAllGroups(token);
    if (result != null)
      groups = result;
    groupsStream = Stream.fromIterable([groups!]);
  }
  Future<void> loadGroupsJoin() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt('id') ?? 0;
    final token = prefs.getString('token') ?? "";
    List<GroupModel>? result = await API_Group.getAllGroupsJoin(token, userId);
    if (result != null)
      groupsJoin = result;
    groupsJoinStream = Stream.fromIterable([groupsJoin!]);
  }
  // List<User> selectedMembers = []; // Danh sách thành viên đã chọn
  //
  // Future<void> addSelectedMembers(BuildContext context, List<User> selectedUsers) async {
  //   selectedMembers = selectedUsers;
  //   final prefs = await SharedPreferences.getInstance();
  //   final userId = prefs.getInt('id') ?? 0;
  //   final token = prefs.getString('token') ?? "";
  //   List<GroupMemberRequest>? members = [];
  //   if (selectedMembers!= null)
  //     {
  //       selectedMembers!.forEach((element) {
  //         GroupMemberRequest groupMemberRequest = GroupMemberRequest(
  //             user_id: element.id,
  //             group_id: group_id.value);
  //         members.add(groupMemberRequest);
  //       });
  //     }
  //   await API_Group.addMembersToGroup(token, members);
  //   users = [];
  //   GetOneGroup(context, group_id.value);
  // }
  Future<void> deleteGroup(BuildContext context, int id) async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt('id') ?? 0;
    final token = prefs.getString('token') ?? "";
    await API_Group.deleteGroupById(id, token);

    loadGroupsOfAdmin();
    loadGroupsJoin();
    Future.delayed(Duration(milliseconds: 100), () {
      int count =0;
      Navigator.of(context).popUntil((_) => count++ >= 2);
    });

  }

  Future<void> deleteMemberOutGroup(BuildContext context, int idMember) async{
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt('id') ?? 0;
    final token = prefs.getString('token') ?? "";
    GroupMemberRequest groupMemberRequest = GroupMemberRequest(user_id: idMember, group_id: group_id.value);

    await API_Group.deleteMemberOutGroupById(groupMemberRequest, token);
    GetOneGroup(context, group_id.value);

  }
  Future<void> outGroupByMe(BuildContext context) async{

    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt('id') ?? 0;
    final token = prefs.getString('token') ?? "";
    GroupMemberRequest groupMemberRequest = GroupMemberRequest(user_id: userId, group_id: group_id.value);

    await API_Group.deleteMemberOutGroupById(groupMemberRequest, token);
    Future.delayed(Duration(milliseconds: 100), () {
      int count =0;
      Navigator.of(context).popUntil((_) => count++ >= 2);
    });
  }

  // Future<void> loadHomeGroupScreen(BuildContext context) async{
  //   loadGroupsJoin();
  //   loadGroupsOfAdmin();
  //   await Future.delayed(Duration(milliseconds: 300), () {
  //     Navigator.push(
  //       context,
  //       PageTransition(
  //         type: PageTransitionType.rightToLeft,
  //         child: GroupScreen(),
  //       ),
  //     );
  //   });
  // }


  Future<void> getInfoGroupToUpdate(BuildContext) async {
    final prefs = await SharedPreferences.getInstance();
    final adminId = prefs.getInt('id')??0;
    final token = prefs.getString('token')??"";
    final groupModel = await API_Group.getGroupById(group_id.value, token);
    if (groupModel !=  null)
    {
      nameGroup.value = groupModel.name ?? "";
      descriptionGroup.value = groupModel.description ?? "";
      listUserMembers= groupModel.listMembers;
      if (groupModel.listMembers[0].id == adminId){
        isAdmin.value = true;
      }
      else
        isAdmin.value = false;
    }
    textControllerNameGroupUpdate.text = nameGroup.value;
    textControllerMotaUpdate.text = descriptionGroup.value;
  }

  final textControllerMotaUpdate = TextEditingController();
  final textControllerNameGroupUpdate = TextEditingController();
  Future<void> updateGroup(BuildContext context) async{
    final description = textControllerMotaUpdate.text;
    final name_group = textControllerNameGroupUpdate.text;
    final prefs = await SharedPreferences.getInstance();
    final adminId = prefs.getInt('id')??0;

    GroupModel newGroup = GroupModel(
        name: name_group,
        id: 0,
        createdDate: DateTime.now(),
        description: description,
        updatedDate: DateTime.now(),
        listMembers: [],
        listPost: []
    );

    final token = prefs.getString('token')??"";
    GroupModel? groupModel = await API_Group.updateGroupById(group_id.value, newGroup, token);
    GetOneGroup(context, group_id.value);
}

}