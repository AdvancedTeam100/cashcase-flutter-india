class AllInOneSearchDataModel {
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
  dynamic description;
  int campaigns;
  DateTime createdAt;
  DateTime updatedAt;
  String trackingUrl;
  String tabColor;
  String searchUrl;

  AllInOneSearchDataModel({
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
    this.description,
    this.campaigns,
    this.createdAt,
    this.updatedAt,
    this.trackingUrl,
    this.tabColor,
    this.searchUrl,
  });

  AllInOneSearchDataModel.fromJson(Map<String, dynamic> json) {
    try {
      id = json["id"];
      campaignId = json["campaign_id"];
      name = json["name"] != null ? json["name"] : '';
      url = json["url"] != null ? json["url"] : '';
      domain = json["domain"] != null ? json["domain"] : '';
      payoutType = json["payout_type"];
      payout = json["payout"] != null ? json["payout"].toDouble() : 0.0;
      image = json["image"] != null ? json["image"] : '';
      category = json["category"];
      categoryId = json["category_id"];
      status = json["status"];
      buttonText = json["button_text"] != null ? json["button_text"] : '';
      affiliatePartner = json["affiliate_partner"];
      description = json["description"] != null ? json["description"] : '';
      campaigns = json["campaigns"];
      trackingUrl = json["tracking_url"] != null ? json["tracking_url"] : '';
      tabColor = json["tab_color"] != null ? json["tab_color"] : '';
      searchUrl = json["search_url"] != null ? json["search_url"] : '';
      createdAt = json["created_at"] != null ? DateTime.parse(json["created_at"]) : null;
      updatedAt = json["updated_at"] != null ? DateTime.parse(json["updated_at"]) : null;
    } catch (e) {
      print("Exception - AllInOneSearchDataModel.dart - AllInOneSearchDataModel.fromJson():" + e.toString());
    }
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "campaign_id": campaignId,
        "name": name,
        "url": url,
        "domain": domain,
        "payout_type": payoutType,
        "payout": payout,
        "image": image == null ? null : image,
        "category": category,
        "category_id": categoryId,
        "status": status,
        "button_text": buttonText,
        "affiliate_partner": affiliatePartner,
        "description": description,
        "campaigns": campaigns,
        "created_at": createdAt != null ? createdAt.toIso8601String() : null,
        "updated_at": updatedAt != null ? updatedAt.toIso8601String() : null,
        "tracking_url": trackingUrl,
        "tab_color": tabColor,
        "search_url": searchUrl,
      };
}
