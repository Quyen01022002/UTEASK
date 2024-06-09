import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:askute/controller/LoginController.dart';
import 'package:askute/model/CommentEntity.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../controller/PostController.dart';
import '../../model/PostModel.dart';
import 'package:http/http.dart' as http;

import '../../service/SendMessage.dart';

class QuestionDetailScreen extends StatefulWidget {
  final PostModel post;

  const QuestionDetailScreen({Key? key, required this.post}) : super(key: key);

  @override
  State<QuestionDetailScreen> createState() => _QuestionDetailScreenState();
}

class ContentComment {
  final String type;
  final String content;

  ContentComment(this.type, this.content);
}

class _QuestionDetailScreenState extends State<QuestionDetailScreen> {
  List<String> imageUrls1 = [
    'https://i.pinimg.com/564x/1b/75/0a/1b750a6aa0f7e26b690ca2b5a0b7960d.jpg',
    'https://i.pinimg.com/736x/24/b7/7a/24b77a1dea1d8bf37163052828f97310.jpg',
    'https://i.pinimg.com/564x/fa/e9/3d/fae93d5d8bc6062038bb01dc243fde5d.jpg',
    'https://i.pinimg.com/564x/83/9f/ca/839fca5eb345e0a4024e961e9b52fa81.jpg',
    'https://i.pinimg.com/564x/c6/ed/e9/c6ede95f6d1aae1937703a39b8e3148d.jpg'
  ];
  List<String> imageUrls2 = [
    'https://i.pinimg.com/564x/1b/75/0a/1b750a6aa0f7e26b690ca2b5a0b7960d.jpg',
    'https://i.pinimg.com/736x/24/b7/7a/24b77a1dea1d8bf37163052828f97310.jpg',
  ];

  final PostController postController = Get.put(PostController());
  final LoginController loginController = Get.put(LoginController());
  Offset _tapPosition = Offset.zero;
  Stream<PostModel>? postCurrent;
  Stream<List<CommentEntity>>? listCommentStream;
  List<CommentEntity>? listCmt = [];
  PostModel? post;
  bool _isKeyboardVisible = false;
  int cmtIsSelect = 0;

  @override
  void initState() {
    super.initState();
    _startTimer();
    _listController.add(_textFirst);
    _imageWidgets.add(_buildFirstTextFieldWidget());
    _initKeyboardListener();
  }

  List<ContentComment> parseContent(String contentString) {
    List<String> parts = contentString.split(', ');
    List<ContentComment> contentList = [];
    for (String part in parts) {
      List<String> pair = part.split('][');
      if (pair.length == 2) {
        String type = pair[0].replaceAll('[', '');
        String content = pair[1].replaceAll(']', '');
        contentList.add(ContentComment(type, content));
      }
    }

    return contentList;
  }

  late Timer _timer;

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      // Gọi hàm cần thiết ở đây
      postController.loadOnePost(context, widget.post.id);
      postCurrent =
          postController.postState; // Đây là Stream mà bạn cần theo dõi
      // Cập nhật danh sách nhóm khi Stream thay đổi
      postCurrent?.listen((PostModel? currentGroup) {
        if (currentGroup != null) {
          setState(() {
            post = currentGroup;
          });
        }
      });

