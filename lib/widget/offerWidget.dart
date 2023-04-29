// ignore_for_file: must_be_immutable

import 'package:cashfuse/controllers/homeController.dart';
import 'package:cashfuse/models/commonModel.dart';
import 'package:cashfuse/models/offerModel.dart';
import 'package:cashfuse/utils/global.dart' as global;
import 'package:cashfuse/utils/images.dart';
import 'package:cashfuse/widget/customImage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:slide_countdown/slide_countdown.dart';

class OfferWidget extends StatelessWidget {
  final OfferModel offer;
  final CommonModel commonModel;
  final String domainImage;
  final bool fromList;
  OfferWidget({this.offer, this.commonModel, this.domainImage, this.fromList});

  HomeController homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: global.getPlatFrom() ? 330 : 260,
      height: fromList ? 250 : 200,
      margin: fromList ? EdgeInsets.only(top: 15) : EdgeInsets.only(right: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: commonModel != null
          ? Column(
              children: [
                Stack(
                  alignment: Alignment.topLeft,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      ),
                      child: CustomImage(
                        image: '${global.appInfo.baseUrls.offerImageUrl}/${commonModel.image}',
                        height: fromList
                            ? 180
                            : global.getPlatFrom()
                                ? 170
                                : 145,
                        width: Get.width,
                        fit: BoxFit.fill,
                        errorImage: Images.dummyImage,
                      ),
                    ),
                    Card(
                      color: Colors.white,
                      margin: EdgeInsets.all(10),
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: CustomImage(
                          image: '${global.appInfo.baseUrls.partnerImageUrl}/$domainImage',
                          height: 30,
                          width: 60,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(
                          color: Get.theme.secondaryHeaderColor,
                          borderRadius: BorderRadius.circular(2),
                        ),
                        child: Text(
                          commonModel.buttonText.isNotEmpty ? commonModel.buttonText : 'Grab Now',
                          style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )
          : offer != null
              ? Column(
                  children: [
                    Stack(
                      alignment: Alignment.topLeft,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                          ),
                          child: CustomImage(
                            image: '${global.appInfo.baseUrls.offerImageUrl}/${offer.bannerImage}',
                            height: fromList
                                ? 180
                                : global.getPlatFrom()
                                    ? 170
                                    : 145,
                            width: Get.width,
                            fit: BoxFit.fill,
                            errorImage: Images.dummyImage,
                          ),
                        ),
                        Card(
                          color: Colors.white,
                          margin: EdgeInsets.all(10),
                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: CustomImage(
                              image: '${global.appInfo.baseUrls.offerImageUrl}/${offer.image}',
                              height: 30,
                              width: 60,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            offer.dayDifference != null && offer.dayDifference > 0
                                ? SlideCountdown(
                                    slideDirection: SlideDirection.none,
                                    textStyle: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w600),
                                    decoration: BoxDecoration(
                                      color: Colors.red[800],
                                      borderRadius: BorderRadius.circular(3),
                                    ),
                                    duration: Duration(days: offer.dayDifference),
                                  )
                                : SizedBox(),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                              decoration: BoxDecoration(
                                color: Get.theme.secondaryHeaderColor,
                                borderRadius: BorderRadius.circular(2),
                              ),
                              child: Text(
                                offer.buttonText,
                                style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w500),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                )
              : SizedBox(),
    );
  }
}
