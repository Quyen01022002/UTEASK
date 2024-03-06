import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ReportUser extends StatefulWidget {
  const ReportUser({Key? key}) : super(key: key);

  @override
  State<ReportUser> createState() => _ReportUserState();
}

class _ReportUserState extends State<ReportUser> {
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
            Text('Báo cáo tài khoản người dùng'),
          ],
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: SafeArea(
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          'Báo cáo tài khoản',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        _buildUserInfoContainer(),
                      ],
                    ),
                  ),
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
                        'Báo cáo tài khoản',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
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

  Widget _buildUserInfoContainer() {
    return Container(
      padding: EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 10.0),
          Container(
            width: 100.0,
            height: 100.0,
            child: CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://i.pinimg.com/564x/6d/9c/23/6d9c2393908ad508854ed24224682608.jpg'),
              radius: 50.0,
            ),
          ),
          SizedBox(height: 8.0),
          Text(
            'Duy Hào',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            '@weihao.7640',
            style: TextStyle(
              color: Color(0xFF4F4F4F),
            ),
          ),
        ],
      ),
    );
  }
}
