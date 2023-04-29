import 'package:cashfuse/controllers/homeController.dart';
import 'package:cashfuse/utils/global.dart' as global;
import 'package:cashfuse/views/categoryScreen.dart';
import 'package:cashfuse/widget/customImage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class HomeWebCategoryView extends StatelessWidget {
  final scrollController = new ScrollController();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (hm) {
      return Row(
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
              height: 140,
              child: global.appInfo.baseUrls != null && hm.isCategoryLoaded
                  ? Stack(
                      children: [
                        StatefulBuilder(
                          builder: (BuildContext context, StateSetter setState) => ListView.builder(
                            shrinkWrap: true,
                            controller: scrollController,
                            scrollDirection: Axis.horizontal,
                            itemCount: hm.topCategoryList.length > 10 ? 10 : hm.topCategoryList.length,
                            padding: const EdgeInsets.symmetric(horizontal: 6),
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  //Get.toNamed(Routes.categoryRoute, arguments: hm.topCategoryList[index]);
                                  Get.to(
                                    () => CategoryScreen(
                                      category: hm.topCategoryList[index],
                                    ),
                                    routeName: 'category',
                                  );
                                },
                                child: Container(
                                  width: 195,
                                  margin: EdgeInsets.only(right: 10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white,
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        hm.topCategoryList[index].name.toUpperCase(),
                                        textAlign: TextAlign.center,
                                        style: Get.theme.primaryTextTheme.bodySmall.copyWith(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      CustomImage(
                                        image: '${global.appInfo.baseUrls.categoryImageUrl}/${hm.topCategoryList[index].image}',
                                        height: 60,
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),

                        //: SizedBox(),
                        // listIndex != ((hm.topCategoryList.length / 2).ceil() - 1)
                        //     ?

                        //: SizedBox(),
                      ],
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: 10,
                      padding: const EdgeInsets.symmetric(horizontal: 6),
                      itemBuilder: (context, index) {
                        return SizedBox(
                          height: 75,
                          child: Shimmer(
                            duration: Duration(seconds: 2),
                            child: Container(
                              width: 195,
                              margin: EdgeInsets.only(right: 15),
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ),
          InkWell(
            onTap: () => scrollController.animateTo(scrollController.position.maxScrollExtent, duration: Duration(seconds: 1), curve: Curves.easeInOut),
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
      );
    });
  }
}
