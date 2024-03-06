import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingController extends GetxController {
  RxString first_name = ('').obs;
  RxString last_name = ('').obs;
  RxString avatar = ('').obs;
  RxString email = ('').obs;
  void loadthongtin() async {
    final prefs = await SharedPreferences.getInstance();

    avatar.value = prefs.getString('Avatar')!;
    first_name.value = prefs.getString('firstName')!;
    last_name.value = prefs.getString('lastName')!;
    print("Tên nè: " + first_name.value + " " + last_name.value);
    email.value = prefs.getString('email')!;
  }

}