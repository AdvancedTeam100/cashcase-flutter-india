import 'package:cashfuse/constants/appConstant.dart';
import 'package:cashfuse/controllers/paymentController.dart';
import 'package:cashfuse/utils/date_converter.dart';
import 'package:cashfuse/utils/images.dart';
import 'package:cashfuse/widget/web/webTopBarWidget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:cashfuse/utils/global.dart' as global;

class PaymentHistoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: global.getPlatFrom()
          ? WebTopBarWidget()
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
                AppLocalizations.of(context).payment_history,
                style: Get.theme.primaryTextTheme.titleSmall.copyWith(color: Colors.white),
              ),
            ),
      body: Align(
        alignment: Alignment.topCenter,
        child: SizedBox(
          width: AppConstants.WEB_MAX_WIDTH,
          child: GetBuilder<PaymentController>(builder: (controller) {
            return controller.isPaymentHistoryLoaded
                ? controller.paymentHistoryList != null && controller.paymentHistoryList.length > 0
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
                                        childAspectRatio: 5,
                                      ),
                                      itemCount: controller.paymentHistoryList.length,
                                      shrinkWrap: true,
                                      padding: EdgeInsets.all(10).copyWith(top: 20),
                                      itemBuilder: (context, index) {
                                        return Card(
                                          shape: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(5),
                                            borderSide: BorderSide(
                                              color: Get.theme.secondaryHeaderColor.withOpacity(0.2),
                                            ),
                                          ),
                                          child: ListTile(
                                            leading: Image.asset(
                                              controller.paymentHistoryList[index].medium == 'UPI'
                                                  ? Images.upi
                                                  : controller.paymentHistoryList[index].medium == 'Bank'
                                                      ? Images.bank
                                                      : controller.paymentHistoryList[index].medium == 'Amazon'
                                                          ? Images.Amazon_pay
                                                          : controller.paymentHistoryList[index].medium == 'Paytm'
                                                              ? Images.paytm
                                                              : controller.paymentHistoryList[index].medium == 'Paypal'
                                                                  ? Images.paypal
                                                                  : Images.logo,
                                              height: 40,
                                              width: 40,
                                            ),
                                            title: Row(
                                              children: [
                                                Text(
                                                  controller.paymentHistoryList[index].amount.toString(),
                                                ),
                                              ],
                                            ),
                                            subtitle: Text(
                                              DateConverter.formatDate(
                                                controller.paymentHistoryList[index].createdAt,
                                              ),
                                            ),
                                            trailing: Container(
                                              width: 80,
                                              height: 40,
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                color: controller.paymentHistoryList[index].approved == 1
                                                    ? Colors.green
                                                    : controller.paymentHistoryList[index].approved == 2
                                                        ? Colors.red
                                                        : Colors.orange,
                                              ),
                                              child: Text(
                                                controller.paymentHistoryList[index].approved == 1
                                                    ? 'Approved'
                                                    : controller.paymentHistoryList[index].approved == 2
                                                        ? 'Rejected'
                                                        : controller.paymentHistoryList[index].approved == 0
                                                            ? 'Pending'
                                                            : '',
                                                style: Get.theme.primaryTextTheme.titleSmall.copyWith(color: Colors.white),
                                              ),
                                            ),
                                          ),
                                        );
                                      }),
                                ),
                              ),
                            ],
                          )
                        : ListView.builder(
                            itemCount: controller.paymentHistoryList.length,
                            shrinkWrap: true,
                            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                            itemBuilder: (context, index) {
                              return Card(
                                child: ListTile(
                                  leading: Image.asset(
                                    controller.paymentHistoryList[index].medium == 'UPI'
                                        ? Images.upi
                                        : controller.paymentHistoryList[index].medium == 'Bank'
                                            ? Images.bank
                                            : controller.paymentHistoryList[index].medium == 'Amazon'
                                                ? Images.Amazon_pay
                                                : controller.paymentHistoryList[index].medium == 'Paytm'
                                                    ? Images.paytm
                                                    : controller.paymentHistoryList[index].medium == 'Paypal'
                                                        ? Images.paypal
                                                        : Images.logo,
                                    height: 40,
                                    width: 40,
                                  ),
                                  title: Row(
                                    children: [
                                      Text(
                                        global.appInfo.currency + controller.paymentHistoryList[index].amount.toString(),
                                      ),
                                    ],
                                  ),
                                  subtitle: Text(
                                    DateConverter.formatDate(
                                      controller.paymentHistoryList[index].createdAt,
                                    ),
                                    style: Get.theme.primaryTextTheme.bodySmall,
                                  ),
                                  trailing: Container(
                                    width: 80,
                                    height: 40,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: controller.paymentHistoryList[index].approved == 1
                                          ? Colors.green
                                          : controller.paymentHistoryList[index].approved == 2
                                              ? Colors.red
                                              : Colors.orange,
                                    ),
                                    child: Text(
                                      controller.paymentHistoryList[index].approved == 1
                                          ? 'Approved'
                                          : controller.paymentHistoryList[index].approved == 2
                                              ? 'Rejected'
                                              : controller.paymentHistoryList[index].approved == 0
                                                  ? 'Pending'
                                                  : '',
                                      style: Get.theme.primaryTextTheme.titleSmall.copyWith(color: Colors.white),
                                    ),
                                  ),
                                ),
                              );
                            },
                          )
                    : Center(
                        child: Text(
                        AppLocalizations.of(context).no_data_found,
                      ))
                : Center(
                    child: CircularProgressIndicator(),
                  );
          }),
        ),
      ),
    );
  }
}
