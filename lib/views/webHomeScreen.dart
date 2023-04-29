// ignore_for_file: must_be_immutable

import 'package:cashfuse/constants/appConstant.dart';
import 'package:cashfuse/controllers/couponController.dart';
import 'package:cashfuse/controllers/homeController.dart';
import 'package:cashfuse/utils/global.dart' as global;
import 'package:cashfuse/utils/images.dart';
import 'package:cashfuse/views/admitedOfferDetailScreen.dart';
import 'package:cashfuse/views/adsCampaignWidgetListScreen.dart';
import 'package:cashfuse/views/adsDetailScreen.dart';
import 'package:cashfuse/views/allcategoriesScreen.dart';
import 'package:cashfuse/views/campaignDetailScreen.dart';
import 'package:cashfuse/views/couponDetailScreen.dart';
import 'package:cashfuse/views/couponListScreen.dart';
import 'package:cashfuse/views/offerDetailScreen.dart';
import 'package:cashfuse/views/offerListScreen.dart';
import 'package:cashfuse/views/utils/viewAllProductScreen.dart';
import 'package:cashfuse/widget/couponWidget.dart';
import 'package:cashfuse/widget/customImage.dart';
import 'package:cashfuse/widget/offerWidget.dart';
import 'package:cashfuse/widget/web/homeWebCategoryView.dart';
import 'package:cashfuse/widget/web/homeWebTopCashbackView.dart';
import 'package:cashfuse/widget/web/webBannerView.dart';
import 'package:cashfuse/widget/web/webFooterWidget.dart';
import 'package:cashfuse/widget/web/webHomeProductView.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:slide_countdown/slide_countdown.dart';

