import 'package:cashfuse/models/userModel.dart';

class ReferralUserModel {
  int id;
  int userId;
  int referredUserId;
  int earn;
  DateTime createdAt;
  DateTime updatedAt;
  UserModel user;
  UserModel referraluser;

  ReferralUserModel({
    this.id,
    this.userId,
    this.referredUserId,
    this.earn,
    this.createdAt,
    this.updatedAt,
    this.user,
    this.referraluser,
  });

  ReferralUserModel.fromJson(Map<String, dynamic> json) {
    try {
      id = json["id"];
      userId = json["user_id"];
      referredUserId = json["referred_user_id"];
      earn = json["earn"];
      user = json["user"] != null ? UserModel.fromJson(json["user"]) : null;
      referraluser = json["referraluser"] != null ? UserModel.fromJson(json["referraluser"]) : null;
      createdAt = DateTime.parse(json["created_at"]);
      updatedAt = DateTime.parse(json["updated_at"]);
    } catch (e) {
      print("Exception - ReferralUserModel.dart - ReferralUserModel.fromJson():" + e.toString());
    }
  }
}
