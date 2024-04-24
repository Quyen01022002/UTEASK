



class MessageModel{
  final int? id;
  final int? userId;
  final int? friendId;
  final String? content;
  final DateTime? createdDate;

  MessageModel({
    required this.id,
    required this.userId,
    required this.friendId,
    required this.content,
    required this.createdDate
  });

  factory MessageModel.fromJson(Map<String,dynamic> json){
    return MessageModel(id: json['id']??0,
        userId: json['userId']??0,
        friendId: json['friendId']??0,
        content: json['content']??"",
        createdDate: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null);
  }
}