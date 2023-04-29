class ProductPriceModel {
  int id;
  int cashback;
  int cId;
  int productId;
  int serialNumber;
  String siteName;
  String siteIcon;
  int mrp;
  int price;
  String url;
  DateTime createdAt;
  DateTime updatedAt;
  int advId;

  ProductPriceModel({
    this.id,
    this.cashback,
    this.cId,
    this.productId,
    this.serialNumber,
    this.siteName,
    this.siteIcon,
    this.mrp,
    this.price,
    this.url,
    this.createdAt,
    this.updatedAt,
    this.advId,
  });

  ProductPriceModel.fromJson(Map<String, dynamic> json) {
    try {
      id = json["id"];
      cashback = json["cashback"];
      cId = json["c_id"];
      productId = json["product_id"];
      serialNumber = json["serial_number"];
      siteName = json["site_name"] != null ? json["site_name"] : '';
      siteIcon = json["site_icon"];
      mrp = json["mrp"];
      price = json["price"];
      url = json["url"];
      createdAt = json["created_at"] != null
          ? DateTime.parse(json["created_at"])
          : null;
      updatedAt = json["updated_at"] != null
          ? DateTime.parse(json["updated_at"])
          : null;
      advId = json["adv_id"];
    } catch (e) {
      print(
          "Exception -  ProductPriceModel.dart - ProductPriceModel.fromJson():" +
              e.toString());
    }
  }
}
