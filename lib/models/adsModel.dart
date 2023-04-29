import 'package:cashfuse/models/categoryModel.dart';
import 'package:cashfuse/models/couponModel.dart';

class AdsModel {
  int id;
  String adId;
  String cId;
  String advName;
  String advId;
  String trackingLink;
  String name;
  int categoryId;
  String categoryIds;
  String description;
  String image;
  String buttonText;
  int partnerId;
  String affiliatePartner;
  String landingPage;
  String type;
  int status;
  DateTime createdAt;
  DateTime updatedAt;
  int ads;
  CategoryModel partner;
  List<Coupon> couponList;
  bool isImageError = false; //for check image error

  AdsModel({
    this.id,
    this.adId,
    this.cId,
    this.advName,
    this.advId,
    this.trackingLink,
    this.name,
    this.categoryId,
    this.categoryIds,
    this.description,
    this.image,
    this.buttonText,
    this.partnerId,
    this.affiliatePartner,
    this.landingPage,
    this.type,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.ads,
    this.partner,
    this.couponList,
    this.isImageError,
  });

  AdsModel.fromJson(Map<String, dynamic> json) {
    try {
      id = json["id"] != null ? int.parse(json["id"].toString()) : null;
      adId = json["ad_id"];
      cId = json["c_id"];
      advId = json["adv_id"];
      advName = json["adv_name"] != null ? json["adv_name"] : '';

      trackingLink = json["tracking_link"] != null ? json["tracking_link"] : '';
      name = json["name"] != null ? json["name"] : '';
      categoryId = json["category_id"] != null ? int.parse(json["category_id"].toString()) : null;
      categoryIds = json["category_ids"] != null ? json["category_ids"] : '';
      description = json["description"] != null ? json["description"] : '';
      image = json["image"] != null ? json["image"] : '';
      buttonText = json["button_text"] != null ? json["button_text"] : '';
      partnerId = json["partner_id"] != null ? int.parse(json["partner_id"].toString()) : null;
      affiliatePartner = json["affiliate_partner"];
      landingPage = json["landing_page"] != null ? json["landing_page"] : '';
      type = json["type"];
      status = json["status"];
      createdAt = json["created_at"] != null ? DateTime.parse(json["created_at"]) : null;
      updatedAt = json["updated_at"] != null ? DateTime.parse(json["updated_at"]) : null;
      ads = json["ads"] != null ? int.parse(json["ads"].toString()) : 0;
      partner = json["partner"] != null ? CategoryModel.fromJson(json["partner"]) : null;
      couponList = json["coupon"] != null && json["coupon"] != [] ? List<Coupon>.from(json["coupon"].map((x) => Coupon.fromJson(x))) : [];
    } catch (e) {
      print("Exception - AdsModel.dart - AdsModel.fromJson():" + e.toString());
    }
  }
}
