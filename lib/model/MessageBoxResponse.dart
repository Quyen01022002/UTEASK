



class MessageBoxResponse{
  final int? id;
  final int? userId;
  final int? friendId;
  final String? content;
  final String? friendName;
  final String? friendAvatar;
  final DateTime? createdDate;

  MessageBoxResponse({
    required this.id,
    required this.userId,
    required this.friendId,
    required this.content,
    required this.friendName,
    required this.friendAvatar,
    required this.createdDate
  });

  factory MessageBoxResponse.fromJson(Map<String,dynamic> json){
    return MessageBoxResponse(id: json['id']??0,
        userId: json['userId']??0,
        friendId: json['friendId']??0,
        content: json['newest_mess']??"",
        friendName: json['friendName']??'',
        friendAvatar: json['friendAvatar']??'',
        createdDate: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null);
  }
}