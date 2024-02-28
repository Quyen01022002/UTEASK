import 'dart:convert';

import 'package:askute/controller/CreatePost.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class CreatePost extends StatefulWidget {
  final bool statepost;

  const CreatePost({Key? key, required this.statepost}) : super(key: key);

  @override
  State<CreatePost> createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  List<XFile> _images = [];
  late bool statepost;
  late bool statecontent = false;
  CreatePostController postController = new CreatePostController();

  @override
  void initState() {
    super.initState();
    statepost = widget.statepost;
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
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 26.0),
                                child: Icon(Icons.arrow_back_ios),
                              ),
                              Text(
                                "Đặt câu hỏi",
                                style: TextStyle(
                                    color: Colors.black,
                                    decoration: TextDecoration.none,
                                    fontSize: 18),
                              ),
                              // Padding(
                              //   padding: EdgeInsets.only(right: 15),
                              //   child: statecontent == true||_images!=null
                              //       ? ElevatedButton(
                              //       onPressed: () async {
                              //         setState(() {
                              //           statepost = true;
                              //         });
                              //         postController.contentpost.value =
                              //             postController
                              //                 .textControllerContent.text;
                              //         await _uploadImages();
                              //         postController.createpost(context);
                              //       },
                              //       style: ElevatedButton.styleFrom(
                              //         primary: Colors.blue,
                              //       ),
                              //       child: Text("Đăng"))
                              //       : ElevatedButton(
                              //       onPressed: () async {},
                              //       style: ElevatedButton.styleFrom(
                              //         primary: Colors.grey,
                              //       ),
                              //       child: Text("Đăng")),
                              // )
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: ClipOval(
                                child: Image.asset(
                                  "assets/images/login.png",
                                  fit: BoxFit.cover,
                                  width: 50,
                                  height: 50,
                                ),
                              ),
                            ),
                            Column(
                              children: [
                                Text(
                                  "Trần Bửu Quyến",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(22.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Tiêu đề:",style: TextStyle(fontWeight: FontWeight.bold),),
                              const SizedBox(height: 6,),
                              Container(
                                padding: EdgeInsets.all(6.0),
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
                                child: TextField(
                                  focusNode: _focusNode,
                                  controller: postController.textControllerContent,
                                  maxLines: 1,
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
                                    hintText: "Tiêu đề",
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 26,
                              ),
                              Text("Ảnh hoặc tài liệu:",style: TextStyle(fontWeight: FontWeight.bold),),
                              const SizedBox(height: 6,),
                              GestureDetector(
                                onTap: (){

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
                                height: 6,
                              ),
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
                                child: TextField(
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
                                    hintText: "Bạn đang nghĩ gì?",
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
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

                        // Column(
                        //   children: [
                        //     Container(
                        //       decoration: BoxDecoration(
                        //         border: Border(
                        //           bottom: BorderSide(
                        //             width: 1,
                        //             color: Colors
                        //                 .grey, // You can specify the color here
                        //           ),
                        //           top: BorderSide(
                        //             width: 1,
                        //             color: Colors
                        //                 .grey, // You can specify the color here
                        //           ),
                        //         ),
                        //       ),
                        //       child: GestureDetector(
                        //         onTap: _getImagesFromCamera,
                        //         child: Row(
                        //           children: [
                        //             Padding(
                        //               padding: const EdgeInsets.all(12.0),
                        //               child: Icon(
                        //                 Icons.image,
                        //                 color: Colors.green,
                        //                 size: 30,
                        //               ),
                        //             ),
                        //             Text("Ảnh"),
                        //           ],
                        //         ),
                        //       ),
                        //     ),
                        //     Container(
                        //       decoration: BoxDecoration(
                        //         border: Border(
                        //           bottom: BorderSide(
                        //             width: 1,
                        //             color: Colors.grey,
                        //           ),
                        //         ),
                        //       ),
                        //       child: GestureDetector(
                        //         onTap: _getImagesFromGallery,
                        //         child: Row(
                        //           children: [
                        //             Padding(
                        //               padding: const EdgeInsets.all(12.0),
                        //               child: Icon(
                        //                 Icons.camera_alt_outlined,
                        //                 size: 30,
                        //                 color: Colors.blue,
                        //               ),
                        //             ),
                        //             Text("Camera"),
                        //           ],
                        //         ),
                        //       ),
                        //     ),
                        //   ],
                        // ),
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
