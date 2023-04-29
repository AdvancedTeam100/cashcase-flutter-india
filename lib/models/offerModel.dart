import 'package:cashfuse/models/categoryModel.dart';
import 'package:cashfuse/models/couponModel.dart';

class OfferModel {
  int id;
  String campaignName;
  int campaignId;
  int categoryId;
  CategoryModel category;
  int offerId;
  String name;
  String bannerImage;
  String image;
  String description;
  String terms;
  String couponCode;
  String url;
  String affiliateUrl;
  int status;
  DateTime startDate;
  DateTime endDate;
  String buttonText;
  String affiliatePartner;
  int exclusive;
  DateTime createdAt;
  DateTime updatedAt;
  int offers;
  CategoryModel partner;
  bool isCliked = false; // for first loader in webview
  List<Coupon> couponList;
  bool isImageError = false; //for check image error

  int dayDifference; //for exclusive offer timer

  OfferModel({
    this.id,
    this.campaignName,
    this.campaignId,
    this.categoryId,
    this.category,
    this.offerId,
    this.name,
    this.bannerImage,
    this.image,
    this.description,
    this.terms,
    this.couponCode,
    this.url,
    this.affiliateUrl,
    this.status,
    this.startDate,
    this.endDate,
    this.buttonText,
    this.affiliatePartner,
    this.exclusive,
    this.createdAt,
    this.updatedAt,
    this.offers,
    this.partner,
    this.isCliked,
    this.couponList,
    this.isImageError,
    this.dayDifference,
  });

  OfferModel.fromJson(Map<String, dynamic> json) {
    try {
      id = json["id"];
      campaignName = json["campaign_name"] != null ? json["campaign_name"] : '';
      campaignId = json["campaign_id"];
      categoryId = json["category_id"];

      offerId = json["offer_id"];
      name = json["name"] != null ? json["name"] : '';
      bannerImage = json["banner_image"] != null ? json["banner_image"] : '';
      image = json["image"] != null ? json["image"] : '';
      description = json["description"] != null ? json["description"] : '';
      terms = json["terms"];
      couponCode = json["coupon_code"];
      url = json["url"];
      affiliateUrl = json["affiliate_url"];
      status = json["status"];
      startDate = json["start_date"] != null ? DateTime.parse(json["start_date"]) : null;
      endDate = json["end_date"] != null ? DateTime.parse(json["end_date"]) : null;
      buttonText = json["button_text"] != null ? json["button_text"] : '';
      affiliatePartner = json["affiliate_partner"];
      exclusive = json["exclusive"];
      createdAt = json["created_at"] != null ? DateTime.parse(json["created_at"]) : null;
      updatedAt = json["updated_at"] != null ? DateTime.parse(json["updated_at"]) : null;

      offers = json["offers"];
      partner = json["partner"] != null ? CategoryModel.fromJson(json["partner"]) : null;
      category = json["category"] != null ? CategoryModel.fromJson(json["category"]) : null;
      couponList = json["coupon"] != null && json["coupon"] != [] ? List<Coupon>.from(json["coupon"].map((x) => Coupon.fromJson(x))) : [];
    } catch (e) {
      print("Exception - OfferModel.dart - OfferModel.fromJson():" + e.toString());
    }
  }
}
