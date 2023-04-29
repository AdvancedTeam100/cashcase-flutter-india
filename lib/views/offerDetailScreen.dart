// ignore_for_file: must_be_immutable

import 'package:cashfuse/constants/appConstant.dart';
import 'package:cashfuse/controllers/homeController.dart';
import 'package:cashfuse/models/offerModel.dart';
import 'package:cashfuse/utils/global.dart' as global;
import 'package:cashfuse/views/getStartedScreen.dart';
import 'package:cashfuse/views/loginOrSignUpScreen.dart';
import 'package:cashfuse/views/moreOfferScreen.dart';
import 'package:cashfuse/widget/customImage.dart';
import 'package:cashfuse/widget/drawerWidget.dart';
import 'package:cashfuse/widget/ratesAndOfferTermsSheetWidget.dart';
import 'package:cashfuse/widget/web/webTopBarWidget.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:get/get.dart';

class OfferDetailScreen extends StatelessWidget {
  final OfferModel offer;
  final bool fromSeeMore;
  final BuildContext context1;
  OfferDetailScreen({this.offer, this.fromSeeMore, this.context1});

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
            : null,
        body: CustomScrollView(slivers: [
          !global.getPlatFrom()
              ? SliverAppBar(
                  expandedHeight: kToolbarHeight,
                  collapsedHeight: kToolbarHeight,
                  toolbarHeight: kToolbarHeight,
                  floating: true,
                  pinned: true,
                  elevation: 0,
                  backgroundColor: Get.theme.primaryColor,
                  leading: IconButton(
                    icon: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Get.back();
                    },
                  ),
                  title: Text(
                    offer.name,
                    style: Get.theme.primaryTextTheme.titleSmall
                        .copyWith(color: Colors.white),
                  ),
                  actions: [
                    !GetPlatform.isWeb
                        ? InkWell(
                            onTap: () async {
                              if (global.currentUser.id != null) {
                                await homeController.getTrackingLink(
                                    offer.url, offer.affiliatePartner);
                                global.share(
                                  homeController.createdLink.isNotEmpty
                                      ? homeController.createdLink
                                      : offer.url,
                                  offer.bannerImage.isNotEmpty &&
                                          !offer.isImageError
                                      ? '${global.appInfo.baseUrls.offerImageUrl}/${offer.bannerImage}'
                                      : '',
                                  '',
                                );
                              } else {
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
                                }
                              }
                            },
                            child: Container(
                              margin: EdgeInsets.symmetric(vertical: 12)
                                  .copyWith(right: 10),
                              padding: EdgeInsets.only(left: 10, right: 3),
                              decoration: BoxDecoration(
                                color: Colors.green[500],
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Row(
                                children: [
                                  Text(
                                      '${AppLocalizations.of(context).share}  '),
                                  CircleAvatar(
                                    radius: 12,
                                    backgroundColor: Colors.green[700],
                                    child: Icon(
                                      Icons.share_outlined,
                                      color: Colors.white,
                                      size: 15,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )
                        : SizedBox()
                  ],
                )
              : SliverToBoxAdapter(child: SizedBox()),
          SliverFillRemaining(
            fillOverscroll: true,
            hasScrollBody: true,
            child: SingleChildScrollView(
              child: Center(
                child: SizedBox(
                  width: AppConstants.WEB_MAX_WIDTH,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        color: Colors.white,
                        width: AppConstants.WEB_MAX_WIDTH,
                        child: Column(
                          children: [
                            Stack(
                              children: [
                                CustomImage(
                                  image:
                                      '${global.appInfo.baseUrls.offerImageUrl}/${offer.bannerImage}',
                                  height: global.getPlatFrom() ? 250 : 200,
                                  width: global.getPlatFrom()
                                      ? AppConstants.WEB_MAX_WIDTH / 3
                                      : Get.width,
                                  fit: global.getPlatFrom()
                                      ? BoxFit.contain
                                      : BoxFit.fill,
                                  offer: offer,
                                ),
                                Card(
                                  color: Colors.white,
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 10),
                                  child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: CustomImage(
                                      image:
                                          '${global.appInfo.baseUrls.partnerImageUrl}/${offer.image}',
                                      height: 30,
                                      width: 60,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            InkWell(
                              onTap: () async {
                                if (global.currentUser.id != null) {
                                  await homeController.getTrackingLink(
                                      offer.url, offer.affiliatePartner);
                                  await homeController.addClick(
                                    offer.campaignName,
                                    global.appInfo.baseUrls.offerImageUrl +
                                        '/' +
                                        offer.image,
                                    homeController.createdLink.isNotEmpty
                                        ? homeController.createdLink
                                        : offer.url,
                                  );

                                  global.launchInBrowser(
                                    homeController.createdLink.isNotEmpty
                                        ? homeController.createdLink
                                        : offer.url,
                                  );

                                  // Get.to(
                                  //   () => WebViewScreen(
                                  //     urlString: homeController.createdLink.isNotEmpty ? homeController.createdLink : offer.url,
                                  //     isCliked: global.clickedList.contains(offer.campaignName),
                                  //     couponList: offer.couponList,
                                  //     partner: offer.partner,
                                  //     brandName: offer.campaignName,
                                  //   ),
                                  // ).then((value) {
                                  //   if (global.clickedList.contains(offer.campaignName)) {
                                  //   } else {
                                  //     global.clickedList.add(offer.campaignName);
                                  //     global.sp.setStringList('clickedList', global.clickedList);
                                  //   }
                                  // });
                                } else {
                                  if (global.getPlatFrom()) {
                                    Get.dialog(Dialog(
                                      child: SizedBox(
                                        width: Get.width / 3,
                                        child: LoginOrSignUpScreen(
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
                                  }
                                }
                              },
                              child: Container(
                                width: global.getPlatFrom()
                                    ? Get.width * 0.2
                                    : Get.width,
                                height: 45,
                                margin: EdgeInsets.symmetric(
                                    horizontal: 40, vertical: 25),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 7, vertical: 8),
                                decoration: BoxDecoration(
                                  color: Get.theme.secondaryHeaderColor,
                                  borderRadius: BorderRadius.circular(2),
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  offer.buttonText,
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
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        color: Colors.white,
                        width: Get.width,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: global.getPlatFrom()
                                ? CrossAxisAlignment.center
                                : CrossAxisAlignment.start,
                            children: [
                              Text(
                                offer.name,
                                style: Get.theme.primaryTextTheme.titleSmall,
                              ),
                              HtmlWidget(
                                offer.description,
                                //style: Get.theme.primaryTextTheme.bodyMedium.copyWith(fontWeight: FontWeight.w300),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  CircleAvatar(
                                    backgroundColor:
                                        Get.theme.secondaryHeaderColor,
                                    radius: 10,
                                    child: CircleAvatar(
                                      radius: 7,
                                      backgroundColor: Colors.white,
                                    ),
                                  ),
                                  Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      DottedLine(
                                        lineLength: 130,
                                        dashColor: Colors.grey,
                                      ),
                                      Card(
                                        margin: EdgeInsets.zero,
                                        elevation: 0,
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.zero),
                                        child: Text(
                                          '>>',
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 20,
                                              letterSpacing: -5),
                                        ),
                                      )
                                    ],
                                  ),
                                  CircleAvatar(
                                    backgroundColor:
                                        Get.theme.secondaryHeaderColor,
                                    radius: 10,
                                    child: CircleAvatar(
                                      radius: 7,
                                      backgroundColor: Colors.white,
                                    ),
                                  )
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 40),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          AppLocalizations.of(context).purchase,
                                          style: TextStyle(
                                              fontWeight: FontWeight.w300,
                                              fontSize: 13),
                                        ),
                                        Text(
                                          'Today',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      width: 50,
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          AppLocalizations.of(context)
                                              .cashback_tracks_in,
                                          style: TextStyle(
                                              fontWeight: FontWeight.w300,
                                              fontSize: 13),
                                        ),
                                        Text(
                                          '24 hours',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              fromSeeMore
                                  ? SizedBox(
                                      key: UniqueKey(),
                                    )
                                  : homeController.seeMoreOfferList != null &&
                                          homeController
                                                  .seeMoreOfferList.length >
                                              0
                                      ? InkWell(
                                          key: UniqueKey(),
                                          onTap: () async {
                                            //await homeController.getMoreOffers(offer.id.toString());
                                            global.getPlatFrom()
                                                ? Get.dialog(
                                                    Dialog(
                                                      child: SizedBox(
                                                        height: 500,
                                                        width: 500,
                                                        child:
                                                            MoreOfferScreen(),
                                                      ),
                                                    ),
                                                  )
                                                : Get.bottomSheet(
                                                    ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.only(
                                                        topLeft:
                                                            Radius.circular(15),
                                                        topRight:
                                                            Radius.circular(15),
                                                      ),
                                                      child: MoreOfferScreen(),
                                                    ),
                                                  );
                                          },
                                          child: Container(
                                            width: global.getPlatFrom()
                                                ? Get.width / 4
                                                : Get.width,
                                            height: 45,
                                            margin: EdgeInsets.symmetric(
                                                horizontal: 30, vertical: 15),
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 7, vertical: 8),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                border: Border.all(
                                                  color: Colors.teal[200],
                                                  width: 1.5,
                                                )),
                                            alignment: Alignment.center,
                                            child: Text(
                                              '${AppLocalizations.of(context).see_more_offers}  >',
                                              style: TextStyle(
                                                  color: Colors.teal[200],
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                          ),
                                        )
                                      : SizedBox(),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ]),
        bottomNavigationBar: offer.partner != null &&
                (offer.partner.leftTab.isNotEmpty ||
                    offer.partner.rightTab.isNotEmpty)
            ? Container(
                width: Get.width,
                alignment: Alignment.center,
                height: 50,
                child: SizedBox(
                  height: 50,
                  width: AppConstants.WEB_MAX_WIDTH,
                  child: Card(
                    margin: EdgeInsets.zero,
                    shape:
                        RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                    color: Get.theme.primaryColor,
                    child: Row(
                      mainAxisAlignment: (offer.partner.leftTab.isNotEmpty &&
                              offer.partner.rightTab.isNotEmpty)
                          ? MainAxisAlignment.spaceEvenly
                          : MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            homeController.setIsOffer(false);
                            Get.bottomSheet(
                              ClipRRect(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(15),
                                  topRight: Radius.circular(15),
                                ),
                                child: RatesAndOfferTermsSheetWidget(
                                  partner: offer.partner,
                                ),
                              ),
                            );
                          },
                          child: Text(
                            offer.partner.leftTab,
                            style: Get.theme.primaryTextTheme.titleSmall
                                .copyWith(
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white),
                          ),
                        ),
                        (offer.partner.leftTab.isNotEmpty &&
                                offer.partner.rightTab.isNotEmpty)
                            ? Icon(
                                Icons.more_vert,
                                size: 22,
                                color: Colors.white.withOpacity(0.3),
                              )
                            : SizedBox(),
                        InkWell(
                          onTap: () {
                            homeController.setIsOffer(true);
                            Get.bottomSheet(
                              ClipRRect(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(15),
                                  topRight: Radius.circular(15),
                                ),
                                child: RatesAndOfferTermsSheetWidget(
                                  partner: offer.partner,
                                ),
                              ),
                              isScrollControlled: true,
                            );
                          },
                          child: Text(
                            offer.partner.rightTab,
                            style: Get.theme.primaryTextTheme.titleSmall
                                .copyWith(
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            : SizedBox(),
      );
    });
  }
}
