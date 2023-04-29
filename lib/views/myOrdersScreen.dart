// ignore_for_file: must_be_immutable

import 'package:cashfuse/constants/appConstant.dart';
import 'package:cashfuse/controllers/orderController.dart';
import 'package:cashfuse/utils/date_converter.dart';
import 'package:cashfuse/utils/global.dart' as global;
import 'package:cashfuse/utils/images.dart';
import 'package:cashfuse/views/bottomNavigationBarScreen.dart';
import 'package:cashfuse/views/orderComplaintScreen.dart';
import 'package:cashfuse/widget/customImage.dart';
import 'package:cashfuse/widget/drawerWidget.dart';
import 'package:cashfuse/widget/web/webTopBarWidget.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class MyOrdersScreen extends StatelessWidget {
  OrderController orderController = Get.find<OrderController>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      drawer: global.getPlatFrom() ? DrawerWidget() : null,
      appBar: global.getPlatFrom()
          ? WebTopBarWidget(
              scaffoldKey: scaffoldKey,
            )
          : AppBar(
              elevation: 0,
              leading: InkWell(
                onTap: () {
                  Get.back();
                },
                child: Icon(
                  Icons.arrow_back,
                ),
              ),
              title: Text(
                AppLocalizations.of(context).my_orders,
                style: Get.theme.primaryTextTheme.titleSmall.copyWith(color: Colors.white),
              ),
            ),
      body: Align(
        alignment: Alignment.topCenter,
        child: SizedBox(
          width: AppConstants.WEB_MAX_WIDTH,
          child: GetBuilder<OrderController>(builder: (controller) {
            return orderController.isDataLoaded
                ? orderController.orderList != null && orderController.orderList.length > 0
                    ? global.getPlatFrom()
                        ? Column(
                            children: [
                              Expanded(
                                child: Container(
                                  color: Colors.white,
                                  child: GridView.builder(
                                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 3,
                                        crossAxisSpacing: 15.0,
                                        mainAxisSpacing: 15.0,
                                        childAspectRatio: 1.45,
                                      ),
                                      itemCount: global.currentUser.withdrawalRequest.length,
                                      shrinkWrap: true,
                                      padding: EdgeInsets.all(10).copyWith(top: 20),
                                      itemBuilder: (context, index) {
                                        return Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(5),
                                            border: Border.all(
                                              color: Get.theme.secondaryHeaderColor.withOpacity(0.2),
                                            ),
                                          ),
                                          padding: const EdgeInsets.all(8),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Card(
                                                margin: EdgeInsets.symmetric(horizontal: 10),
                                                child: Padding(
                                                  padding: const EdgeInsets.all(10.0),
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      ListTile(
                                                        contentPadding: EdgeInsets.zero,
                                                        leading:
                                                            // Container(
                                                            //   width: 50,
                                                            //   decoration: BoxDecoration(
                                                            //     shape: BoxShape.circle,
                                                            //     color: Colors.white,
                                                            //     border: Border.all(
                                                            //       color: Colors.grey[400],
                                                            //     ),
                                                            //   ),
                                                            //   padding: EdgeInsets.all(2),
                                                            //   child:
                                                            CustomImage(
                                                          image: global.appInfo.baseUrls.partnerImageUrl + '/' + orderController.orderList[index].logo,
                                                          fit: BoxFit.contain,
                                                          errorImage: Images.logo,
                                                          width: 50,
                                                        ),
                                                        //),
                                                        title: Text(orderController.orderList[index].advertisers),
                                                        trailing: InkWell(
                                                          onTap: () async {
                                                            await orderController.getOrderComplains(orderController.orderList[index].id);
                                                            Get.to(
                                                              () => OrderComplaintScreen(
                                                                orderModel: orderController.orderList[index],
                                                              ),
                                                              routeName: 'order-complaint',
                                                            );
                                                          },
                                                          child: Container(
                                                            padding: EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                                                            decoration: BoxDecoration(
                                                              color: Colors.white,
                                                              borderRadius: BorderRadius.circular(3),
                                                              border: Border.all(
                                                                color: Get.theme.primaryColor,
                                                              ),
                                                            ),
                                                            child: Text(
                                                              AppLocalizations.of(context).raise_complaint,
                                                              style: TextStyle(
                                                                fontSize: 10,
                                                                color: Get.theme.primaryColor,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Divider(),
                                                      Padding(
                                                        padding: const EdgeInsets.only(top: 10),
                                                        child: Row(
                                                          children: [
                                                            Container(
                                                              padding: EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                                                              decoration: BoxDecoration(
                                                                color: orderController.orderList[index].orderStatus == 0.toString()
                                                                    ? Get.theme.primaryColor.withOpacity(0.2)
                                                                    : orderController.orderList[index].orderStatus == 1.toString()
                                                                        ? Colors.green.withOpacity(0.2)
                                                                        : Colors.red.withOpacity(0.2),
                                                                borderRadius: BorderRadius.circular(15),
                                                              ),
                                                              child: Row(
                                                                children: [
                                                                  Icon(
                                                                    Icons.check_circle,
                                                                    color: orderController.orderList[index].orderStatus == 0.toString()
                                                                        ? Get.theme.primaryColor
                                                                        : orderController.orderList[index].orderStatus == 1.toString()
                                                                            ? Colors.green
                                                                            : Colors.red,
                                                                    size: 20,
                                                                  ),
                                                                  Text(
                                                                    orderController.orderList[index].orderStatus == 0.toString()
                                                                        ? 'Purchase Tracked'
                                                                        : orderController.orderList[index].orderStatus == 1.toString()
                                                                            ? 'Cashback Received'
                                                                            : 'Cashback Reject',
                                                                    style: TextStyle(
                                                                      fontSize: 10,
                                                                      color: orderController.orderList[index].orderStatus == 0.toString()
                                                                          ? Get.theme.primaryColor
                                                                          : orderController.orderList[index].orderStatus == 1.toString()
                                                                              ? Colors.green
                                                                              : Colors.red,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            // orderController.orderList[index].url.isNotEmpty
                                                            //     ? InkWell(
                                                            //         onTap: () {
                                                            //           Get.to(() => WebViewScreen(
                                                            //                 brandName: orderController.orderList[index].advertisers,
                                                            //                 urlString: orderController.orderList[index].url,
                                                            //               ));
                                                            //         },
                                                            //         child: Container(
                                                            //           margin: EdgeInsets.only(left: 10),
                                                            //           padding: EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                                                            //           decoration: BoxDecoration(
                                                            //             color: Colors.grey[200],
                                                            //             borderRadius: BorderRadius.circular(15),
                                                            //           ),
                                                            //           child: Row(
                                                            //             children: [
                                                            //               Icon(
                                                            //                 Icons.local_offer,
                                                            //                 textDirection: TextDirection.rtl,
                                                            //                 color: Colors.black54,
                                                            //                 size: 20,
                                                            //               ),
                                                            //               Text(
                                                            //                 AppLocalizations.of(context).shopping,
                                                            //                 style: TextStyle(
                                                            //                   fontSize: 10,
                                                            //                   color: Colors.black54,
                                                            //                 ),
                                                            //               ),
                                                            //             ],
                                                            //           ),
                                                            //         ),
                                                            //       )
                                                            //     : SizedBox(),
                                                          ],
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                color: Colors.white,
                                                margin: EdgeInsets.symmetric(horizontal: 15),
                                                padding: EdgeInsets.all(10).copyWith(top: 20),
                                                child: Column(
                                                  mainAxisSize: MainAxisSize.min,
                                                  // mainAxisAlignment: MainAxisAlignment.start,
                                                  // crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Icon(
                                                          Icons.check_circle,
                                                          size: 20,
                                                          color:
                                                              orderController.orderList[index].orderStatus == 0.toString() || orderController.orderList[index].orderStatus == 1.toString() || orderController.orderList[index].orderStatus == 2.toString() ? Get.theme.secondaryHeaderColor : Colors.grey,
                                                        ),
                                                        Padding(
                                                          padding: const EdgeInsets.only(left: 10),
                                                          child: Text(
                                                            'Clicked Tracked',
                                                            style: TextStyle(
                                                              fontWeight: FontWeight.w500,
                                                              fontSize: 12,
                                                              color: orderController.orderList[index].orderStatus == 0.toString() || orderController.orderList[index].orderStatus == 1.toString() || orderController.orderList[index].orderStatus == 2.toString() ? Colors.black : Colors.grey,
                                                            ),
                                                          ),
                                                        ),
                                                        Expanded(child: SizedBox()),
                                                        orderController.orderList[index].orderStatus == 0.toString() || orderController.orderList[index].orderStatus == 1.toString() || orderController.orderList[index].orderStatus == 2.toString()
                                                            ? Text(
                                                                DateConverter.dateTimeStringToDateTime(
                                                                  orderController.orderList[index].createdAt.toString(),
                                                                ).toString(),
                                                                style: TextStyle(fontSize: 10, color: Colors.grey),
                                                              )
                                                            : SizedBox(),
                                                      ],
                                                    ),
                                                    Stack(
                                                      alignment: Alignment.centerLeft,
                                                      children: [
                                                        Padding(
                                                          padding: const EdgeInsets.only(left: 10),
                                                          child: DottedLine(
                                                            lineLength: 125,
                                                            direction: Axis.vertical,
                                                            dashColor: Colors.grey,
                                                          ),
                                                        ),
                                                        Row(
                                                          children: [
                                                            Card(
                                                              margin: EdgeInsets.zero,
                                                              elevation: 0,
                                                              shape: RoundedRectangleBorder(
                                                                borderRadius: BorderRadius.circular(10),
                                                              ),
                                                              child: Icon(
                                                                Icons.check_circle,
                                                                size: 20,
                                                                color: orderController.orderList[index].orderStatus == 0.toString() || orderController.orderList[index].orderStatus == 1.toString() || orderController.orderList[index].orderStatus == 2.toString() ? Get.theme.primaryColor : Colors.grey,
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding: const EdgeInsets.only(left: 10),
                                                              child: Text(
                                                                'Purchase Tracked',
                                                                style: TextStyle(
                                                                  fontWeight: FontWeight.w500,
                                                                  fontSize: 12,
                                                                  color: orderController.orderList[index].orderStatus == 0.toString() || orderController.orderList[index].orderStatus == 1.toString() || orderController.orderList[index].orderStatus == 2.toString() ? Colors.black : Colors.grey,
                                                                ),
                                                              ),
                                                            ),
                                                            Expanded(child: SizedBox()),
                                                            orderController.orderList[index].orderStatus == 0.toString() || orderController.orderList[index].orderStatus == 1.toString() || orderController.orderList[index].orderStatus == 2.toString()
                                                                ? Text(
                                                                    DateConverter.dateTimeStringToDateTime(
                                                                      orderController.orderList[index].createdAt.toString(),
                                                                    ).toString(),
                                                                    style: TextStyle(fontSize: 10, color: Colors.grey),
                                                                  )
                                                                : SizedBox(),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        orderController.orderList[index].orderStatus == 2.toString()
                                                            ? Padding(
                                                                padding: const EdgeInsets.only(left: 2),
                                                                child: CircleAvatar(
                                                                  radius: 9,
                                                                  child: Icon(
                                                                    Icons.close,
                                                                    color: Colors.white,
                                                                    size: 14,
                                                                  ),
                                                                  backgroundColor: Colors.red,
                                                                ),
                                                              )
                                                            : Icon(
                                                                Icons.check_circle,
                                                                size: 20,
                                                                color: orderController.orderList[index].orderStatus == 1.toString() ? Colors.green : Colors.grey,
                                                              ),
                                                        Padding(
                                                          padding: const EdgeInsets.only(left: 10),
                                                          child: Text(
                                                            orderController.orderList[index].orderStatus == 2.toString() ? 'Cashback Rejected' : 'Cashback Received',
                                                            style: TextStyle(
                                                              fontWeight: FontWeight.w500,
                                                              fontSize: 12,
                                                              color: orderController.orderList[index].orderStatus == 1.toString() ? Colors.black : Colors.grey,
                                                            ),
                                                          ),
                                                        ),
                                                        Expanded(child: SizedBox()),
                                                        orderController.orderList[index].orderStatus == 1.toString()
                                                            ? Text(
                                                                DateConverter.dateTimeStringToDateTime(
                                                                  orderController.orderList[index].updatedAt.toString(),
                                                                ).toString(),
                                                                style: TextStyle(fontSize: 10, color: Colors.grey),
                                                              )
                                                            : SizedBox(),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      }),
                                ),
                              ),
                            ],
                          )
                        : ListView.builder(
                            shrinkWrap: true,
                            itemCount: orderController.orderList.length,
                            padding: EdgeInsets.symmetric(vertical: 10),
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Card(
                                      margin: EdgeInsets.symmetric(horizontal: 10),
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            ListTile(
                                              contentPadding: EdgeInsets.zero,
                                              leading:
                                                  // Container(
                                                  //   width: 50,
                                                  //   decoration: BoxDecoration(
                                                  //     shape: BoxShape.circle,
                                                  //     color: Colors.white,
                                                  //     border: Border.all(
                                                  //       color: Colors.grey[400],
                                                  //     ),
                                                  //   ),
                                                  //   padding: EdgeInsets.all(2),
                                                  //   child:
                                                  CustomImage(
                                                image: global.appInfo.baseUrls.partnerImageUrl + '/' + orderController.orderList[index].logo,
                                                fit: BoxFit.contain,
                                                errorImage: Images.logo,
                                                width: 50,
                                              ),
                                              //),
                                              title: Text(orderController.orderList[index].advertisers),
                                              trailing: InkWell(
                                                onTap: () async {
                                                  await orderController.getOrderComplains(orderController.orderList[index].id);
                                                  Get.to(
                                                    () => OrderComplaintScreen(
                                                      orderModel: orderController.orderList[index],
                                                    ),
                                                    routeName: 'order-complaint',
                                                  );
                                                },
                                                child: Container(
                                                  padding: EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius: BorderRadius.circular(3),
                                                    border: Border.all(
                                                      color: Get.theme.primaryColor,
                                                    ),
                                                  ),
                                                  child: Text(
                                                    AppLocalizations.of(context).raise_complaint,
                                                    style: TextStyle(
                                                      fontSize: 10,
                                                      color: Get.theme.primaryColor,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Divider(),
                                            Padding(
                                              padding: const EdgeInsets.only(top: 10),
                                              child: Row(
                                                children: [
                                                  Container(
                                                    padding: EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                                                    decoration: BoxDecoration(
                                                      color: orderController.orderList[index].orderStatus == 0.toString()
                                                          ? Get.theme.primaryColor.withOpacity(0.2)
                                                          : orderController.orderList[index].orderStatus == 1.toString()
                                                              ? Colors.green.withOpacity(0.2)
                                                              : Colors.red.withOpacity(0.2),
                                                      borderRadius: BorderRadius.circular(15),
                                                    ),
                                                    child: Row(
                                                      children: [
                                                        Icon(
                                                          Icons.check_circle,
                                                          color: orderController.orderList[index].orderStatus == 0.toString()
                                                              ? Get.theme.primaryColor
                                                              : orderController.orderList[index].orderStatus == 1.toString()
                                                                  ? Colors.green
                                                                  : Colors.red,
                                                          size: 20,
                                                        ),
                                                        Text(
                                                          orderController.orderList[index].orderStatus == 0.toString()
                                                              ? 'Purchase Tracked'
                                                              : orderController.orderList[index].orderStatus == 1.toString()
                                                                  ? 'Cashback Received'
                                                                  : 'Cashback Reject',
                                                          style: TextStyle(
                                                            fontSize: 10,
                                                            color: orderController.orderList[index].orderStatus == 0.toString()
                                                                ? Get.theme.primaryColor
                                                                : orderController.orderList[index].orderStatus == 1.toString()
                                                                    ? Colors.green
                                                                    : Colors.red,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  // orderController.orderList[index].url.isNotEmpty
                                                  //     ? InkWell(
                                                  //         onTap: () {
                                                  //           Get.to(() => WebViewScreen(
                                                  //                 brandName: orderController.orderList[index].advertisers,
                                                  //                 urlString: orderController.orderList[index].url,
                                                  //               ));
                                                  //         },
                                                  //         child: Container(
                                                  //           margin: EdgeInsets.only(left: 10),
                                                  //           padding: EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                                                  //           decoration: BoxDecoration(
                                                  //             color: Colors.grey[200],
                                                  //             borderRadius: BorderRadius.circular(15),
                                                  //           ),
                                                  //           child: Row(
                                                  //             children: [
                                                  //               Icon(
                                                  //                 Icons.local_offer,
                                                  //                 textDirection: TextDirection.rtl,
                                                  //                 color: Colors.black54,
                                                  //                 size: 20,
                                                  //               ),
                                                  //               Text(
                                                  //                 AppLocalizations.of(context).shopping,
                                                  //                 style: TextStyle(
                                                  //                   fontSize: 10,
                                                  //                   color: Colors.black54,
                                                  //                 ),
                                                  //               ),
                                                  //             ],
                                                  //           ),
                                                  //         ),
                                                  //       )
                                                  //     : SizedBox(),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    Container(
                                      color: Colors.white,
                                      margin: EdgeInsets.symmetric(horizontal: 15),
                                      padding: EdgeInsets.all(10).copyWith(top: 20),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        // mainAxisAlignment: MainAxisAlignment.start,
                                        // crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.check_circle,
                                                size: 20,
                                                color: orderController.orderList[index].orderStatus == 0.toString() || orderController.orderList[index].orderStatus == 1.toString() || orderController.orderList[index].orderStatus == 2.toString() ? Get.theme.secondaryHeaderColor : Colors.grey,
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(left: 10),
                                                child: Text(
                                                  'Clicked Tracked',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 12,
                                                    color: orderController.orderList[index].orderStatus == 0.toString() || orderController.orderList[index].orderStatus == 1.toString() || orderController.orderList[index].orderStatus == 2.toString() ? Colors.black : Colors.grey,
                                                  ),
                                                ),
                                              ),
                                              Expanded(child: SizedBox()),
                                              orderController.orderList[index].orderStatus == 0.toString() || orderController.orderList[index].orderStatus == 1.toString() || orderController.orderList[index].orderStatus == 2.toString()
                                                  ? Text(
                                                      DateConverter.dateTimeStringToDateTime(
                                                        orderController.orderList[index].createdAt.toString(),
                                                      ).toString(),
                                                      style: TextStyle(fontSize: 10, color: Colors.grey),
                                                    )
                                                  : SizedBox(),
                                            ],
                                          ),
                                          Stack(
                                            alignment: Alignment.centerLeft,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(left: 10),
                                                child: DottedLine(
                                                  lineLength: 125,
                                                  direction: Axis.vertical,
                                                  dashColor: Colors.grey,
                                                ),
                                              ),
                                              Row(
                                                children: [
                                                  Card(
                                                    margin: EdgeInsets.zero,
                                                    elevation: 0,
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(10),
                                                    ),
                                                    child: Icon(
                                                      Icons.check_circle,
                                                      size: 20,
                                                      color: orderController.orderList[index].orderStatus == 0.toString() || orderController.orderList[index].orderStatus == 1.toString() || orderController.orderList[index].orderStatus == 2.toString() ? Get.theme.primaryColor : Colors.grey,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.only(left: 10),
                                                    child: Text(
                                                      'Purchase Tracked',
                                                      style: TextStyle(
                                                        fontWeight: FontWeight.w500,
                                                        fontSize: 12,
                                                        color: orderController.orderList[index].orderStatus == 0.toString() || orderController.orderList[index].orderStatus == 1.toString() || orderController.orderList[index].orderStatus == 2.toString() ? Colors.black : Colors.grey,
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(child: SizedBox()),
                                                  orderController.orderList[index].orderStatus == 0.toString() || orderController.orderList[index].orderStatus == 1.toString() || orderController.orderList[index].orderStatus == 2.toString()
                                                      ? Text(
                                                          DateConverter.dateTimeStringToDateTime(
                                                            orderController.orderList[index].createdAt.toString(),
                                                          ).toString(),
                                                          style: TextStyle(fontSize: 10, color: Colors.grey),
                                                        )
                                                      : SizedBox(),
                                                ],
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              orderController.orderList[index].orderStatus == 2.toString()
                                                  ? Padding(
                                                      padding: const EdgeInsets.only(left: 2),
                                                      child: CircleAvatar(
                                                        radius: 9,
                                                        child: Icon(
                                                          Icons.close,
                                                          color: Colors.white,
                                                          size: 14,
                                                        ),
                                                        backgroundColor: Colors.red,
                                                      ),
                                                    )
                                                  : Icon(
                                                      Icons.check_circle,
                                                      size: 20,
                                                      color: orderController.orderList[index].orderStatus == 1.toString() ? Colors.green : Colors.grey,
                                                    ),
                                              Padding(
                                                padding: const EdgeInsets.only(left: 10),
                                                child: Text(
                                                  orderController.orderList[index].orderStatus == 2.toString() ? 'Cashback Rejected' : 'Cashback Received',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 12,
                                                    color: orderController.orderList[index].orderStatus == 1.toString() ? Colors.black : Colors.grey,
                                                  ),
                                                ),
                                              ),
                                              Expanded(child: SizedBox()),
                                              orderController.orderList[index].orderStatus == 1.toString()
                                                  ? Text(
                                                      DateConverter.dateTimeStringToDateTime(
                                                        orderController.orderList[index].updatedAt.toString(),
                                                      ).toString(),
                                                      style: TextStyle(fontSize: 10, color: Colors.grey),
                                                    )
                                                  : SizedBox(),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            })
                    : Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              Images.Click_image,
                              height: 150,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Text(
                                AppLocalizations.of(context).orders_title,
                                style: Get.theme.primaryTextTheme.titleMedium.copyWith(fontWeight: FontWeight.w500),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                              child: Text(
                                "Once you shop via ${global.appName}, your order details will appear here within 72 hours.",
                                textAlign: TextAlign.center,
                                //style: Get.theme.primaryTextTheme.titleSmall.copyWith(fontWeight: FontWeight.w500),
                              ),
                            ),
                            InkWell(
                              onTap: () async {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => BottomNavigationBarScreen(
                                      pageIndex: 0,
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                height: 45,
                                width: Get.width / 2.5,
                                //margin: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                                padding: EdgeInsets.symmetric(horizontal: 7, vertical: 8),
                                decoration: BoxDecoration(
                                  color: Get.theme.secondaryHeaderColor,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  AppLocalizations.of(context).see_best_deals,
                                  style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                : ListView.builder(
                    shrinkWrap: true,
                    itemCount: 3,
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Shimmer(
                          duration: Duration(seconds: 2),
                          child: Column(
                            children: [
                              Container(
                                height: 100,
                                decoration: BoxDecoration(
                                  color: Colors.grey[300],
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                              Container(
                                height: 150,
                                color: Colors.grey[300],
                                margin: EdgeInsets.symmetric(horizontal: 15),
                                padding: EdgeInsets.all(10).copyWith(top: 20),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  );
          }),
        ),
      ),
    );
  }
}
