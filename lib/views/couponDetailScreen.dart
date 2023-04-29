// ignore_for_file: must_be_immutable

import 'package:cashfuse/constants/appConstant.dart';
import 'package:cashfuse/controllers/homeController.dart';
import 'package:cashfuse/models/couponModel.dart';
import 'package:cashfuse/utils/global.dart' as global;
import 'package:cashfuse/views/getStartedScreen.dart';
import 'package:cashfuse/widget/customImage.dart';
import 'package:cashfuse/widget/customSnackbar.dart';
import 'package:cashfuse/widget/web/webTopBarWidget.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:slide_countdown/slide_countdown.dart';

class CouponDetailScreen extends StatelessWidget {
  final Coupon coupon;
  CouponDetailScreen({this.coupon});
  HomeController homeController = Get.find<HomeController>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (controller) {
      return Scaffold(
        key: scaffoldKey,
        appBar: global.getPlatFrom()
            ? WebTopBarWidget(
                scaffoldKey: scaffoldKey,
              )
            : AppBar(
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
                  coupon.name,
                  style: Get.theme.primaryTextTheme.titleSmall
                      .copyWith(color: Colors.white),
                ),
                actions: [
                  !GetPlatform.isWeb
                      ? InkWell(
                          onTap: () async {
                            if (global.currentUser.id != null) {
                              await homeController.getTrackingLink(
                                  coupon.url, coupon.affiliatePartner);
                              global.share(
                                homeController.createdLink.isNotEmpty
                                    ? homeController.createdLink
                                    : coupon.url,
                                coupon.bannerImage.isNotEmpty &&
                                        !coupon.isImageError
                                    ? '${global.appInfo.baseUrls.couponBannerImageUrl}/${coupon.bannerImage}'
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
                                Text('${AppLocalizations.of(context).share}  '),
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
              ),
        body: SingleChildScrollView(
          child: Center(
            child: Container(
              color: global.getPlatFrom() ? Colors.white : Colors.white,
              height: Get.height,
              width: AppConstants.WEB_MAX_WIDTH,
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    AppLocalizations.of(context).deal_ends_in,
                    style: Get.theme.primaryTextTheme.titleSmall,
                  ),
                  coupon.dayDifference != null && coupon.dayDifference > 0
                      ? Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: SlideCountdownSeparated(
                            separatorType: SeparatorType.symbol,
                            durationTitle: DurationTitle(
                              hours: 'hr',
                              minutes: 'min',
                              seconds: 'sec',
                              days: 'day',
                            ),
                            slideDirection: SlideDirection.none,
                            textStyle: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.w600),
                            decoration: BoxDecoration(
                              color: Colors.red[800],
                              borderRadius: BorderRadius.circular(3),
                            ),
                            duration: Duration(
                              days: coupon.dayDifference,
                            ),
                          ),
                        )
                      : SizedBox(),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    color: Colors.white,
                    width: Get.width,
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            CustomImage(
                              image:
                                  '${global.appInfo.baseUrls.couponBannerImageUrl}/${coupon.bannerImage}',
                              height: global.getPlatFrom() ? 250 : 200,
                              width: global.getPlatFrom()
                                  ? AppConstants.WEB_MAX_WIDTH / 3
                                  : Get.width,
                              fit: global.getPlatFrom()
                                  ? BoxFit.contain
                                  : BoxFit.fill,
                              coupon: coupon,
                            ),
                            // Align(
                            //   alignment: Alignment.topRight,
                            //   child: RotatedBox(
                            //     quarterTurns: 45,
                            //     child: ClipPath(
                            //       clipper: MultiplePointsClipper(Sides.bottom, heightOfPoint: 10, numberOfPoints: 1),
                            //       child: Container(
                            //         width: 20,
                            //         height: 140,
                            //         decoration: BoxDecoration(
                            //           color: Colors.red[600],
                            //         ),
                            //         alignment: Alignment.topCenter,
                            //         padding: EdgeInsets.only(bottom: 5, top: 5),
                            //         child: RotatedBox(
                            //           quarterTurns: -45,
                            //           child: Text(
                            //             'LOWEST PRICE GURRENTY',
                            //             textAlign: TextAlign.center,
                            //             style: Get.theme.primaryTextTheme.bodySmall.copyWith(
                            //               color: Colors.white,
                            //               fontSize: 10,
                            //             ),
                            //           ),
                            //         ),
                            //       ),
                            //     ),
                            //   ),
                            // ),
                            Card(
                              color: Colors.white,
                              margin: EdgeInsets.all(10),
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: CustomImage(
                                  image:
                                      '${global.appInfo.baseUrls.partnerImageUrl}/${coupon.image}',
                                  height: 30,
                                  width: 60,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          ],
                        ),
                        coupon.code != null && coupon.code.isNotEmpty
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    AppLocalizations.of(context).use_code,
                                    style: Get.theme.primaryTextTheme.bodyLarge
                                        .copyWith(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 10),
                                    child: DottedBorder(
                                      padding: EdgeInsets.all(10),
                                      color: Get.theme.secondaryHeaderColor,
                                      child: Text(
                                        coupon.code,
                                        style: Get
                                            .theme.primaryTextTheme.titleSmall
                                            .copyWith(
                                          color: Get.theme.secondaryHeaderColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Clipboard.setData(
                                        ClipboardData(
                                          text: coupon.code,
                                        ),
                                      ).then((value) {
                                        showCustomSnackBar(
                                          'Coupon Code Copied',
                                        );
                                      });
                                    },
                                    child: Text(
                                      AppLocalizations.of(context).copy_code,
                                      style: Get
                                          .theme.primaryTextTheme.bodyLarge
                                          .copyWith(
                                        color: Colors.teal,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                  )
                                ],
                              )
                            : Text(
                                '*Coupon code not required',
                                style: TextStyle(color: Colors.red),
                              ),
                        InkWell(
                          onTap: () async {
                            if (global.currentUser.id != null) {
                              await homeController.getTrackingLink(
                                  coupon.url, coupon.affiliatePartner);
                              await homeController.addClick(
                                  coupon.partnerName,
                                  '${global.appInfo.baseUrls.partnerImageUrl}/${coupon.image}',
                                  coupon.url);

                              global.launchInBrowser(
                                homeController.createdLink.isNotEmpty
                                    ? homeController.createdLink
                                    : coupon.url,
                              );
                              // Get.to(() => WebViewScreen(
                              //       urlString: coupon.url,
                              //       brandName: coupon.partnerName,
                              //     )).then((value) {
                              //   if (global.clickedList.contains(coupon.partnerName)) {
                              //   } else {
                              //     global.clickedList.add(coupon.partnerName);
                              //     global.sp.setStringList('clickedList', global.clickedList);
                              //   }
                              // });
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
                            width: global.getPlatFrom()
                                ? Get.width / 4
                                : Get.width,
                            height: 45,
                            margin: EdgeInsets.symmetric(
                                horizontal: 40, vertical: 20),
                            padding: EdgeInsets.symmetric(
                                horizontal: 7, vertical: 8),
                            decoration: BoxDecoration(
                              color: Get.theme.secondaryHeaderColor,
                              borderRadius: BorderRadius.circular(2),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              coupon.buttonText,
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
                    width: global.getPlatFrom() ? Get.width / 3 : Get.width,
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppLocalizations.of(context).about_this_coupon,
                            style: global.getPlatFrom()
                                ? Get.theme.primaryTextTheme.titleMedium
                                    .copyWith(fontWeight: FontWeight.w600)
                                : Get.theme.primaryTextTheme.titleSmall,
                          ),
                          Divider(),
                          Text(
                            coupon.heading,
                            style: Get.theme.primaryTextTheme.bodyMedium
                                .copyWith(fontWeight: FontWeight.w500),
                          ),
                          Text(
                            coupon.description,
                            style: Get.theme.primaryTextTheme.bodyMedium
                                .copyWith(fontWeight: FontWeight.w300),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Container(
                  //   color: Colors.white,
                  //   child: Padding(
                  //     padding: const EdgeInsets.all(10.0),
                  //     child: Column(
                  //       crossAxisAlignment: CrossAxisAlignment.start,
                  //       children: [
                  //         Text(
                  //           'Important Information',
                  //           style: Get.theme.primaryTextTheme.titleSmall,
                  //         ),
                  //         Divider(),
                  //         ListTile(
                  //           contentPadding: EdgeInsets.zero,
                  //           horizontalTitleGap: 10,
                  //           minLeadingWidth: 0,
                  //           leading: CircleAvatar(
                  //             radius: 3,
                  //             backgroundColor: Colors.black54,
                  //           ),
                  //           title: Text(
                  //             'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
                  //             style: Get.theme.primaryTextTheme.bodyMedium.copyWith(fontWeight: FontWeight.w300),
                  //           ),
                  //         ),
                  //         ListTile(
                  //           contentPadding: EdgeInsets.zero,
                  //           horizontalTitleGap: 10,
                  //           minLeadingWidth: 0,
                  //           leading: CircleAvatar(
                  //             radius: 3,
                  //             backgroundColor: Colors.black54,
                  //           ),
                  //           title: Text(
                  //             'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
                  //             style: Get.theme.primaryTextTheme.bodyMedium.copyWith(fontWeight: FontWeight.w300),
                  //           ),
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: 10,
                  // ),
                  // Container(
                  //   color: Colors.white,
                  //   child: Padding(
                  //     padding: const EdgeInsets.all(10.0),
                  //     child: Column(
                  //       crossAxisAlignment: CrossAxisAlignment.start,
                  //       children: [
                  //         Text(
                  //           '${global.appName} Rewards Details',
                  //           style: Get.theme.primaryTextTheme.titleSmall,
                  //         ),
                  //         Divider(),
                  //         ListTile(
                  //           contentPadding: EdgeInsets.zero,
                  //           horizontalTitleGap: 10,
                  //           minLeadingWidth: 0,
                  //           leading: CircleAvatar(
                  //             radius: 3,
                  //             backgroundColor: Colors.black54,
                  //           ),
                  //           title: Text(
                  //             'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
                  //             style: Get.theme.primaryTextTheme.bodyMedium.copyWith(fontWeight: FontWeight.w300),
                  //           ),
                  //         ),
                  //         ListTile(
                  //           contentPadding: EdgeInsets.zero,
                  //           horizontalTitleGap: 10,
                  //           minLeadingWidth: 0,
                  //           leading: CircleAvatar(
                  //             radius: 3,
                  //             backgroundColor: Colors.black54,
                  //           ),
                  //           title: Text(
                  //             'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
                  //             style: Get.theme.primaryTextTheme.bodyMedium.copyWith(fontWeight: FontWeight.w300),
                  //           ),
                  //         ),
                  //         ListTile(
                  //           contentPadding: EdgeInsets.zero,
                  //           horizontalTitleGap: 10,
                  //           minLeadingWidth: 0,
                  //           leading: CircleAvatar(
                  //             radius: 3,
                  //             backgroundColor: Colors.black54,
                  //           ),
                  //           title: Text(
                  //             'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
                  //             style: Get.theme.primaryTextTheme.bodyMedium.copyWith(fontWeight: FontWeight.w300),
                  //           ),
                  //         )
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: 10,
                  // ),
                  // Container(
                  //   color: Colors.white,
                  //   child: Padding(
                  //     padding: const EdgeInsets.all(10.0),
                  //     child: Column(
                  //       crossAxisAlignment: CrossAxisAlignment.start,
                  //       children: [
                  //         Text(
                  //           'How to get this offer',
                  //           style: Get.theme.primaryTextTheme.titleSmall,
                  //         ),
                  //         Divider(),
                  //         ListTile(
                  //           contentPadding: EdgeInsets.zero,
                  //           horizontalTitleGap: 10,
                  //           minLeadingWidth: 0,
                  //           leading: CircleAvatar(
                  //             radius: 3,
                  //             backgroundColor: Colors.black54,
                  //           ),
                  //           title: Text(
                  //             'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
                  //             style: Get.theme.primaryTextTheme.bodyMedium.copyWith(fontWeight: FontWeight.w300),
                  //           ),
                  //         ),
                  //         ListTile(
                  //           contentPadding: EdgeInsets.zero,
                  //           horizontalTitleGap: 10,
                  //           minLeadingWidth: 0,
                  //           leading: CircleAvatar(
                  //             radius: 3,
                  //             backgroundColor: Colors.black54,
                  //           ),
                  //           title: Text(
                  //             'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
                  //             style: Get.theme.primaryTextTheme.bodyMedium.copyWith(fontWeight: FontWeight.w300),
                  //           ),
                  //         ),
                  //         ListTile(
                  //           contentPadding: EdgeInsets.zero,
                  //           horizontalTitleGap: 10,
                  //           minLeadingWidth: 0,
                  //           leading: CircleAvatar(
                  //             radius: 3,
                  //             backgroundColor: Colors.black54,
                  //           ),
                  //           title: Text(
                  //             'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
                  //             style: Get.theme.primaryTextTheme.bodyMedium.copyWith(fontWeight: FontWeight.w300),
                  //           ),
                  //         )
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: 10,
                  // ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
