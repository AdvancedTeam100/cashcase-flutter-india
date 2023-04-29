// ignore_for_file: must_be_immutable

import 'package:cashfuse/constants/appConstant.dart';
import 'package:cashfuse/views/helpDetailSceen.dart';
import 'package:cashfuse/widget/drawerWidget.dart';
import 'package:cashfuse/widget/web/webTopBarWidget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import '../controllers/commonController.dart';
import 'package:cashfuse/utils/global.dart' as global;

class FaqScreen extends StatelessWidget {
  CommonController commonController = Get.find<CommonController>();
  final fSeachNode = new FocusNode();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CommonController>(builder: (controller) {
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
                title: commonController.isSearch
                    ? TextFormField(
                        controller: commonController.searchString,
                        focusNode: fSeachNode,
                        textAlign: TextAlign.start,
                        textAlignVertical: TextAlignVertical.center,
                        cursorColor: Colors.white,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'What are you looking for?',
                          hintStyle: Get.theme.primaryTextTheme.bodySmall.copyWith(color: Colors.grey, fontSize: 11),
                        ),
                        onFieldSubmitted: (value) {
                          commonController.faqLocalSearch();
                        },
                      )
                    : Text(
                        AppLocalizations.of(context).faqs,
                        style: Get.theme.primaryTextTheme.titleLarge.copyWith(color: Colors.white),
                      ),
                actions: [
                  InkWell(
                    onTap: () {
                      if (commonController.isSearch) {
                        commonController.searchShow(false);
                      } else {
                        commonController.searchShow(true);
                        FocusScope.of(context).requestFocus(fSeachNode);
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(right: 10, left: 10),
                      child: Icon(
                        FontAwesomeIcons.magnifyingGlass,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
        body: Align(
          alignment: Alignment.topCenter,
          child: Column(
            children: [
              Expanded(
                child: Container(
                  color: Colors.white,
                  width: global.getPlatFrom() ? AppConstants.WEB_MAX_WIDTH / 2 : Get.width,
                  child: commonController.isfaqLoaded
                      ? commonController.faqList != null && commonController.faqList.length > 0
                          ? ListView.builder(
                              padding: EdgeInsets.only(top: 5),
                              shrinkWrap: true,
                              itemCount: commonController.faqList.length,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {
                                    Get.to(
                                      () => HelpDetailSceen(
                                        faq: commonController.faqList[index],
                                      ),
                                      routeName: 'faq',
                                    );
                                  },
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          commonController.faqList[index].ques,
                                          style: Get.theme.primaryTextTheme.bodyMedium.copyWith(color: Colors.grey[600]),
                                        ),
                                      ),
                                      Divider(
                                        color: Colors.grey,
                                        thickness: 1,
                                      ),
                                    ],
                                  ),
                                );
                              },
                            )
                          : Center(
                              child: Text(AppLocalizations.of(context).no_data_found),
                            )
                      : ListView.builder(
                          shrinkWrap: true,
                          itemCount: 10,
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                          itemBuilder: (context, index) {
                            return Shimmer(
                              duration: Duration(seconds: 2),
                              child: Container(
                                height: 65,
                                margin: EdgeInsets.only(bottom: 10),
                                decoration: BoxDecoration(
                                  color: Colors.grey[300],
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            );
                          },
                        ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
