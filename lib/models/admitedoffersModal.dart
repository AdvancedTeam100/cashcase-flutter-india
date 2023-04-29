import 'package:cashfuse/models/categoryModel.dart';
import 'package:cashfuse/models/couponModel.dart';

class AdmitedOffersModal {
  AdmitedOffersModal({
    this.id,
    this.adId,
    this.advId,
    this.name,
    this.nameAliases,
    this.siteUrl,
    this.gotourl,
    this.image,
    this.description,
    this.rawDescription,
    this.currency,
    this.country,
    this.catId,
    this.rating,
    this.crTrend,
    this.epcTrend,
    this.ecpcTrend,
    this.exclusive,
    this.activationDate,
    this.modifiedDate,
    this.denynewwms,
    this.gotoCookieLifetime,
    this.retag,
    this.showProductsLinks,
    this.landingCode,
    this.landingTitle,
    this.geotargeting,
    this.maxHoldTime,
    this.avgHoldTime,
    this.avgMoneyTransferTime,
    this.allowDeeplink,
    this.couponIframeDenied,
    this.actionTestingLimit,
    this.mobileDeviceType,
    this.mobileOs,
    this.mobileOsType,
    this.allowActionsAllCountries,
    this.affiliatePartner,
    this.connected,
    this.notify,
    this.updatedAt,
    this.createdAt,
  });

  int id;
  int adId;
  int advId;
  String name;
  String nameAliases;
  String siteUrl;
  String gotourl;
  String image;
  String description;
  String rawDescription;
  String currency;
  String country;
  int catId;
  int rating;
  String crTrend;
  String epcTrend;
  String ecpcTrend;
  String exclusive;
  DateTime activationDate;
  DateTime modifiedDate;
  String denynewwms;
  String gotoCookieLifetime;
  String retag;
  String showProductsLinks;
  dynamic landingCode;
  dynamic landingTitle;
  String geotargeting;
  dynamic maxHoldTime;
  String avgHoldTime;
  String avgMoneyTransferTime;
  String allowDeeplink;
  String couponIframeDenied;
  dynamic actionTestingLimit;
  dynamic mobileDeviceType;
  dynamic mobileOs;
  dynamic mobileOsType;
  String allowActionsAllCountries;
  String affiliatePartner;
  String connected;
  int notify;
  int status;
  DateTime updatedAt;
  DateTime createdAt;
  List<Coupon> coupon;
  CategoryModel partner;

  AdmitedOffersModal.fromJson(Map<String, dynamic> json) {
    try {
      id = json["id"];
      adId = json["ad_id"];
      advId = json["adv_id"];
      name = json["name"];
      nameAliases = json["name_aliases"];
      siteUrl = json["site_url"];
      gotourl = json["gotourl"];
      image = json["image"];
      description = json["description"];
      rawDescription = json["raw_description"];
      currency = json["currency"];
      country = json["country"];
      catId = json["cat_id"];
      rating = json["rating"];
      crTrend = json["cr_trend"];
      epcTrend = json["epc_trend"];
      ecpcTrend = json["ecpc_trend"];
      exclusive = json["exclusive"];
      activationDate = json["activation_date"] == null
          ? null
          : DateTime.parse(json["activation_date"]);
      modifiedDate = json["modified_date"] == null
          ? null
          : DateTime.parse(json["modified_date"]);
      denynewwms = json["denynewwms"];
      gotoCookieLifetime = json["goto_cookie_lifetime"];
      retag = json["retag"];
      showProductsLinks = json["show_products_links"];
      landingCode = json["landing_code"];
      landingTitle = json["landing_title"];
      geotargeting = json["geotargeting"];
      maxHoldTime = json["max_hold_time"];
      avgHoldTime = json["avg_hold_time"];
      avgMoneyTransferTime = json["avg_money_transfer_time"];
      allowDeeplink = json["allow_deeplink"];
      couponIframeDenied = json["coupon_iframe_denied"];
      actionTestingLimit = json["action_testing_limit"];
      mobileDeviceType = json["mobile_device_type"];
      mobileOs = json["mobile_os"];
      mobileOsType = json["mobile_os_type"];
      allowActionsAllCountries = json["allow_actions_all_countries"];
      affiliatePartner = json["affiliate_partner"];
      connected = json["connected"];
      status = json["status"];
      notify = json["notify"];
      updatedAt = json["updated_at"] == null
          ? null
          : DateTime.parse(json["updated_at"]);
      createdAt = json["created_at"] == null
          ? null
          : DateTime.parse(json["created_at"]);
      coupon = json["coupon"] != null && json["coupon"] != []
          ? List<Coupon>.from(json["coupon"].map((x) => Coupon.fromJson(x)))
          : [];
      partner = json["partner"] != null
          ? CategoryModel.fromJson(json["partner"])
          : null;
    } catch (e) {
      print(
          "Exception - AdmitedOffersModal.dart - AdmitedOffersModal.fromJson():" +
              e.toString());
    }
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "ad_id": adId,
        "adv_id": advId,
        "name": name,
        "name_aliases": nameAliases,
        "site_url": siteUrl,
        "gotourl": gotourl,
        "image": image,
        "description": description,
        "raw_description": rawDescription,
        "currency": currency,
        "country": country,
        "cat_id": catId,
        "rating": rating,
        "cr_trend": crTrend,
        "epc_trend": epcTrend,
        "ecpc_trend": ecpcTrend,
        "exclusive": exclusive,
        "activation_date": activationDate?.toIso8601String(),
        "modified_date": modifiedDate?.toIso8601String(),
        "denynewwms": denynewwms,
        "goto_cookie_lifetime": gotoCookieLifetime,
        "retag": retag,
        "show_products_links": showProductsLinks,
        "landing_code": landingCode,
        "landing_title": landingTitle,
        "geotargeting": geotargeting,
        "max_hold_time": maxHoldTime,
        "avg_hold_time": avgHoldTime,
        "avg_money_transfer_time": avgMoneyTransferTime,
        "allow_deeplink": allowDeeplink,
        "coupon_iframe_denied": couponIframeDenied,
        "action_testing_limit": actionTestingLimit,
        "mobile_device_type": mobileDeviceType,
        "mobile_os": mobileOs,
        "mobile_os_type": mobileOsType,
        "allow_actions_all_countries": allowActionsAllCountries,
        "affiliate_partner": affiliatePartner,
        "connected": connected,
        "notify": notify,
        "updated_at": updatedAt?.toIso8601String(),
        "created_at": createdAt?.toIso8601String(),
      };
}
