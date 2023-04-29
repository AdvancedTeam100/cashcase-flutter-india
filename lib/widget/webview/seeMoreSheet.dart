import 'package:cashfuse/controllers/homeController.dart';
import 'package:cashfuse/models/categoryModel.dart';
import 'package:cashfuse/models/couponModel.dart';
import 'package:cashfuse/utils/global.dart' as global;
import 'package:cashfuse/utils/images.dart';
import 'package:cashfuse/widget/customSnackbar.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SeeMoreSheet extends StatelessWidget {
  final int screenId;
  final List<Coupon> couponList;
  final CategoryModel partner;
  final String brandName;
  SeeMoreSheet({this.screenId, this.couponList, this.partner, this.brandName});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (homeController) {
        return Container(
          padding: EdgeInsets.only(top: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              homeController.webBottomIndex == 0
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Image.asset(
                                Images.logo,
                                height: 30,
                              ),
                              Text(
                                AppLocalizations.of(context).what_next,
                                style: Get.theme.primaryTextTheme.titleMedium.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  Get.back();
                                },
                                child: Icon(
                                  Icons.close,
                                  size: 15,
                                ),
                              )
                            ],
                          ),
                        ),
                        Divider(),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  CircleAvatar(
                                    backgroundColor: Get.theme.secondaryHeaderColor,
                                    radius: 10,
                                  ),
                                  Text(
                                    ' Shop at $brandName',
                                    style: Get.theme.primaryTextTheme.titleSmall.copyWith(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  )
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 5),
                                child: Icon(
                                  Icons.arrow_downward_outlined,
                                  color: Get.theme.secondaryHeaderColor,
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  CircleAvatar(
                                    backgroundColor: Get.theme.secondaryHeaderColor,
                                    radius: 10,
                                  ),
                                  Expanded(
                                    child: Text(
                                      ' $brandName pays commison to ${global.appName}',
                                      maxLines: 2,
                                      style: Get.theme.primaryTextTheme.titleSmall.copyWith(
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 5),
                                child: Icon(
                                  Icons.arrow_downward_outlined,
                                  color: Get.theme.secondaryHeaderColor,
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  CircleAvatar(
                                    backgroundColor: Get.theme.secondaryHeaderColor,
                                    radius: 10,
                                  ),
                                  Text(
                                    ' ${global.appName} Pays you Cashback',
                                    style: Get.theme.primaryTextTheme.titleSmall.copyWith(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: 48,
                          color: Colors.grey[100],
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.check_circle,
                                color: Colors.green,
                              ),
                              Text(
                                ' Real Money',
                                style: Get.theme.primaryTextTheme.bodySmall,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Icon(
                                Icons.check_circle,
                                color: Colors.green,
                              ),
                              Text(
                                ' Above all discounts',
                                style: Get.theme.primaryTextTheme.bodySmall,
                              )
                            ],
                          ),
                        ),
                      ],
                    )
                  : homeController.webBottomIndex == 1
                      ? Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    partner.leftTab,
                                    style: Get.theme.primaryTextTheme.titleMedium.copyWith(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Get.back();
                                    },
                                    child: Icon(
                                      Icons.close,
                                      size: 15,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Divider(),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: HtmlWidget(
                                partner.leftTabDesc,
                              ),
                            )
                            // Expanded(
                            //   child: ListView.builder(
                            //     padding: EdgeInsets.zero,
                            //     shrinkWrap: true,
                            //     itemCount: 10,
                            //     itemBuilder: (context, index) {
                            //       return Column(
                            //         crossAxisAlignment: CrossAxisAlignment.start,
                            //         children: [
                            //           Padding(
                            //             padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                            //             child: RichText(
                            //               text: TextSpan(
                            //                 text: '6%',
                            //                 style: Get.theme.primaryTextTheme.titleSmall.copyWith(
                            //                   color: Get.theme.secondaryHeaderColor,
                            //                 ),
                            //                 children: <TextSpan>[
                            //                   TextSpan(
                            //                     text: '      Cashback for New Myntra Users',
                            //                     style: Get.theme.primaryTextTheme.bodySmall,
                            //                   ),
                            //                 ],
                            //               ),
                            //             ),
                            //           ),
                            //           Divider(
                            //             height: 1,
                            //             thickness: 1,
                            //           ),
                            //         ],
                            //       );
                            //     },
                            //   ),
                            // )
                          ],
                        )
                      : homeController.webBottomIndex == 2
                          ? Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        AppLocalizations.of(context).coupon,
                                        style: Get.theme.primaryTextTheme.titleMedium.copyWith(
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          Get.back();
                                        },
                                        child: Icon(
                                          Icons.close,
                                          size: 15,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Divider(),
                                ListView.builder(
                                  padding: EdgeInsets.all(10),
                                  shrinkWrap: true,
                                  itemCount: couponList.length,
                                  itemBuilder: (context, index) {
                                    return Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            DottedBorder(
                                              color: Get.theme.secondaryHeaderColor,
                                              child: Text(
                                                couponList[index].code,
                                                style: Get.theme.primaryTextTheme.titleSmall.copyWith(
                                                  color: Get.theme.secondaryHeaderColor,
                                                ),
                                              ),
                                            ),
                                            Expanded(child: SizedBox()),
                                            Icon(
                                              Icons.copy,
                                              color: Get.theme.secondaryHeaderColor,
                                              size: 18,
                                            ),
                                            InkWell(
                                              onTap: () {
                                                Clipboard.setData(
                                                  ClipboardData(
                                                    text: couponList[index].code,
                                                  ),
                                                ).then((value) {
                                                  showCustomSnackBar(
                                                    'Coupon Code Copied',
                                                  );
                                                });
                                              },
                                              child: Text(
                                                AppLocalizations.of(context).copy_code,
                                                style: Get.theme.primaryTextTheme.bodyLarge.copyWith(
                                                  decoration: TextDecoration.underline,
                                                  color: Get.theme.secondaryHeaderColor,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 15),
                                          child: Text(couponList[index].description),
                                        ),
                                        Divider(
                                          height: 1,
                                        ),
                                      ],
                                    );
                                  },
                                )
                              ],
                            )
                          : Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        partner.rightTab,
                                        style: Get.theme.primaryTextTheme.titleMedium.copyWith(
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          Get.back();
                                        },
                                        child: Icon(
                                          Icons.close,
                                          size: 15,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Divider(),
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: HtmlWidget(partner.rightTabDesc),
                                ),
                              ],
                            ),
              StatefulBuilder(
                builder: (BuildContext context, StateSetter setState) => Container(
                  color: Get.theme.primaryColor,
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          homeController.setWebBottomIndex(0);
                        },
                        child: Card(
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                gradient: LinearGradient(
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                  colors: [
                                    Get.theme.primaryColor,
                                    Get.theme.primaryColor,
                                    Get.theme.primaryColor,
                                    Get.theme.primaryColor.withOpacity(0.8),
                                  ],
                                )),
                            child: RichText(
                              text: TextSpan(
                                text: "CF",
                                style: Get.theme.primaryTextTheme.titleSmall.copyWith(
                                  letterSpacing: -0.2,
                                  color: Get.theme.secondaryHeaderColor,
                                  fontWeight: FontWeight.w600,
                                ),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: ' ${AppLocalizations.of(context).see_more}',
                                    style: Get.theme.primaryTextTheme.bodySmall.copyWith(
                                      letterSpacing: -0.2,
                                      fontWeight: FontWeight.w300,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      //Expanded(child: SizedBox()),
                      partner != null && partner.leftTab.isNotEmpty
                          ? InkWell(
                              onTap: () {
                                homeController.setWebBottomIndex(1);
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 15),
                                child: Text(
                                  partner.leftTab,
                                  style: Get.theme.primaryTextTheme.bodySmall.copyWith(
                                    letterSpacing: -0.2,
                                    fontWeight: FontWeight.w300,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            )
                          : SizedBox(),
                      //Expanded(child: SizedBox()),
                      couponList != null && couponList.length > 0
                          ? InkWell(
                              onTap: () {
                                homeController.setWebBottomIndex(2);
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(left: 5, right: 15),
                                child: Text(
                                  ' ${AppLocalizations.of(context).coupon}',
                                  style: Get.theme.primaryTextTheme.bodySmall.copyWith(
                                    letterSpacing: -0.2,
                                    fontWeight: FontWeight.w300,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            )
                          : SizedBox(),
                      //Expanded(child: SizedBox()),
                      partner != null && partner.rightTab.isNotEmpty
                          ? InkWell(
                              onTap: () {
                                homeController.setWebBottomIndex(3);
                              },
                              child: Text(
                                partner.rightTab,
                                style: Get.theme.primaryTextTheme.bodySmall.copyWith(
                                  letterSpacing: -0.2,
                                  fontWeight: FontWeight.w300,
                                  color: Colors.white,
                                ),
                              ),
                            )
                          : SizedBox(),
                    ],
                  ),
                  // Row(
                  //   children: [
                  //     InkWell(
                  //       onTap: () {
                  //         Get.find<HomeController>().setWebBottomIndex(0);
                  //       },
                  //       child: Card(
                  //         elevation: 5,
                  //         shape: RoundedRectangleBorder(
                  //           borderRadius: BorderRadius.circular(20),
                  //         ),
                  //         child: Container(
                  //           padding: EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                  //           decoration: BoxDecoration(
                  //               borderRadius: BorderRadius.circular(20),
                  //               gradient: LinearGradient(
                  //                 begin: Alignment.centerLeft,
                  //                 end: Alignment.centerRight,
                  //                 colors: [
                  //                   Get.theme.primaryColor,
                  //                   Get.theme.primaryColor,
                  //                   Get.theme.primaryColor,
                  //                   Get.theme.primaryColor.withOpacity(0.8),
                  //                 ],
                  //               )),
                  //           child: RichText(
                  //             text: TextSpan(
                  //               text: "CK",
                  //               style: Get.theme.primaryTextTheme.titleSmall.copyWith(
                  //                 letterSpacing: -0.2,
                  //                 color: Get.theme.secondaryHeaderColor,
                  //                 fontWeight: FontWeight.w600,
                  //               ),
                  //               children: <TextSpan>[
                  //                 TextSpan(
                  //                   text: ' See more',
                  //                   style: Get.theme.primaryTextTheme.bodySmall.copyWith(
                  //                     letterSpacing: -0.2,
                  //                     fontWeight: FontWeight.w300,
                  //                     color: Colors.white,
                  //                   ),
                  //                 ),
                  //               ],
                  //             ),
                  //           ),
                  //         ),
                  //       ),
                  //     ),
                  //     Expanded(child: SizedBox()),
                  //     InkWell(
                  //       onTap: () {
                  //         Get.find<HomeController>().setWebBottomIndex(1);
                  //       },
                  //       child: Row(
                  //         children: [
                  //           Icon(
                  //             Icons.currency_rupee_sharp,
                  //             color: Colors.white,
                  //             size: 15,
                  //           ),
                  //           Text(
                  //             ' Cashback',
                  //             style: Get.theme.primaryTextTheme.bodySmall.copyWith(
                  //               letterSpacing: -0.2,
                  //               fontWeight: FontWeight.w300,
                  //               color: Colors.white,
                  //             ),
                  //           ),
                  //         ],
                  //       ),
                  //     ),
                  //     Expanded(child: SizedBox()),
                  //     InkWell(
                  //       onTap: () {
                  //         Get.find<HomeController>().setWebBottomIndex(2);
                  //       },
                  //       child: Row(
                  //         children: [
                  //           Icon(
                  //             Icons.local_offer,
                  //             color: Colors.white,
                  //             size: 15,
                  //           ),
                  //           Text(
                  //             ' Coupon',
                  //             style: Get.theme.primaryTextTheme.bodySmall.copyWith(
                  //               letterSpacing: -0.2,
                  //               fontWeight: FontWeight.w300,
                  //               color: Colors.white,
                  //             ),
                  //           ),
                  //         ],
                  //       ),
                  //     ),
                  //     Expanded(child: SizedBox()),
                  //     InkWell(
                  //       onTap: () {
                  //         Get.find<HomeController>().setWebBottomIndex(3);
                  //       },
                  //       child: Row(
                  //         children: [
                  //           Icon(
                  //             Icons.info,
                  //             color: Colors.white,
                  //             size: 15,
                  //           ),
                  //           Text(
                  //             ' Info',
                  //             style: Get.theme.primaryTextTheme.bodySmall.copyWith(
                  //               letterSpacing: -0.2,
                  //               fontWeight: FontWeight.w300,
                  //               color: Colors.white,
                  //             ),
                  //           )
                  //         ],
                  //       ),
                  //     ),
                  //   ],
                  // ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
