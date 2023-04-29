import 'package:cashfuse/models/adsModel.dart';
import 'package:cashfuse/models/campaignModel.dart';
import 'package:cashfuse/models/categoryModel.dart';
import 'package:cashfuse/models/commonModel.dart';
import 'package:cashfuse/models/offerModel.dart';

class SearchDataModel {
  List<CategoryModel> advertiserList;
  List<AdsModel> adsList;
  List<CampaignModel> campaignList;
  List<OfferModel> offerList;
  List<CommonModel> commonList = [];

  SearchDataModel({
    this.advertiserList,
    this.adsList,
    this.campaignList,
    this.offerList,
    this.commonList,
  });

  SearchDataModel.fromJson(Map<String, dynamic> json) {
    try {
      advertiserList = json['advertisers'] != null && json['advertisers'] != [] ? List<CategoryModel>.from(json['advertisers'].map((x) => CategoryModel.fromJson(x))) : [];
      adsList = json['ads'] != null && json['ads'] != [] ? List<AdsModel>.from(json['ads'].map((x) => AdsModel.fromJson(x))) : [];
      campaignList = json['campaign'] != null && json['campaign'] != [] ? List<CampaignModel>.from(json['campaign'].map((x) => CampaignModel.fromJson(x))) : [];
      offerList = json['offer'] != null && json['offer'] != [] ? List<OfferModel>.from(json['offer'].map((x) => OfferModel.fromJson(x))) : [];
    } catch (e) {
      print("Exception - SearchDataModel.dart - SearchDataModel.fromJson():" + e.toString());
    }
  }
}
