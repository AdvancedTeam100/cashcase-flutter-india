class AdModel {
  int id;
  String adId;
  String placementId;
  String adType;
  int status;
  int location;
  int clicks;
  int rewards;
  String platform;
  DateTime createdAt;
  DateTime updatedAt;

  AdModel({
    this.id,
    this.adId,
    this.placementId,
    this.adType,
    this.status,
    this.location,
    this.clicks,
    this.rewards,
    this.platform,
    this.createdAt,
    this.updatedAt,
  });

  AdModel.fromJson(Map<String, dynamic> json) {
    try {
      id = json["id"] != null ? int.parse(json["id"].toString()) : null;
      adId = json["ad_id"] != null ? json["ad_id"] : '';
      placementId = json["placement_id"] != null ? json["placement_id"] : '';
      adType = json["ad_type"] != null ? json["ad_type"] : '';
      status = json["status"] != null ? int.parse(json["status"].toString()) : null;
      location = json["location"] != null ? int.parse(json["location"].toString()) : null;
      clicks = json["clicks"] != null ? int.parse(json["clicks"].toString()) : 0;
      rewards = json["rewards"];
      platform = json["platform"];
      createdAt = json["created_at"] != null ? DateTime.parse(json["created_at"]) : null;
      updatedAt = json["updated_at"] != null ? DateTime.parse(json["updated_at"]) : null;
    } catch (e) {
      print("Exception - AdModel.dart - AdModel.fromJson():" + e.toString());
    }
  }
}
