import 'package:cashfuse/constants/appConstant.dart';
import 'package:cashfuse/models/productModel.dart';
import 'package:cashfuse/utils/global.dart' as global;
import 'package:cashfuse/views/webScreen/webProductDetails.dart';
import 'package:cashfuse/widget/web/webTopBarWidget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/Mycolors.dart';
import '../product_Details.dart';

class ViewAllProductScreen extends StatefulWidget {
  final String title;
  final List<ProductModel> productList;
  ViewAllProductScreen({Key key, this.title, this.productList})
      : super(key: key);

  @override
  State<ViewAllProductScreen> createState() =>
      _ViewAllProductScreenState(this.title, this.productList);
}

class _ViewAllProductScreenState extends State<ViewAllProductScreen> {
  String title;
  List<ProductModel> productList;

  _ViewAllProductScreenState(this.title, this.productList) : super();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: global.getPlatFrom()
          ? WebTopBarWidget()
          : AppBar(
              leading: InkWell(
                onTap: () {
                  Get.back();
                },
                child: Icon(
                  Icons.arrow_back,
                ),
              ),
              title: Text(
                title,
                style: Get.theme.primaryTextTheme.titleSmall
                    .copyWith(color: Colors.white),
              ),
            ),
      body: Align(
        alignment: Alignment.topCenter,
        child: SizedBox(
          width: AppConstants.WEB_MAX_WIDTH,
          // height: 285,
          child: GridView.builder(
            gridDelegate: global.getPlatFrom()
                ? SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: AppConstants.WEB_MAX_WIDTH / 7,
                    mainAxisSpacing: 15,
                    crossAxisSpacing: 15,
                    childAspectRatio: 0.75,
                  )
                : SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: global.getPlatFrom() ? 7 : 2,
                    crossAxisSpacing: global.getPlatFrom() ? 25 : 10.0,
                    mainAxisSpacing: global.getPlatFrom() ? 25 : 10.0,
                    mainAxisExtent: 260,
                  ),
            //  scrollDirection: Axis.horizontal,
            itemCount: productList.length,
            shrinkWrap: true,
            padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 10),
            itemBuilder: (context, index) {
              return InkWell(
                  onTap: () {
                    // Get.to(
                    //       () => CategoryScreen(
                    //     category: homeController.topCashbackList[index],
                    //   ),
                    //   routeName: 'category',
                    // );

                    if (global.getPlatFrom()) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => WebProductDetailsScreen(
                                    title: "LATEST PRODUCTS",
                                    product: productList[index],
                                  )));
                    } else {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProductDetailsScreen(
                                    title: '',
                                    product: productList[index],
                                  )));
                    }
                  },
                  child: Container(
                    width: global.getPlatFrom() ? 180 : 150,
                    // height: 150,
                    // margin: EdgeInsets.only(right: 10),
                    color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          padding: EdgeInsets.only(top: 15, bottom: 15),
                          child: RichText(
                            text: TextSpan(
                                text: "Price Compared ",
                                style: TextStyle(
                                    color: Colors.black54,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 10),
                                children: [
                                  TextSpan(
                                      text:
                                          '(${productList[index].productPrices.length} Sellers)',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 10,
                                          color: Colors.blueAccent.shade400)),
                                ]),
                          ),
                        ),
                        Container(
                          color: Colors.grey.shade400,
                          height: 1,
                        ),
                        Image.network(
                          "${global.appInfo.baseUrls.productImageurl}/${productList[index].image}",
                          height: 120,
                          fit: BoxFit.contain,
                        ),
                        // Padding(
                        //   padding: const EdgeInsets.only(top: 8.0, bottom: 8),
                        //   child: RichText(
                        //     text: TextSpan(
                        //         text: "Brand: ",
                        //         style: TextStyle(
                        //             color: Colors.black54,
                        //             fontWeight: FontWeight.w500,
                        //             fontSize: 10),
                        //         children: [
                        //           TextSpan(
                        //               text: '${productList[index].name} ',
                        //               style: TextStyle(
                        //                   fontWeight: FontWeight.w600,
                        //                   fontSize: 10,
                        //                   color: Colors.black)),
                        //         ]),
                        //   ),
                        // ),
                        Container(
                          color: Colors.grey.shade400,
                          height: 1,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0, bottom: 8),
                          child: Text(
                            "${productList[index].name} ",
                            style: TextStyle(
                                color: Colors.black54,
                                fontWeight: FontWeight.w500,
                                fontSize: 10),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: Mycolors.lightOrage,
                              border: Border.all(color: Mycolors.orange)),
                          padding:
                              EdgeInsets.symmetric(horizontal: 13, vertical: 3),
                          child: Text(
                            "+ ₹ ${productList[index].productPrices[0].cashback}  REWARDS",
                            style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: Mycolors.orange),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0, bottom: 8),
                          child: Text(
                            "Final Price ₹ ${productList[index].productPrices[0].price}",
                            style: TextStyle(
                                color: Mycolors.blue,
                                fontWeight: FontWeight.w600,
                                fontSize: 12),
                          ),
                        ),
                      ],
                    ),
                  ));
            },
          ),
        ),
      ),
    );
  }
}
