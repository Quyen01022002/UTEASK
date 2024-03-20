import 'package:askute/model/NoticationsModel.dart';
import 'package:askute/service/API_Notications.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';


import '../model/PostModel.dart';


class NoticationsController extends GetxController {
  RxList<NoticationsModel> listNoticaiotns = List<NoticationsModel>.empty(growable: true).obs;
  RxList<NoticationsModel> listNoticaiotnsIsRead = List<NoticationsModel>.empty(growable: true).obs;
  RxBool isloaded = false.obs;
  RxBool isliked = false.obs;
  RxInt postid = 0.obs;


  void loadNotications() async
  {
    try {
      final prefs = await SharedPreferences.getInstance();

      isloaded(true);
      final userId = prefs.getInt('id') ?? 0;
      final token = prefs.getString('token') ?? "";
      List<NoticationsModel>? result = await API_Notications.LoadNotications(userId,token);
      if (result != null) {

        listNoticaiotns.clear();
        listNoticaiotns.addAll(result);
        listNoticaiotns.refresh();
        print("Api");
      }
    }
    finally
    {
      isloaded(false);
    }
  }
  void loadNoticationsIsRead() async
  {
    try {
      final prefs = await SharedPreferences.getInstance();


      final userId = prefs.getInt('id') ?? 0;
      final token = prefs.getString('token') ?? "";
      List<NoticationsModel>? result = await API_Notications.LoadNoticationsRead(userId,token);
      if (result != null) {

        listNoticaiotnsIsRead.clear();
        listNoticaiotnsIsRead.addAll(result);
        update();
      }
    }
    finally
    {
      isloaded(false);
    }
  }
  void readNotifications(int? notiId) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? "";
    API_Notications.readNotification(notiId, token);
  }
}