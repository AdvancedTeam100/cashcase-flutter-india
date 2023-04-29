// ignore_for_file: must_be_immutable

import 'package:cashfuse/constants/appConstant.dart';
import 'package:cashfuse/controllers/orderController.dart';
import 'package:cashfuse/models/orderModel.dart';
import 'package:cashfuse/views/addComplaintSceen.dart';
import 'package:cashfuse/views/faqSceen.dart';
import 'package:cashfuse/widget/drawerWidget.dart';
import 'package:cashfuse/widget/web/webTopBarWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:cashfuse/utils/global.dart' as global;

class OrderComplaintScreen extends StatelessWidget {
  bool isSHow = false;
  OrderModel orderModel;

  OrderComplaintScreen({this.orderModel});

  OrderController orderController = Get.find<OrderController>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrderController>(builder: (controller) {
      return SafeArea(
        child: Scaffold(
          key: scaffoldKey,
          drawer: global.getPlatFrom() ? DrawerWidget() : null,
          appBar: global.getPlatFrom()
              ? WebTopBarWidget(
                  scaffoldKey: scaffoldKey,
                )
              : AppBar(
                  leading: InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                  ),
                  title: Text(
                    AppLocalizations.of(context).order_complaints,
                    style: Get.theme.primaryTextTheme.titleSmall.copyWith(color: Colors.white),
                  ),
                ),
          backgroundColor: Colors.grey[200],
          floatingActionButton: FloatingActionButton(
            backgroundColor: Get.theme.primaryColor,
            child: Icon(FontAwesomeIcons.commentDots),
            onPressed: () {
              Get.to(
                () => FaqScreen(),
                routeName: 'faq',
              );
            },
          ),
          body: orderController.complainList != null && orderController.complainList.length > 0
              ? global.getPlatFrom()
                  ? Align(
                      alignment: Alignment.topCenter,
                      child: SizedBox(
                        width: AppConstants.WEB_MAX_WIDTH,
                        child: Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            Column(
                              children: [
                                Expanded(
                                  child: Container(
                                    width: AppConstants.WEB_MAX_WIDTH,
                                    color: Colors.white,
                                    child: GridView.builder(
                                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 3,
                                          crossAxisSpacing: 15.0,
                                          mainAxisSpacing: 15.0,
                                          childAspectRatio: 5,
                                        ),
                                        itemCount: orderController.complainList.length,
                                        shrinkWrap: true,
                                        padding: EdgeInsets.all(10).copyWith(top: 20),
                                        itemBuilder: (context, index) {
                                          return InkWell(
                                            child: Card(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets.all(8),
                                                    child: RichText(
                                                      text: TextSpan(
                                                        text: "${AppLocalizations.of(context).complaint} : ",
                                                        style: Get.theme.primaryTextTheme.titleSmall.copyWith(
                                                          letterSpacing: -0.2,
                                                          fontWeight: FontWeight.w500,
                                                        ),
                                                        children: <TextSpan>[
                                                          TextSpan(
                                                            text: orderController.complainList[index].complain,
                                                            style: Get.theme.primaryTextTheme.titleSmall.copyWith(
                                                              letterSpacing: -0.2,
                                                              fontWeight: FontWeight.w300,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.all(8),
                                                    child: RichText(
                                                      text: TextSpan(
                                                        text: "${AppLocalizations.of(context).reply} : ",
                                                        style: Get.theme.primaryTextTheme.titleSmall.copyWith(
                                                          letterSpacing: -0.2,
                                                          fontWeight: FontWeight.w500,
                                                        ),
                                                        children: <TextSpan>[
                                                          TextSpan(
                                                            text: orderController.complainList[index].reply.isNotEmpty ? orderController.complainList[index].reply : 'Waiting for reply....',
                                                            style: Get.theme.primaryTextTheme.titleSmall.copyWith(
                                                              letterSpacing: -0.2,
                                                              fontWeight: FontWeight.w300,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        }),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      if (global.getPlatFrom()) {
                                        Get.dialog(Dialog(
                                          child: SizedBox(
                                            width: 500,
                                            height: 500,
                                            child: AddComplaintSceen(
                                              orderModel: orderModel,
                                            ),
                                          ),
                                        ));
                                      } else {
                                        Get.to(
                                          () => AddComplaintSceen(
                                            orderModel: orderModel,
                                          ),
                                          routeName: 'add-complaint',
                                        );
                                      }
                                    },
                                    child: CircleAvatar(
                                      radius: 30,
                                      backgroundColor: Get.theme.secondaryHeaderColor,
                                      child: orderController.complainList != null && orderController.complainList.length > 0
                                          ? InkWell(
                                              onTap: () {
                                                if (global.getPlatFrom()) {
                                                  Get.dialog(Dialog(
                                                    child: SizedBox(
                                                      width: 500,
                                                      height: 500,
                                                      child: AddComplaintSceen(
                                                        orderModel: orderModel,
                                                      ),
                                                    ),
                                                  ));
                                                } else {
                                                  Get.to(
                                                    () => AddComplaintSceen(
                                                      orderModel: orderModel,
                                                    ),
                                                    routeName: 'add-complaint',
                                                  );
                                                }
                                              },
                                              child: Icon(
                                                Icons.add,
                                                color: Colors.white,
                                                size: 20,
                                              ))
                                          : SizedBox(),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    AppLocalizations.of(context).add_complaint,
                                    style: Get.theme.primaryTextTheme.titleSmall.copyWith(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  : ListView.builder(
                      padding: EdgeInsets.all(10),
                      shrinkWrap: true,
                      itemCount: orderController.complainList.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          child: Card(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: RichText(
                                    text: TextSpan(
                                      text: "${AppLocalizations.of(context).complaint} : ",
                                      style: Get.theme.primaryTextTheme.titleSmall.copyWith(
                                        letterSpacing: -0.2,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: orderController.complainList[index].complain,
                                          style: Get.theme.primaryTextTheme.titleSmall.copyWith(
                                            letterSpacing: -0.2,
                                            fontWeight: FontWeight.w300,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: RichText(
                                    text: TextSpan(
                                      text: "${AppLocalizations.of(context).reply} : ",
                                      style: Get.theme.primaryTextTheme.titleSmall.copyWith(
                                        letterSpacing: -0.2,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: orderController.complainList[index].reply.isNotEmpty ? orderController.complainList[index].reply : 'Waiting for reply....',
                                          style: Get.theme.primaryTextTheme.titleSmall.copyWith(
                                            letterSpacing: -0.2,
                                            fontWeight: FontWeight.w300,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    )
              : Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 70,
                        backgroundColor: Get.theme.secondaryHeaderColor,
                        child: Icon(
                          Icons.question_mark_outlined,
                          color: Get.theme.primaryColor,
                          size: 70,
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Text(
                        AppLocalizations.of(context).add_complaint_title,
                        style: Get.theme.primaryTextTheme.bodyLarge.copyWith(fontWeight: FontWeight.w300),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Text(
                        AppLocalizations.of(context).add_complaint_subtitle,
                        style: Get.theme.primaryTextTheme.bodySmall,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      InkWell(
                        onTap: () {
                          if (global.getPlatFrom()) {
                            Get.dialog(Dialog(
                              child: SizedBox(
                                width: 500,
                                height: 500,
                                child: AddComplaintSceen(
                                  orderModel: orderModel,
                                ),
                              ),
                            ));
                          } else {
                            Get.to(
                              () => AddComplaintSceen(
                                orderModel: orderModel,
                              ),
                              routeName: 'add-complaint',
                            );
                          }
                        },
                        child: Container(
                          height: 40,
                          width: Get.width / 2,
                          color: Get.theme.secondaryHeaderColor,
                          alignment: Alignment.center,
                          child: Text(
                            AppLocalizations.of(context).add_complaint,
                            style: Get.theme.primaryTextTheme.titleSmall.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
          bottomNavigationBar: !global.getPlatFrom() && orderController.complainList != null && orderController.complainList.length > 0
              ? InkWell(
                  onTap: () {
                    if (global.getPlatFrom()) {
                      Get.dialog(Dialog(
                        child: SizedBox(
                          width: 500,
                          height: 500,
                          child: AddComplaintSceen(
                            orderModel: orderModel,
                          ),
                        ),
                      ));
                    } else {
                      Get.to(
                        () => AddComplaintSceen(
                          orderModel: orderModel,
                        ),
                        routeName: 'add-complaint',
                      );
                    }
                  },
                  child: Container(
                    height: 50,
                    width: Get.width / 2,
                    color: Get.theme.secondaryHeaderColor,
                    alignment: Alignment.center,
                    child: Text(
                      AppLocalizations.of(context).add_complaint,
                      style: Get.theme.primaryTextTheme.titleSmall.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                )
              : SizedBox(),
        ),
      );
    });
  }
}
