import 'package:cashfuse/constants/appConstant.dart';
import 'package:cashfuse/controllers/paymentController.dart';
import 'package:cashfuse/utils/date_converter.dart';
import 'package:cashfuse/utils/images.dart';
import 'package:cashfuse/widget/drawerWidget.dart';
import 'package:cashfuse/widget/web/webTopBarWidget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cashfuse/utils/global.dart' as global;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PaymentScreen extends StatelessWidget {
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
                AppLocalizations.of(context).payments,
                style: Get.theme.primaryTextTheme.titleSmall.copyWith(color: Colors.white),
              ),
            ),
      body: Align(
        alignment: Alignment.topCenter,
        child: SizedBox(
          width: AppConstants.WEB_MAX_WIDTH,
          child: GetBuilder<PaymentController>(builder: (controller) {
            return global.currentUser.withdrawalRequest.length > 0
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
                                  itemCount: global.currentUser.withdrawalRequest.length,
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
                                          global.currentUser.withdrawalRequest[index].medium == 'UPI'
                                              ? Images.upi
                                              : global.currentUser.withdrawalRequest[index].medium == 'Bank'
                                                  ? Images.bank
                                                  : global.currentUser.withdrawalRequest[index].medium == 'Amazon'
                                                      ? Images.Amazon_pay
                                                      : global.currentUser.withdrawalRequest[index].medium == 'Paytm'
                                                          ? Images.paytm
                                                          : global.currentUser.withdrawalRequest[index].medium == 'Paypal'
                                                              ? Images.paypal
                                                              : Images.logo,
                                          height: 40,
                                          width: 40,
                                        ),
                                        title: Row(
                                          children: [
                                            Text(
                                              global.appInfo.currency + global.currentUser.withdrawalRequest[index].amount.toString(),
                                            ),
                                          ],
                                        ),
                                        subtitle: Text(
                                          DateConverter.formatDate(
                                            global.currentUser.withdrawalRequest[index].createdAt,
                                          ),
                                          style: Get.theme.primaryTextTheme.bodySmall,
                                        ),
                                        trailing: Container(
                                          width: 80,
                                          height: 40,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            color: global.currentUser.withdrawalRequest[index].approved == 1
                                                ? Colors.green
                                                : global.currentUser.withdrawalRequest[index].approved == 2
                                                    ? Colors.red
                                                    : Colors.orange,
                                          ),
                                          child: Text(
                                            global.currentUser.withdrawalRequest[index].approved == 1
                                                ? 'Approved'
                                                : global.currentUser.withdrawalRequest[index].approved == 2
                                                    ? 'Rejected'
                                                    : global.currentUser.withdrawalRequest[index].approved == 0
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
                        itemCount: global.currentUser.withdrawalRequest.length,
                        shrinkWrap: true,
                        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        itemBuilder: (context, index) {
                          return Card(
                            child: ListTile(
                              leading: Image.asset(
                                global.currentUser.withdrawalRequest[index].medium == 'UPI'
                                    ? Images.upi
                                    : global.currentUser.withdrawalRequest[index].medium == 'Bank'
                                        ? Images.bank
                                        : global.currentUser.withdrawalRequest[index].medium == 'Amazon'
                                            ? Images.Amazon_pay
                                            : global.currentUser.withdrawalRequest[index].medium == 'Paytm'
                                                ? Images.paytm
                                                : global.currentUser.withdrawalRequest[index].medium == 'Paypal'
                                                    ? Images.paypal
                                                    : Images.logo,
                                height: 40,
                                width: 40,
                              ),
                              title: Row(
                                children: [
                                  Text(
                                    global.appInfo.currency + global.currentUser.withdrawalRequest[index].amount.toString(),
                                  ),
                                ],
                              ),
                              subtitle: Text(
                                DateConverter.formatDate(
                                  global.currentUser.withdrawalRequest[index].createdAt,
                                ),
                                style: Get.theme.primaryTextTheme.bodySmall,
                              ),
                              trailing: Container(
                                width: 80,
                                height: 40,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: global.currentUser.withdrawalRequest[index].approved == 1
                                      ? Colors.green
                                      : global.currentUser.withdrawalRequest[index].approved == 2
                                          ? Colors.red
                                          : Colors.orange,
                                ),
                                child: Text(
                                  global.currentUser.withdrawalRequest[index].approved == 1
                                      ? 'Approved'
                                      : global.currentUser.withdrawalRequest[index].approved == 2
                                          ? 'Rejected'
                                          : global.currentUser.withdrawalRequest[index].approved == 0
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
                    ),
                  );
          }),
        ),
      ),
    );
  }
}
