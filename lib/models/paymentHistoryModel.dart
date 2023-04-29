import 'package:cashfuse/models/userModel.dart';

class PaymentHistoryModel {
  int id;
  int userId;
  int amount;
  int approved;
  DateTime createdAt;
  DateTime updatedAt;
  String medium;
  String mediumDetails;
  UserModel user;

  PaymentHistoryModel({
    this.id,
    this.userId,
    this.amount,
    this.approved,
    this.createdAt,
    this.updatedAt,
    this.medium,
    this.mediumDetails,
    this.user,
  });

  PaymentHistoryModel.fromJson(Map<String, dynamic> json) {
    try {
      id = json["id"];
      userId = json["user_id"];
      amount = json["amount"];
      approved = json["approved"];
      createdAt = json["created_at"] != null ? DateTime.parse(json["created_at"]) : null;
      updatedAt = json["updated_at"] != null ? DateTime.parse(json["updated_at"]) : null;
      medium = json["medium"];
      mediumDetails = json["medium_details"];
      user = json["user"] != null ? UserModel.fromJson(json["user"]) : null;
    } catch (e) {
      print("Exception - PaymentHistoryModel.dart - PaymentHistoryModel.fromJson():" + e.toString());
    }
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "amount": amount,
        "approved": approved,
        "created_at": createdAt != null ? createdAt.toIso8601String() : null,
        "updated_at": updatedAt != null ? updatedAt.toIso8601String() : null,
        "medium": medium,
        "medium_details": mediumDetails,
        "user": user != null ? user.toJson() : null,
      };
}
