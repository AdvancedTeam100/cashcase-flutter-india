// ignore_for_file: must_be_immutable

import 'package:cashfuse/constants/appConstant.dart';
import 'package:cashfuse/controllers/adController.dart';
import 'package:cashfuse/controllers/homeController.dart';
import 'package:cashfuse/models/categoryModel.dart';
import 'package:cashfuse/utils/global.dart' as global;
import 'package:cashfuse/views/adsDetailScreen.dart';
import 'package:cashfuse/views/campaignDetailScreen.dart';
import 'package:cashfuse/widget/admobNativeAdWidget.dart';
import 'package:cashfuse/widget/adsCampaignWidget.dart';
import 'package:cashfuse/widget/drawerWidget.dart';
import 'package:cashfuse/widget/fbNativeAdWidget.dart';
import 'package:cashfuse/widget/web/webAdsCampaignWidget.dart';
import 'package:cashfuse/widget/web/webTopBarWidget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'admitedOfferDetailScreen.dart';

class CategoryScreen extends StatefulWidget {
  final String title;
  final CategoryModel category;
  // CategoryModel category = Get.arguments;
  CategoryScreen({this.category, this.title});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  HomeController homeController = Get.find<HomeController>();

  final scaffoldKey = GlobalKey<ScaffoldState>();

  AdController _adController = Get.find<AdController>();

  String currentPlatform() {
    if (GetPlatform.isAndroid) {
      return 'android';
    } else if (GetPlatform.isIOS) {
      return 'ios';
    }
    return '';
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      drawer: global.getPlatFrom() ? DrawerWidget() : null,
      appBar: global.getPlatFrom()
          ? WebTopBarWidget(
              scaffoldKey: scaffoldKey,
            )
          : AppBar(
              elevation: 0,
              leading: InkWell(
                onTap: () {
                  Get.back();
                },
                child: Icon(
                  Icons.arrow_back,
                ),
              ),
              title: Text(
                widget.category != null ? widget.category.name : '',
                style: Get.theme.primaryTextTheme.titleSmall
                    .copyWith(color: Colors.white),
              ),
            ),
      body: GetBuilder<AdController>(builder: (adController) {
        return SingleChildScrollView(
          child: Align(
            alignment: Alignment.topCenter,
            child: SizedBox(
              width: AppConstants.WEB_MAX_WIDTH,
              child: Column(
                children: [
                  GetBuilder<AdController>(
                    builder: (adController) {
                      return _adController.isfbNativeAd2Exist
                          ? FbNativeAdWidget(
                              adId:
                                  "VID_HD_16_9_46S_APP_INSTALL#536153035214384_536880055141682",
                            )
                          : SizedBox();
                    },
                  ),
                  GetBuilder<AdController>(
                    builder: (adController) {
                      return _adController.isAdmobNativeAd2Exist
                          ? AdmobNativeAdWidget(
                              adId: 'ca-app-pub-3940256099942544/2247696110',
                            )
                          : SizedBox();
                    },
                  ),
                  widget.category.commonList != null &&
                          widget.category.commonList.length > 0
                      ? GetBuilder<HomeController>(builder: (controller) {
                          return GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: global.getPlatFrom() ? 4 : 2,
                              crossAxisSpacing:
                                  global.getPlatFrom() ? 25 : 15.0,
                              mainAxisSpacing: global.getPlatFrom() ? 25 : 15.0,
                            ),
                            itemCount: widget.category.commonList.length,
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 20),
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () async {
                                  if (widget.category.commonList[index].adId !=
                                          null &&
                                      widget.category.commonList[index].adId
                                          .isNotEmpty) {
                                    await homeController.getAdDetails(
                                        widget.category.commonList[index].adId);
                                    Get.to(
                                      () => AdsDetailScreen(
                                        ads: homeController.ads,
                                        fromSeeMore: false,
                                      ),
                                      routeName: 'detail',
                                    );
                                  } else if (widget
                                          .category.commonList[index].from
                                          .toString() ==
                                      "admit") {
                                    await homeController.getAdmitedDetails(
                                        widget.category.commonList[index]
                                            .campaignId);

                                    Get.to(
                                        () => AdmitedDetailScreen(
                                              admitedData:
                                                  controller.admitedOffer,
                                              fromSeeMore: false,
                                            ),
                                        routeName: 'detail');
                                    // print('jkabshjd');
                                    // print(
                                    //     '${widget.category.commonList[index].from}');

                                    // if (widget.category.commonList[index].from
                                    //         .toString() ==
                                    //     "admit") {
                                    //   // await homeController.getCampignDetails(widget.category.commonList[index].campaignId.toString());
                                    //   _admitedOffers
                                    //       .admitedOfferDetails(widget.category
                                    //           .commonList[index].campaignId
                                    //           .toString())
                                    //       .then((value) {
                                    //     value['status'].toString() == "0"
                                    //         ? null
                                    //         : Get.to(
                                    //             () => AdmitedDetailScreen(
                                    //                 fromSeeMore: false,
                                    //                 admitedData: _admitedOffers
                                    //                     .admitedData),
                                    //             routeName: 'detail');
                                    //   });
                                  } else {
                                    await homeController.getCampignDetails(
                                        widget.category.commonList[index]
                                            .campaignId
                                            .toString());
                                    print('jasbhjd');
                                    print('${homeController.campaign}');
                                    Get.to(
                                        () => CampaignDetailScreen(
                                              campaign: homeController.campaign,
                                              fromSeeMore: false,
                                            ),
                                        routeName: 'detail');
                                  }
                                },
                                child: global.getPlatFrom()
                                    ? WebAdsCampaignWidget(
                                        fromWebHome: false,
                                        commonModel:
                                            widget.category.commonList[index],
                                      )
                                    : AdsCampaignWidget(
                                        commonModel:
                                            widget.category.commonList[index],
                                      ),
                              );
                            },
                          );
                        })
                      : SizedBox(
                          // height: Get.height,
                          child: Center(
                            child: Text(
                              'No data found.',
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
