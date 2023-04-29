import 'package:cashfuse/controllers/homeController.dart';
import 'package:cashfuse/models/commonModel.dart';
import 'package:cashfuse/utils/global.dart' as global;
import 'package:cashfuse/views/categoryScreen.dart';
import 'package:cashfuse/widget/web/webAdsCampaignWidget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class HomeWebTopCashbackView extends StatelessWidget {
  final scrollController = new ScrollController();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (hmController) {
      return global.appInfo.baseUrls != null && hmController.isTopCashbackLoaded
          ? hmController.topCashbackList != null && hmController.topCashbackList.length > 0
              ? Row(
                  children: [
                    InkWell(
                      onTap: () => scrollController.animateTo(scrollController.initialScrollOffset, duration: Duration(seconds: 1), curve: Curves.easeInOut),
                      child: Container(
                        width: 30,
                        height: 80,
                        margin: EdgeInsets.only(right: 5),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          color: Get.theme.secondaryHeaderColor,
                        ),
                        child: Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Expanded(
                      child: SizedBox(
                        height: 190,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          controller: scrollController,
                          itemCount: hmController.topCashbackList.length,
                          shrinkWrap: true,
                          physics: AlwaysScrollableScrollPhysics(),
                          padding: const EdgeInsets.symmetric(horizontal: 6),
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                Get.to(
                                  () => CategoryScreen(
                                    category: hmController.topCashbackList[index],
                                  ),
                                  routeName: 'category',
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(right: 13),
                                child: SizedBox(
                                  width: 192,
                                  child: WebAdsCampaignWidget(
                                    fromWebHome: true,
                                    commonModel: CommonModel(
                                      name: hmController.topCashbackList[index].name,
                                      image: '${global.appInfo.baseUrls.partnerImageUrl}/${hmController.topCashbackList[index].image}',
                                      tagline: hmController.topCashbackList[index].tagline,
                                      adId: hmController.topCashbackList[index].id.toString(),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () => scrollController.animateTo(scrollController.position.viewportDimension, duration: Duration(seconds: 1), curve: Curves.easeInOut),
                      child: Container(
                        width: 30,
                        height: 80,
                        margin: EdgeInsets.only(left: 5),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          color: Get.theme.secondaryHeaderColor,
                        ),
                        child: Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                )
              : SizedBox()
          : SizedBox(
              height: 155,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 5,
                  shrinkWrap: true,
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 20),
                  itemBuilder: (context, index) {
                    return Shimmer(
                      duration: Duration(seconds: 2),
                      child: Container(
                        width: 155,
                        margin: EdgeInsets.only(right: 15),
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    );
                  }),
            );
    });
  }
}
