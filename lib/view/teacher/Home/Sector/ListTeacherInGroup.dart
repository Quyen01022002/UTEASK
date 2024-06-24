import 'package:askute/controller/HomeGroupController.dart';
import 'package:askute/model/SectorResponse.dart';
import 'package:askute/service/API_Profile.dart';
import 'package:askute/service/API_login.dart';
import 'package:askute/view/teacher/Home/Sector/HomeSector.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../../../model/Class.dart';
import '../../../../model/SectorMembers.dart';
import '../../../../model/UserProfile.dart';

class GroupTeacher extends StatefulWidget {
  const GroupTeacher({super.key});

  @override
  State<GroupTeacher> createState() => _GroupTeacherState();
}

class _GroupTeacherState extends State<GroupTeacher> {
  final HomeGroupController homeGroupController =
      Get.put(HomeGroupController());

  //final ClassModel classes;
  String? _selectedValue; // Giá trị mặc định của ComboBox
  List<String> _options = [
    'Công nghệ phần mềm',
    'Kỹ thuật dữ liêệu',
    'An ninh mạng'
  ]; // Giá trị mặc định được chọn
  void _openEditDialog(String userName) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return EditDialog(userName: userName);
      },
    );
  }

  Future<List<SectorMembers>?> fetchData() async {
    // Đây là ví dụ về việc tải dữ liệu từ cơ sở dữ liệu hoặc một API
    // Thay thế phần này bằng hàm thực sự để tải dữ liệu của bạn
    homeGroupController.loadGroup(context);
    return homeGroupController.loadTeacherSector(context);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Danh sách giảng viên'),
        ),
        body: SingleChildScrollView(
            child: Container(
          child: Column(children: [
            _buildKhoa(),
            Container(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Colors.blue,
                            width: 2.0,
                          ),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 2, 0, 2),
                            child: Text(
                              "Trưởng Khoa",
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          ClipOval(
                            child: Image.network(
                              homeGroupController.avatarAdmin.value,
                              width: 32,
                              height: 32,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text(
                              homeGroupController.nameAdmin.value,
                              style: TextStyle(
                                fontSize: 18,
                                color: Color(0xFF646368),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: Colors.blue,
                                width: 2.0,
                              ),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 2, 0, 2),
                                child: Text(
                                  "Giảng viên",
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  _showCreateFieldDialog(context);
                                  //_openEditDialog('');
                                },
                                child: Icon(
                                  Icons.person_add_outlined,
                                  size: 30,
                                  color: Colors.blue,
                                ),
                              ),
                            ],
                          ),
                        ),
                        // _buildUserList()
                        SingleChildScrollView(
                          child: Container(
                              padding: EdgeInsets.all(8.0),
                              child: FutureBuilder<List<SectorMembers>?>(
                                future: fetchData(),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    // Hiển thị màn hình chờ khi dữ liệu đang được tải
                                    return CircularProgressIndicator();
                                  } else if (snapshot.hasError) {
                                    // Hiển thị lỗi nếu có lỗi xảy ra trong quá trình tải dữ liệu
                                    return Text('Error: ${snapshot.error}');
                                  } else if (snapshot.hasData) {
                                    return GetBuilder<HomeGroupController>(
                                      builder: (context) {
                                        return Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
                                          children: List.generate(
                                            context.listTC.length,
                                            (index) => Padding(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 8.0),
                                              child: _buildUserItem(
                                                  context.listTC[index]),
                                            ),
                                          ),
                                        );
                                      }
                                    );
                                  } else {
                                    return Container();
                                  }
                                },
                              )),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ]),
        )),
      ),
    );
  }

  Widget _buildKhoa() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 120,
      margin: EdgeInsets.symmetric(horizontal: 5.0),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(homeGroupController.avatarGroup.value),
          // Thay đổi đường dẫn tới ảnh của bạn
          fit: BoxFit.cover, // Đảm bảo ảnh sẽ che đầy Container
        ),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Center(
        child: Text(
          homeGroupController.nameGroup.value,
          style: TextStyle(
            color: Colors.white,
            fontSize: 28.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildUserItem(SectorMembers sectorMembers) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(sectorMembers.avatarUser!),
      ),
      title: Text('${sectorMembers.first_name!} ${sectorMembers.last_name!}'),
      subtitle: Text('${sectorMembers.name!}'),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            onPressed: () {
              _selectedValue = sectorMembers.sectorid!.toString();
              _showUpdateFieldDialog(sectorMembers, context);
            },
            icon: Icon(Icons.edit),
          ),
          IconButton(
            onPressed: () {
              setState(() {
                // Xử lý sự kiện khi nhấn vào nút "Xóa"
                // users.remove(user);
                homeGroupController.DeleteOneSectorTeacher(sectorMembers, context);
              });
            },
            icon: Icon(Icons.delete),
          ),
        ],
      ),
    );
  }

  Widget _buildUserItemCard(String userName) {
    return Card(
      elevation: 3.0,
      child: Padding(
        padding: EdgeInsets.all(12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                userName,
                style: TextStyle(fontSize: 16.0),
              ),
            ),
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                // Xử lý sự kiện chỉnh sửa ở đây

              },
            ),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                // Xử lý sự kiện xóa ở đây
              },
            ),
          ],
        ),
      ),
    );
  }

  String? avatarU;
  String? nameU;
  bool isEmailValid = true;

  Future<UserProfile?> searchEmail() async {
    // Đây là ví dụ về việc tải dữ liệu từ cơ sở dữ liệu hoặc một API
    // Thay thế phần này bằng hàm thực sự để tải dữ liệu của bạn
    return homeGroupController.checkEmailRole(context);
  }

  void _showCreateFieldDialog(BuildContext context) {
    String avatarUrl = 'https://i.pravatar.cc/150?img=1';

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, setState) {
          return AlertDialog(
            title: Text('Thêm giáo viên'),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  FutureBuilder<UserProfile?>(
                      future: searchEmail(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          // Hiển thị màn hình chờ khi dữ liệu đang được tải
                          return CircularProgressIndicator();
                        } else if (snapshot.hasError) {
                          // Hiển thị lỗi nếu có lỗi xảy ra trong quá trình tải dữ liệu
                          return Text(
                              'Không tìm thấy giảng viên với email đã nhập');
                        } else if (snapshot.hasData) {
                          return Row(
                            children: [
                              CircleAvatar(
                                backgroundImage:
                                    NetworkImage(snapshot.data!.avatarUrl!),
                                radius: 30,
                              ),
                              SizedBox(width: 10),
                              Text(
                                  '${snapshot.data!.first_name} ${snapshot.data!.last_name}'),
                            ],
                          );
                        } else {
                          return Container();
                        }
                      }),
                  TextField(
                    controller: homeGroupController.emailText,
                    decoration: InputDecoration(
                      labelText: 'Email tài khoản',
                    ),
                    onChanged: (value) {
                      setState(() {});
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  DropdownButton<String>(
                    value: _selectedValue,
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedValue = newValue!;
                      });
                    },
                    items: homeGroupController.listSt
                        .map<DropdownMenuItem<String>>((SectorResponse value) {
                      return DropdownMenuItem<String>(
                        value: value.id.toString(),
                        child: Text(value.name.toString()),
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Hủy'),
              ),
              ElevatedButton(
                onPressed: () {
                  // Xử lý sự kiện lưu lĩnh vực ở đây
                  if (homeGroupController.emailText.text.trim() != '' &&
                      _selectedValue != null) {
                    if (homeGroupController.idUserAdded.value != 0) {
                      String? selectedSectorId = _selectedValue;
                      print('id đã chọn: $selectedSectorId');
                      homeGroupController.addTeacherSector(
                          int.parse(selectedSectorId!),
                          homeGroupController.idUserAdded.value,
                          context);

                      Navigator.of(context).pop();
                    }
                  } else
                    _validateInputs();
                },
                child: Text('Lưu'),
              ),
            ],
          );
        });
      },
    );
  }
  void _showUpdateFieldDialog(SectorMembers sectorMembers, BuildContext context) {
    String avatarUrl = 'https://i.pravatar.cc/150?img=1';

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, setState) {
          String? _selectedValueN = sectorMembers.name != null && sectorMembers.name!.isNotEmpty
              ? sectorMembers.name!
              : (homeGroupController.listSt.isNotEmpty ? homeGroupController.listSt.first.id.toString() : null);

          return AlertDialog(
            title: Text('Thêm giáo viên'),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
              Row(
              children: [
              CircleAvatar(
              backgroundImage:
                  NetworkImage(sectorMembers.avatarUser!),
              radius: 30,
            ),
            SizedBox(width: 10),
            Text(
                '${sectorMembers.first_name!} ${sectorMembers.last_name!}'),
            ],
          ),
                  SizedBox(
                    height: 20,
                  ),
                  DropdownButton<String>(
                    value: _selectedValue,
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedValue = newValue!;
                      });
                    },
                    items: homeGroupController.listSt
                        .map<DropdownMenuItem<String>>((SectorResponse value) {
                      return DropdownMenuItem<String>(
                        value: value.id.toString(),
                        child: Text(value.name.toString()),
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Hủy'),
              ),
              ElevatedButton(
                onPressed: () {
                  // Xử lý sự kiện lưu lĩnh vực ở đây
                  if (_selectedValue != null) {

                      String? selectedSectorId = _selectedValue;
                      print('id đã chọn: $selectedSectorId');
                      homeGroupController.updateTeacherSector(
                        sectorMembers,
                        int.parse(selectedSectorId!),
                        sectorMembers.userid!,
                        context
                      );

                      Navigator.of(context).pop();

                  } else
                    _validateInputs();
                },
                child: Text('Lưu'),
              ),
            ],
          );
        });
      },
    );
  }

  void _validateInputs() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Lỗi'),
          content: Text('Vui lòng nhập đầy đủ thông tin.'),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

