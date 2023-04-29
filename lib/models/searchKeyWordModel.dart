class SearchKeyWordModel {
  int id;
  String name;
  DateTime createdAt;
  DateTime updatedAt;

  SearchKeyWordModel({
    this.id,
    this.name,
    this.createdAt,
    this.updatedAt,
  });

  SearchKeyWordModel.fromJson(Map<String, dynamic> json) {
    try {
      id = json["id"];
      name = json["name"];
      createdAt = DateTime.parse(json["created_at"]);
      updatedAt = DateTime.parse(json["updated_at"]);
    } catch (e) {
      print("Exception - SearchKeyWordModel.dart - SearchKeyWordModel.fromJson():" + e.toString());
    }
  }
}
