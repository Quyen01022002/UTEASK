import 'dart:convert';

List<UserEnity> userListFromJson(String val) =>
    List<UserEnity>.from(json.decode(val)['data']);

class UserEnity {
  final int? user_id;
  final String? first_name;
  final String? last_name;
  final String? email;
  final bool? is_email;
  final String? phone;
  final bool? is_phone;
  final String? password_hash;
  final String? hash;
  final String? avatarUrl;
  final bool? is_actived;
  final bool? isFriends;
  final DateTime? created_at;
  final DateTime? updated_at;
  final int? countFriend;
  final int? idFriends;

  UserEnity({
    this.user_id,
    this.first_name,
    this.last_name,
    this.email,
    this.is_email,
    this.phone,
    this.is_phone,
    this.password_hash,
    this.hash,
    this.avatarUrl,
    this.is_actived,
    this.isFriends,
    this.created_at,
    this.updated_at,
    this.countFriend,
    this.idFriends,
  });

  factory UserEnity.fromJson(Map<String, dynamic> data) => UserEnity(
        user_id: data.containsKey("id") ? data["id"] : 0,
        first_name: data["firstName"] ?? "",
        last_name: data["lastName"] ?? "",
        email: data["email"] ?? "",
        is_email: data["isEmail"] ?? false,
        phone: data["phone"] ?? "",
        is_phone: data["isPhone"] ?? false,
        hash: data["hash"] ?? "",
        avatarUrl: data["profilePicture"] ?? "",
        is_actived: data["isActived"] ?? false,
        isFriends: data["isFriends"] ?? false,
        created_at:
            DateTime.tryParse(data["createdAt"] ?? "") ?? DateTime.now(),
        updated_at:
            DateTime.tryParse(data["updatedAt"] ?? "") ?? DateTime.now(),
        countFriend: data.containsKey("countFriend") ? data["countFriend"] : 0,
        idFriends: data.containsKey("idFriends") ? data["idFriends"] : 0,
      );
}
