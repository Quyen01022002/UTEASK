import 'package:askute/model/GroupMemberRequest.dart';
import 'package:askute/model/Class.dart';
import 'package:askute/model/GroupModel.dart';
import 'package:askute/model/PostModel.dart';
import 'package:askute/model/ReportPostResponse.dart';
import 'package:askute/model/UserProfile.dart';
import 'package:askute/model/UserProgress.dart';
import 'package:askute/service/API_Post.dart';
import 'package:askute/service/API_Profile.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../service/API_Group.dart';
import '../model/SectorMembers.dart';
import '../model/SectorResponse.dart';

class User {
  final int id;
  final String name;
  final String avatar;
  bool check;

  User(this.id, this.name, this.avatar, this.check);
}

class HomeGroupController extends GetxController {
  RxString nameGroup = "".obs;
  RxString descriptionGroup = "".obs;
  RxString avatarGroup = "".obs;
  RxInt group_id = 0.obs;
  RxBool isAdmin = false.obs;
  List<UserMember>? listUserMembers = [];
  List<PostModel> listPost = [];
  List<PostModel> listPostClass = [];
  RxList<GroupModel> deliverGroup = List<GroupModel>.empty(growable: true).obs;
  final textControllerMota = TextEditingController();
  final textControllerNameGroup = TextEditingController();
  final desc = RxString('');
  final name_Group = RxString('');
  RxList<SectorResponse> listSt = List<SectorResponse>.empty(growable: true).obs;
  RxList<SectorMembers> listTC = List<SectorMembers>.empty(growable: true).obs;

  // void CreateGroup(BuildContext context) async{
  //   final description = textControllerMota.text;
  //   final name_group = textControllerNameGroup.text;
  //   final prefs = await SharedPreferences.getInstance();
  //   final adminId = prefs.getInt('id')??0;
  //
  //   GroupModel newGroup = GroupModel(
  //       name: name_group,
  //       id: 0,
  //       createdDate: DateTime.now(),
  //       description: description,
  //       updatedDate: DateTime.now(),
  //       listMembers: [],
  //       listPost: []
  //   );
  //
  //   final token = prefs.getString('token')??"";
  //   GroupModel? groupModel = await API_Group.addGroup(newGroup, token);
  //   GroupMemberRequest groupMemberRequest = GroupMemberRequest(
  //       user_id: adminId,
  //       group_id: groupModel?.id);
  //   List<GroupMemberRequest>? members = [];
  //   members.add(groupMemberRequest);
  //   await API_Group.addMembersToGroup(token, members);
  //   group_id.value = groupMemberRequest.group_id!;
  //     Future.delayed(Duration(milliseconds: 100), () {
  //       int count = 0;
  //       Navigator.of(context).popUntil((_) => count++ >= 1);
  //       GetOneGroup(context, group_id.value);
  //     });
  // }

  Stream<GroupModel>? groupCurrent;

  void GetOneGroup(BuildContext context, int idgroup) async {
    final prefs = await SharedPreferences.getInstance();
    final adminId = prefs.getInt('id') ?? 0;
    final token = prefs.getString('token') ?? "";
    group_id.value = idgroup;
    final groupModel = await API_Group.getGroupById(idgroup, token);
    if (groupModel != null) {
      print("load");
      nameGroup.value = groupModel.name ?? "";
      descriptionGroup.value = groupModel.description ?? "";
      listUserMembers = groupModel.listMembers;
      listPost = groupModel.listPost;
      if (groupModel.listMembers[0].id == adminId) {
        isAdmin.value = true;
      } else
        isAdmin.value = false;
    }
    groupCurrent = Stream.fromIterable([groupModel!]);
  }
  Future<GroupModel?> GetGroup(BuildContext context, int idgroup) async {
    final prefs = await SharedPreferences.getInstance();
    final adminId = prefs.getInt('id') ?? 0;
    final token = prefs.getString('token') ?? "";
    return await API_Group.getGroupById(idgroup, token);
  }

  RxInt pagenumber = 0.obs;
  RxInt pagenumber3 = 0.obs;
  Stream<List<PostModel>>? allPostFollowingStream;
  void GetListPost(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    final adminId = prefs.getInt('id') ?? 0;
    final token = prefs.getString('token') ?? "";
    pagenumber.value=0;
    final groupModel = await API_Group.LoadMainHome(adminId, token, 0);
    if (groupModel != null) {
      listPost.clear();
      listPost.addAll(groupModel);
      update();
    }
    allPostFollowingStream = Stream.fromIterable([groupModel!]);
  }

