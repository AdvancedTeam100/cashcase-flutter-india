import 'package:cashfuse/models/offerModel.dart';

class BannerModel {
  int id;
  String name;
  String image;
  String type;
  String url;
  int offerId;
  int status;
  String heading;
  String description;
  DateTime createdAt;
  DateTime updatedAt;
  OfferModel cuelinkoffer;

  BannerModel({
    this.id,
    this.name,
    this.image,
    this.type,
    this.url,
    this.offerId,
    this.status,
    this.heading,
    this.description,
    this.createdAt,
    this.updatedAt,
    this.cuelinkoffer,
  });

  BannerModel.fromJson(Map<String, dynamic> json) {
    try {
      id = json["id"];
      name = json["name"];
      image = json["image"] != null ? json["image"] : '';
      type = json["type"] != null ? json["type"] : '';
      url = json["url"] != null ? json["url"] : '';
      offerId = json["offer_id"];
      status = json["status"];
      heading = json["heading"] != null ? json["heading"] : '';
      description = json["description"] != null ? json["description"] : '';
      createdAt = DateTime.parse(json["created_at"]);
      updatedAt = DateTime.parse(json["updated_at"]);
      cuelinkoffer = json["cuelinkoffer"] != null ? OfferModel.fromJson(json["cuelinkoffer"]) : null;
    } catch (e) {
      print("Exception - BannerModel.dart - BannerModel.fromJson():" + e.toString());
    }
  }
}
