import 'package:askute/model/CommentEntity.dart';
import 'package:flutter/material.dart';

class OneCommentScreen extends StatefulWidget {
  final CommentEntity commentEntity;
  const OneCommentScreen({Key? key, required this.commentEntity}) : super(key: key);

  @override
  State<OneCommentScreen> createState() => _OneCommentScreenState();
}

class _OneCommentScreenState extends State<OneCommentScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5.0),
      child: Column(
        children: [
          _buildUserComment(),
          SizedBox(height: 5,),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                  flex: 2,
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/images/FILTER.png',
                        width: 30,
                        height: 30,
                      ),
                      Text('8',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),),
                      Image.asset(
                        'assets/images/FILTER.png',
                        width: 30,
                        height: 30,
                      ),
                      SizedBox(height: 10,),
                      Image.asset(
                        'assets/images/FILTER.png',
                        width: 30,
                        height: 40,
                      ),
                    ],
                  )),
              Expanded(
                  flex: 8,
                  child: Column(
                    children: [
                      Text(
                          'Now everything works fine when I run it but I keep getting the error (Name non-constant identifiers using lowerCamelCase.)'),
                      Image.network(
                          'https://i.pinimg.com/564x/fa/e9/3d/fae93d5d8bc6062038bb01dc243fde5d.jpg'),

                    ],
                  ))
            ],
          ),
        ],
      ),
    );
  }
  Widget _buildUserComment() {
    return Container(
      child: Row(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundImage:
            NetworkImage(
                'https://i.pinimg.com/564x/fa/e9/3d/fae93d5d8bc6062038bb01dc243fde5d.jpg'),
            // Hoặc sử dụng NetworkImage nếu avatar từ một URL
            // backgroundImage: NetworkImage('URL_TO_AVATAR'),
          ),
          SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Trần Bửu Quến',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),

              Text(
                'buuquen2002',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.black45,
                ),
              ),
            ],
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
    );
  }
}
