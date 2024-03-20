import 'dart:convert';

List<InteractionsEntity> InteractionsFromJson(String val) =>
    List<InteractionsEntity>.from(json.decode(val)['data']);

class InteractionsEntity {
  final int? interaction_id;
  final int? user_id;
  final int? post_id;
  final bool? liked;
  final DateTime? timestamp;


  InteractionsEntity({
    this.interaction_id,
    this.user_id,
    this.post_id,
    this.liked,
    this.timestamp

  });

  factory InteractionsEntity.fromJson(Map<String, dynamic> data) => InteractionsEntity(
    interaction_id: data["interaction_id"] ?? 0,
    user_id: data["user_id"] ?? 0,
    post_id: data["post_id"] ?? 0,
    liked: data["liked"] ?? false,
    timestamp: DateTime.fromMillisecondsSinceEpoch(data["timestamp"] ?? 0),

  );

}
