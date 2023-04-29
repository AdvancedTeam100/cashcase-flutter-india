import 'package:cashfuse/constants/appConstant.dart';
import 'package:cashfuse/controllers/homeController.dart';
import 'package:cashfuse/models/categoryModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:get/get.dart';

class RatesAndOfferTermsSheetWidget extends StatelessWidget {
  final bool isOffer;
  final CategoryModel partner;
  RatesAndOfferTermsSheetWidget({this.isOffer, this.partner});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (homeController) {
        return SingleChildScrollView(
          child: Container(
            alignment: Alignment.bottomCenter,
            width: AppConstants.WEB_MAX_WIDTH,
            child: Container(
              width: AppConstants.WEB_MAX_WIDTH,
              padding: EdgeInsets.only(top: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                ),
                color: Colors.white,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15, bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          homeController.isOffer ? partner.rightTab : partner.leftTab,
                          style: Get.theme.primaryTextTheme.titleSmall.copyWith(
                            fontWeight: FontWeight.w600,
                            letterSpacing: -0.1,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Get.back();
                          },
                          child: Icon(
                            Icons.close,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    height: 1,
                    thickness: 1,
                  ),
                  // SizedBox(
                  //   height: 20,
                  // ),
                  homeController.isOffer
                      ? HtmlWidget(
                          partner.rightTabDesc,
                        )
                      : Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: HtmlWidget(
                            partner.leftTabDesc,
                          ),
                        ),

                  (partner.leftTab.isEmpty || partner.rightTab.isEmpty)
                      ? SizedBox()
                      : SizedBox(
                          height: 50,
                          child: Card(
                            margin: EdgeInsets.zero,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                            color: Get.theme.primaryColor,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                InkWell(
                                  onTap: () {
                                    Get.find<HomeController>().setIsOffer(false);
                                  },
                                  child: Text(
                                    partner.leftTab,
                                    style: Get.theme.primaryTextTheme.titleSmall.copyWith(fontWeight: FontWeight.w400, color: Colors.white),
                                  ),
                                ),
                                Icon(
                                  Icons.more_vert,
                                  size: 22,
                                  color: Colors.white.withOpacity(0.3),
                                ),
                                InkWell(
                                  onTap: () {
                                    homeController.setIsOffer(true);
                                  },
                                  child: Text(
                                    partner.rightTab,
                                    style: Get.theme.primaryTextTheme.titleSmall.copyWith(fontWeight: FontWeight.w400, color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
