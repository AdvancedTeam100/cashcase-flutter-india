// ignore_for_file: must_be_immutable

import 'package:cashfuse/constants/appConstant.dart';
import 'package:cashfuse/controllers/homeController.dart';
import 'package:cashfuse/models/clickModel.dart';
import 'package:cashfuse/utils/images.dart';
import 'package:cashfuse/views/bottomNavigationBarScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:cashfuse/utils/global.dart' as global;

class RecentClickDialogWidget extends StatelessWidget {
  final ClickModel click;
  RecentClickDialogWidget({this.click});

  HomeController homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: global.getPlatFrom() ? 500 : 460,
      width: global.getPlatFrom() ? AppConstants.WEB_MAX_WIDTH / 3 : Get.width,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          InkWell(
            onTap: () {
              Get.back();
            },
            child: Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  Icons.close,
                  color: Colors.grey,
                  size: 20,
                ),
              ),
            ),
          ),
          Image.asset(
            Images.imoji,
            fit: BoxFit.contain,
            height: 100,
          ),
          Text(
            'All is well!',
            style: Get.theme.primaryTextTheme.titleLarge,
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text(
              homeController.clickDialogText(click),
              textAlign: TextAlign.center,
            ),
          ),
          InkWell(
            onTap: () async {
              Get.back();
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => BottomNavigationBarScreen(
                    pageIndex: 0,
                  ),
                ),
              );
            },
            child: Container(
              width: global.getPlatFrom() ? Get.width / 5 : Get.width / 2,
              height: 45,
              margin: EdgeInsets.only(top: 10, bottom: 10),
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
          Expanded(child: SizedBox()),
          ClipRRect(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10),
            ),
            child: Image.asset(
              Images.curve,
              fit: BoxFit.fill,
            ),
          ),
        ],
      ),
    );
  }
}
