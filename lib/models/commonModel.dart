import 'package:cashfuse/models/categoryModel.dart';

class CommonModel {
  String adId;
  String advName;
  String advId;
  String trackingLink; // for ads
  String name;
  int campaignId;
  String url; //for campaign
  String image;
  String category;
  String buttonText;
  String tagline;
  CategoryModel partner;
  bool isExist = false;
  String from;

  CommonModel({
    this.adId,
    this.advName,
    this.advId,
    this.trackingLink,
    this.name,
    this.campaignId,
    this.url,
    this.image,
    this.category,
    this.buttonText,
    this.tagline,
    this.partner,
    this.isExist,
    this.from
  });
}
