import 'dart:convert';
import 'dart:io';

import 'package:askute/controller/CreatePost.dart';
import 'package:askute/controller/HomeGroupController.dart';
import 'package:askute/model/Class.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
class CreateHotQuestion extends StatefulWidget {
  final bool statepost;
  final int groupid;

  const CreateHotQuestion({Key? key, required this.statepost, required this.groupid}) : super(key: key);

  @override
  State<CreateHotQuestion> createState() => _CreateHotQuestionState();
}

class _CreateHotQuestionState extends State<CreateHotQuestion>  {
  DateTime _selectedDate = DateTime.now();
  TextEditingController _dateController = TextEditingController();

  List<XFile> _images = [];
  late bool statepost;
  late bool statecontent = false;
  late int groupid=0;
  final HomeGroupController _homeController = Get.put(HomeGroupController());
  CreatePostController postController = new CreatePostController();

  @override
  void initState() {
    super.initState();
    _dateController.text = DateFormat('dd/MM/yyyy').format(_selectedDate);
    statepost = widget.statepost;
    _homeController.loadGroupsJoin();
  }

  Future<void> _getImagesFromGallery() async {
    final images = await ImagePicker().pickMultiImage();

    setState(() {
      _images = images ?? [];
    });
  }

  Future<void> _getImagesFromCamera() async {
    List<XFile>? images = [];

    // Capture multiple images from the camera (you can define a limit)
    for (int i = 0; i < 5; i++) {
      XFile? image = await ImagePicker().pickImage(source: ImageSource.camera);
      if (image != null) {
        images.add(image);
      } else {
        // Break the loop if the user cancels the image capture
        break;
      }
    }

    setState(() {
      _images = images ?? [];
    });
  }
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(), // Ngăn người dùng chọn ngày trước ngày hôm nay
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != _selectedDate)
      setState(() {
        _selectedDate = picked;
        _dateController.text = DateFormat('dd/MM/yyyy').format(_selectedDate);
      });
  }
  Future<void> _uploadImages() async {
    List<String> imagePaths = [];
    for (var image in _images) {
      var url =
      Uri.parse('https://api.cloudinary.com/v1_1/dq21kejpj/image/upload');

      var request = http.MultipartRequest('POST', url);
      request.fields['upload_preset'] = 'q8pgyal8';
      request.files.add(
        await http.MultipartFile.fromPath('file', image.path),
      );

      try {
        final response = await request.send();

        if (response.statusCode == 200) {
          final responseData = await response.stream.toBytes();
          final responseString = String.fromCharCodes(responseData);
          final jsonMap = jsonDecode(responseString);
          final imageUrl = jsonMap['url'];

          imagePaths.add(imageUrl);
          print('Image URL: $imageUrl');
        } else {
          print('Failed to upload image. Status code: ${response.statusCode}');
        }
      } catch (error) {
        print('Error uploading image: $error');
      }
      postController.imagePaths.value = imagePaths;
    }
  }

  @override
  Widget build(BuildContext context) {
    FocusNode _focusNode = FocusNode();
    return statepost == false
        ? Scaffold(
      resizeToAvoidBottomInset: false,
      body: GestureDetector(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              decoration: BoxDecoration(color: Colors.white),
              child: Column(
                children: [
                  Container(
                    height: 60,
                    decoration: BoxDecoration(),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: (){
                            Navigator.of(context).pop();
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(left: 26.0),
                            child: Icon(Icons.arrow_back_ios),
                          ),
                        ),
                        Text(
                          "Đăng thông báo",
                          style: TextStyle(
                            color: Colors.black,
                            decoration: TextDecoration.none,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 15),
                          child: statecontent == true
                              ? ElevatedButton(
                              onPressed: () async {
                                setState(() {
                                  statepost = true;
                                });
                                groupid=widget.groupid;
                                int daysDifference = _selectedDate.difference(DateTime.now()).inDays+1;
                                postController.contentpost.value =
                                    postController
                                        .textControllerContent.text;
                                await _uploadImages();
                                postController.createHotPost(context,groupid, daysDifference);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue,
                              ),
                              child: Text("Đăng"))
                              : ElevatedButton(
                              onPressed: () async {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.grey,
                              ),
                              child: Text("Đăng")),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFormField(
                          controller: _dateController,
                          readOnly: true,
                          onTap: () => _selectDate(context),
                          decoration: InputDecoration(
                            labelText: "Thông báo sẽ đăng đến ngày",
                            suffixIcon: Icon(Icons.calendar_today),
                          ),
                        ),
                        const SizedBox(
                          height: 26,
                        ),
                        Text("Ảnh hoặc tài liệu:",style: TextStyle(fontWeight: FontWeight.bold),),
                        const SizedBox(height: 6,),
                        GestureDetector(
                          onTap: (){
                            _showBottomSheet(context,this);
                          },
                          child: Container(
                            height: 180,
                            width: 350,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: Offset(0, 3), // Độ dịch chuyển của bóng
                                ),
                              ],
                            ),
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset("assets/images/upload.png"),
                                  Text("Chọn vào đây để tải lên"),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Text("Nội dung thông báo",style: TextStyle(fontWeight: FontWeight.bold),),
                        const SizedBox(height: 6,),
                        Container(
                          padding: EdgeInsets.all(16.0),
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: Offset(0, 3), // Độ dịch chuyển của bóng
                              ),
                            ],
                            borderRadius: BorderRadius.circular(20.0), // Bo góc
                            color: Colors.white,
                          ),
                          child: Column(
                            children: [
                              TextField(
                                focusNode: _focusNode,
                                autofocus: false,
                                controller: postController.textControllerContent,
                                maxLines: 4,
                                onChanged: (text) {
                                  if (text == null || text.isEmpty) {
                                    setState(() {
                                      statecontent = false;
                                    });
                                  } else {
                                    setState(() {
                                      statecontent = true;
                                    });
                                  }
                                },
                                decoration: InputDecoration(
                                  hintText: "Nhập nội dung thông báo",
                                  border: InputBorder.none,
                                ),

                              ),
                              if (_images.isNotEmpty)
                                Column(
                                  children: _images.map((image) {
                                    return Image.file(
                                      File(image.path),
                                      height: 400,
                                      width: 380,
                                      fit: BoxFit.cover,
                                    );
                                  }).toList(),
                                ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),

                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    )
        : Center(
      child: SpinKitFoldingCube(
        color: Colors.blue,
        size: 50.0,
      ),
    );
  }
}
void _showBottomSheet(BuildContext context, _CreateHotQuestionState state) {
  showModalBottomSheet(
    context: context,
    builder: (BuildContext builderContext) {
      return Container(
        child: Wrap(
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.camera),
              title: Text('Thư viện'),
              onTap: () {
                state._getImagesFromGallery();
              },
            ),
            ListTile(
              leading: Icon(Icons.camera_alt_outlined),
              title: Text('Máy Ảnh'),
              onTap: () {
                state._getImagesFromCamera(); // Gọi phương thức từ thể hiện của _CreatePostState
              },
            ),
            // Add more items as needed
          ],
        ),
      );
    },
  );
}
