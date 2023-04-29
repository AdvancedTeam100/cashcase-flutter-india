import 'package:cashfuse/models/categoryModel.dart';
import 'package:cashfuse/models/couponModel.dart';

class CampaignModel {
  int id;
  int campaignId;
  String name;
  String url;
  String domain;
  String payoutType;
  double payout;
  String image;
  String category;
  int categoryId;
  int status;
  String buttonText;
  String affiliatePartner;
  DateTime createdAt;
  DateTime updatedAt;
  int campaigns;
  String description;
  CategoryModel partner;
  List<Coupon> couponList;
  bool isImageError = false; //for check image error

  CampaignModel({
    this.id,
    this.campaignId,
    this.name,
    this.url,
    this.domain,
    this.payoutType,
    this.payout,
    this.image,
    this.category,
    this.categoryId,
    this.status,
    this.buttonText,
    this.affiliatePartner,
    this.createdAt,
    this.updatedAt,
    this.campaigns,
    this.description,
    this.partner,
    this.couponList,
    this.isImageError,
  });

  CampaignModel.fromJson(Map<String, dynamic> json) {
    try {
      id = json["id"];
      campaignId = json["campaign_id"];
      name = json["name"] != null ? json["name"] : '';
      url = json["url"] != null ? json["url"] : '';
      domain = json["domain"];
      payoutType = json["payout_type"];
      payout = json["payout"] != null ? json["payout"].toDouble() : 0.0;
      image = json["image"] != null ? json["image"] : '';

      categoryId = json["category_id"];
      status = json["status"];
      buttonText = json["button_text"] != null ? json["button_text"] : '';
      affiliatePartner =
          json["affiliate_partner"] != null ? json["affiliate_partner"] : '';
      createdAt = json["created_at"] != null
          ? DateTime.parse(json["created_at"])
          : null;
      updatedAt = json["updated_at"] != null
          ? DateTime.parse(json["updated_at"])
          : null;
      campaigns = json["campaigns"];
      description = json["description"] != null ? json["description"] : '';
      partner = json["partner"] != null
          ? CategoryModel.fromJson(json["partner"])
          : null;
      couponList = json["coupon"] != null && json["coupon"] != []
          ? List<Coupon>.from(json["coupon"].map((x) => Coupon.fromJson(x)))
          : [];
      category = json["category"];
    } catch (e) {
      print("Exception - CampaignModel.dart - CampaignModel.fromJson():" +
          e.toString());
    }
  }
}
