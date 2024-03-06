import 'package:flutter/material.dart';

class ReportPost extends StatefulWidget {
  const ReportPost({super.key});

  @override
  State<ReportPost> createState() => _ReportPostState();
}

class _ReportPostState extends State<ReportPost> {
  String selectedReason = '';
  TextEditingController customReasonController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF6A9EF5),
        title: Row(
          children: [
            SizedBox(width: 8.0),
            Text('Báo cáo bài đăng câu hỏi'),
          ],
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(left: 10, top: 20, bottom: 10),
                    child: Text(
                      'Báo cáo bài viết',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  _buildPostInfoContainer(),
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.only(left: 12),
                          child: Text(
                            'Nội dung báo cáo:',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        RadioListTile(
                          dense: true, // Set dense to true to reduce vertical spacing
                          title: Text(
                            'Người dùng đăng nội dung phản cảm',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          value: 'Option 1',
                          groupValue: selectedReason,
                          onChanged: (value) {
                            setState(() {
                              selectedReason = 'Option 3';
                            });
                          },
                        ),
                        RadioListTile(
                          dense: true,
                          title: Text(
                            'Tải khoản giả mạo',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          value: 'Option 2',
                          groupValue: selectedReason,
                          onChanged: (value) {
                            setState(() {
                              selectedReason = 'Option 2';
                            });
                          },
                        ),
                        RadioListTile(
                          dense: true,
                          title: Text(
                            'Tài khoản vi phạm bản quyền',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          value: 'Option 3',
                          groupValue: selectedReason,
                          onChanged: (value) {
                            setState(() {
                              selectedReason = 'Option 3';
                            });
                          },
                        ),
                        RadioListTile(
                          dense: true,
                          title: Text(
                            'Khác',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          value: 'Option 4',
                          groupValue: selectedReason,
                          onChanged: (value) {
                            setState(() {
                              selectedReason = 'Option 4';
                            });
                          },
                        ),
                        // Visibility widget to show/hide input field based on option selection
                        Visibility(
                          visible: selectedReason == 'Option 4',
                          child: Container(
                            margin: EdgeInsets.only(left: 16, right: 16),
                            padding: EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey, // You can set the border color
                                width: 1.0, // You can set the border width
                              ),
                              borderRadius: BorderRadius.circular(8.0), // Set the border radius
                            ),
                            child: TextFormField(
                              controller: customReasonController,
                              decoration: InputDecoration(
                                hintText: 'Nhập lý do khác',
                                border: InputBorder.none, // Remove the default border
                              ),
                            ),
                          ),
                        ),

                      ],
                    ),
                  ),
                  SizedBox(height: 10.0),

                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  20), // Điều chỉnh góc bo tròn
                            ),
                            backgroundColor: Color(0xFF8587F1),
                          ),
                          onPressed: () {
                            // Perform the report action here
                            print('Selected Reason: $selectedReason');
                            if (selectedReason == 'Option 4') {
                              print('Custom Reason: ${customReasonController.text}');
                            }
                          },
                          child: Container(
                            margin: EdgeInsets.all(10),
                            padding: EdgeInsets.all(10),
                            width: 250,
                            alignment: Alignment.center, // Align the text to the center
                            child: Text(
                              'Báo cáo bài viết',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],

              ),
            ),

          ),

        ],
      ),

    );
  }

  Widget _buildPostInfoContainer() {
    return Container(
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
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
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundImage:
                AssetImage('assets/images/search.png'),
                // Hoặc sử dụng NetworkImage nếu avatar từ một URL
                // backgroundImage: NetworkImage('URL_TO_AVATAR'),
              ),
              SizedBox(width: 8),
              Text(
                'Đỗ Duy Hào',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Container(
            child: Column(
              children: [
                Text(
                  'Nội dung của bài viết hoặc tin nhắn sẽ được đặt ở đây. Bạn có thể thay đổi độ dài và nội dung theo ý muốn.',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black87,
                  ),
                ),
                Image.asset('assets/images/login-back.png')
              ],
            ),
          ),
        ],
      ),
    );
  }
}

