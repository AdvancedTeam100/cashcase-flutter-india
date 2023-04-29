// ignore_for_file: must_be_immutable

import 'package:cashfuse/controllers/homeController.dart';
import 'package:cashfuse/controllers/searchController.dart';
import 'package:cashfuse/models/commonModel.dart';
import 'package:cashfuse/utils/global.dart' as global;
import 'package:cashfuse/utils/images.dart';
import 'package:cashfuse/views/adsCampaignWidgetListScreen.dart';
import 'package:cashfuse/views/adsDetailScreen.dart';
import 'package:cashfuse/views/bottomNavigationBarScreen.dart';
import 'package:cashfuse/views/campaignDetailScreen.dart';
import 'package:cashfuse/views/categoryScreen.dart';
import 'package:cashfuse/views/offerDetailScreen.dart';
import 'package:cashfuse/widget/adsCampaignWidget.dart';
import 'package:cashfuse/widget/customImage.dart';
import 'package:cashfuse/widget/offerWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:slide_countdown/slide_countdown.dart';

class SearchScreen extends StatelessWidget {
  final Color bgColor;
  SearchScreen({this.bgColor});
  SearchController searchController = Get.find<SearchController>();
  HomeController homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[200],
        elevation: 0,
        leading: InkWell(
          onTap: () async {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => BottomNavigationBarScreen(
                  pageIndex: 0,
                ),
              ),
            );
          },
          child: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        title: TextFormField(
          controller: searchController.searchString,
          cursorColor: Colors.orange,
          style: Get.theme.primaryTextTheme.bodySmall.copyWith(color: Colors.black),
          decoration: InputDecoration(
            suffix: searchController.searchString.text.isNotEmpty
                ? InkWell(
                    onTap: () {
                      searchController.searchString.clear();
                      searchController.searchData = null;
                      searchController.update();
                    },
                    child: Icon(
                      Icons.close,
                      color: Colors.black,
                    ),
                  )
                : SizedBox(),
            border: InputBorder.none,
            hintText: 'What do you want to buy today?',
            hintStyle: Get.theme.primaryTextTheme.bodySmall.copyWith(color: Colors.black.withOpacity(0.4)),
          ),
          onEditingComplete: () {
            searchController.getSearchData(searchController.searchString.text.trim());
          },
        ),
      ),
      body: GetBuilder<SearchController>(builder: (controller) {
        return searchController.searchData != null
            ? searchController.searchData.advertiserList.isEmpty && searchController.searchData.commonList.isEmpty && searchController.searchData.offerList.isEmpty
                ? Center(child: Text(AppLocalizations.of(context).no_data_found))
                : SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        searchController.searchData.advertiserList != null && searchController.searchData.advertiserList.length > 0
                            ? Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                child: Text(
                                  'in Stores',
                                  style: Get.theme.primaryTextTheme.titleSmall,
                                ),
                              )
                            : SizedBox(),
                        searchController.searchData.advertiserList != null && searchController.searchData.advertiserList.length > 0
                            ? SizedBox(
                                height: 155,
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemCount: searchController.searchData.advertiserList.length,
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                      onTap: () {
                                        Get.to(
                                          () => CategoryScreen(
                                            category: searchController.searchData.advertiserList[index],
                                          ),
                                          routeName: 'category',
                                        );
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.only(right: 12),
                                        child: SizedBox(
                                          width: 155,
                                          child: AdsCampaignWidget(
                                            commonModel: CommonModel(
                                              name: searchController.searchData.advertiserList[index].name,
                                              image: '${global.appInfo.baseUrls.partnerImageUrl}/${searchController.searchData.advertiserList[index].image}',
                                              tagline: searchController.searchData.advertiserList[index].tagline,
                                              adId: searchController.searchData.advertiserList[index].id.toString(),
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              )
                            : SizedBox(),
                        searchController.searchData.commonList != null && searchController.searchData.commonList.length > 0
                            ? Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                child: Text(
                                  'in Offers & Deals',
                                  style: Get.theme.primaryTextTheme.titleSmall,
                                ),
                              )
                            : SizedBox(),
                        searchController.searchData.commonList != null && searchController.searchData.commonList.length > 0
                            ? SizedBox(
                                height: 155,
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemCount: searchController.searchData.commonList.length,
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                      onTap: () async {
                                        if (searchController.searchData.commonList[index].adId != null && searchController.searchData.commonList[index].adId.isNotEmpty) {
                                          await homeController.getAdDetails(searchController.searchData.commonList[index].adId);
                                          Get.to(
                                            () => AdsDetailScreen(
                                              ads: homeController.ads,
                                              fromSeeMore: false,
                                            ),
                                            routeName: 'detail',
                                          );
                                        } else {
                                          await homeController.getCampignDetails(searchController.searchData.commonList[index].campaignId.toString());
                                          Get.to(
                                            () => CampaignDetailScreen(
                                              campaign: homeController.campaign,
                                              fromSeeMore: false,
                                            ),
                                            routeName: 'detail',
                                          );
                                        }
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.only(right: 15),
                                        child: SizedBox(
                                          width: 155,
                                          child: AdsCampaignWidget(
                                            commonModel: searchController.searchData.commonList[index],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              )
                            : SizedBox(),
                        searchController.searchData.offerList != null && searchController.searchData.offerList.length > 0
                            ? SizedBox(
                                height: global.getPlatFrom() ? 260 : 230,
                                child: ListView.builder(
                                  itemCount: searchController.searchData.offerList.length,
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 15),
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                      onTap: () async {
                                        await homeController.getOfferDetails(searchController.searchData.offerList[index].id.toString());
                                        Get.to(
                                          () => OfferDetailScreen(
                                            offer: homeController.offer,
                                            fromSeeMore: false,
                                          ),
                                          routeName: 'offer',
                                        );
                                      },
                                      child: OfferWidget(
                                        offer: searchController.searchData.offerList[index],
                                        fromList: false,
                                      ),
                                    );
                                  },
                                ),
                              )
                            : SizedBox(),
                      ],
                    ),
                  )
            : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Text(
                          'Trending Keywords',
                          style: Get.theme.primaryTextTheme.titleSmall,
                        ),
                      ),
                      Wrap(
                        runSpacing: 0,
                        spacing: 10,
                        children: List.generate(searchController.searchKeywordList.length, (index) {
                          return InkWell(
                            onTap: () {
                              searchController.getSearchData(searchController.searchKeywordList[index].name);
                            },
                            child: Chip(
                              label: Text(
                                searchController.searchKeywordList[index].name,
                              ),
                            ),
                          );
                        }),
                      ),
                      GetBuilder<HomeController>(builder: (hmController) {
                        return hmController.topCashbackList != null && hmController.topCashbackList.length > 0
                            ? Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 20),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      AppLocalizations.of(context).top_cashback_stores,
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black.withOpacity(0.79),
                                        letterSpacing: -0.3,
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        Get.to(
                                          () => AdsCampaignWidgetListScreen(
                                            title: AppLocalizations.of(context).top_cashback_stores,
                                          ),
                                          routeName: 'all',
                                        );
                                      },
                                      child: Text(
                                        '${AppLocalizations.of(context).view_all} >',
                                        style: Get.theme.primaryTextTheme.bodySmall.copyWith(color: Colors.teal),
                                      ),
                                    )
                                  ],
                                ),
                              )
                            : SizedBox();
                      }),
                      GetBuilder<HomeController>(builder: (hmController) {
                        return hmController.isTopCashbackLoaded
                            ? hmController.topCashbackList != null && hmController.topCashbackList.length > 0
                                ? SizedBox(
                                    height: 155,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: hmController.topCashbackList.length > 6 ? 6 : hmController.topCashbackList.length,
                                      shrinkWrap: true,
                                      padding: EdgeInsets.zero,
                                      itemBuilder: (context, index) {
                                        return InkWell(
                                          onTap: () {
                                            Get.to(
                                              () => CategoryScreen(
                                                category: hmController.topCashbackList[index],
                                              ),
                                              routeName: 'category',
                                            );
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.only(right: 13),
                                            child: SizedBox(
                                              width: 155,
                                              child: AdsCampaignWidget(
                                                commonModel: CommonModel(
                                                  name: hmController.topCashbackList[index].name,
                                                  image: '${global.appInfo.baseUrls.partnerImageUrl}/${hmController.topCashbackList[index].image}',
                                                  tagline: hmController.topCashbackList[index].tagline,
                                                  adId: hmController.topCashbackList[index].id.toString(),
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  )
                                : SizedBox()
                            : SizedBox(
                                height: 155,
                                child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: 5,
                                    shrinkWrap: true,
                                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 20),
                                    itemBuilder: (context, index) {
                                      return Shimmer(
                                        duration: Duration(seconds: 2),
                                        child: Container(
                                          width: 155,
                                          margin: EdgeInsets.only(right: 15),
                                          decoration: BoxDecoration(
                                            color: Colors.grey[300],
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                        ),
                                      );
                                    }),
                              );
                      }),
                      GetBuilder<HomeController>(builder: (hmCon) {
                        return hmCon.exclusiveOfferList != null && hmCon.exclusiveOfferList.length > 0
                            ? Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 15),
                                child: Text(
                                  AppLocalizations.of(context).exclusive_offers,
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black.withOpacity(0.79),
                                    letterSpacing: -0.3,
                                  ),
                                ),
                              )
                            : SizedBox();
                      }),
                      GetBuilder<HomeController>(builder: (hmCon) {
                        return hmCon.isOfferLoaded
                            ? hmCon.exclusiveOfferList != null && hmCon.exclusiveOfferList.length > 0
                                ? SizedBox(
                                    height: 165,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: hmCon.exclusiveOfferList.length,
                                      shrinkWrap: true,
                                      padding: EdgeInsets.zero,
                                      itemBuilder: (context, index) {
                                        return InkWell(
                                          onTap: () async {
                                            await hmCon.getOfferDetails(hmCon.exclusiveOfferList[index].id.toString());
                                            Get.to(
                                              () => OfferDetailScreen(
                                                offer: hmCon.offer,
                                                fromSeeMore: false,
                                              ),
                                              routeName: 'offer',
                                            );
                                          },
                                          child: Container(
                                            width: 240, //Get.width - 120,
                                            margin: EdgeInsets.only(right: 10),
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.circular(10),
                                            ),
                                            child: Stack(
                                              alignment: Alignment.bottomLeft,
                                              children: [
                                                ClipRRect(
                                                    borderRadius: BorderRadius.circular(10),
                                                    child: CustomImage(
                                                      image: '${global.appInfo.baseUrls.offerImageUrl}/${hmCon.exclusiveOfferList[index].bannerImage}',
                                                      height: 165,
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
                                                      padding: const EdgeInsets.all(2.0),
                                                      child: CustomImage(
                                                        image: '${global.appInfo.baseUrls.offerImageUrl}/${hmCon.exclusiveOfferList[index].image}',
                                                        height: 30,
                                                        width: 60,
                                                        fit: BoxFit.contain,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                hmCon.exclusiveOfferList[index].dayDifference != null && hmCon.exclusiveOfferList[index].dayDifference > 0
                                                    ? Padding(
                                                        padding: const EdgeInsets.all(10),
                                                        child: SlideCountdown(
                                                          slideDirection: SlideDirection.none,
                                                          textStyle: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w600),
                                                          decoration: BoxDecoration(
                                                            color: Colors.red[800],
                                                            borderRadius: BorderRadius.circular(3),
                                                          ),
                                                          duration: Duration(
                                                            days: hmCon.exclusiveOfferList[index].dayDifference,
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
                                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 20),
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
                              );
                      }),
                    ],
                  ),
                ),
              );
      }),
    );
  }
}
