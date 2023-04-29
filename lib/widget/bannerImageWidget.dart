import 'package:cashfuse/constants/appConstant.dart';
import 'package:cashfuse/controllers/splashController.dart';
import 'package:cashfuse/widget/customImage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cashfuse/utils/global.dart' as global;

SplashController splashController = Get.find<SplashController>();

Widget bannerImageWidget() {
  return global.isBannerShow && global.bannerImage.isNotEmpty
      ? GetBuilder<SplashController>(builder: (splash) {
          return WillPopScope(
            onWillPop: () async {
              return false;
            },
            child: FutureBuilder(
                builder: (context1, snapshot) {
                  return SizedBox();
                },
                future: Future.delayed(Duration.zero).then((value) {
                  return Get.dialog(
                    Dialog(
                      backgroundColor: Colors.transparent,
                      insetPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      child: Stack(
                        alignment: Alignment.topRight,
                        clipBehavior: Clip.none,
                        children: [
                          CustomImage(
                            image: global.appInfo.baseUrls.notificationBannerImageUrl + '/' + global.bannerImage,
                            fit: BoxFit.contain,
                            width: global.getPlatFrom() ? AppConstants.WEB_MAX_WIDTH / 3 : null,
                          ),
                          Positioned(
                            top: !global.getPlatFrom() ? 60 : 10,
                            right: -7,
                            child: InkWell(
                              onTap: () async {
                                Get.back();
                                await splashController.bannerShow();
                              },
                              child: CircleAvatar(
                                radius: 15,
                                child: Icon(
                                  Icons.close,
                                  color: Colors.black,
                                  size: 20,
                                ),
                                backgroundColor: Colors.grey[400],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    barrierDismissible: false,
                  );
                })),
          );
        })
      : SizedBox();
}
