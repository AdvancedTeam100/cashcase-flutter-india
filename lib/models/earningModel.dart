class EarningModel {
  int id;
  int userId;
  String totalEarnings;
  String withdrawal;
  String remEarning;
  String sentForWithdrawal;
  String referralEarning;
  String rewardEarning;
  String pendingEarning;
  DateTime createdAt;
  DateTime updatedAt;

  EarningModel({
    this.id,
    this.userId,
    this.totalEarnings,
    this.withdrawal,
    this.remEarning,
    this.sentForWithdrawal,
    this.referralEarning,
    this.rewardEarning,
    this.pendingEarning,
    this.createdAt,
    this.updatedAt,
  });

  EarningModel.fromJson(Map<String, dynamic> json) {
    try {
      id = json["id"];
      userId = json["user_id"];
      totalEarnings = json["total_earnings"] != null ? json["total_earnings"].toString() : '';
      withdrawal = json["withdrawal"] != null ? json["withdrawal"].toString() : '';
      remEarning = json["rem_earning"] != null ? json["rem_earning"].toString() : '';
      sentForWithdrawal = json["sent_for_withdrawal"] != null ? json["sent_for_withdrawal"].toString() : '';
      referralEarning = json["referral_earning"] != null ? json["referral_earning"].toString() : '';
      rewardEarning = json["reward_earning"] != null ? json["reward_earning"].toString() : '';
      pendingEarning = json["pending_earnings"] != null ? json["pending_earnings"].toString() : '';
      createdAt = json["created_at"] != null ? DateTime.parse(json["created_at"]) : null;
      updatedAt = json["updated_at"] != null ? DateTime.parse(json["updated_at"]) : null;
    } catch (e) {
      print("Exception - EarningModel.dart - EarningModel.fromJson():" + e.toString());
    }
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "total_earnings": totalEarnings,
        "withdrawal": withdrawal,
        "rem_earning": remEarning,
        "sent_for_withdrawal": sentForWithdrawal,
        "referral_earning": referralEarning,
        "reward_earning": rewardEarning,
        "pending_earnings": pendingEarning,
        "created_at": createdAt != null ? createdAt.toIso8601String() : null,
        "updated_at": updatedAt != null ? updatedAt.toIso8601String() : null,
      };
}
