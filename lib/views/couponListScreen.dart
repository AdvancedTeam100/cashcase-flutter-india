// ignore_for_file: must_be_immutable

import 'package:cashfuse/constants/appConstant.dart';
import 'package:cashfuse/controllers/couponController.dart';
import 'package:cashfuse/views/couponDetailScreen.dart';
import 'package:cashfuse/views/offerDetailScreen.dart';
import 'package:cashfuse/widget/couponWidget.dart';
import 'package:cashfuse/widget/web/webTopBarWidget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:cashfuse/utils/global.dart' as global;

class CouponListScreen extends StatelessWidget {
  CouponController couponController = Get.find<CouponController>();

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
                AppLocalizations.of(context).coupons_of_the_day.toUpperCase(),
                style: Get.theme.primaryTextTheme.titleSmall
                    .copyWith(color: Colors.white),
              ),
            ),
      body: Align(
        alignment: Alignment.topCenter,
        child: SizedBox(
          width: AppConstants.WEB_MAX_WIDTH,
          child: GridView.builder(
            gridDelegate: global.getPlatFrom()
                ? SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: AppConstants.WEB_MAX_WIDTH / 4,
                    childAspectRatio: 3)
                : SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1, childAspectRatio: 3),
            // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            //   crossAxisCount: global.getPlatFrom() ? 4 : 1,
            //   // crossAxisSpacing: 15.0,
            //   // mainAxisSpacing: 15.0,
            //   childAspectRatio: global.getPlatFrom() ? 3 : 3,
            // ),
            itemCount: couponController.couponList.length,
            shrinkWrap: true,
            padding: EdgeInsets.symmetric(horizontal: 0, vertical: 20),
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  if (couponController.couponList[index].offer != null) {
                    Get.to(
                      () => OfferDetailScreen(
                        offer: couponController.couponList[index].offer,
                        fromSeeMore: false,
                      ),
                      routeName: 'offer',
                      preventDuplicates: false,
                    );
                  } else {
                    Get.to(
                      () => CouponDetailScreen(
                        coupon: couponController.couponList[index],
                      ),
                      routeName: 'coupon',
                      preventDuplicates: false,
                    );
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Container(
                    alignment: Alignment.center,
                    child: CouponWidget(
                      coupon: couponController.couponList[index],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
