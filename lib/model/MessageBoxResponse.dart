import 'package:askute/model/MessageContent.dart';
import 'package:askute/model/MessageModel.dart';

class MessageBoxResponse {
  final int? id;
  final String? name;
  final String? Avatar;
  final List<MessageModel> messageMembersList;
  final List<MessageContent> messagesList;

  MessageBoxResponse(
      {required this.id,
      required this.name,
      required this.Avatar,
      required this.messageMembersList,
      required this.messagesList});

  factory MessageBoxResponse.fromJson(Map<String, dynamic> json) {
    List<MessageModel> listMembers = [];
    if (json['messageMembersList'] == null)
      listMembers = [];
    else
      listMembers = (json['messageMembersList'] as List)
          .map((item) => MessageModel.fromJson(item))
          .toList();
    List<MessageContent> listMessages = [];
    if (json['messagesList'] == null)
      listMessages = [];
    else
      listMessages = (json['messagesList'] as List)
          .map((item) => MessageContent.fromJson(item))
          .toList();

    return MessageBoxResponse(
        id: json['id'] ?? 0,
        name: json['name'] ?? '',
        Avatar: json['Avatar'] ?? '',
        messageMembersList: listMembers,
        messagesList: listMessages);
  }


}
