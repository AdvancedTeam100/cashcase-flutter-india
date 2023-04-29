class BaseUrls {
  String offerImageUrl;
  String partnerImageUrl;
  String userImageUrl;
  String categoryImageUrl;
  String businessLogoUrl;
  String bannerImageUrl;
  String faqImageUrl;
  String couponBannerImageUrl;
  String orderImageUrl;
  String notificationBannerImageUrl;
  String productImageurl;
  String productSiteUrl;

  BaseUrls({
    this.offerImageUrl,
    this.partnerImageUrl,
    this.userImageUrl,
    this.categoryImageUrl,
    this.businessLogoUrl,
    this.bannerImageUrl,
    this.faqImageUrl,
    this.couponBannerImageUrl,
    this.orderImageUrl,
    this.productImageurl,
    this.productSiteUrl,
  });

  BaseUrls.fromJson(Map<String, dynamic> json) {
    try {
      offerImageUrl = json["offer_image_url"] != null ? json["offer_image_url"] : '';
      partnerImageUrl = json["partner_image_url"] != null ? json["partner_image_url"] : '';
      userImageUrl = json["user_image_url"] != null ? json["user_image_url"] : '';
      categoryImageUrl = json["category_image_url"] != null ? json["category_image_url"] : '';
      businessLogoUrl = json["business_logo_url"] != null ? json["business_logo_url"] : '';
      bannerImageUrl = json["banner_image_url"] != null ? json["banner_image_url"] : '';
      faqImageUrl = json["faq_image_url"] != null ? json["faq_image_url"] : '';
      couponBannerImageUrl = json["coupon_banner_url"] != null ? json["coupon_banner_url"] : '';
      orderImageUrl = json["order_image_url"] != null ? json["order_image_url"] : '';
      notificationBannerImageUrl = json["notification_image_url"] != null ? json["notification_image_url"] : '';
      productImageurl = json["product_image_url"] != null ? json["product_image_url"] : '';
      productSiteUrl = json["product_site_url"] != null ? json["product_site_url"] : '';
    } catch (e) {
      print("Exception - BaseUrls.dart - BaseUrls.fromJson():" + e.toString());
    }
  }
}
