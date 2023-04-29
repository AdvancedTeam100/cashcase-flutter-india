class ClickModel {
  int id;
  String userId;
  String name;
  String image;
  DateTime createdAt;
  DateTime updatedAt;

  ClickModel({
    this.id,
    this.userId,
    this.name,
    this.image,
    this.createdAt,
    this.updatedAt,
  });

  ClickModel.fromJson(Map<String, dynamic> json) {
    try {
      id = json["id"];
      userId = json["user_id"];
      name = json["name"] != null ? json["name"] : '';
      image = json["image"] != null ? json["image"] : '';
      createdAt = DateTime.parse(json["created_at"]);
      updatedAt = DateTime.parse(json["updated_at"]);
    } catch (e) {
      print("Exception - ClickModel.dart - ClickModel.fromJson():" + e.toString());
    }
  }
}
