class BankDetailsModel {
  int id;
  int userId;
  String acNo;
  String acHolderName;
  String bankName;
  String ifsc;
  String upi;
  String payPalEmail;
  String paytmNo;
  String amazonNo;
  DateTime createdAt;
  DateTime updatedAt;

  BankDetailsModel({
    this.id,
    this.userId,
    this.acNo,
    this.acHolderName,
    this.bankName,
    this.ifsc,
    this.upi,
    this.payPalEmail,
    this.paytmNo,
    this.amazonNo,
    this.createdAt,
    this.updatedAt,
  });

  BankDetailsModel.fromJson(Map<String, dynamic> json) {
    try {
      id = json["id"];
      userId = json["user_id"] != null ? int.parse(json["user_id"].toString()) : null;
      acNo = json["ac_no"] != null ? json["ac_no"] : '';
      acHolderName = json["ac_holder_name"] != null ? json["ac_holder_name"] : '';
      bankName = json["bank_name"] != null ? json["bank_name"] : '';
      ifsc = json["ifsc"] != null ? json["ifsc"] : '';
      upi = json["upi"] != null ? json["upi"] : '';
      payPalEmail = json["paypal_email"] != null ? json["paypal_email"] : '';
      paytmNo = json["paytm_no"] != null ? json["paytm_no"] : '';
      amazonNo = json["amazon_no"] != null ? json["amazon_no"] : '';
      createdAt = json["created_at"] != null ? DateTime.parse(json["created_at"]) : null;
      updatedAt = json["updated_at"] != null ? DateTime.parse(json["updated_at"]) : null;
    } catch (e) {
      print("Exception - BankDetailsModel.dart - BankDetailsModel.fromJson():" + e.toString());
    }
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "ac_no": acNo,
        "ac_holder_name": acHolderName,
        "bank_name": bankName,
        "ifsc": ifsc,
        "upi": upi,
        "paypal_email": payPalEmail,
        "paytm_no": paytmNo,
        "amazon_no": amazonNo,
        "created_at": createdAt != null ? createdAt.toIso8601String() : null,
        "updated_at": updatedAt != null ? updatedAt.toIso8601String() : null,
      };
}