class WebHomeScreen extends StatelessWidget {
  HomeController homeController = Get.find<HomeController>();
  CouponController couponController = Get.find<CouponController>();
  final couponScrollController = new ScrollController();
  final offerScrollController = new ScrollController();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (controller) {
      return GetBuilder<CouponController>(builder: (controller) {
        return SingleChildScrollView(
          primary: true,
          child: Center(
            child: SizedBox(
              width: AppConstants.WEB_MAX_WIDTH,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  WebBannerView(homeController: homeController),
                  homeController.topCategoryList != null &&
                          homeController.topCategoryList.length > 0
                      ? Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 6, vertical: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                AppLocalizations.of(context).top_categories,
                                style: TextStyle(
                                  fontSize: global.getPlatFrom() ? 16 : 13,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black.withOpacity(0.79),
                                  letterSpacing: -0.3,
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  Get.to(
                                    () => AllCategoriesScreen(),
                                    routeName: 'allcategory',
                                  );
                                },
                                child: Text(
                                  '${AppLocalizations.of(context).view_all} >',
                                  style: Get.theme.primaryTextTheme.bodySmall
                                      .copyWith(
                                          color: Colors.teal,
                                          fontSize:
                                              global.getPlatFrom() ? 16 : null),
                                ),
                              )
                            ],
                          ),
                        )
                      : SizedBox(),
                  homeController.topCategoryList != null &&
                          homeController.topCategoryList.length > 0
                      ? HomeWebCategoryView()
                      : SizedBox(),
                  couponController.couponList != null &&
                          couponController.couponList.length > 0
                      ? Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 6, vertical: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                AppLocalizations.of(context)
                                    .coupons_of_the_day
                                    .toUpperCase(),
                                style: TextStyle(
                                  fontSize: global.getPlatFrom() ? 16 : 13,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black.withOpacity(0.79),
                                  letterSpacing: -0.3,
                                ),
                              ),
                              couponController.couponList.length > 6
                                  ? InkWell(
                                      onTap: () {
                                        Get.to(
                                          () => CouponListScreen(),
                                          routeName: 'coupon',
                                        );
                                      },
                                      child: Text(
                                        '${AppLocalizations.of(context).view_all} >',
                                        style: Get
                                            .theme.primaryTextTheme.bodySmall
                                            .copyWith(
                                                color: Colors.teal,
                                                fontSize: global.getPlatFrom()
                                                    ? 16
                                                    : null),
                                      ),
                                    )
                                  : SizedBox(),
                            ],
                          ),
                        )
                      : SizedBox(),
                  global.appInfo.baseUrls != null &&
                          couponController.isDataLoaded
                      ? couponController.couponList != null &&
                              couponController.couponList.length > 0
                          ? Row(
                              children: [
                                global.getPlatFrom()
                                    ? InkWell(
                                        onTap: () =>
                                            couponScrollController.animateTo(
                                                couponScrollController
                                                    .initialScrollOffset,
                                                duration: Duration(seconds: 1),
                                                curve: Curves.easeInOut),
                                        child: Container(
                                          width: 30,
                                          height: 80,
                                          margin: EdgeInsets.only(left: 5),
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.rectangle,
                                            color:
                                                Get.theme.secondaryHeaderColor,
                                          ),
                                          child: Icon(
                                            Icons.arrow_back,
                                            color: Colors.white,
                                          ),
                                        ),
                                      )
                                    : SizedBox(),
                                Expanded(
                                  child: SizedBox(
                                    height: GetPlatform.isWeb ? 106 : 100,
                                    child: ListView.builder(
                                      controller: couponScrollController,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 6),
                                      scrollDirection: Axis.horizontal,
                                      itemCount: couponController
                                                  .couponList.length >=
                                              5
                                          ? 5
                                          : couponController.couponList.length,
                                      shrinkWrap: true,
                                      itemBuilder: (context, index) {
                                        return InkWell(
                                          onTap: () {
                                            if (couponController
                                                    .couponList[index].offer !=
                                                null) {
                                              Get.to(
                                                () => OfferDetailScreen(
                                                  offer: couponController
                                                      .couponList[index].offer,
                                                  fromSeeMore: false,
                                                ),
                                                routeName: 'offer',
                                              );
                                            } else {
                                              Get.to(
                                                () => CouponDetailScreen(
                                                  coupon: couponController
                                                      .couponList[index],
                                                ),
                                                routeName: 'coupon',
                                              );
                                            }
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                right: 10),
                                            child: CouponWidget(
                                              coupon: couponController
                                                  .couponList[index],
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () => couponScrollController.animateTo(
                                      couponScrollController
                                          .position.maxScrollExtent,
                                      duration: Duration(seconds: 1),
                                      curve: Curves.easeInOut),
                                  child: Container(
                                    width: 30,
                                    height: 80,
                                    margin: EdgeInsets.only(left: 5),
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.rectangle,
                                      color: Get.theme.secondaryHeaderColor,
                                    ),
                                    child: Icon(
                                      Icons.arrow_forward,
                                      color: Colors.white,
                                    ),
                                  ),
                                )
                              ],
                            )
                          : SizedBox()
                      : SizedBox(
                          height: 150,
                          child: ListView.builder(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 6, vertical: 20),
                            scrollDirection: Axis.horizontal,
                            itemCount: 5,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return Shimmer(
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 10),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(9),
                                      color: Colors.grey[300],
                                    ),
                                    width: 280,
                                    // child:
                                    // CouponWidget(
                                    //   coupon: couponC.couponList[index],
                                    // ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                  homeController.exclusiveOfferList != null &&
                          homeController.exclusiveOfferList.length > 0
                      ? Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 6, vertical: 15),
                          child: Text(
                            AppLocalizations.of(context).exclusive_offers,
                            style: TextStyle(
                              fontSize: global.getPlatFrom() ? 16 : 13,
                              fontWeight: FontWeight.w600,
                              color: Colors.black.withOpacity(0.79),
                              letterSpacing: -0.3,
                            ),
                          ),
                        )
                      : SizedBox(),
                  global.appInfo.baseUrls != null &&
                          homeController.isOfferLoaded
                      ? homeController.exclusiveOfferList != null &&
                              homeController.exclusiveOfferList.length > 0
                          ? SizedBox(
                              height: global.getPlatFrom() ? 170 : 165,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount:
                                    homeController.exclusiveOfferList.length,
                                shrinkWrap: true,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 6),
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: () async {
                                      await homeController.getOfferDetails(
                                          homeController
                                              .exclusiveOfferList[index].id
                                              .toString());
                                      Get.to(
                                        () => OfferDetailScreen(
                                          offer: homeController.offer,
                                          fromSeeMore: false,
                                        ),
                                        routeName: 'offer',
                                      );
                                    },
                                    child: Container(
                                      width: global.getPlatFrom()
                                          ? 270
                                          : 240, //Get.width - 120,
                                      margin: EdgeInsets.only(right: 10),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Stack(
                                        alignment: Alignment.bottomLeft,
                                        children: [
                                          ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              child: CustomImage(
                                                image:
                                                    '${global.appInfo.baseUrls.offerImageUrl}/${homeController.exclusiveOfferList[index].bannerImage}',
                                                height: 170,
                                                width: Get.width,
                                                fit: BoxFit.fill,
                                                errorImage: Images.dummyImage,
                                              )
                                              // Image.asset(
                                              //   Images.dummyImage,
                                              //   height: 165,
                                              //   fit: BoxFit.cover,
                                              // ),
                                              ),
                                          Align(
                                            alignment: Alignment.topLeft,
                                            child: Card(
                                              color: Colors.white,
                                              margin: EdgeInsets.all(10),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(2.0),
                                                child: CustomImage(
                                                  image:
                                                      '${global.appInfo.baseUrls.offerImageUrl}/${homeController.exclusiveOfferList[index].image}',
                                                  height: 30,
                                                  width: 60,
                                                  fit: BoxFit.contain,
                                                ),
                                              ),
                                            ),
                                          ),
                                          homeController
                                                          .exclusiveOfferList[
                                                              index]
                                                          .dayDifference !=
                                                      null &&
                                                  homeController
                                                          .exclusiveOfferList[
                                                              index]
                                                          .dayDifference >
                                                      0
                                              ? Padding(
                                                  padding:
                                                      const EdgeInsets.all(10),
                                                  child: SlideCountdown(
                                                    slideDirection:
                                                        SlideDirection.none,
                                                    textStyle: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 10,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                    decoration: BoxDecoration(
                                                      color: Colors.red[800],
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              3),
                                                    ),
                                                    duration: Duration(
                                                      days: homeController
                                                          .exclusiveOfferList[
                                                              index]
                                                          .dayDifference,
                                                    ),
                                                  ),
                                                )
                                              : SizedBox()
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ))
                          : SizedBox()
                      : SizedBox(
                          height: 165,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: 5,
                              shrinkWrap: true,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 6, vertical: 20),
                              itemBuilder: (context, index) {
                                return Shimmer(
                                  duration: Duration(seconds: 2),
                                  child: Container(
                                    width: 240,
                                    height: 165,
                                    margin: EdgeInsets.only(right: 15),
                                    decoration: BoxDecoration(
                                      color: Colors.grey[300],
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                );
                              }),
                        ),
                  homeController.topCashbackList != null &&
                          homeController.topCashbackList.length > 0
                      ? Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 6, vertical: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                AppLocalizations.of(context)
                                    .top_cashback_stores,
                                style: TextStyle(
                                  fontSize: global.getPlatFrom() ? 16 : 13,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black.withOpacity(0.79),
                                  letterSpacing: -0.3,
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  Get.to(
                                    () => AdsCampaignWidgetListScreen(
                                      title: AppLocalizations.of(context)
                                          .top_cashback_stores,
                                    ),
                                    routeName: 'all',
                                  );
                                },
                                child: Text(
                                  '${AppLocalizations.of(context).view_all} >',
                                  style: Get.theme.primaryTextTheme.bodySmall
                                      .copyWith(
                                          color: Colors.teal,
                                          fontSize:
                                              global.getPlatFrom() ? 16 : null),
                                ),
                              )
                            ],
                          ),
                        )
                      : SizedBox(),
                  HomeWebTopCashbackView(),
                  homeController.productList != null &&
                          homeController.productList.length > 0
                      ? Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 6)
                              .copyWith(top: 25, bottom: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "LATEST PRODUCTS",
                                style: TextStyle(
                                  fontSize: global.getPlatFrom() ? 16 : 13,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black.withOpacity(0.79),
                                  letterSpacing: -0.3,
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  Get.to(
                                    () => ViewAllProductScreen(
                                      productList: homeController.productList,
                                      title: "TRENDING PRODUCTS",
                                    ),
                                    routeName: 'all',
                                  );
                                },
                                child: Text(
                                  '${AppLocalizations.of(context).view_all} >',
                                  style: Get.theme.primaryTextTheme.bodySmall
                                      .copyWith(
                                          color: Colors.teal,
                                          fontSize:
                                              global.getPlatFrom() ? 16 : null),
                                ),
                              )
                            ],
                          ),
                        )
                      : SizedBox(),
                  WebHomeProductView(),
                  homeController.newFlashOfferList != null &&
                          homeController.newFlashOfferList.length > 0
                      ? Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 6)
                              .copyWith(top: 25, bottom: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'NEW FLASH DEALS - LIVE NOW',
                                style: TextStyle(
                                  fontSize: global.getPlatFrom() ? 16 : 13,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black.withOpacity(0.79),
                                  letterSpacing: -0.3,
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  Get.to(
                                    () => OfferListScreen(),
                                    routeName: 'all',
                                  );
                                },
                                child: Text(
                                  '${AppLocalizations.of(context).view_all} >',
                                  style: Get.theme.primaryTextTheme.bodySmall
                                      .copyWith(
                                          color: Colors.teal,
                                          fontSize:
                                              global.getPlatFrom() ? 16 : null),
                                ),
                              )
                            ],
                          ),
                        )
                      : SizedBox(),
                  global.appInfo.baseUrls != null &&
                          homeController.isFlashOffersLoaded
                      ? homeController.newFlashOfferList != null &&
                              homeController.newFlashOfferList.length > 0
                          ? Row(
                              children: [
                                global.getPlatFrom()
                                    ? InkWell(
                                        onTap: () =>
                                            offerScrollController.animateTo(
                                                offerScrollController
                                                    .initialScrollOffset,
                                                duration: Duration(seconds: 1),
                                                curve: Curves.easeInOut),
                                        child: Container(
                                          width: 30,
                                          height: 80,
                                          margin: EdgeInsets.only(left: 5),
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.rectangle,
                                            color:
                                                Get.theme.secondaryHeaderColor,
                                          ),
                                          child: Icon(
                                            Icons.arrow_back,
                                            color: Colors.white,
                                          ),
                                        ),
                                      )
                                    : SizedBox(),
                                Expanded(
                                  child: SizedBox(
                                    height: global.getPlatFrom() ? 230 : 200,
                                    child: ListView.builder(
                                      itemCount: homeController
                                          .newFlashOfferList.length,
                                      shrinkWrap: true,
                                      controller: offerScrollController,
                                      scrollDirection: Axis.horizontal,
                                      physics: AlwaysScrollableScrollPhysics(),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 6),
                                      itemBuilder: (context, index) {
                                        return InkWell(
                                          onTap: () async {
                                            await homeController
                                                .getOfferDetails(homeController
                                                    .newFlashOfferList[index].id
                                                    .toString());
                                            Get.to(
                                              () => OfferDetailScreen(
                                                offer: homeController.offer,
                                                fromSeeMore: false,
                                              ),
                                              routeName: 'offer',
                                            );
                                          },
                                          child: OfferWidget(
                                            offer: homeController
                                                .newFlashOfferList[index],
                                            fromList: false,
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                                global.getPlatFrom()
                                    ? InkWell(
                                        onTap: () =>
                                            offerScrollController.animateTo(
                                                offerScrollController
                                                    .position.viewportDimension,
                                                duration: Duration(seconds: 1),
                                                curve: Curves.easeInOut),
                                        child: Container(
                                          width: 30,
                                          height: 80,
                                          margin: EdgeInsets.only(right: 5),
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.rectangle,
                                            color:
                                                Get.theme.secondaryHeaderColor,
                                          ),
                                          child: Icon(
                                            Icons.arrow_forward,
                                            color: Colors.white,
                                          ),
                                        ),
                                      )
                                    : SizedBox(),
                              ],
                            )
                          : SizedBox()
                      : SizedBox(
                          height: 200,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: 5,
                              shrinkWrap: true,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 6),
                              itemBuilder: (context, index) {
                                return Shimmer(
                                  duration: Duration(seconds: 2),
                                  child: Container(
                                    width: 330,
                                    margin: EdgeInsets.only(right: 15),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Column(
                                      children: [
                                        Container(
                                          width: 300,
                                          height: 145,
                                          decoration: BoxDecoration(
                                            color: Colors.grey[300],
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(11),
                                              topRight: Radius.circular(11),
                                            ),
                                          ),
                                        ),
                                        Align(
                                          alignment: Alignment.centerRight,
                                          child: Container(
                                            height: 35,
                                            width: 80,
                                            margin: EdgeInsets.symmetric(
                                                vertical: 10, horizontal: 20),
                                            decoration: BoxDecoration(
                                              color: Colors.grey[300],
                                              borderRadius:
                                                  BorderRadius.circular(2),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }),
                        ),
                  homeController.productList != null &&
                          homeController.productList.length > 0
                      ? Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 6)
                              .copyWith(top: 25, bottom: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "TRENDING PRODUCTS",
                                style: TextStyle(
                                  fontSize: global.getPlatFrom() ? 16 : 13,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black.withOpacity(0.79),
                                  letterSpacing: -0.3,
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  Get.to(
                                    () => ViewAllProductScreen(
                                      productList:
                                          homeController.trendingProductList,
                                      title: "TRENDING PRODUCTS",
                                    ),
                                    routeName: 'all',
                                  );
                                },
                                child: Text(
                                  '${AppLocalizations.of(context).view_all} >',
                                  style: Get.theme.primaryTextTheme.bodySmall
                                      .copyWith(
                                          color: Colors.teal,
                                          fontSize:
                                              global.getPlatFrom() ? 16 : null),
                                ),
                              )
                            ],
                          ),
                        )
                      : SizedBox(),
                  WebHomeProductView(),
                  ListView.builder(
                    itemCount: homeController.homeAdvList.length,
                    shrinkWrap: true,
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return global.appInfo.baseUrls != null &&
                              homeController.isHomeAdvLoaded
                          ? homeController.homeAdvList[index].commonList !=
                                      null &&
                                  homeController.homeAdvList[index].commonList
                                          .length >
                                      0
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                              horizontal: 6)
                                          .copyWith(top: 25, bottom: 10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            homeController
                                                .homeAdvList[index].name
                                                .toUpperCase(),
                                            style: TextStyle(
                                              fontSize: global.getPlatFrom()
                                                  ? 16
                                                  : 13,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.black
                                                  .withOpacity(0.79),
                                              letterSpacing: -0.3,
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              Get.to(
                                                () => OfferListScreen(
                                                  categoryModel: homeController
                                                      .homeAdvList[index],
                                                ),
                                                routeName: 'all',
                                              );
                                            },
                                            child: Text(
                                              '${AppLocalizations.of(context).view_all} >',
                                              style: Get.theme.primaryTextTheme
                                                  .bodySmall
                                                  .copyWith(
                                                      color: Colors.teal,
                                                      fontSize:
                                                          global.getPlatFrom()
                                                              ? 16
                                                              : null),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          bottom: (global.getPlatFrom() &&
                                                  (homeController
                                                              .homeAdvList[
                                                                  index]
                                                              .commonList
                                                              .length -
                                                          1) !=
                                                      null)
                                              ? 20
                                              : 0),
                                      child: SizedBox(
                                        height:
                                            global.getPlatFrom() ? 230 : 200,
                                        child: ListView.builder(
                                            itemCount: homeController
                                                .homeAdvList[index]
                                                .commonList
                                                .length,
                                            shrinkWrap: true,
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 6),
                                            scrollDirection: Axis.horizontal,
                                            itemBuilder: (context, i) {
                                              return InkWell(
                                                onTap: () async {
                                                  if (homeController
                                                              .homeAdvList[
                                                                  index]
                                                              .commonList[i]
                                                              .adId !=
                                                          null &&
                                                      homeController
                                                          .homeAdvList[index]
                                                          .commonList[i]
                                                          .adId
                                                          .isNotEmpty) {
                                                    await homeController
                                                        .getAdDetails(
                                                            homeController
                                                                .homeAdvList[
                                                                    index]
                                                                .commonList[i]
                                                                .adId);
                                                    Get.to(
                                                      () => AdsDetailScreen(
                                                        ads: homeController.ads,
                                                        fromSeeMore: false,
                                                      ),
                                                      routeName: 'detail',
                                                    );
                                                  } else if (homeController
                                                          .homeAdvList[index]
                                                          .commonList[i]
                                                          .from ==
                                                      'admit') {
                                                    await homeController
                                                        .getAdmitedDetails(
                                                            homeController
                                                                .homeAdvList[
                                                                    index]
                                                                .commonList[i]
                                                                .campaignId);

                                                    Get.to(
                                                        () =>
                                                            AdmitedDetailScreen(
                                                              admitedData:
                                                                  homeController
                                                                      .admitedOffer,
                                                              fromSeeMore:
                                                                  false,
                                                            ),
                                                        routeName: 'detail');
                                                  } else {
                                                    await homeController
                                                        .getCampignDetails(
                                                            homeController
                                                                .homeAdvList[
                                                                    index]
                                                                .commonList[i]
                                                                .campaignId
                                                                .toString());
                                                    Get.to(
                                                      () =>
                                                          CampaignDetailScreen(
                                                        campaign: homeController
                                                            .campaign,
                                                        fromSeeMore: false,
                                                      ),
                                                      routeName: 'detail',
                                                    );
                                                  }
                                                },
                                                child: OfferWidget(
                                                  commonModel: homeController
                                                      .homeAdvList[index]
                                                      .commonList[i],
                                                  domainImage: homeController
                                                      .homeAdvList[index].image,
                                                  fromList: false,
                                                ),
                                              );
                                            }),
                                      ),
                                    ),
                                  ],
                                )
                              : SizedBox()
                          : SizedBox(
                              height: 230,
                              child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: 5,
                                  shrinkWrap: true,
                                  padding: const EdgeInsets.only(
                                      top: 20, bottom: 10),
                                  itemBuilder: (context, index) {
                                    return Shimmer(
                                      duration: Duration(seconds: 2),
                                      child: Container(
                                        width: Get.width - 60,
                                        margin: EdgeInsets.only(right: 15),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Column(
                                          children: [
                                            Container(
                                              width: Get.width - 60,
                                              height: 145,
                                              decoration: BoxDecoration(
                                                color: Colors.grey[300],
                                                borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(11),
                                                  topRight: Radius.circular(11),
                                                ),
                                              ),
                                            ),
                                            Align(
                                              alignment: Alignment.centerRight,
                                              child: Container(
                                                height: 35,
                                                width: 80,
                                                margin: EdgeInsets.symmetric(
                                                    vertical: 10,
                                                    horizontal: 20),
                                                decoration: BoxDecoration(
                                                  color: Colors.grey[300],
                                                  borderRadius:
                                                      BorderRadius.circular(2),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  }),
                            );
                    },
                  ),
                  GetPlatform.isWeb ? WebFooterWidget() : SizedBox(),
                ],
              ),
            ),
          ),
        );
      });
    });
  }
}
