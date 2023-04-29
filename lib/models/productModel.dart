import 'package:cashfuse/models/productPriceModel.dart';

class ProductModel {
  int id;
  String name;
  String description;
  String image;
  int status;
  String affiliatePartner;
  int trending;
  int comissionType;
  dynamic comissionPercentage;
  DateTime createdAt;
  DateTime updatedAt;
  List<String> images;
  List<ProductPriceModel> productPrices;

  ProductModel({
    this.id,
    this.name,
    this.description,
    this.image,
    this.status,
    this.affiliatePartner,
    this.trending,
    this.comissionType,
    this.comissionPercentage,
    this.createdAt,
    this.updatedAt,
    this.images,
    this.productPrices,
  });

  ProductModel.fromJson(Map<String, dynamic> json) {
    try {
      id = json["id"];
      name = json["name"] != null ? json["name"] : '';
      description = json["description"] != null ? json["description"] : '';
      image = json["image"] != null ? json["image"] : '';
      status = json["status"];
      affiliatePartner = json["affiliate_partner"];
      trending = json["trending"];
      comissionType = json["comission_type"];
      comissionPercentage = json["comission_percentage"];
      createdAt = DateTime.parse(json["created_at"]);
      updatedAt = DateTime.parse(json["updated_at"]);
      images = json["images"] != null
          ? List<String>.from(json["images"].map((x) => x['image']))
          : [];
      productPrices = json["product_prices"] != null &&
              json["product_prices"] != []
          ? List<ProductPriceModel>.from(
              json["product_prices"].map((x) => ProductPriceModel.fromJson(x)))
          : [];
    } catch (e) {
      print("Exception -  ProductModel.dart - ProductModel.fromJson():" +
          e.toString());
    }
  }
}
