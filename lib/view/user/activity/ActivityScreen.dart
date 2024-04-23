import 'package:askute/controller/MyActivityController.dart';
import 'package:askute/model/CommentEntity.dart';
import 'package:askute/model/CommentResponse.dart';
import 'package:askute/model/InteractionsResponse.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../Quetions/QuestionDetail.dart';

class ActivityScreen extends StatefulWidget {
  const ActivityScreen({super.key});

  @override
  State<ActivityScreen> createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen>
    with SingleTickerProviderStateMixin {
  ScrollController _scrollController = ScrollController();
  final MyActivityController myActivityController = Get.put(MyActivityController());
  late TabController _tabController;
  List<List<int>> twoDimArray = [
    [1, 0, 3,0],       // Mảng con đầu tiên có 3 phần tử
    [4, 0],          // Mảng con thứ hai có 2 phần tử
    [6, 7, 8, 9],    // Mảng con thứ ba có 4 phần tử
  ];
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this, initialIndex: 0);
    myActivityController.loadAllComment(context);
    myActivityController.loadAllMyLike(context);
    int i =0;
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
  String getCommentStart(String contentComment){
    List<ContentComment> content = parseContent(contentComment);
    for (int i= 0; i<content.length; i++){
      if(content[i].content!='' && content[i].type=='TEXT')
        {
          return content[i].content;
        }
    }
    return '';
  }
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: NestedScrollView(
            controller: _scrollController,
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                SliverAppBar(
                  pinned: true,
                  title: Container(
                    padding: EdgeInsets.all(10),
                    child: Row(
                      children: [
                        Expanded(child: Text('Hoạt động của tôi')),
                        // GestureDetector(
                        //   onTap: () {
                        //   },
                        //   child: Padding(
                        //     padding: const EdgeInsets.all(8.0),
                        //     child: Icon(Icons.search),
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                  bottom: TabBar(
                    controller: _tabController,
                    tabs: [
                      _buildTab('Thích'),
                      _buildTab('Bình luận'),
                    ],
                  ),
                ),
              ];
            },
            body: _buildTabBarView()),
      ),
    );
  }

  Widget _buildTabBarView() {
    return TabBarView(
      controller: _tabController,
      children: [
        _buildCategoryContent('Thích'),
        _buildCategoryContent('Bình luận'),
      ],
    );
  }

  Widget _buildCategoryContent(String category) {
    // Kiểm tra loại category và trả về nội dung tương ứng
    switch (category) {
      case 'Thích':
        return _ListLikePost();
      case 'Bình luận':
        return _ListCommentPost();
      default:
        return Container(); // Trả về container trống nếu không khớp với bất kỳ category nào
    }
  }

  Widget _ListLikePost() {
    return Expanded(
        child: ListView.builder(
            itemCount: myActivityController.likeList.length,
            itemBuilder: (context, index){
              return AnimatedOpacity(
                  duration: Duration(milliseconds: 100),
                  opacity: 1,
                  child: _buildOneLikePostOnADay(myActivityController.likeList[index])
              );
            }));
  }
  Widget _ListCommentPost() {
    return Expanded(
        child: ListView.builder(
            itemCount: myActivityController.cmtList.length,
            itemBuilder: (context, index){
              return AnimatedOpacity(
                  duration: Duration(milliseconds: 100),
                  opacity: 1,
                  child: _buildOneCommentPostOnADay(myActivityController.cmtList[index])
              );
            }));
  }

  Widget _buildTab(String title) {
    return Tab(
      child: Container(
        padding: EdgeInsets.all(2),
        alignment: Alignment.center,
        child: Text(
          title,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.bold,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }

  Widget _buildOneLikePostOnADay(List<InteractionResponse> ltLike) {
    return Container(
      margin: EdgeInsets.only(left: 5, right: 5, top: 5, bottom: 5),
      padding: EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all( Radius.circular(5)
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: Text(
                ltLike[0].timestamp!,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w100),
              ),
            ),
              SizedBox(height: 10,),
              ListView.builder(
                itemCount: ltLike.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index){
                    return AnimatedOpacity(
                      duration: Duration(milliseconds: 100),
                      opacity: 1,
                      child: _buildOneLikePost(ltLike[index])
                    );
                  }




            )
          ],
      ),
    );
  }
  Widget _buildOneCommentPostOnADay(List<CommentResponse> lsCmt) {
    return Container(
      margin: EdgeInsets.only(left: 5, right: 5, top: 5, bottom: 5),
      padding: EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all( Radius.circular(5)
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Text(
              lsCmt[0].timestamp.toString(),
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w100),
            ),
          ),
          SizedBox(height: 10,),
          ListView.builder(
              itemCount: lsCmt.length,
              shrinkWrap: true,
              itemBuilder: (context, index){
                return AnimatedOpacity(
                    duration: Duration(milliseconds: 100),
                    opacity: 1,
                    child: _buildOneCommentPost(lsCmt[index])
                );
              }
          )
        ],
      ),
    );
  }
  Widget _buildOneLikePost(InteractionResponse like) {
    return Container(
      margin: EdgeInsets.only(top: 5),
      padding: EdgeInsets.all(4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Row(
            children: [
              Expanded(
                flex: 2,
                child: CircleAvatar(
                  backgroundImage: NetworkImage(
                      like.post_id!.listAnh[0]),
                  radius: 30.0,
                ),
              ),
              Expanded(
                flex: 6,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 200,
                      child: Text.rich(
                        TextSpan(
                          text: 'Bạn đã thích bài đăng của ',
                          style: TextStyle(),
                          children: <TextSpan>[
                            TextSpan(
                              text: like.post_id!.firstName+" " + like.post_id!.lastName,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      width: 150,
                      child: Text(
                        like.post_id!.contentPost,
                        style: TextStyle(
                          fontSize: 12,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(5), // Điều chỉnh góc bo tròn
                    ),
                    backgroundColor: Color(0xFFFFFFFF),
                  ).copyWith(
                    fixedSize: MaterialStateProperty.all(Size(
                        100, 20)), // Điều chỉnh kích thước theo nhu cầu của bạn
                  ),
                  onPressed: () {



                  },
                  child: Container(
                    // Alig// n the text to the center
                    child: Text(
                      'Bỏ thích',
                      style: TextStyle(
                        fontSize: 10,
                        color: Color(0xFF4C6ED7),
                      ),
                      softWrap: false,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOneCommentPost(CommentResponse comment) {
    return Container(
      padding: EdgeInsets.all(4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Row(
            children: [
              Expanded(
                flex: 2,
                child: CircleAvatar(
                  backgroundImage: NetworkImage(
                      comment.post_id!.listAnh[0].toString()),
                  radius: 30.0,
                ),
              ),
              Expanded(
                flex: 6,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 200,
                      child: comment.post_id ==0 ? Text.rich(
                        TextSpan(
                          text: 'Bạn đã phản hồi về bình luận của ',
                          style: TextStyle(),
                          children: <TextSpan>[
                            TextSpan(
                              text: 'Trần Bửu Quến',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ) : Text.rich(
                TextSpan(
                text: 'Bạn đã bình luân về bài viết của ',
                    style: TextStyle(),
                children: <TextSpan>[
                  TextSpan(
                    text: 'Trần Bửu Quến',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
    ),
                    ),
                    Container(
                      width: 150,
                      child: comment.post_id==0 ? Text(
                        'Phần API thì xử lý như thế nào nhỉ? Cậu có ví dụ cụ thể không?',
                        style: TextStyle(
                          fontSize: 12,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ): Text(
                        comment.post_id!.contentPost!,
                        style: TextStyle(
                          fontSize: 12,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius:
                      BorderRadius.circular(5), // Điều chỉnh góc bo tròn
                    ),
                    backgroundColor: Color(0xFFFFFFFF),
                  ).copyWith(
                    fixedSize: MaterialStateProperty.all(Size(
                        100, 20)), // Điều chỉnh kích thước theo nhu cầu của bạn
                  ),
                  onPressed: () {},
                  child: Container(
                    // Alig// n the text to the center
                    child: Text(
                      'Xóa bình luận',
                      style: TextStyle(
                        fontSize: 10,
                        color: Color(0xFF4C6ED7),
                      ),
                      softWrap: false,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: Container(),
              ),
              Expanded(
                flex: 6,
                  child: Container(
                    child: Text(
                      '--- ' + getCommentStart(comment.content_cmt!),
                      style: TextStyle(
                        fontSize: 12,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  )),
              Expanded(
                  flex: 2,
                  child: Container()),
            ],
          )
        ],
      ),
    );
  }
}
