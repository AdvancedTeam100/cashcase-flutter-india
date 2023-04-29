import 'package:cashfuse/controllers/homeController.dart';
import 'package:cashfuse/utils/Mycolors.dart';
import 'package:cashfuse/utils/global.dart' as global;
import 'package:cashfuse/views/webScreen/webProductDetails.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class WebHomeProductView extends StatelessWidget {
  WebHomeProductView({Key key}) : super(key: key);

  final scrollController = new ScrollController();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (homeController) {
      return global.appInfo.baseUrls != null && homeController.isProductsLoaded
          ? homeController.productList != null &&
                  homeController.productList.length > 0
              ? Row(
                  children: [
                    InkWell(
                      onTap: () => scrollController.animateTo(
                          scrollController.initialScrollOffset,
                          duration: Duration(seconds: 1),
                          curve: Curves.easeInOut),
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
                        height: 290,
                        // height: Get.height * 0.35,
                        child: ListView.builder(
                          controller: scrollController,
                            shrinkWrap: true,
                            itemCount: homeController.productList.length,
                            scrollDirection: Axis.horizontal,
                            padding: EdgeInsets.symmetric(horizontal: 6),
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              WebProductDetailsScreen(
                                                title: "LATEST PRODUCTS",
                                                product: homeController
                                                    .productList[index],
                                              )));
                                },
                                child: Container(
                                  width: 192,
                                  // width: Get.width * 0.1,
                                  // height: Get.height * 0.35,
                                  // height: Get.height * 0.35,
                                  margin: EdgeInsets.only(right: 13),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        padding: EdgeInsets.only(
                                            top: 15, bottom: 15),
                                        child: RichText(
                                          text: TextSpan(
                                              text: "Price Compared ",
                                              style: TextStyle(
                                                  color: Colors.black54,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 13),
                                              children: [
                                                TextSpan(
                                                    text:
                                                        '(${homeController.productList[index].productPrices.length} Sellers)',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 13,
                                                        color: Colors.blueAccent
                                                            .shade400)),
                                              ]),
                                        ),
                                      ),
                                      Divider(),
                                      // Container(
                                      //   color: Colors.grey.shade400,
                                      //   height: 1,
                                      // ),
                                      Image.network(
                                        "${global.appInfo.baseUrls.productImageurl}/${homeController.productList[index].image}",
                                        // width: 150,
                                        height: 120,
                                        // height: Get.height * 0.15,
                                        fit: BoxFit.contain,
                                      ),
                                      // Padding(
                                      //   padding: const EdgeInsets.only(
                                      //       top: 8.0, bottom: 8),
                                      //   child: RichText(
                                      //     text: TextSpan(
                                      //         text: "Brand: ",
                                      //         style: TextStyle(
                                      //             color: Colors.black54,
                                      //             fontWeight: FontWeight.w500,
                                      //             fontSize: 10),
                                      //         children: [
                                      //           TextSpan(
                                      //               text:
                                      //                   '${homeController.productList[index].name} ',
                                      //               style: TextStyle(
                                      //                   fontWeight:
                                      //                       FontWeight.w600,
                                      //                   fontSize: 12,
                                      //                   color: Colors.black)),
                                      //         ]),
                                      //   ),
                                      // ),
                                      Divider(
                                        height: 0,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 8.0, bottom: 8),
                                        child: Text(
                                          "${homeController.productList[index].name} ",
                                          style: TextStyle(
                                              color: Colors.black54,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 13),
                                        ),
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                            color: Mycolors.lightOrage,
                                            border: Border.all(
                                                color: Mycolors.orange)),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 13, vertical: 3),
                                        child: Text(
                                          "+ ₹ ${homeController.productList[index].productPrices[0].cashback}  REWARDS",
                                          style: TextStyle(
                                              fontSize: 11,
                                              fontWeight: FontWeight.w700,
                                              color: Mycolors.orange),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 8.0, bottom: 8),
                                        child: Text(
                                          "Final Price ₹ ${homeController.productList[index].productPrices[0].price}",
                                          style: TextStyle(
                                              color: Mycolors.blue,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 12),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }),
                      ),
                    ),
                    InkWell(
                      onTap: () => scrollController.animateTo(
                          scrollController.position.viewportDimension,
                          duration: Duration(seconds: 1),
                          curve: Curves.easeInOut),
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 6, vertical: 20),
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
