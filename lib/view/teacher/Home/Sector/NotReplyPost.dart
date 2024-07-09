import 'package:askute/controller/HomeGroupController.dart';
import 'package:askute/model/PostModel.dart';
import 'package:askute/model/ReportPostResponse.dart';
import 'package:askute/model/SectorResponse.dart';
import 'package:askute/view/component/postNotReplyItem.dart';
import 'package:askute/view/component/postReportItem.dart';
import 'package:askute/view/component/post_newScreen.dart';
import 'package:askute/view/teacher/Home/Sector/ListSector.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotReplyScreen extends StatefulWidget {
  const NotReplyScreen({super.key});

  @override
  State<NotReplyScreen> createState() => _NotReplyScreenState();
}

class _NotReplyScreenState extends State<NotReplyScreen> {

  final HomeGroupController homeGroupController =
  Get.put(HomeGroupController());
  final ScrollController _scrollController = ScrollController();
  List<PostModel> _posts = [];
  bool _isLoading = false;
  //final ClassModel classes;
  List<String> dropdownItems = [
    'Công nghệ phần mềm',
    'Kỹ thuật dữ liệu',
    'An ninh mạng'
  ]; // Danh sách các mục cho ComboBox
  String selectedValue = 'Option 1'; // Giá trị mặc định được chọn
  void _openEditDialog(String userName) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return EditDialog(userName: userName);
      },
    );
  }
  void initState() {
    super.initState();
    homeGroupController.pageReport.value = 0;
    _posts.clear();
    _fetchReport();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        _fetchReport();
      }
    });
  }
  Future<void> _fetchReport() async {
    if (_isLoading) return;
    setState(() {
      _isLoading = true;
    });
    List<PostModel>? response;
    //repose = load giá trị listpost dưới controller
    response = await homeGroupController.loadListNotReplyPost(context);
    if (response!= null && response.length!=0) {
      setState(() {
        //set pagenumber ++
        homeGroupController.pageNotReply.value++;
        _posts.addAll(response!);
        _isLoading = false;
      });
    } else {
      setState(() {
        _isLoading = false;
      });
      throw Exception('Failed to load posts');
    }
  }
  void _refreshPage(){
    setState(() {
      homeGroupController.pageNotReply.value = 0;
      _posts.clear();
      _isLoading = false;
      _fetchReport();
      _buildPost();
    });
  }
  Future<List<ReportPostResponse>?> fetchData() async {
    // Đây là ví dụ về việc tải dữ liệu từ cơ sở dữ liệu hoặc một API
    // Thay thế phần này bằng hàm thực sự để tải dữ liệu của bạn

    return homeGroupController.loadListReportPost(context);
  }
  @override
  void dispose() {
    _scrollController.dispose();
    homeGroupController.pageNotReply.value = 0;
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Chưa trả lời'),
        ),
        body:NestedScrollView(
          //controller: _scrollController,
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
            ];
          },
          body: _buildPost(),
        ),
      ),
    );
  }
  Widget _buildPost(){
    return Container(
      child: ListView.builder(
        controller: _scrollController,
        itemCount: _posts.length + 1,
        itemBuilder: (context, index) {
          if (index == _posts.length) {
            return _isLoading ? Center(child: CircularProgressIndicator()) : SizedBox.shrink();
          }
          return Column(
            children: [
              PostNotReplyItem(
                reportPostResponse: _posts[index],
                onReportAction: _refreshPage,),
              Container(
                margin: EdgeInsets.only(top: 5),
                height: 10, // Chiều cao của thanh ngang
                width: 500, // Độ dày của thanh ngang
                color: Colors.black12,
              ),
            ],
          );
        },
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
          image: NetworkImage(
              homeGroupController.avatarGroup.value),
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


  Widget _buildUserItem(SectorResponse sectorResponse) {
    return ListTile(
      title: Text(sectorResponse.name!),
      subtitle: Text(sectorResponse.description!),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            onPressed: () {
              homeGroupController.nameText.text= sectorResponse.name!;
              homeGroupController.descText.text = sectorResponse.description!;
              _showUpdateFieldDialog(sectorResponse, context);
            },
            icon: Icon(Icons.edit),
          ),
          IconButton(
            onPressed: () {
              setState(() {
                // Xử lý sự kiện khi nhấn vào nút "Xóa"
                homeGroupController.DeleteOneSector(sectorResponse, context);
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

  void _showCreateFieldDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Tạo lĩnh vực mới'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Row(
                //   children: [
                //     CircleAvatar(
                //       backgroundImage: NetworkImage(avatarUrl),
                //       radius: 30,
                //     ),
                //     SizedBox(width: 10),
                //     ElevatedButton(
                //       onPressed: () {
                //         // Xử lý sự kiện chọn avatar ở đây
                //       },
                //       child: Text('Chọn avatar'),
                //     ),
                //   ],
                // ),
                TextField(
                  controller: homeGroupController.nameText,
                  decoration: InputDecoration(
                    labelText: 'Tên lĩnh vực',
                  ),
                ),
                TextField(
                  controller: homeGroupController.descText,
                  decoration: InputDecoration(
                    labelText: 'Mô tả lĩnh vực',
                  ),
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
                if (homeGroupController.nameText.text.trim() != '' &&
                    homeGroupController.descText.text.trim() != '') {
                  homeGroupController.CreateOnSector(context);

                  Navigator.of(context).pop();
                } else
                  _validateInputs();
              },
              child: Text('Lưu'),
            ),
          ],
        );
      },
    );
  }

  void _showUpdateFieldDialog(SectorResponse sectorResponse, BuildContext context) {
    String avatarUrl = 'https://i.pravatar.cc/150?img=1';

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Tạo lĩnh vực mới'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Row(
                //   children: [
                //     CircleAvatar(
                //       backgroundImage: NetworkImage(avatarUrl),
                //       radius: 30,
                //     ),
                //     SizedBox(width: 10),
                //     ElevatedButton(
                //       onPressed: () {
                //         // Xử lý sự kiện chọn avatar ở đây
                //       },
                //       child: Text('Chọn avatar'),
                //     ),
                //   ],
                // ),
                TextField(
                  controller: homeGroupController.nameText,
                  decoration: InputDecoration(
                    labelText: 'Tên lĩnh vực',
                  ),
                ),
                TextField(
                  controller: homeGroupController.descText,
                  decoration: InputDecoration(
                    labelText: 'Mô tả lĩnh vực',
                  ),
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

                if (homeGroupController.nameText.text.trim() != '' &&
                    homeGroupController.descText.text.trim() != '') {
                  homeGroupController.UpdateOneSector( sectorResponse, context);

                  Navigator.of(context).pop();
                  setState(() {

                  });
                } else
                  _validateInputs();
              },
              child: Text('Lưu'),
            ),
          ],
        );
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
