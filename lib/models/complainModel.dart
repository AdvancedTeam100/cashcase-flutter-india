class ComplainModel {
  int userId;
  int orderId;
  String complain;
  DateTime createdAt;
  DateTime updatedAt;
  int id;

  int status;
  String reply;

  ComplainModel({
    this.userId,
    this.orderId,
    this.complain,
    this.createdAt,
    this.updatedAt,
    this.id,
    this.status,
    this.reply,
  });

  ComplainModel.fromJson(Map<String, dynamic> json) {
    try {
      userId = json["user_id"];
      orderId = json["order_id"];
      complain = json["complain"] != null ? json["complain"] : '';
      status = json["status"];
      reply = json["reply"] != null ? json["reply"] : '';
      createdAt = json["created_at"] != null ? DateTime.parse(json["created_at"]) : null;
      updatedAt = json["updated_at"] != null ? DateTime.parse(json["updated_at"]) : null;
      id = json["id"];
    } catch (e) {
      print("Exception - ComplainModel.dart - ComplainModel.fromJson():" + e.toString());
    }
  }
}
