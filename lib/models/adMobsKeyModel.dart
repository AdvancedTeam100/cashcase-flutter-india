class AdMobKeyModel {
  int id;
  int status;
  String type;
  String banner;
  String native;
  String interstitial;
  String reward;
  DateTime createdAt;
  DateTime updatedAt;

  AdMobKeyModel({
    this.id,
    this.status,
    this.type,
    this.banner,
    this.native,
    this.interstitial,
    this.reward,
    this.createdAt,
    this.updatedAt,
  });

  AdMobKeyModel.fromJson(Map<String, dynamic> json) {
    try {
      id = json["id"];
      status = json["status"];
      type = json["type"] != null ? json["type"] : '';
      banner = json["banner"] != null ? json["banner"] : '';
      native = json["native"] != null ? json["native"] : '';
      interstitial = json["interstitial"] != null ? json["interstitial"] : '';
      reward = json["reward"] != null ? json["reward"] : '';
      createdAt = json["created_at"] != null ? DateTime.parse(json["created_at"]) : null;
      updatedAt = json["updated_at"] != null ? DateTime.parse(json["updated_at"]) : null;
    } catch (e) {
      print("Exception - AdMobKeyModel.dart - AdMobKeyModel.fromJson():" + e.toString());
    }
  }
}
