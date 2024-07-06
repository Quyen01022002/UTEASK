import 'dart:async';

import 'package:askute/controller/HomeController.dart';
import 'package:askute/controller/HomeGroupController.dart';
import 'package:askute/controller/LoginController.dart';
import 'package:askute/controller/PostController.dart';
import 'package:askute/view/Home/new%20home/home_screen_3.dart';
import 'package:askute/view/report/report_post_screen2.dart';
import 'package:askute/view/user/user_proflie_other.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../controller/MyProfileController.dart';
import '../../model/PostModel.dart';
import '../Quetions/QuestionDetail.dart';
import '../user/user_proflie_screen.dart';

class PostScreenNew extends StatefulWidget {
  //const PostScreen({super.key});
  final PostModel post;
  const PostScreenNew({Key? key, required this.post}) : super(key: key);
  @override
  State<PostScreenNew> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreenNew> {
  late String formattedTime = '';
  final PostController postController = Get.put(PostController());
  final HomeController homeController = Get.put(HomeController());
  final HomeGroupController homeGroupController = Get.put(HomeGroupController());
  MyProfileController myProfileController = Get.put(MyProfileController());
  LoginController loginController = Get.put(LoginController());
  late bool statelike=false;
  late int contlike=0;
  late RxInt curnetUser=0.obs;
  Stream<PostModel>? postCurren;
  PostModel? postHT;
  @override
  void initState() {
    super.initState();
    _startTimer();
    postHT = widget.post;
    statelike = postHT!.user_liked;
    contlike=postHT!.like_count;
    formattedTime = formatTimeDifference(postHT!.timeStamp);
  }
  void fetchDate() async{
    final postUpdate = await postController.loadAPost(context, widget.post.id);
    postCurren = Stream.fromIterable([postUpdate!]);
  }

  late Timer _timer;
  void _startTimer(){
    _timer = Timer.periodic(Duration(milliseconds: 500), (timer) {
      fetchDate();
      postCurren?.listen((PostModel? postModel) {
        setState(() {
          postHT = postModel;
        });
      });

    });

  }
  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void initCurrentUser() async {
    final prefs = await SharedPreferences.getInstance();
    curnetUser = (prefs.getInt('id') ?? 0).obs;
  }
  @override
  Widget build(BuildContext context) {

        return Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
                child: GestureDetector(
                  onTap: ()
                  {
                    if (loginController.idMe.value != postHT!.createBy?.id){
                      myProfileController.ortherId.value = postHT!.createBy!.id;
                      Navigator.push(
                        context,
                        PageTransition(
                          type: PageTransitionType.rightToLeft,
                          child: ProfileUserOther(id: postHT!.createBy!.id,),
                        ),
                      );}
                    else
                      Navigator.push(
                        context,
                        PageTransition(
                          type: PageTransitionType.rightToLeft,
                          child: ProfileUserScreen(id: postHT!.createBy!.id,),
                        ),
                      );
                  },
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: (){
                          if (loginController.idMe.value != postHT!.createBy?.id){
                            myProfileController.ortherId.value = postHT!.createBy!.id;
                            Navigator.push(
                              context,
                              PageTransition(
                                type: PageTransitionType.rightToLeft,
                                child: ProfileUserOther(id: postHT!.createBy!.id,),
                              ),
                            );}
                          else
                            Navigator.push(
                              context,
                              PageTransition(
                                type: PageTransitionType.rightToLeft,
                                child: ProfileUserScreen(id: postHT!.createBy!.id,),
                              ),
                            );
                        },
                        child: CircleAvatar(
                          radius: 20,
                          backgroundImage:
                          NetworkImage(postHT!.createBy!.profilePicture),
                          // Hoặc sử dụng NetworkImage nếu avatar từ một URL
                          // backgroundImage: NetworkImage('URL_TO_AVATAR'),
                        ),
                      ),
                      SizedBox(width: 8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: (){

                            },
                            child: Row(
                              children: [
                                Text(
                                  postHT!.createBy!.firstName+" " + postHT!.createBy!.lastName,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),

                                Text(
                                  " đã đăng ${formattedTime}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.black45,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          Text(
                            postHT!.name_group,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.black45,
                            ),
                          ),                              ],
                      ),

                      Spacer(),
                      PopupMenuButton<String>(
                        icon: Icon(Icons.more_vert),
                        onSelected: (String value) async {
                          if (value == 'Truy cập Khoa') {
                            final group = await homeGroupController.GetGroup(context, postHT!.groupid);
                            Navigator.push(
                              context,
                              PageTransition(
                                type: PageTransitionType.rightToLeft,
                                child: HomeGroup(groupModel: group,),
                              ),
                            );
                          } else if (value == 'Báo cáo') {
                            // Hành động khi chọn "Báo cáo"
                            Navigator.push(
                              context,
                              PageTransition(
                                type: PageTransitionType.rightToLeft,
                                child: ReportPost(post: postHT!),
                              ),
                            );
                          }
                        },
                        itemBuilder: (BuildContext context) {
                          return {'Truy cập Khoa', 'Báo cáo'}.map((String choice) {
                            return PopupMenuItem<String>(
                              value: choice,
                              child: Text(choice),
                            );
                          }).toList();
                        },
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 15, right: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 8),
                    GestureDetector(
                      onTap: () {
                       postController.loadOnePost(context, postHT!.id);
                        // Thực hiện hành động khi người dùng nhấn vào văn bản
                       Navigator.push(
                         context,
                         PageTransition(
                           type: PageTransitionType.rightToLeft,
                           child: QuestionDetailScreen(post: postHT!, checkUserReply: 0,),
                         ),
                       );
                      },
                      child: Container(
                        padding: EdgeInsets.only(left: 5),

                        child: Text(
                          postHT!.contentPost,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 10),
                    _buildImages(postHT!.listAnh!),

                    SizedBox(height: 10),

                  ],
                ),
              ),
              Container(
                alignment: Alignment.center,
                child: Container(
                  margin: EdgeInsets.only(top: 5),
                  height: 0.5, // Chiều cao của thanh ngang
                  width: 330, // Độ dày của thanh ngang
                  color: Color(0xC0C0C0C0),
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 5, left: 30, right: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            // setState(() {
                            //   statelike?contlike=contlike-1:contlike=contlike+1;
                            //   statelike = !statelike;
                            // });
                            // postController.postid.value = postHT!.id;
                            // postController.Like();
                            // print("Like");
                            postController.Like(postHT!.id);
                            print("đã bấm nút like");

                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                            child: Row(
                                children: [
                                  Icon(postHT!.user_liked ? Icons.thumb_up : Icons.thumb_up_outlined, size: 20,
                                    color: postHT!.user_liked ? Colors.blue : Colors.black,),
                                  SizedBox(width: 2,),Text(postHT!.like_count.toString(),
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold
                                    ),),
                                ]),
                          ),
                        ),

                      ],
                    ),
                    Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            postController.loadOnePost(context, postHT!.id);
                            // Thực hiện hành động khi người dùng nhấn vào văn bản
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => QuestionDetailScreen(post: postHT!, checkUserReply: 0)),
                            );
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                            child: Row(
                                children: [
                                  Icon(Icons.mode_comment_outlined, size: 20,),
                                  SizedBox(width: 2,),Text(postHT!.comment_count.toString(),
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold
                                    ),),
                                ]),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        GestureDetector(
                          onTap: () {

                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                            child: GestureDetector(
                              onTap: ()
                              {
                                homeController.postid.value = postHT!.id;
                                homeController.Saved();
                              },
                              child: Row(
                                  children: [
                                    Icon(postHT!.user_saved ? Icons.bookmark_outline : Icons.bookmark_outline, size: 20,
                                      color: postHT!.user_saved ? Colors.blue : Colors.black,),
                                    SizedBox(width: 2,),Text(postHT!.save_count.toString(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold
                                      ),),
                                  ]),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
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
      width: MediaQuery.of(context).size.width * 1,
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
    //nếu list ảnh có 4 hình ảnh trở lên
    return Container(

      child: Container(
        height: (MediaQuery.of(context).size.width -30)*1.028,
        width: (MediaQuery.of(context).size.width - 30),
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
                    width: (MediaQuery.of(context).size.width-30) * 0.5 * 0.89,
                    height: (MediaQuery.of(context).size.height-30) * 0.99,
                    child: _buildFirstImage(imageUrls[0]))),
            Container(
              height: (MediaQuery.of(context).size.height-30),
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
      ),
    );
  }
  Widget _buildFourImages(List<String> imageUrls) {
    //nếu list ảnh có 4 hình ảnh trở lên
    return Container(

      child: Container(
        height: (MediaQuery.of(context).size.width -30)*1.028,
        width: (MediaQuery.of(context).size.width - 30),
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
                    width: (MediaQuery.of(context).size.width-30) * 0.5 * 0.99,
                    height: (MediaQuery.of(context).size.height-30) * 0.99,
                    child: _buildFirstImage(imageUrls[0]))),
            Container(
              height: (MediaQuery.of(context).size.height-30),
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
                          (MediaQuery.of(context).size.height -30) * 0.25 * 0.99,
                          width: (MediaQuery.of(context).size.width -30) * 0.5 * 0.99,
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
      ),
    );
  }

  Widget _buildFirstImage(String imageUrl) {
    //xây dựng khung ảnh đầu tiên của bộ đôi, bộ ba ảnh
    return Image.network(
      imageUrl,
      width: (MediaQuery.of(context).size.width-30) * 0.985 * 0.5,
      height: (MediaQuery.of(context).size.height-30) * 0.99,
      fit: BoxFit.cover,
    );
  }

  Widget _buildSecondImage(String imageUrl) {
    //xây dựng khung ảnh thứ 2,3 của bộ ba ảnh trở lên
    return Image.network(
      imageUrl,
      width: (MediaQuery.of(context).size.width -30) * 0.5 * 0.99,
      height: (MediaQuery.of(context).size.height -30) * 0.25 * 0.99,
      fit: BoxFit.cover,
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
String formatTimeDifference(String timeStamp) {
  DateTime dateTime = DateTime.parse(timeStamp);
  DateTime now = DateTime.now();
  Duration difference = now.difference(dateTime);

  if (difference.inDays > 30) {
    return DateFormat('dd/MM/yyyy').format(dateTime);
  } else if (difference.inDays >= 1) {
    return '${difference.inDays} ngày trước';
  } else if (difference.inHours > 0) {
    if (difference.inMinutes > 0) {
      return '${difference.inHours} giờ';
    } else {
      return '${difference.inHours} giờ trước';
    }
  } else if (difference.inMinutes > 0) {
    return '${difference.inMinutes} phút trước';
  } else {
    return "Bây giờ";
  }
}