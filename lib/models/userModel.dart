import 'package:cashfuse/models/bankDetailsModel.dart';
import 'package:cashfuse/models/earningModel.dart';
import 'package:cashfuse/models/paymentHistoryModel.dart';

class UserModel {
  int id;
  String name;
  String userImage;
  String email;
  String phone;
  String cmFirebaseToken;
  int emailVerifiedAt;
  int isPhoneVerified;
  int status;
  DateTime createdAt;
  DateTime updatedAt;
  String token;
  String loginType;
  String socialId;
  EarningModel earning;
  List<PaymentHistoryModel> withdrawalRequest;
  BankDetailsModel bankDetail;
  String referralCode;
  int notify;
  int verified;

  UserModel({
    this.id,
    this.name,
    this.userImage,
    this.email,
    this.phone,
    this.cmFirebaseToken,
    this.emailVerifiedAt,
    this.isPhoneVerified,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.token,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    try {
      id = json["id"];
      name = json["name"] != null ? json["name"] : '';
      userImage = json["image"] != null ? json["image"] : '';
      email = json["email"] != null ? json["email"] : '';
      phone = json["phone"] != null ? json["phone"] : '';
      cmFirebaseToken =
          json["cm_firebase_token"] != null ? json["cm_firebase_token"] : '';
      emailVerifiedAt = json["email_verified_at"] != null
          ? int.parse(json["email_verified_at"].toString())
          : null;
      isPhoneVerified = json["is_phone_verified"] != null
          ? int.parse(json["is_phone_verified"].toString())
          : null;
      status =
          json["status"] != null ? int.parse(json["status"].toString()) : null;
      createdAt = json["created_at"] != null
          ? DateTime.parse(json["created_at"])
          : null;
      updatedAt = json["updated_at"] != null
          ? DateTime.parse(json["updated_at"])
          : null;
      token = json['token'] != null ? json['token'] : null;
      earning = json['earning'] != null
          ? EarningModel.fromJson(json['earning'])
          : null;
      bankDetail = json['bank_detail'] != null
          ? BankDetailsModel.fromJson(json['bank_detail'])
          : null;
      withdrawalRequest =
          json["withdrawal_request"] != null && json["withdrawal_request"] != []
              ? List<PaymentHistoryModel>.from(json["withdrawal_request"]
                  .map((x) => PaymentHistoryModel.fromJson(x)))
              : [];

      referralCode = json["referral_code"];
      notify = json["notify"];
      verified = json["verified"];
      loginType = json["register_via"] != null ? json["register_via"] : '';
      socialId = json["social_id"] != null ? json["social_id"] : '';
    } catch (e) {
      print(
          "Exception - UserModel.dart - UserModel.fromJson():" + e.toString());
    }
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": userImage,
        "email": email,
        "phone": phone,
        "cm_firebase_token": cmFirebaseToken,
        "email_verified_at": emailVerifiedAt,
        "is_phone_verified": isPhoneVerified,
        "status": status,
        "created_at": createdAt != null ? createdAt.toIso8601String() : null,
        "updated_at": updatedAt != null ? updatedAt.toIso8601String() : null,
        "token": token,
        "earning": earning != null ? earning.toJson() : null,
        "bank_detail": bankDetail != null ? bankDetail.toJson() : null,
        "withdrawal_request":
            withdrawalRequest != null && withdrawalRequest.length > 0
                ? withdrawalRequest
                : null,
        'type': loginType,
        'socialId': socialId,
      };
}
