import 'package:cashfuse/constants/appConstant.dart';
import 'package:cashfuse/controllers/homeController.dart';
import 'package:cashfuse/utils/global.dart' as global;
import 'package:cashfuse/views/getStartedScreen.dart';
import 'package:cashfuse/views/loginOrSignUpScreen.dart';
import 'package:cashfuse/views/offerDetailScreen.dart';
import 'package:cashfuse/widget/customImage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class WebBannerView extends StatelessWidget {
  final HomeController homeController;
  WebBannerView({@required this.homeController});

  Widget build(BuildContext context) {
    final PageController _pageController = PageController();
    return Container(
      color: Colors.transparent,
      padding: EdgeInsets.all(10),
      alignment: Alignment.center,
      child: global.appInfo.baseUrls != null && homeController.isBannerLoaded
          ? homeController.topBannerList != null &&
                  homeController.topBannerList.length > 0
              ? SizedBox(
                  width: AppConstants.WEB_MAX_WIDTH,
                  height: 220,
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      PageView.builder(
                        controller: _pageController,
                        itemCount:
                            (homeController.topBannerList.length / 3).ceil(),
                        itemBuilder: (context, index) {
                          // int index1 = index * 3;
                          // int index2 = (index * 3) + 1;
                          // bool _hasSecond = index2 < homeController.topBannerList.length;

                          return Row(
                            children: [
                              Expanded(
                                child: InkWell(
                                  onTap: () async {
                                    if (homeController
                                            .topBannerList[index * 3].type ==
                                        'url') {
                                      if (global.currentUser.id != null) {
                                        // Get.to(
                                        //   () => WebViewScreen(
                                        //     urlString: homeController.topBannerList[index].url,
                                        //     brandName: homeController.topBannerList[index].name,
                                        //   ),
                                        // );
                                        global.launchInBrowser(
                                          homeController
                                              .topBannerList[index * 3].url,
                                        );
                                      } else {
                                        Get.dialog(Dialog(
                                          child: SizedBox(
                                            width: Get.width / 3,
                                            child: GetStartedScreen(
                                              fromMenu: true,
                                            ),
                                          ),
                                        ));
                                      }
                                    } else {
                                      await homeController.getOfferDetails(
                                        homeController
                                            .topBannerList[index * 3].offerId
                                            .toString(),
                                      );
                                      Get.to(
                                        () => OfferDetailScreen(
                                          offer: homeController.offer,
                                          fromSeeMore: false,
                                        ),
                                        routeName: 'offer',
                                      );
                                    }
                                  },
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: CustomImage(
                                      image:
                                          '${global.appInfo.baseUrls.bannerImageUrl}/${homeController.topBannerList[index * 3].image}',
                                      fit: BoxFit.fill,
                                      height: 220,
                                      //width: AppConstants.WEB_MAX_WIDTH / 4,
                                    ),
                                  ),
                                ),
                              ),
                              ((index * 3) + 1) <
                                      homeController.topBannerList.length
                                  ? Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: InkWell(
                                          onTap: () async {
                                            if (homeController
                                                    .topBannerList[
                                                        (index * 3) + 1]
                                                    .type ==
                                                'url') {
                                              if (global.currentUser.id !=
                                                  null) {
                                                // Get.to(
                                                //   () => WebViewScreen(
                                                //     urlString: homeController.topBannerList[index].url,
                                                //     brandName: homeController.topBannerList[index].name,
                                                //   ),
                                                // );
                                                global.launchInBrowser(
                                                  homeController
                                                      .topBannerList[
                                                          (index * 3) + 1]
                                                      .url,
                                                );
                                              } else {
                                                Get.dialog(Dialog(
                                                  child: SizedBox(
                                                    width: Get.width / 3,
                                                    child: LoginOrSignUpScreen(
                                                      fromMenu: true,
                                                    ),
                                                  ),
                                                ));
                                              }
                                            } else {
                                              await homeController
                                                  .getOfferDetails(
                                                homeController
                                                    .topBannerList[
                                                        (index * 3) + 1]
                                                    .offerId
                                                    .toString(),
                                              );
                                              Get.to(
                                                () => OfferDetailScreen(
                                                  offer: homeController.offer,
                                                  fromSeeMore: false,
                                                ),
                                                routeName: 'offer',
                                              );
                                            }
                                          },
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child: CustomImage(
                                              image:
                                                  '${global.appInfo.baseUrls.bannerImageUrl}/${homeController.topBannerList[(index * 3) + 1].image}',
                                              fit: BoxFit.fill,
                                              height: 220,
                                              //width: AppConstants.WEB_MAX_WIDTH / 4,
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  : Expanded(child: SizedBox()),
                              ((index * 3) + 2) <
                                      homeController.topBannerList.length
                                  ? Expanded(
                                      child: InkWell(
                                        onTap: () async {
                                          if (homeController
                                                  .topBannerList[
                                                      (index * 3) + 2]
                                                  .type ==
                                              'url') {
                                            if (global.currentUser.id != null) {
                                              // Get.to(
                                              //   () => WebViewScreen(
                                              //     urlString: homeController.topBannerList[index].url,
                                              //     brandName: homeController.topBannerList[index].name,
                                              //   ),
                                              // );
                                              global.launchInBrowser(
                                                homeController
                                                    .topBannerList[
                                                        (index * 3) + 2]
                                                    .url,
                                              );
                                            } else {
                                              Get.dialog(Dialog(
                                                child: SizedBox(
                                                  width: Get.width / 3,
                                                  child: GetStartedScreen(
                                                    fromMenu: true,
                                                  ),
                                                ),
                                              ));
                                            }
                                          } else {
                                            await homeController
                                                .getOfferDetails(
                                              homeController
                                                  .topBannerList[
                                                      (index * 3) + 2]
                                                  .offerId
                                                  .toString(),
                                            );
                                            Get.to(
                                              () => OfferDetailScreen(
                                                offer: homeController.offer,
                                                fromSeeMore: false,
                                              ),
                                              routeName: 'offer',
                                            );
                                          }
                                        },
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: CustomImage(
                                            image:
                                                '${global.appInfo.baseUrls.bannerImageUrl}/${homeController.topBannerList[(index * 3) + 2].image}',
                                            fit: BoxFit.fill,
                                            height: 220,
                                            //width: AppConstants.WEB_MAX_WIDTH / 4,
                                          ),
                                        ),
                                      ),
                                    )
                                  : Expanded(child: SizedBox()),
                            ],
                          );
                        },
                        onPageChanged: (int index) =>
                            homeController.setBannerIndex(index),
                      ),
                      homeController.bannerIndex != 0
                          ? Positioned(
                              top: 0,
                              bottom: 0,
                              left: 0,
                              child: InkWell(
                                onTap: () => _pageController.previousPage(
                                    duration: Duration(seconds: 1),
                                    curve: Curves.easeInOut),
                                child: Container(
                                  height: 40,
                                  width: 40,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Theme.of(context).cardColor,
                                  ),
                                  child: Icon(Icons.arrow_back),
                                ),
                              ),
                            )
                          : SizedBox(),
                      homeController.bannerIndex !=
                              ((homeController.topBannerList.length / 2)
                                      .ceil() -
                                  1)
                          ? Positioned(
                              top: 0,
                              bottom: 0,
                              right: 0,
                              child: InkWell(
                                onTap: () => _pageController.nextPage(
                                    duration: Duration(seconds: 1),
                                    curve: Curves.easeInOut),
                                child: Container(
                                  height: 40,
                                  width: 40,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Theme.of(context).cardColor,
                                  ),
                                  child: Icon(Icons.arrow_forward),
                                ),
                              ),
                            )
                          : SizedBox(),
                    ],
                  ),
                )
              : SizedBox()
          : WebBannerShimmer(),
    );
  }
}

class WebBannerShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Shimmer(
      duration: Duration(seconds: 2),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Row(children: [
          Expanded(
              child: Container(
            height: 220,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey[300]),
          )),
          SizedBox(width: 20),
          Expanded(
              child: Container(
            height: 220,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey[300]),
          )),
        ]),
      ),
    );
  }
}
