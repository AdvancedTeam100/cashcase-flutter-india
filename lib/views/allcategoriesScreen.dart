// ignore_for_file: must_be_immutable

import 'package:cashfuse/constants/appConstant.dart';
import 'package:cashfuse/controllers/adController.dart';
import 'package:cashfuse/controllers/homeController.dart';
import 'package:cashfuse/utils/global.dart' as global;
import 'package:cashfuse/views/categoryScreen.dart';
import 'package:cashfuse/widget/admobNativeAdWidget.dart';
import 'package:cashfuse/widget/customImage.dart';
import 'package:cashfuse/widget/drawerWidget.dart';
import 'package:cashfuse/widget/fbNativeAdWidget.dart';
import 'package:cashfuse/widget/web/webTopBarWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';

class AllCategoriesScreen extends StatelessWidget {
  HomeController homeController = Get.find<HomeController>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  AdController _adController = Get.find<AdController>();

  void paginateTask() {
    homeController.catScrollController.addListener(() async {
      if (homeController.catScrollController.position.pixels ==
          homeController.catScrollController.position.maxScrollExtent) {
        homeController.isMoreDataAvailable.value = true;
        print('Reached end');
        await homeController.getTopCategories();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    paginateTask();

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
                AppLocalizations.of(context).all_categories,
                style: Get.theme.primaryTextTheme.titleSmall
                    .copyWith(color: Colors.white),
              ),
            ),
      body: GetBuilder<HomeController>(builder: (controller) {
        return Align(
          alignment: Alignment.topCenter,
          child: SizedBox(
            width: AppConstants.WEB_MAX_WIDTH,
            child: SingleChildScrollView(
              controller: controller.catScrollController,
              child: Column(
                children: [
                  GridView.builder(
                    //controller: controller.scrollController,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: global.getPlatFrom() ? 6 : 3,
                      crossAxisSpacing: 15.0,
                      mainAxisSpacing: 15.0,
                    ),
                    itemCount: controller.topCategoryList.length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                    itemBuilder: (context, index) {
                      return controller.isMoreDataAvailable.value == true &&
                              controller.isAllDataLoaded.value &&
                              controller.topCategoryList.length - 1 == index
                          ? Center(
                              child: CircularProgressIndicator(),
                            )
                          : InkWell(
                              onTap: () async {
                                Get.to(
                                  () => CategoryScreen(
                                    category: controller.topCategoryList[index],
                                  ),
                                  routeName: 'category',
                                );
                              },
                              child: Container(
                                //width: 95,
                                //margin: EdgeInsets.only(right: 15),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5),
                                      child: Text(
                                        controller.topCategoryList[index].name
                                            .toUpperCase(),
                                        textAlign: TextAlign.center,
                                        style: Get
                                            .theme.primaryTextTheme.bodySmall
                                            .copyWith(
                                          fontSize:
                                              global.getPlatFrom() ? 16 : 10,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: global.getPlatFrom() ? 15 : 5,
                                    ),
                                    CustomImage(
                                      image:
                                          '${global.appInfo.baseUrls.categoryImageUrl}/${controller.topCategoryList[index].image}',
                                      height: global.getPlatFrom() ? 80 : 40,
                                    ),
                                  ],
                                ),
                              ),
                            );
                    },
                  ),
                  GetBuilder<AdController>(
                    builder: (adController) {
                      return _adController.isfbNativeAd1Exist
                          ? FbNativeAdWidget(
                              adId:
                                  "VID_HD_16_9_46S_APP_INSTALL#536153035214384_536880055141682",
                            )
                          : SizedBox();
                    },
                  ),
                  GetBuilder<AdController>(
                    builder: (adController) {
                      return _adController.isAdmobNativeAd1Exist
                          ? AdmobNativeAdWidget(
                              adId: 'ca-app-pub-3940256099942544/2247696110',
                            )
                          : SizedBox();
                    },
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
