// ignore_for_file: must_be_immutable

import 'package:cashfuse/constants/appConstant.dart';
import 'package:cashfuse/controllers/homeController.dart';
import 'package:cashfuse/utils/global.dart' as global;
import 'package:cashfuse/utils/images.dart';
import 'package:cashfuse/views/bottomNavigationBarScreen.dart';
import 'package:cashfuse/views/getStartedScreen.dart';
import 'package:cashfuse/widget/confirmationDialog.dart';
import 'package:cashfuse/widget/customImage.dart';
import 'package:cashfuse/widget/drawerWidget.dart';
import 'package:cashfuse/widget/recentClickDialogWidget.dart';
import 'package:cashfuse/widget/web/webTopBarWidget.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';

class RecentClickScreen extends StatelessWidget {
  final Color bgColor;
  RecentClickScreen({this.bgColor});
  HomeController homeController = Get.find<HomeController>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (home) {
      return Scaffold(
        key: scaffoldKey,
        drawer: global.getPlatFrom() ? DrawerWidget() : null,
        appBar: global.getPlatFrom()
            ? WebTopBarWidget(
                scaffoldKey: scaffoldKey,
              )
            : AppBar(
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
                title: Text(
                  AppLocalizations.of(context).recents_clicks,
                  style: Get.theme.primaryTextTheme.titleSmall,
                ),
                actions: [
                  global.currentUser.id != null &&
                          homeController.recentClickList != null &&
                          homeController.recentClickList.length > 0
                      ? InkWell(
                          onTap: () {
                            showConfirmationDialog(
                              context,
                              AppLocalizations.of(context).delete,
                              AppLocalizations.of(context).delete_desc_click,
                              [
                                CupertinoDialogAction(
                                  child: Text(
                                    AppLocalizations.of(context).yes,
                                    style: Get.theme.primaryTextTheme.titleSmall
                                        .copyWith(color: Colors.red),
                                  ),
                                  onPressed: () {
                                    Get.back();
                                    homeController.deleteClicks();
                                  },
                                ),
                                CupertinoDialogAction(
                                  child: Text(
                                    AppLocalizations.of(context).no,
                                    style: Get.theme.primaryTextTheme.titleSmall
                                        .copyWith(color: Colors.blue),
                                  ),
                                  onPressed: () {
                                    Get.back();
                                  },
                                ),
                              ],
                            );
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Icon(
                              Icons.delete,
                              color: Colors.black,
                            ),
                          ),
                        )
                      : SizedBox(),
                ],
              ),
        body: Align(
          alignment: Alignment.topCenter,
          child: SizedBox(
            width: AppConstants.WEB_MAX_WIDTH,
            child: RefreshIndicator(
              onRefresh: () async {
                await homeController.getClick();
              },
              child: global.currentUser.id != null
                  ? homeController.isClickDataLoaded.value
                      ? homeController.recentClickList != null &&
                              homeController.recentClickList.length > 0
                          ? global.getPlatFrom()
                              ? Column(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        color: Colors.white,
                                        child: GridView.builder(
                                            gridDelegate:
                                                SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 4,
                                              crossAxisSpacing: 15.0,
                                              mainAxisSpacing: 15.0,
                                              childAspectRatio: 2,
                                            ),
                                            itemCount: homeController
                                                .recentClickList.length,
                                            shrinkWrap: true,
                                            padding: EdgeInsets.all(10)
                                                .copyWith(top: 20),
                                            itemBuilder: (context, index) {
                                              return Card(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    ListTile(
                                                      leading: Card(
                                                        color: Colors.white,
                                                        //margin: EdgeInsets.all(10),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(5.0),
                                                          child: CustomImage(
                                                            image: homeController
                                                                .recentClickList[
                                                                    index]
                                                                .image,
                                                            height: 30,
                                                            width: 60,
                                                            fit: BoxFit.contain,
                                                            errorImage:
                                                                Images.logo,
                                                          ),
                                                        ),
                                                      ),
                                                      trailing: Text(
                                                        homeController.clickTime(
                                                            homeController
                                                                    .recentClickList[
                                                                index]),
                                                        style: Get
                                                            .theme
                                                            .primaryTextTheme
                                                            .bodySmall
                                                            .copyWith(
                                                          fontWeight:
                                                              FontWeight.w300,
                                                          color:
                                                              Colors.grey[600],
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 25,
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 20,
                                                              right: 20),
                                                      child: Text(
                                                        '${AppLocalizations.of(context).did_you_shop_on} ${homeController.recentClickList[index].name}?',
                                                        style: Get
                                                            .theme
                                                            .primaryTextTheme
                                                            .bodyMedium
                                                            .copyWith(
                                                          fontWeight:
                                                              FontWeight.w300,
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 25,
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 20,
                                                              right: 20),
                                                      child: DottedLine(
                                                        dashColor:
                                                            Colors.grey[350],
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 15,
                                                    ),
                                                    InkWell(
                                                      onTap: () {
                                                        Get.dialog(
                                                          Dialog(
                                                            shape:
                                                                RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),
                                                            ),
                                                            insetPadding:
                                                                EdgeInsets
                                                                    .symmetric(
                                                                        horizontal:
                                                                            15),
                                                            child:
                                                                RecentClickDialogWidget(
                                                              click: homeController
                                                                      .recentClickList[
                                                                  index],
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 20,
                                                                right: 20),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              '${AppLocalizations.of(context).yes_i_did} ',
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: Get
                                                                  .theme
                                                                  .primaryTextTheme
                                                                  .bodySmall
                                                                  .copyWith(
                                                                color:
                                                                    Colors.teal,
                                                              ),
                                                            ),
                                                            CircleAvatar(
                                                              radius: 6,
                                                              backgroundColor:
                                                                  Colors.teal,
                                                              child: Icon(
                                                                Icons
                                                                    .arrow_forward_ios_rounded,
                                                                size: 8,
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 15,
                                                    ),
                                                  ],
                                                ),
                                              );
                                            }),
                                      ),
                                    ),
                                  ],
                                )
                              : ListView.builder(
                                  shrinkWrap: true,
                                  itemCount:
                                      homeController.recentClickList.length,
                                  padding: EdgeInsets.only(
                                      top: 10, left: 5, right: 5),
                                  itemBuilder: (context, index) {
                                    return Card(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          ListTile(
                                            leading: Card(
                                              color: Colors.white,
                                              //margin: EdgeInsets.all(10),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(5.0),
                                                child: CustomImage(
                                                  image: homeController
                                                      .recentClickList[index]
                                                      .image,
                                                  height: 30,
                                                  width: 60,
                                                  fit: BoxFit.contain,
                                                  errorImage: Images.logo,
                                                ),
                                              ),
                                            ),
                                            trailing: Text(
                                              homeController.clickTime(
                                                  homeController
                                                      .recentClickList[index]),
                                              style: Get.theme.primaryTextTheme
                                                  .bodySmall
                                                  .copyWith(
                                                fontWeight: FontWeight.w300,
                                                color: Colors.grey[600],
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 25,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 20, right: 20),
                                            child: Text(
                                              '${AppLocalizations.of(context).did_you_shop_on} ${homeController.recentClickList[index].name}?',
                                              style: Get.theme.primaryTextTheme
                                                  .bodyMedium
                                                  .copyWith(
                                                fontWeight: FontWeight.w300,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 25,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 20, right: 20),
                                            child: DottedLine(
                                              dashColor: Colors.grey[350],
                                            ),
                                          ),
                                          SizedBox(
                                            height: 15,
                                          ),
                                          InkWell(
                                            onTap: () {
                                              Get.dialog(
                                                Dialog(
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                  insetPadding:
                                                      EdgeInsets.symmetric(
                                                          horizontal: 15),
                                                  child:
                                                      RecentClickDialogWidget(
                                                    click: homeController
                                                        .recentClickList[index],
                                                  ),
                                                ),
                                              );
                                            },
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 20, right: 20),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    '${AppLocalizations.of(context).yes_i_did} ',
                                                    textAlign: TextAlign.center,
                                                    style: Get
                                                        .theme
                                                        .primaryTextTheme
                                                        .bodySmall
                                                        .copyWith(
                                                      color: Colors.teal,
                                                    ),
                                                  ),
                                                  CircleAvatar(
                                                    radius: 6,
                                                    backgroundColor:
                                                        Colors.teal,
                                                    child: Icon(
                                                      Icons
                                                          .arrow_forward_ios_rounded,
                                                      size: 8,
                                                      color: Colors.white,
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 15,
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                )
                          : Center(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    Images.Click_image,
                                    height: 150,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: Text(
                                      AppLocalizations.of(context).click_title,
                                      style: Get
                                          .theme.primaryTextTheme.titleMedium
                                          .copyWith(
                                              fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 15),
                                    child: Text(
                                      "When you visit any of the sites on ${global.appName}, it will record your click and display on it.",
                                      textAlign: TextAlign.center,
                                      //style: Get.theme.primaryTextTheme.titleSmall.copyWith(fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () async {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              BottomNavigationBarScreen(
                                            pageIndex: 0,
                                          ),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      height: 45,
                                      width: Get.width / 2.5,
                                      //margin: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 7, vertical: 8),
                                      decoration: BoxDecoration(
                                        color: Get.theme.secondaryHeaderColor,
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      alignment: Alignment.center,
                                      child: Text(
                                        AppLocalizations.of(context)
                                            .see_best_deals,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                      : Center(child: CircularProgressIndicator())
                  : Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            Images.Click_image,
                            height: 150,
                          ),
                          // Padding(
                          //   padding: const EdgeInsets.only(top: 10),
                          //   child: Text(
                          //     AppLocalizations.of(context).profile_desc,
                          //     style: Get.theme.primaryTextTheme.titleMedium.copyWith(fontWeight: FontWeight.w500),
                          //   ),
                          // ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 15),
                            child: Text(
                              AppLocalizations.of(context).profile_desc,
                              textAlign: TextAlign.center,
                              //style: Get.theme.primaryTextTheme.titleSmall.copyWith(fontWeight: FontWeight.w500),
                            ),
                          ),
                          InkWell(
                            onTap: () async {
                              if (global.getPlatFrom()) {
                                Get.dialog(Dialog(
                                  child: SizedBox(
                                    width: Get.width / 3,
                                    child: GetStartedScreen(
                                      fromMenu: true,
                                    ),
                                  ),
                                ));
                              } else {
                                Get.to(
                                  () => GetStartedScreen(
                                    fromMenu: true,
                                  ),
                                  routeName: 'login',
                                );
                                // Get.to(
                                //   () =>LoginScreen(),
                                //   //     LoginOrSignUpScreen(
                                //   //   fromMenu: true,
                                //   // ),
                                //   routeName: 'login',
                                // );
                              }
                            },
                            child: Container(
                              height: 45,
                              width: Get.width / 2.5,
                              //margin: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 7, vertical: 8),
                              decoration: BoxDecoration(
                                color: Get.theme.secondaryHeaderColor,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                AppLocalizations.of(context).login,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
            ),
          ),
        ),
      );
    });
  }
}
