import 'package:carousel_slider/carousel_slider.dart';
import 'package:cashfuse/constants/appConstant.dart';
import 'package:cashfuse/controllers/homeController.dart';
import 'package:cashfuse/models/productModel.dart';
import 'package:cashfuse/utils/global.dart' as global;
import 'package:cashfuse/views/getStartedScreen.dart';
import 'package:cashfuse/widget/customImage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/Mycolors.dart';

class ProductDetailsScreen extends StatefulWidget {
  final String title;
  final ProductModel product;
  ProductDetailsScreen({Key key, this.title, this.product}) : super(key: key);

  @override
  State<ProductDetailsScreen> createState() =>
      _ProductDetailsScreenState(this.product);
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  ProductModel product;
  _ProductDetailsScreenState(this.product) : super();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: Icon(
            Icons.arrow_back,
          ),
        ),
        title: Text(
          widget.title,
          style: Get.theme.primaryTextTheme.titleSmall
              .copyWith(color: Colors.white),
        ),
      ),
      body: Align(
        alignment: Alignment.topCenter,
        child: SizedBox(
          width: AppConstants.WEB_MAX_WIDTH,
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Container(
                //   margin: EdgeInsets.only(left: 15, top: 10, bottom: 10),
                //   child: Text(
                //     product.name,
                //     style: TextStyle(
                //         fontSize: 14,
                //         color: Colors.black87,
                //         fontWeight: FontWeight.w600),
                //   ),
                // ),
                SizedBox(
                  height: 10,
                ),
                CarouselSlider(
                  options: CarouselOptions(height: 200.0, autoPlay: true),
                  items: product.images.map((i) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Container(
                            width: GetPlatform.isWeb
                                ? AppConstants.WEB_MAX_WIDTH / 2
                                : MediaQuery.of(context).size.width,
                            margin: EdgeInsets.symmetric(horizontal: 5.0),
                            decoration: BoxDecoration(
                                //color: Colors.amber
                                ),
                            child: CustomImage(
                              image:
                                  "${global.appInfo.baseUrls.productImageurl}/$i",
                              fit: BoxFit.contain,
                            ));
                      },
                    );
                  }).toList(),
                ),
                SizedBox(
                  height: 10,
                ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     Column(
                //       crossAxisAlignment: CrossAxisAlignment.start,
                //       children: [
                //         Container(
                //           margin: EdgeInsets.only(left: 10),
                //           child: Text(
                //             "Choose Varient",
                //             style: TextStyle(
                //                 fontWeight: FontWeight.w500,
                //                 fontSize: 12,
                //                 color: Colors.black),
                //           ),
                //         ),
                //         SizedBox(
                //           height: 10,
                //         ),
                //         Container(
                //           margin: EdgeInsets.only(right: 5, left: 10),
                //           alignment: Alignment.center,
                //           width: 160,
                //           decoration: BoxDecoration(
                //               border: Border.all(color: Colors.black, width: 1)),
                //           child: DropdownButton<String>(
                //             value: dropdownValue,
                //             icon: const Icon(Icons.arrow_drop_down),
                //             elevation: 16,
                //             style: const TextStyle(color: Colors.deepPurple),
                //             underline: Container(),
                //             onChanged: (String value) {
                //               // This is called when the user selects an item.
                //               setState(() {
                //                 dropdownValue = value;
                //               });
                //             },
                //             items:
                //                 list.map<DropdownMenuItem<String>>((String value) {
                //               return DropdownMenuItem<String>(
                //                 value: value,
                //                 child: Container(width: 100, child: Text(value)),
                //               );
                //             }).toList(),
                //           ),
                //         )
                //       ],
                //     ),
                //     Column(
                //       crossAxisAlignment: CrossAxisAlignment.start,
                //       children: [
                //         Text(
                //           "Choose Colour",
                //           style: TextStyle(
                //               fontWeight: FontWeight.w500,
                //               fontSize: 12,
                //               color: Colors.black),
                //         ),
                //         SizedBox(
                //           height: 10,
                //         ),
                //         Container(
                //           margin: EdgeInsets.only(right: 10),
                //           alignment: Alignment.center,
                //           width: 160,
                //           decoration: BoxDecoration(
                //               border: Border.all(color: Colors.black, width: 1)),
                //           child: DropdownButton<String>(
                //             value: dropdownValue,
                //             icon: const Icon(Icons.arrow_drop_down),
                //             elevation: 16,
                //             style: const TextStyle(color: Colors.deepPurple),
                //             underline: Container(),
                //             onChanged: (String value) {
                //               // This is called when the user selects an item.
                //               setState(() {
                //                 dropdownValue = value;
                //               });
                //             },
                //             items:
                //                 list.map<DropdownMenuItem<String>>((String value) {
                //               return DropdownMenuItem<String>(
                //                 value: value,
                //                 child: Container(width: 100, child: Text(value)),
                //               );
                //             }).toList(),
                //           ),
                //         )
                //       ],
                //     ),
                //   ],
                // ),
                // SizedBox(
                //   height: 10,
                // ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  color: Colors.grey.shade300,
                  width: MediaQuery.of(context).size.width,
                  child: Text(
                    "Choose Best Price",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                GetBuilder<HomeController>(builder: (homeController) {
                  return ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: product.productPrices.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        color: Colors.white,
                        padding: EdgeInsets.only(left: 10, right: 10),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomImage(
                                  image:
                                      "${global.appInfo.baseUrls.productSiteUrl}/${product.productPrices[index].siteIcon}",
                                  height: 40,
                                  width: 100,
                                ),
                                InkWell(
                                  onTap: () async {
                                    if (global.currentUser.id != null) {
                                      await homeController.getTrackingLink(
                                          product.productPrices[index].url,
                                          product.affiliatePartner,
                                          cId: product.productPrices[index].cId
                                              .toString());
                                      await homeController.addClick(
                                        product.productPrices[index].siteName,
                                        global.appInfo.baseUrls.productSiteUrl +
                                            '/' +
                                            product
                                                .productPrices[index].siteIcon,
                                        homeController.createdLink.isNotEmpty
                                            ? homeController.createdLink
                                            : product.productPrices[index].url,
                                      );

                                      global.launchInBrowser(
                                        homeController.createdLink.isNotEmpty
                                            ? homeController.createdLink
                                            : product.productPrices[index].url,
                                      );

                                      // Get.to(
                                      //   () => WebViewScreen(
                                      //     urlString: homeController.createdLink.isNotEmpty ? homeController.createdLink : ads.landingPage,
                                      //     isCliked: global.clickedList.contains(ads.advName),
                                      //     couponList: ads.couponList,
                                      //     partner: ads.partner,
                                      //     brandName: ads.advName,
                                      //   ),
                                      // ).then((value) {
                                      //   if (global.clickedList.contains(ads.advName)) {
                                      //   } else {
                                      //     global.clickedList.add(ads.advName);
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
                                    padding: EdgeInsets.only(
                                        left: 13, right: 13, bottom: 3, top: 3),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: Colors.black,
                                    ),
                                    child: Text(
                                      "Grab Now",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 13),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              height: 2,
                              color: Colors.grey.shade400,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Column(
                                  children: [
                                    Text(
                                      "₹ ${product.productPrices[index].mrp}",
                                      style: TextStyle(
                                          color: Colors.black54,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 12),
                                    ),
                                    Text(
                                      "Seller price",
                                      style: TextStyle(
                                          color: Colors.black54,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 12),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Container(
                                  width: 2,
                                  height: 70,
                                  color: Colors.grey,
                                ),
                                product.productPrices[index].cashback == null
                                    ? Container(
                                        width: 70,
                                        child: Text(
                                          "This is the best Price",
                                          style: TextStyle(
                                              color: Colors.black54,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 12),
                                        ),
                                      )
                                    : Column(
                                        children: [
                                          Text(
                                            "₹ ${product.productPrices[index].cashback}",
                                            style: TextStyle(
                                                color: Mycolors.orange,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 12),
                                          ),
                                          Text(
                                            "CashBack",
                                            style: TextStyle(
                                                color: Colors.black54,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 12),
                                          ),
                                        ],
                                      ),
                                SizedBox(
                                  width: 10,
                                ),
                                Container(
                                  width: 2,
                                  height: 70,
                                  color: Colors.grey,
                                ),
                                Column(
                                  children: [
                                    Text(
                                      "₹ ${product.productPrices[index].price}",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 12),
                                    ),
                                    Text(
                                      "Best Price",
                                      style: TextStyle(
                                          color: Colors.black54,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 12),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                              ],
                            )
                          ],
                        ),
                      );
                    },
                  );
                })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
