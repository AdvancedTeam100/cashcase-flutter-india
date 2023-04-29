import 'package:cashfuse/models/baseUrlsModel.dart';

class AppInfo {
  String admob;
  String facebookAd;
  String businessName;
  String logo;
  String currency;
  String country;
  String countryCode;
  String perOrderReferPercentage;
  String minimumRedeemValue;
  BaseUrls baseUrls;

  AppInfo({
    this.admob,
    this.facebookAd,
    this.businessName,
    this.logo,
    this.currency,
    this.perOrderReferPercentage,
    this.minimumRedeemValue,
    this.baseUrls,
  });

  AppInfo.fromJson(Map<String, dynamic> json) {
    try {
      admob = json['admob'];
      facebookAd = json['facebook_ad'];
      businessName = json["business_name"] != null ? json["business_name"] : '';
      logo = json["logo"] != null ? json["logo"] : '';
      country = json["country"] != null ? json["country"] : '';
      countryCode = json["phone_code"] != null ? json["phone_code"] : '';
      currency = json["currency"] != null ? json["currency"] : '';
      perOrderReferPercentage = json["per_order_refer_percentage"] != null ? json["per_order_refer_percentage"] : '';
      minimumRedeemValue = json["minimum_redeem_value"] != null ? json["minimum_redeem_value"] : '';
      baseUrls = json["base_urls"] != null ? BaseUrls.fromJson(json["base_urls"]) : BaseUrls();
    } catch (e) {
      print("Exception - AppInfo.dart - AppInfo.fromJson():" + e.toString());
    }
  }
}
