import 'package:cashfuse/models/adModel.dart';

class AdmobSettingModel {
  List<AdModel> bannerAdList;
  List<AdModel> nativeAdList;
  List<AdModel> interstitialAdList;
  List<AdModel> rewardsAdList;

  AdmobSettingModel({
    this.bannerAdList,
    this.nativeAdList,
    this.interstitialAdList,
    this.rewardsAdList,
  });

  AdmobSettingModel.fromJson(Map<String, dynamic> json) {
    try {
      bannerAdList = json["banner"] != null && json["banner"] != [] ? List<AdModel>.from(json["banner"].map((x) => AdModel.fromJson(x))) : [];
      nativeAdList = json["native"] != null && json["native"] != [] ? List<AdModel>.from(json["native"].map((x) => AdModel.fromJson(x))) : [];
      interstitialAdList = json["interstitial"] != null && json["interstitial"] != [] ? List<AdModel>.from(json["interstitial"].map((x) => AdModel.fromJson(x))) : [];
      rewardsAdList = json["rewards"] != null && json["rewards"] != [] ? List<AdModel>.from(json["rewards"].map((x) => AdModel.fromJson(x))) : [];
    } catch (e) {
      print("Exception - AdmobSettingModel.dart - AdmobSettingModel.fromJson():" + e.toString());
    }
  }
}
