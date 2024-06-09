class BotReponse {
  final String? recipient_id;
  final String? text;

  BotReponse({
    required this.recipient_id,
    required this.text,
  });

  factory BotReponse.fromJson(Map<String, dynamic> json) {
    return BotReponse(
      recipient_id: json['recipient_id'] ?? '',
      text: json['text'] ?? '',
    );
  }
}
