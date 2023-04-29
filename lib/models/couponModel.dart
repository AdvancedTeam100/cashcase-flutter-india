import 'package:cashfuse/models/offerModel.dart';

class Coupon {
  int id;
  String name;
  String code;
  String image;
  int advId;
  String heading;
  String description;
  DateTime startDate;
  DateTime endDate;
  String affiliatePartner;
  DateTime createdAt;
  DateTime updatedAt;
  OfferModel offer;
  String url;
  String bannerImage;
  String buttonText;
  String partnerName;
  bool isImageError = false; //for check image error
  int dayDifference; //for coupon timer

  Coupon({
    this.id,
    this.name,
    this.code,
    this.image,
    this.advId,
    this.heading,
    this.description,
    this.startDate,
    this.endDate,
    this.affiliatePartner,
    this.createdAt,
    this.updatedAt,
    this.offer,
    this.url,
    this.bannerImage,
    this.buttonText,
    this.partnerName,
    this.isImageError,
    this.dayDifference,
  });

  Coupon.fromJson(Map<String, dynamic> json) {
    try {
      id = json["id"] != null ? int.parse(json["id"].toString()) : null;
      advId = json["adv_id"] != null ? int.parse(json["adv_id"].toString()) : null;
      name = json["name"] != null ? json["name"] : '';
      code = json["code"] != null ? json["code"] : '';
      image = json["image"] != null ? json["image"] : '';
      heading = json["heading"] != null ? json["heading"] : '';
      description = json["description"] != null ? json["description"] : '';
      startDate = json["start_date"] != null ? DateTime.parse(json["start_date"]) : null;
      endDate = json["end_date"] != null ? DateTime.parse(json["end_date"]) : null;
      affiliatePartner = json["affiliate_partner"];
      createdAt = json["created_at"] != null ? DateTime.parse(json["created_at"]) : '';
      updatedAt = json["updated_at"] != null ? DateTime.parse(json["updated_at"]) : '';
      offer = json["offers"] != null ? OfferModel.fromJson(json["offers"]) : null;
      url = json["url"] != null ? json["url"] : '';
      bannerImage = json["banner_image"] != null ? json["banner_image"] : '';
      partnerName = json["partner"] != null ? json["partner"] : '';
      buttonText = json["button_text"] != null ? json["button_text"] : '';
    } catch (e) {
      print("Exception - CouponModel.dart - Coupon.fromJson():" + e.toString());
    }
  }
}
