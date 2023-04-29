// ignore_for_file: must_be_immutable

import 'package:cashfuse/constants/appConstant.dart';
import 'package:cashfuse/controllers/homeController.dart';
import 'package:cashfuse/models/commonModel.dart';
import 'package:cashfuse/utils/global.dart' as global;
import 'package:cashfuse/views/categoryScreen.dart';
import 'package:cashfuse/widget/adsCampaignWidget.dart';
import 'package:cashfuse/widget/drawerWidget.dart';
import 'package:cashfuse/widget/web/webAdsCampaignWidget.dart';
import 'package:cashfuse/widget/web/webTopBarWidget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdsCampaignWidgetListScreen extends StatelessWidget {
  final String title;
  AdsCampaignWidgetListScreen({this.title});

  HomeController homeController = Get.find<HomeController>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  void paginateTask() {
    homeController.topCashBackScrollController.addListener(() async {
      if (homeController.topCashBackScrollController.position.pixels == homeController.topCashBackScrollController.position.maxScrollExtent) {
        homeController.isMoreDataAvailable.value = true;
        print('Reached end');
        await homeController.getAllAdv();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    paginateTask();
    return GetBuilder<HomeController>(builder: (homeController1) {
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
                  title,
                  style: Get.theme.primaryTextTheme.titleSmall.copyWith(color: Colors.white),
                ),
              ),
        body: Align(
          alignment: Alignment.topCenter,
          child: SizedBox(
            width: AppConstants.WEB_MAX_WIDTH,
            child: GridView.builder(
              controller: homeController.topCashBackScrollController,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: global.getPlatFrom() ? 5 : 2,
                crossAxisSpacing: global.getPlatFrom() ? 25 : 15.0,
                mainAxisSpacing: global.getPlatFrom() ? 25 : 15.0,
              ),
              itemCount: homeController.allAdvList.length,
              shrinkWrap: true,
              padding: EdgeInsets.all(10).copyWith(top: 20),
              itemBuilder: (context, index) {
                return homeController.isMoreDataAvailable.value == true && homeController.allAdvList.length - 1 == index
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : InkWell(
                        onTap: () {
                          Get.to(
                            () => CategoryScreen(
                              category: homeController.allAdvList[index],
                            ),
                            routeName: 'category',
                          );
                        },
                        child: global.getPlatFrom()
                            ? WebAdsCampaignWidget(
                                fromWebHome: false,
                                commonModel: CommonModel(
                                  name: homeController.allAdvList[index].name,
                                  image: '${global.appInfo.baseUrls.partnerImageUrl}/${homeController.allAdvList[index].image}',
                                  tagline: homeController.allAdvList[index].tagline,
                                  adId: homeController.allAdvList[index].id.toString(),
                                ),
                              )
                            : AdsCampaignWidget(
                                commonModel: CommonModel(
                                  name: homeController.allAdvList[index].name,
                                  image: '${global.appInfo.baseUrls.partnerImageUrl}/${homeController.allAdvList[index].image}',
                                  tagline: homeController.allAdvList[index].tagline,
                                  adId: homeController.allAdvList[index].id.toString(),
                                ),
                              ),
                      );
              },
            ),
          ),
        ),
      );
    });
  }
}