      listCommentStream = postController.listCommentStream;
      listCommentStream?.listen((List<CommentEntity>? list) {
        if (list != null) {
          setState(() {
            listCmt = list;
          });
        }
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _disposeKeyboardListener();
    super.dispose();
  }

  void _initKeyboardListener() {
    WidgetsBinding.instance!.addPostFrameCallback(_keyboardVisibilityObserver);
  }

  void _disposeKeyboardListener() {
    // No need to dispose the observer
  }

  void _keyboardVisibilityObserver(Duration timeStamp) {
    final bool isKeyboardVisible = MediaQuery.of(context).viewInsets.bottom > 0;
    setState(() {
      _isKeyboardVisible = isKeyboardVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: CustomScrollView(
                  slivers: <Widget>[
                    SliverAppBar(
                      title: Text('Bài thảo luận của Duy Hào'),
                    ),
                    SliverToBoxAdapter(
                      child: StreamBuilder<PostModel>(
                          stream: postCurrent,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _buildOwnerUser(),
                                  _buildContent(),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    child: Container(
                                      margin: EdgeInsets.only(top: 5),
                                      height: 0.5,
                                      // Chiều cao của thanh ngang
                                      width: 330,
                                      // Độ dày của thanh ngang
                                      color: Color(0xC0C0C0C0),
                                    ),
                                  ),
                                  Container(
                                    margin:
                                        EdgeInsets.only(top: 10, bottom: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Column(
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                // setState(() {
                                                //   statelike?contlike=contlike-1:contlike=contlike+1;
                                                //   statelike = !statelike;
                                                // });
                                                // postController.postid.value = widget.post.id;
                                                // postController.Like();
                                                // print("Like");
                                                postController.Like(
                                                    postController
                                                        .postid.value);
                                                print("đã bấm nút like");
                                              },
                                              child: Container(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 8,
                                                    horizontal: 12),
                                                child: Row(children: [
                                                  Icon(
                                                    snapshot.data!.user_liked
                                                        ? Icons.thumb_up
                                                        : Icons
                                                            .thumb_up_outlined,
                                                    size: 20,
                                                    color: snapshot
                                                            .data!.user_liked
                                                        ? Colors.blue
                                                        : Colors.black,
                                                  ),
                                                  SizedBox(
                                                    width: 2,
                                                  ),
                                                  Text(
                                                    snapshot.data!.like_count
                                                        .toString(),
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ]),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            GestureDetector(
                                              onTap: () {},
                                              child: Container(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 8,
                                                    horizontal: 12),
                                                child: GestureDetector(
                                                  onTap: () {},
                                                  child: Row(children: [
                                                    Icon(
                                                        false
                                                            ? Icons
                                                                .bookmark_outline
                                                            : Icons
                                                                .bookmark_border_outlined,
                                                        size: 20,
                                                        color: false
                                                            ? Colors.blue
                                                            : Colors.black),
                                                    SizedBox(
                                                      width: 2,
                                                    ),
                                                    Text(
                                                      0.toString(),
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ]),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 20),
                                    height: 5, // Chiều cao của thanh ngang
                                    width: 400, // Độ dày của thanh ngang
                                    color: Color(0xC0C0C0C0),
                                  ),
                                ],
                              );
                            } else {
                              return Container();
                            }
                          }),
                    ),
                    SliverFillRemaining(
                      hasScrollBody: true,
                      child: _buildComment(),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 100,
              )
            ],
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: _isKeyboardVisible
                ? MediaQuery.of(context).viewInsets.bottom
                : 0,
            child: _buildInputAllField(),
          ),
        ],
      ),
    ));
  }

  List<Widget> _contentWidgets = [];
  List<Widget> _imageWidgets = [];
  TextEditingController _textFirst = TextEditingController();
  List<TextEditingController> _listController = [];
  final List<ContentComment> listContent = [];

  Future<void> _goToListTypeContentComment() async {
    for (int i = 0; i < _imageWidgets.length; i++) {
      if (_imageWidgets[i] is TextField) {
        TextField textField1 = _imageWidgets[i] as TextField;
        ContentComment a =
            ContentComment('TEXT', '${textField1.controller!.text}');
        listContent.add(a);
      } else if (_imageWidgets[i] is Stack) {
        Stack stack = _imageWidgets[i] as Stack;
        for (var child in stack.children) {
          if (child is Image) {
            final pic = child.image as FileImage;
            String link = await _uploadImages(pic.file.path);
            ContentComment a = ContentComment('IMAGE', '$link');
            listContent.add(a);
          }
        }
      }
    }
  }

  Future<String> _uploadImages(String imagePath) async {
    var url =
        Uri.parse('https://api.cloudinary.com/v1_1/dq21kejpj/image/upload');

    var request = http.MultipartRequest('POST', url);
    request.fields['upload_preset'] = 'q8pgyal8';
    request.files.add(
      await http.MultipartFile.fromPath('file', imagePath),
    );

    try {
      final response = await request.send();

      if (response.statusCode == 200) {
        final responseData = await response.stream.toBytes();
        final responseString = String.fromCharCodes(responseData);
        final jsonMap = jsonDecode(responseString);
        final imageUrl = jsonMap['url'];
        print('Image URL: $imageUrl');
        return imageUrl.toString();
        //myController.imagePath.value = imageUrl;
      } else {
        print('Failed to upload image. Status code: ${response.statusCode}');
        return '';
      }
    } catch (error) {
      print('Error uploading image: $error');
      return '';
    }
  }

  Widget _buildInputAllField() {
    return Container(
      color: Colors.grey[200],
      padding: EdgeInsets.all(8),
      child: Row(
        children: [
          GestureDetector(
            onTap: _pickImage,
            child: Icon(Icons.image),
          ),
          SizedBox(width: 8),
          Expanded(
            child: Container(
              constraints: BoxConstraints(maxHeight: 200),
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                border: Border.all(),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // TextField(
                    //   controller: _textFirst,
                    //   decoration: InputDecoration(
                    //     hintText: 'Nhập nội dung của bạn...',
                    //     border: InputBorder.none,
                    //   ),
                    // ),
                    // SizedBox(height: 8),
                    // ..._imageWidgets,
                    ..._imageWidgets,
                  ],
                ),
              ),
            ),
          ),
          SizedBox(width: 8),
          ElevatedButton(
            onPressed: () async {
              // Xử lý nút gửi bình luận
              await _goToListTypeContentComment();
              postController.CommentToQuestion(context, listContent);
              _imageWidgets.clear();
              listContent.clear();
              _listController.clear();
              TextEditingController _textFirsts = TextEditingController();
              _listController.add(_textFirsts);
              _imageWidgets.add(_buildFirstTextFieldWidget());
              setState(() {
                _imageWidgets;
              });
            },
            child: Text('Đăng'),
          ),
        ],
      ),
    );
  }

  final textController = TextEditingController();

  void _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageWidgets.add(_buildImageWidget(File(pickedFile.path)));
        final nextTextController = TextEditingController();
        _listController.add(nextTextController);
        _imageWidgets.add(_buildTextFieldWidget(_listController.length - 1));
      });
    }
  }

  Widget _buildImageWidget(File imageFile) {
    return Stack(
      children: [
        Image.file(imageFile),
        Positioned(
          top: 5,
          right: 5,
          child: GestureDetector(
            onTap: () {
              setState(() {
                print('Đã bấm nút xóa');
                final a = Image.file(imageFile);
                _imageWidgets.removeWhere((widget) {
                  if (widget is Stack) {
                    for (var child in widget.children) {
                      if (child is Image &&
                          child.image == FileImage(imageFile)) {
                        return true;
                      }
                    }
                  }
                  return false;
                });
                _mergeAdjacentTextFields();
              });
            },
            child: Icon(Icons.delete),
          ),
        ),
      ],
    );
  }

  Widget _buildTextFieldWidget(index) {
    return TextField(
      controller: _listController[index],
      decoration: InputDecoration(
        hintText: 'Nhập nội dung của bạn...',
        border: InputBorder.none,
      ),
    );
  }

  Widget _buildFirstTextFieldWidget() {
    return TextField(
      controller: _listController[0],
      decoration: InputDecoration(
        hintText: 'Nhập nội dung của bạn...',
        border: InputBorder.none,
      ),
    );
  }

  void _mergeAdjacentTextFields() {
    List<Widget> mergedWidgets = [];
    String mergedText = '';

    for (int i = 0; i < _imageWidgets.length; i++) {
      if (_imageWidgets[i] is TextField &&
          i + 1 < _imageWidgets.length &&
          _imageWidgets[i + 1] is TextField) {
        TextField textField1 = _imageWidgets[i] as TextField;
        TextField textField2 = _imageWidgets[i + 1] as TextField;
        mergedText =
            '${textField1.controller!.text} ${textField2.controller!.text}';
        mergedWidgets.add(
          TextField(
            controller: TextEditingController(text: mergedText),
            decoration: InputDecoration(
              hintText: 'Nhập nội dung của bạn...',
              border: InputBorder.none,
            ),
          ),
        );
        i++; // Bỏ qua widget thứ hai vì đã được gộp
      } else {
        mergedWidgets.add(_imageWidgets[i]);
      }
    }

    setState(() {
      _imageWidgets = mergedWidgets;
    });
  }

  Widget _buildContent() {
    return Container(
      padding: EdgeInsets.only(top: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.post.contentPost,
            style: TextStyle(
              fontSize: 18,
            ),
          ),
          _buildImages(widget.post.listAnh),
        ],
      ),
    );
  }

  Widget _buildIInteraction(
      bool user_liked, int like_count, bool user_saved, int save_count) {
    return Container(
      margin: EdgeInsets.only(top: 10, bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            children: [
              GestureDetector(
                onTap: () {
                  // setState(() {
                  //   statelike?contlike=contlike-1:contlike=contlike+1;
                  //   statelike = !statelike;
                  // });
                  // postController.postid.value = widget.post.id;
                  // postController.Like();
                  // print("Like");
                  postController.Like(postController.postid.value);
                  print("đã bấm nút like");
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                  child: Row(children: [
                    Icon(
                      user_liked ? Icons.thumb_up : Icons.thumb_up_outlined,
                      size: 20,
                      color: user_liked ? Colors.blue : Colors.black,
                    ),
                    SizedBox(
                      width: 2,
                    ),
                    Text(
                      like_count.toString(),
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ]),
                ),
              ),
            ],
          ),
          Column(
            children: [
              GestureDetector(
                onTap: () {},
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                  child: GestureDetector(
                    onTap: () {},
                    child: Row(children: [
                      Icon(
                          user_saved
                              ? Icons.bookmark_outline
                              : Icons.bookmark_border_outlined,
                          size: 20,
                          color: user_saved ? Colors.blue : Colors.black),
                      SizedBox(
                        width: 2,
                      ),
                      Text(
                        save_count.toString(),
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ]),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOwnerUser() {
    return Container(
      padding: EdgeInsets.only(left: 10),
      alignment: Alignment.center,
      child: Center(
        child: Row(
          children: [
            CircleAvatar(
              radius: 25,
              backgroundImage:
                  NetworkImage(widget.post.createBy.profilePicture),
              // Hoặc sử dụng NetworkImage nếu avatar từ một URL
              // backgroundImage: NetworkImage('URL_TO_AVATAR'),
            ),
            SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 10,
                ),
                Text(
                  widget.post.createBy.firstName +
                      ' ' +
                      widget.post.createBy.lastName,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'cách đây 2 phút',
                  style: TextStyle(
                    fontSize: 10,
                    color: Color(0xFFCECECE),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildComment() {
    return StreamBuilder<List<CommentEntity>>(
        stream: listCommentStream,
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  List<ContentComment> content =
                      parseContent(snapshot.data![index].content_cmt!);
                  List<Widget> contentWg = [];
                  for (int i = 0; i < content.length; i++) {
                    if (content[i].type == 'TEXT') {
                      contentWg.add(_buiText(content[i].content));
                    } else if (content[i].type == 'IMAGE') {
                      contentWg.add(_buiImage(content[i].content));
                    }
                  }
                  if (snapshot.data![index].is_reply == false)
                    return _buildOneComment(snapshot.data![index], contentWg);
                  else
                    return _buildOneCommentReply(
                        snapshot.data![index], contentWg);
                });
          } else {
            return Container();
          }
        });
  }

  Widget _buiText(String ct) {
    return Text(ct);
  }

  Widget _buiImage(String link) {
    return Container(
        child: GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => ImageDetailOne(anh: link),
              ));
            },
            child: Image.network(link)));
  }

  Widget _buildOneComment(CommentEntity cmt, List<Widget> contentWidget) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10), // Đặt bán kính của viền tròn
        border: Border.all(
          color: Colors.black, // Màu sắc của viền tròn
          width: 0.1, // Độ dày của viền tròn
        ),
      ),
      padding: EdgeInsets.all(5),
      margin: EdgeInsets.all(5.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildUserComment(cmt),
          SizedBox(
            height: 10,
          ),
          GestureDetector(
            onTapDown: _getTapPosition,
            onLongPress: () {
              cmtIsSelect = cmt.comment_id!;
              _showContextMenu(context, cmt);
            },
            child: Container(
                padding: EdgeInsets.only(left: 38, right: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ...contentWidget,
                  ],
                )),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Expanded(
                flex: 8,
                child: Row(
                  children: [
                    SizedBox(
                      width: 38,
                    ),
                    Icon(Icons.reply_outlined, size: 15),
                    SizedBox(
                      width: 20,
                    ),
                    Icon(Icons.thumb_up_outlined, size: 15),
                    SizedBox(
                      width: 20,
                    ),
                    Icon(Icons.thumb_down_outlined, size: 15),
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child: Icon(Icons.bookmarks_outlined, size: 15),
              ),
            ],
          )
        ],
      ),
    );
  }

  void _showContextMenu(BuildContext context, CommentEntity cmt) async {
    final RenderBox overlay =
        Overlay.of(context).context.findRenderObject() as RenderBox;
if (loginController.role.value == "RoleEnum.HEADDEPARTMENT"){
    print(loginController.role.value);}
else
  print("oooooooo");
    showMenu(
      context: context,
      position: RelativeRect.fromRect(
        _tapPosition & Size(40, 40), // smaller rect, the touch area
        Offset.zero & overlay.size, // larger rect, the entire screen
      ),
      items: (loginController.role.value == "RoleEnum.TEACHER" || loginController.role.value == "RoleEnum.HEADDEPARTMENT") && loginController.idMe.value == cmt.user_id! ?
      [
        cmt.is_reply==false ?
        PopupMenuItem<int>(
          value: 1,
          child: Text('Đánh dấu là câu trả lời đúng'),
        ) : PopupMenuItem<int>(
          value: 3,
          child: Text('Không phải câu trả lời đúng'),
        ),
        PopupMenuItem<int>(
          value: 2,
          child: Text('Xóa câu trả lời'),
        ),
      ]:
        (loginController.role.value == "RoleEnum.TEACHER" || loginController.role.value == "RoleEnum.HEADDEPARTMENT") && loginController.idMe.value != cmt.user_id! ?
    [
      cmt.is_reply==false ?
      PopupMenuItem<int>(
        value: 1,
        child: Text('Đánh dấu là câu trả lời đúng'),
      ) : PopupMenuItem<int>(
        value: 3,
        child: Text('Không phải câu trả lời đúng'),
      ),
    ]

            :
         loginController.idMe.value == widget.post.createBy.id ?
        [
          cmt.is_reply==false ?
          PopupMenuItem<int>(
            value: 1,
            child: Text('Đánh dấu là câu trả lời đúng'),
          ) : PopupMenuItem<int>(
            value: 3,
            child: Text('Không phải câu trả lời đúng'),
          ),
          PopupMenuItem<int>(
            value: 2,
            child: Text('Xóa câu trả lời'),
          ),
        ]: loginController.idMe.value == cmt.user_id!
          ? [

              PopupMenuItem<int>(
                value: 2,
                child: Text('Xóa câu trả lời'),
              ),
            ]
          : [
              // PopupMenuItem<int>(
              //   value: 1,
              //   child: Text('Xóa câu trả lời'),
              // ),
            ],
      elevation: 8.0,
    ).then((value) {
      if (value != null) {
        _onMenuItemSelected(int.parse(value.toString()), cmtIsSelect);
      }
    });
  }

  void _onMenuItemSelected(int value, int cmtid) {
    // Handle the menu item selection here
    switch (value) {
      case 1:
        {
          postController.setAnswer(context, cmtid);
          print('1111111');
          cmtIsSelect = 0;
        break;}
      case 2:
        {
print('22222222');
      postController.deleteCmt(context, cmtid);
        break;}
      case 3:
        {
          postController.setAnswerToCmt(BuildContext, cmtid);
          break;
        }
    }
  }

  void _getTapPosition(TapDownDetails details) {
    final RenderBox referenceBox = context.findRenderObject() as RenderBox;
    setState(() {
      _tapPosition = referenceBox.globalToLocal(details.globalPosition);
    });
  }

  Widget _buildOneCommentReply(CommentEntity cmt, List<Widget> contentWidget) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.green[50],
        borderRadius: BorderRadius.circular(10), // Đặt bán kính của viền tròn
        border: Border.all(
          color: Colors.green, // Màu sắc của viền tròn
          width: 1, // Độ dày của viền tròn
        ),
      ),
      padding: EdgeInsets.all(5),
      margin: EdgeInsets.all(5.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildUserComment(cmt),
          SizedBox(
            height: 10,
          ),
          GestureDetector(
            onTapDown: _getTapPosition,
            onLongPress: () {
              cmtIsSelect = cmt.comment_id!;
              _showContextMenu(context, cmt);
            },
            child: Container(
                padding: EdgeInsets.only(left: 38, right: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ...contentWidget,
                  ],
                )),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Expanded(
                flex: 8,
                child: Row(
                  children: [
                    SizedBox(
                      width: 38,
                    ),
                    Icon(Icons.reply_outlined, size: 15),
                    SizedBox(
                      width: 20,
                    ),
                    Icon(Icons.thumb_up_outlined, size: 15),
                    SizedBox(
                      width: 20,
                    ),
                    Icon(Icons.thumb_down_outlined, size: 15),
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child: Icon(Icons.bookmarks_outlined, size: 15),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildUserComment(CommentEntity cmt) {
    return Container(
      child: Row(
        children: [
          CircleAvatar(
            radius: 15,
            backgroundImage: NetworkImage(cmt.avatar!),
            // Hoặc sử dụng NetworkImage nếu avatar từ một URL
            // backgroundImage: NetworkImage('URL_TO_AVATAR'),
          ),
          SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                cmt.first_name! + ' ' + cmt.last_name!,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                cmt.timestamp.toString(),
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.black45,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildImages(List<String> images) {
    int imageCount = images.length;

    if (imageCount == 1) {
      return _buildSingleImage(images);
    } else if (imageCount == 2) {
      return _buildTwoImages(images);
    } else if (imageCount == 3) {
      return _buildThreeImages(images);
    } else if (imageCount == 0) {
      return Container();
    } else {
      // Xử lý cho trường hợp có nhiều hơn 3 ảnh
      return _buildFourImages(
          images); // Thay bằng xử lý tùy thuộc vào số lượng ảnh cần hiển thị
    }
  }

  Widget _buildSingleImage(List<String> list) {
    //Nếu list ảnh chỉ có một hình ảnh
    return Container(
      height: MediaQuery.of(context).size.width * 0.99,
      width: MediaQuery.of(context).size.width * 0.99,
      child: GestureDetector(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => ImageDetail(
                index: 0,
                listAnh: list,
              ),
            ));
          },
          child: _buildFirstImage(list[0])),
    );
  }

  Widget _buildTwoImages(List<String> imageUrls) {
    //nếu list ảnh có 2 hình ảnh
    return Container(
      height: MediaQuery.of(context).size.width * 0.99,
      width: MediaQuery.of(context).size.width * 0.99,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ImageDetail(
                    index: 0,
                    listAnh: imageUrls,
                  ),
                ));
              },
              child: _buildFirstImage(imageUrls[0])),
          GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ImageDetail(
                    index: 0,
                    listAnh: imageUrls,
                  ),
                ));
              },
              child: _buildFirstImage(imageUrls[1])),
        ],
      ),
    );
  }

  Widget _buildThreeImages(List<String> imageUrls) {
    // nếu list ảnh có 3 hình ảnh
    return Container(
      height: MediaQuery.of(context).size.width * 0.985,
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ImageDetail(
                    index: 0,
                    listAnh: imageUrls,
                  ),
                ));
              },
              child: Container(
                  width: MediaQuery.of(context).size.width * 0.5 * 0.99,
                  height: MediaQuery.of(context).size.height * 0.99,
                  child: _buildFirstImage(imageUrls[0]))),
          Container(
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ImageDetail(
                          index: 1,
                          listAnh: imageUrls,
                        ),
                      ));
                    },
                    child: _buildSecondImage(imageUrls[1])),
                GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ImageDetail(
                          index: 2,
                          listAnh: imageUrls,
                        ),
                      ));
                    },
                    child: _buildSecondImage(imageUrls[2])),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFourImages(List<String> imageUrls) {
    //nếu list ảnh có 4 hình ảnh trở lên
    return Container(
      height: MediaQuery.of(context).size.width * 0.985,
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ImageDetail(
                    index: 0,
                    listAnh: imageUrls,
                  ),
                ));
              },
              child: Container(
                  width: MediaQuery.of(context).size.width * 0.5 * 0.99,
                  height: MediaQuery.of(context).size.height * 0.99,
                  child: _buildFirstImage(imageUrls[0]))),
          Container(
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ImageDetail(
                          index: 1,
                          listAnh: imageUrls,
                        ),
                      ));
                    },
                    child: _buildSecondImage(imageUrls[1])),
                Stack(
                  children: [
                    _buildSecondImage(imageUrls[2]),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ImageDetail(
                            index: 2,
                            listAnh: imageUrls,
                          ),
                        ));
                      },
                      child: Container(
                        height:
                            MediaQuery.of(context).size.height * 0.25 * 0.99,
                        width: MediaQuery.of(context).size.width * 0.5 * 0.99,
                        color: Colors.black
                            .withOpacity(0.5), // Độ mờ ở đây, giả sử 0.5
                      ),
                    ),
                    Positioned.fill(
                      child: Center(
                        child: Text(
                          '+' + (imageUrls.length - 2).toString(),
                          style: TextStyle(
                            fontSize: 30,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFirstImage(String imageUrl) {
    //xây dựng khung ảnh đầu tiên của bộ đôi, bộ ba ảnh
    return Image.network(
      imageUrl,
      width: MediaQuery.of(context).size.width * 0.985 * 0.5,
      height: MediaQuery.of(context).size.height * 0.99,
      fit: BoxFit.cover,
    );
  }

  Widget _buildSecondImage(String imageUrl) {
    //xây dựng khung ảnh thứ 2,3 của bộ ba ảnh trở lên
    return Image.network(
      imageUrl,
      width: MediaQuery.of(context).size.width * 0.5 * 0.99,
      height: MediaQuery.of(context).size.height * 0.25 * 0.99,
      fit: BoxFit.cover,
    );
  }

  Widget _buildInputField() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              //controller: messageBoxController.textControllerMess,
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.add_to_photos_rounded,
                  color: Color(0xFF6A9EF5),
                ), // Thêm biểu tượng ở đây
                hintText: 'Type a message...',
              ),
            ),
          ),
          IconButton(
            icon: Icon(
              Icons.send,
              color: Color(0xFF6A9EF5),
            ),
            onPressed: () {
              //_sendMessage();
            },
          ),
        ],
      ),
    );
  }
}

class ImageDetail extends StatelessWidget {
  //Phóng to ảnh
  final int index;
  final List<String> listAnh;

  ImageDetail({required this.index, required this.listAnh});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: PageView.builder(
          itemCount: listAnh.length,
          controller: PageController(initialPage: index),
          itemBuilder: (context, pageIndex) {
            return Hero(
              tag: pageIndex.toString(),
              child: Image.network(
                listAnh[pageIndex], // Thay thế URL hình ảnh của bạn
                fit: BoxFit.contain,
              ),
            );
          },
        ),
      ),
    );
  }
}

class ImageDetailOne extends StatelessWidget {
  //Phóng to ảnh
  final String anh;

  ImageDetailOne({required this.anh});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Hero(
        tag: '',
        child: Image.network(
          anh.toString(), // Thay thế URL hình ảnh của bạn
          fit: BoxFit.contain,
        ),
      )),
    );
  }
}
