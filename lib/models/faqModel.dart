class FaqModel {
  int id;
  String ques;
  String ans;
  String image;
  DateTime createdAt;
  DateTime updatedAt;

  FaqModel({
    this.id,
    this.ques,
    this.ans,
    this.image,
    this.createdAt,
    this.updatedAt,
  });

  FaqModel.fromJson(Map<String, dynamic> json) {
    try {
      id = json["id"];
      ques = json["ques"] != null ? json["ques"] : '';
      ans = json["ans"] != null ? json["ans"] : '';
      image = json["image"] != null ? json["image"] : '';
      createdAt = DateTime.parse(json["created_at"]);
      updatedAt = DateTime.parse(json["updated_at"]);
    } catch (e) {
      print("Exception - FaqModel.dart - FaqModel.fromJson():" + e.toString());
    }
  }
}
