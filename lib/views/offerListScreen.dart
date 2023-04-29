import 'package:cashfuse/constants/appConstant.dart';
import 'package:cashfuse/controllers/homeController.dart';
import 'package:cashfuse/models/categoryModel.dart';
import 'package:cashfuse/views/adsDetailScreen.dart';
import 'package:cashfuse/views/campaignDetailScreen.dart';
import 'package:cashfuse/views/offerDetailScreen.dart';
import 'package:cashfuse/widget/drawerWidget.dart';
import 'package:cashfuse/widget/offerWidget.dart';
import 'package:cashfuse/widget/web/webTopBarWidget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cashfuse/utils/global.dart' as global;

class OfferListScreen extends StatelessWidget {
  final CategoryModel categoryModel;
  OfferListScreen({this.categoryModel});

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (homeController) {
      return Scaffold(
        key: scaffoldKey,
        drawer: global.getPlatFrom() ? DrawerWidget() : null,
        appBar: global.getPlatFrom()
            ? WebTopBarWidget(
                scaffoldKey: scaffoldKey,
              )
            : AppBar(
                leading: InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: Icon(
                    Icons.arrow_back,
                  ),
                ),
                title: Text(
                  categoryModel != null ? categoryModel.name : 'NEW FLASH DEALS - LIVE NOW',
                  style: Get.theme.primaryTextTheme.titleSmall.copyWith(color: Colors.white),
                ),
              ),
        body: Align(
          alignment: Alignment.topCenter,
          child: SizedBox(
            width: AppConstants.WEB_MAX_WIDTH,
            child: Column(
              children: [
                Expanded(
                  child: categoryModel != null
                      ? global.getPlatFrom()
                          ? GridView.builder(
                              //controller: homeController.scrollController,
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 4,
                                crossAxisSpacing: 15.0,
                                mainAxisSpacing: 15.0,
                                childAspectRatio: 1.4,
                              ),
                              itemCount: categoryModel.commonList.length,
                              shrinkWrap: true,
                              padding: EdgeInsets.all(10).copyWith(top: 20),
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () async {
                                    if (categoryModel.commonList[index].adId != null && categoryModel.commonList[index].adId.isNotEmpty) {
                                      await homeController.getAdDetails(categoryModel.commonList[index].adId);
                                      Get.to(
                                        () => AdsDetailScreen(
                                          ads: homeController.ads,
                                          fromSeeMore: false,
                                        ),
                                        routeName: 'detail',
                                      );
                                    } else {
                                      await homeController.getCampignDetails(categoryModel.commonList[index].campaignId.toString());
                                      Get.to(
                                        () => CampaignDetailScreen(
                                          campaign: homeController.campaign,
                                          fromSeeMore: false,
                                        ),
                                        routeName: 'detail',
                                      );
                                    }
                                  },
                                  child: OfferWidget(
                                    commonModel: categoryModel.commonList[index],
                                    fromList: true,
                                    domainImage: categoryModel.image,
                                  ),
                                );
                              },
                            )
                          : ListView.builder(
                              itemCount: categoryModel.commonList.length,
                              shrinkWrap: true,
                              padding: EdgeInsets.all(10),
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () async {
                                    if (categoryModel.commonList[index].adId != null && categoryModel.commonList[index].adId.isNotEmpty) {
                                      await homeController.getAdDetails(categoryModel.commonList[index].adId);
                                      Get.to(
                                        () => AdsDetailScreen(
                                          ads: homeController.ads,
                                          fromSeeMore: false,
                                        ),
                                        routeName: 'detail',
                                      );
                                    } else {
                                      await homeController.getCampignDetails(categoryModel.commonList[index].campaignId.toString());
                                      Get.to(
                                        () => CampaignDetailScreen(
                                          campaign: homeController.campaign,
                                          fromSeeMore: false,
                                        ),
                                        routeName: 'detail',
                                      );
                                    }
                                  },
                                  child: OfferWidget(
                                    commonModel: categoryModel.commonList[index],
                                    fromList: true,
                                    domainImage: categoryModel.image,
                                  ),
                                );
                              },
                            )
                      : global.getPlatFrom()
                          ? GridView.builder(
                              //controller: homeController.scrollController,
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 4,
                                crossAxisSpacing: 15.0,
                                mainAxisSpacing: 15.0,
                                childAspectRatio: 1.4,
                              ),
                              itemCount: homeController.newFlashOfferList.length,
                              shrinkWrap: true,
                              padding: EdgeInsets.all(10).copyWith(top: 20),
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () async {
                                    await homeController.getOfferDetails(
                                      homeController.newFlashOfferList[index].id.toString(),
                                    );
                                    Get.to(
                                      () => OfferDetailScreen(
                                        offer: homeController.offer,
                                        fromSeeMore: false,
                                      ),
                                      routeName: 'offer',
                                    );
                                  },
                                  child: OfferWidget(
                                    offer: homeController.newFlashOfferList[index],
                                    fromList: true,
                                  ),
                                );
                              },
                            )
                          : ListView.builder(
                              itemCount: homeController.newFlashOfferList.length,
                              shrinkWrap: true,
                              padding: EdgeInsets.all(10),
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () async {
                                    await homeController.getOfferDetails(
                                      homeController.newFlashOfferList[index].id.toString(),
                                    );
                                    Get.to(
                                      () => OfferDetailScreen(
                                        offer: homeController.offer,
                                        fromSeeMore: false,
                                      ),
                                      routeName: 'offer',
                                    );
                                  },
                                  child: OfferWidget(
                                    offer: homeController.newFlashOfferList[index],
                                    fromList: true,
                                  ),
                                );
                              },
                            ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
