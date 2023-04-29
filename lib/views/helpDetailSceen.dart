import 'package:cashfuse/constants/appConstant.dart';
import 'package:cashfuse/controllers/commonController.dart';
import 'package:cashfuse/models/faqModel.dart';
import 'package:cashfuse/widget/web/webTopBarWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:get/get.dart';
import 'package:cashfuse/utils/global.dart' as global;

class HelpDetailSceen extends StatelessWidget {
  final FaqModel faq;
  HelpDetailSceen({this.faq});

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
                faq.ques,
                style: Get.theme.primaryTextTheme.titleSmall.copyWith(color: Colors.white),
              ),
            ),
      body: GetBuilder<CommonController>(builder: (controller) {
        return Center(
          child: Container(
            width: global.getPlatFrom() ? AppConstants.WEB_MAX_WIDTH / 3 : AppConstants.WEB_MAX_WIDTH,
            color: Colors.white,
            height: Get.height,
            margin: global.getPlatFrom() ? EdgeInsets.zero : EdgeInsets.all(10).copyWith(bottom: 0),
            child: SingleChildScrollView(
              child: HtmlWidget(
                faq.ans,
                textStyle: global.getPlatFrom() ? Get.theme.primaryTextTheme.titleSmall : null,
              ),
            ),
          ),
        );
      }),
    );
  }
}
