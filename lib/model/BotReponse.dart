class BotResponse {
  final String? recipientId;
  final String? text;

  BotResponse({
    required this.recipientId,
    required this.text,
  });

  factory BotResponse.fromJson(Map<String, dynamic> json) {
    return BotResponse(
      recipientId: json['recipient_id'] ?? '',
      text: json['text'] ?? '',
    );
  }

  static List<BotResponse> listFromJson(List<dynamic> jsonList) {
    return jsonList.map((json) => BotResponse.fromJson(json)).toList();
  }
}
