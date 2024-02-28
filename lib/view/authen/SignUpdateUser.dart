import 'package:askute/controller/SignUpdateController.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/SignUpController.dart';

class DatePickerApp extends StatelessWidget {
  const DatePickerApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DatePickerExample(),
    );
  }
}

class DatePickerExample extends StatefulWidget {
  const DatePickerExample({Key? key});

  @override
  State<DatePickerExample> createState() => _DatePickerExampleState();
}

class _DatePickerExampleState extends State<DatePickerExample> {
  String selectedGender = '';
  final SignUpdateController myController = Get.put(SignUpdateController());
  DateTime date = DateTime(2023, 10, 26);
  List<String> genders = ['MALE', 'FEMALE', 'OTHER'];


  void _showDialog(Widget child) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => Container(
        height: 216,
        padding: const EdgeInsets.only(top: 6.0),
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        color: CupertinoColors.systemBackground.resolveFrom(context),
        child: SafeArea(
          top: false,
          child: child,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: DefaultTextStyle(
        style: TextStyle(
          color: CupertinoColors.label.resolveFrom(context),
          fontSize: 22.0,
        ),

        child:SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
              children: <Widget>[
                Image.asset('assets/images/logo.png',),
                Text("Cập nhật thông tin tài khoản",style: TextStyle(fontWeight: FontWeight.w500),),
                const SizedBox(height: 86,),
                _Input(
                  icon: CupertinoIcons.person,
                  hintText: 'First Name',
                  controller: myController.firstNameController,
                ),
                _Input(
                  icon: CupertinoIcons.person,
                  hintText: 'Last Name',
                  controller: myController.lastNameController,
                ),
                _Input(
                  icon: CupertinoIcons.person,
                  hintText: 'Address Name',
                  controller: myController.addressController,
                ),
                _Input(
                  icon: CupertinoIcons.calendar,
                  hintText: 'Date of Birth',
                  controller: myController.dateController,
                  readOnly: true,
                  onTap: () => _showDialog(
                    CupertinoDatePicker(
                      initialDateTime: date,
                      mode: CupertinoDatePickerMode.date,
                      use24hFormat: true,
                      showDayOfWeek: true,
                      onDateTimeChanged: (DateTime newDate) {
                        setState(() {
                          date = newDate;
                          myController.dateController.text =
                          '${newDate.month}-${newDate.day}-${newDate.year}';
                        });
                      },
                    ),
                  ),
                ),
                _Input(
                  icon: CupertinoIcons.person,
                  hintText: 'Gender',
                  controller: myController.genderController,
                  readOnly: true,
                  onTap: () => _showDialog(
                    CupertinoPicker(
                      itemExtent: 32.0,
                      onSelectedItemChanged: (int index) {
                        setState(() {
                          // Lấy giá trị giới tính từ danh sách tùy chọn
                          selectedGender = genders[index];
                          // Gán giá trị vào controller để hiển thị
                          myController.genderController.text = selectedGender;
                        });
                      },
                      children: genders.map((gender) => Text(gender)).toList(),
                    ),
                  ),
                ),

                Positioned(
                  bottom: 0,
                  child: GestureDetector(
                    onTap: (){
                      myController.signup(context);
                    },
                    child: Container(
                      margin: EdgeInsets.fromLTRB(200,100,0,0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.blue
                      ),
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(16, 10, 16, 10),
                        child: Text("Tiếp Theo",style: TextStyle(color: Colors.white,fontSize: 15),),
                      ),
                    ),
                  ),
                )
              ],
            ),


        ),

      ),
    );
  }
}

class _DatePickerItem extends StatelessWidget {
  const _DatePickerItem({required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: children,
        ),
      ),
    );
  }
}

class _Input extends StatelessWidget {
  const _Input({
    required this.icon,
    required this.hintText,
    required this.controller,
    this.readOnly = false,
    this.onTap,
  });

  final IconData icon;
  final String hintText;
  final TextEditingController controller;
  final bool readOnly;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return CupertinoFormRow(
      child: CupertinoTextField(
        controller: controller,
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
        placeholder: hintText,
        readOnly: readOnly,
        prefix: Padding(
          padding: const EdgeInsets.only(right: 12.0),
          child: Icon(
            icon,
            color: CupertinoColors.systemGrey,
          ),
        ),
        decoration: BoxDecoration(
          border: Border.all(
            color: CupertinoColors.inactiveGray,
          ),
          borderRadius: BorderRadius.circular(12.0),
          color: CupertinoColors.white,
        ),
        onTap: onTap,
      ),
    );
  }
}