  RxInt pagenumberClass = 0.obs;
  Stream<List<PostModel>>? allPostClassesStream;
  void GetListPostClass(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    final adminId = prefs.getInt('id') ?? 0;
    final token = prefs.getString('token') ?? "";
    pagenumberClass.value=0;
    final groupModel = await API_Group.LoadPostClass(adminId, token, 0);
    if (groupModel != null) {
      listPostClass.clear();
      listPostClass.addAll(groupModel);
      update();
    }
    allPostClassesStream = Stream.fromIterable([groupModel!]);
  }
  void loadMorePostsClass(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    final adminId = prefs.getInt('id') ?? 0;
    final token = prefs.getString('token') ?? "";

    final groupModel = await API_Group.LoadPostClass(adminId, token, pagenumber.value+1);
    if (groupModel != null && groupModel.length!= 0) {
      //listPost.clear();
      pagenumberClass.value = pagenumberClass.value+1;
      listPostClass.addAll(groupModel);
      update();
    }
    allPostFollowingStream = Stream.fromIterable([listPost!]);
  }



  void loadMorePosts(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    final adminId = prefs.getInt('id') ?? 0;
    final token = prefs.getString('token') ?? "";

    final groupModel = await API_Group.LoadMainHome(adminId, token, pagenumber.value+1);
    if (groupModel != null && groupModel.length!= 0) {
      //listPost.clear();
      pagenumber.value = pagenumber.value+1;
      listPost.addAll(groupModel);
      update();
    }
    allPostFollowingStream = Stream.fromIterable([listPost!]);
  }

  Future<List<PostModel>?> morePosts(BuildContext context, int page) async {
    final prefs = await SharedPreferences.getInstance();
    final adminId = prefs.getInt('id') ?? 0;
    final token = prefs.getString('token') ?? "";
    return await API_Group.LoadMainHome(adminId, token, page);
  }

  RxInt pagenumber4 = 0.obs;
  Future<List<PostModel>?> morePostsClass(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    final adminId = prefs.getInt('id') ?? 0;
    final token = prefs.getString('token') ?? "";
    return await API_Group.LoadPostClass(adminId, token, pagenumber4.value);
  }

  void followGroup(int userid, int groupid, BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    final adminId = prefs.getInt('id') ?? 0;
    final token = prefs.getString('token') ?? "";
    GroupMemberRequest groupMemberRequest = GroupMemberRequest(user_id: userid, group_id: groupid);
    await API_Group.followGroup(groupMemberRequest, token);
  }
  void unfollowGroup(int userid, int groupid, BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    final adminId = prefs.getInt('id') ?? 0;
    final token = prefs.getString('token') ?? "";
    GroupMemberRequest groupMemberRequest = GroupMemberRequest(user_id: userid, group_id: groupid);
    await API_Group.deleteMemberOutGroupById(groupMemberRequest, token);
  }