class EditDialog extends StatelessWidget {
  final String userName;

  const EditDialog({Key? key, required this.userName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String selectedValue =
        'Công nghệ phần mềm'; // Giá trị mặc định của ComboBox
    List<String> dropdownItems = [
      'Công nghệ phần mềm',
      'Kỹ thuật dữ liêệu',
      'An ninh mạng'
    ];

    return AlertDialog(
      title: Text('Thông tin'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              ClipOval(
                child: Image.network(
                  'https://i.pinimg.com/564x/3f/11/11/3f11116df4e1cd1bc817347285582689.jpg',
                  width: 20,
                  height: 20,
                  fit: BoxFit.cover,
                ),
              ),
              Text('$userName'),
            ],
          ),
          SizedBox(height: 20),
          DropdownButton<String>(
            value: selectedValue,
            onChanged: (String? newValue) {
              selectedValue = newValue!;
            },
            items: dropdownItems.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Đóng dialog khi nhấn nút "Hủy"
          },
          child: Text('Hủy'),
        ),
        ElevatedButton(
          onPressed: () {
            // Xử lý sự kiện lưu thay đổi ở đây
            Navigator.of(context).pop(); // Đóng dialog khi nhấn nút "Lưu"
          },
          child: Text('Lưu'),
        ),
      ],
    );
  }
}