  void addlistMembers(List<int> listuserid) {}
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
    if (result != null) groups = result;
    groupsStream = Stream.fromIterable([groups!]);
  }

  Future<void> loadGroupsJoin() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt('id') ?? 0;
    final token = prefs.getString('token') ?? "";
    List<GroupModel>? result = await API_Group.getAllGroupsJoin(token, userId);
    if (result != null) groupsJoin = result;
    groupsJoinStream = Stream.fromIterable([groupsJoin!]);
  }

  Future<List<GroupModel>?> loadGroupJoinValue(BuildContext context) async
  {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userId = prefs.getInt('id') ?? 0;
      final token = prefs.getString('token') ?? "";
      List<GroupModel>? result = await API_Group.getAllGroupsJoin(token, userId);
      if (result!=null)
        {
          deliverGroup.clear();
          deliverGroup.addAll(result);

        }
    return result;

    }
    finally {

    }
  }

  Future<void> deleteGroup(BuildContext context, int id) async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt('id') ?? 0;
    final token = prefs.getString('token') ?? "";
    await API_Group.deleteGroupById(id, token);

    loadGroupsOfAdmin();
    loadGroupsJoin();
    Future.delayed(Duration(milliseconds: 100), () {
      int count = 0;
      Navigator.of(context).popUntil((_) => count++ >= 2);
    });
  }

  Future<void> deleteMemberOutGroup(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt('id') ?? 0;
    final token = prefs.getString('token') ?? "";
    GroupMemberRequest groupMemberRequest =
        GroupMemberRequest(user_id: userId, group_id: group_id.value);

    await API_Group.deleteMemberOutGroupById(groupMemberRequest, token);
    GetOneGroup(context, group_id.value);
  }

  Future<void> outGroupByMe(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt('id') ?? 0;
    final token = prefs.getString('token') ?? "";
    GroupMemberRequest groupMemberRequest =
        GroupMemberRequest(user_id: userId, group_id: group_id.value);

    await API_Group.deleteMemberOutGroupById(groupMemberRequest, token);
    Future.delayed(Duration(milliseconds: 100), () {
      int count = 0;
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

  Future<void> addMembers(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt('id') ?? 0;
    final token = prefs.getString('token') ?? "";
    List<GroupMemberRequest>? members = [];

    GroupMemberRequest groupMemberRequest =
        GroupMemberRequest(user_id: userId, group_id: group_id.value);
    members.add(groupMemberRequest);
    await API_Group.addMembersToGroup(token, members);
    users = [];
    GetOneGroup(context, group_id.value);
  }

  Future<void> getInfoGroupToUpdate(BuildContext) async {
    final prefs = await SharedPreferences.getInstance();
    final adminId = prefs.getInt('id') ?? 0;
    final token = prefs.getString('token') ?? "";
    final groupModel = await API_Group.getGroupById(group_id.value, token);
    if (groupModel != null) {
      nameGroup.value = groupModel.name ?? "";
      descriptionGroup.value = groupModel.description ?? "";
      listUserMembers = groupModel.listMembers;
      if (groupModel.listMembers[0].id == adminId) {
        isAdmin.value = true;
      } else
        isAdmin.value = false;
    }
    textControllerNameGroupUpdate.text = nameGroup.value;
    textControllerMotaUpdate.text = descriptionGroup.value;
  }

  final textControllerMotaUpdate = TextEditingController();
  final textControllerNameGroupUpdate = TextEditingController();
//   Future<void> updateGroup(BuildContext context) async{
//     final description = textControllerMotaUpdate.text;
//     final name_group = textControllerNameGroupUpdate.text;
//     final prefs = await SharedPreferences.getInstance();
//     final adminId = prefs.getInt('id')??0;
//
//     GroupModel newGroup = GroupModel(
//         name: name_group,
//         id: 0,
//         createdDate: DateTime.now(),
//         description: description,
//         updatedDate: DateTime.now(),
//         listMembers: [],
//         listPost: []
//     );
//
//     final token = prefs.getString('token')??"";
//     GroupModel? groupModel = await API_Group.updateGroupById(group_id.value, newGroup, token);
//     GetOneGroup(context, group_id.value);
// }

  final nameText = new TextEditingController();
  final descText = new TextEditingController();
  RxString linkAvatarSector = ''.obs;
  void CreateOnSector(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    final adminId = prefs.getInt('id') ?? 0;
    final token = prefs.getString('token') ?? "";

    final rs = await API_Group.addSector(nameText.text, descText.text, '', group_id.value, token);

    nameText.text='';
    descText.text='';
    await loadGroup(context);
    update();
  }

  void UpdateOneSector( SectorResponse sectorResponse, BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    final adminId = prefs.getInt('id') ?? 0;
    final token = prefs.getString('token') ?? "";

    final rs = await API_Group.updateSector(sectorResponse.id!, nameText.text, descText.text, sectorResponse.avatar!, sectorResponse.groupId!, token);

    nameText.text='';
    descText.text='';
    await loadGroup(context);
    update();
  }
  void DeleteOneSector( SectorResponse sectorResponse, BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    final adminId = prefs.getInt('id') ?? 0;
    final token = prefs.getString('token') ?? "";

    final rs = await API_Group.deleteSector(sectorResponse.id!, token);

    nameText.text='';
    descText.text='';
    await loadGroup(context);
    update();
  }

  Future<List<SectorResponse>?> loadSector(BuildContext context) async
  {
    try {
      final prefs = await SharedPreferences.getInstance();
      final adminId = prefs.getInt('id') ?? 0;
      final token = prefs.getString('token') ?? "";

      final rs = await API_Group.getListSector(group_id.value, token);
      return rs;

    }
    finally {

    }
  }
  Future<List<SectorMembers>?> loadTeacherSector(BuildContext context) async
  {
    try {
      final prefs = await SharedPreferences.getInstance();
      final adminId = prefs.getInt('id') ?? 0;
      final token = prefs.getString('token') ?? "";

      final rs = await API_Group.getTeacherInGroup(group_id.value, token);
      return rs;

    }
    finally {

    }
  }
RxInt countSec = 0.obs;
  RxInt countTeac = 0.obs;
  RxString avatarAdmin = ''.obs;
  RxString nameAdmin = ''.obs;

  Future<GroupModel?> loadGroup(BuildContext context) async
  {
    try {
      final prefs = await SharedPreferences.getInstance();
      final adminId = prefs.getInt('id') ?? 0;
      final token = prefs.getString('token') ?? "";
      avatarAdmin.value = prefs.getString('Avatar')??"";
      final firstN = prefs.getString('firstName')??"";
      final lastN = prefs.getString('lastName')??"";
      nameAdmin.value = firstN + " "+ lastN;

      final rs = await API_Group.loadGroupMeDepartment(adminId, token);
      if (rs!=null){
        group_id.value = rs.id!;
        final list = await API_Group.getListSector(rs.id!, token);
        final listTea = await API_Group.getTeacherInGroup(rs.id!, token);
        listSt.clear();
        listSt.addAll(list!);
        listTC.clear();
        listTC.addAll(listTea!);
        countSec.value = list!.length;
        countTeac.value = listTea!.length;
        nameGroup.value = rs.name!;
        avatarGroup.value = rs.avatar!;

      }
      return rs;

    }
    finally {

    }
  }

  final emailText = new TextEditingController();
  RxString avatarUserAdded = ''.obs;
  RxString nameUserAdded = ''.obs;
  RxString emailUserAdded = ''.obs;
  RxInt idUserAdded = 0.obs;
  Future<UserProfile?> checkEmailRole(context) async{
    try {
      final prefs = await SharedPreferences.getInstance();
      final adminId = prefs.getInt('id') ?? 0;
      final token = prefs.getString('token') ?? "";
      idUserAdded.value = 0;
      final user = await API_Profile.searchEmailUser(
          emailText.text.trim(), token);
      if (user!.roleEnum.name == 'TEACHER')
        idUserAdded.value = user.id!;
      return user;
    }
  finally {

  }
  }


  void addTeacherSector (int sectorid, int userid, BuildContext context) async{
    final prefs = await SharedPreferences.getInstance();
    final adminId = prefs.getInt('id') ?? 0;
    final token = prefs.getString('token') ?? "";
    final rs = await API_Group.addSectorTeacher(userid, sectorid, token);
    idUserAdded.value = 0;
    emailText.text='';
    await loadGroup(context);
update();
  }

  void updateTeacherSector (SectorMembers sectorMembers,int sectorid, int userid, BuildContext context) async{
    final prefs = await SharedPreferences.getInstance();
    final adminId = prefs.getInt('id') ?? 0;
    final token = prefs.getString('token') ?? "";
    final rs = await API_Group.updateSectorTeacher(sectorMembers.id!,userid, sectorid, token);
    idUserAdded.value = 0;
    emailText.text='';
    await loadGroup(context);
    update();
  }
  void DeleteOneSectorTeacher( SectorMembers sectorMembers, BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    final adminId = prefs.getInt('id') ?? 0;
    final token = prefs.getString('token') ?? "";
    final rs = await API_Group.deleteSectorTeacher(sectorMembers.id!, token);
    await loadGroup(context);
    update();
  }

  RxInt numberGroupPage = 0.obs;
  Future<List<PostModel>?> loadPostOfGroup(BuildContext context) async
  {
    try {
      final prefs = await SharedPreferences.getInstance();
      final adminId = prefs.getInt('id') ?? 0;
      final token = prefs.getString('token') ?? "";
      final rs = await API_Post.LoadPostOfGroup(group_id.value, numberGroupPage.value, adminId, token);
      return rs;

    }
    finally {

    }
  }
  Future<List<PostModel>?> loadPostOfGroupView(int idgroup,BuildContext context) async
  {
    try {
      final prefs = await SharedPreferences.getInstance();
      final adminId = prefs.getInt('id') ?? 0;
      final token = prefs.getString('token') ?? "";
      final rs = await API_Post.LoadPostOfGroup(idgroup, numberGroupPage.value, adminId, token);
      return rs;

    }
    finally {

    }
  }

  Future<List<UserProgress>?> loadTeacherProgress(BuildContext context) async
  {
    try {
      final prefs = await SharedPreferences.getInstance();
      final adminId = prefs.getInt('id') ?? 0;
      final token = prefs.getString('token') ?? "";
      final rs = await API_Post.LoadTeacherProgress(group_id.value, 0, adminId, token);
      return rs;

    }
    finally {

    }
  }
  RxInt pageReport = 0.obs;
  Future<List<ReportPostResponse>?> loadListReportPost(BuildContext context) async
  {
    try {
      final prefs = await SharedPreferences.getInstance();
      final adminId = prefs.getInt('id') ?? 0;
      final token = prefs.getString('token') ?? "";
      final rs = await API_Group.loadListReportPostInGroup(group_id.value, pageReport.value, token);
      return rs;

    }
    finally {

    }
  }

  bool checkUserInGroup(int myId,GroupModel group,BuildContext context){
    if (group.listMembers.length != 0)
      {
        for (int i=0; i<group.listMembers.length; i++)
          {
            if (group.listMembers[i].id == myId)
              return true;
          }
      }
    return false;
  }

}
