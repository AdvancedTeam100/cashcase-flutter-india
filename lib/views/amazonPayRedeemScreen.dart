// ignore_for_file: must_be_immutable

import 'package:cashfuse/controllers/paymentController.dart';
import 'package:cashfuse/utils/images.dart';
import 'package:cashfuse/widget/customSnackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:cashfuse/utils/global.dart' as global;

class AmazonPayRedeemScreen extends StatelessWidget {
  final fContactNo = new FocusNode();
  var contactNo = TextEditingController();

  PaymentController paymentController = Get.find<PaymentController>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PaymentController>(builder: (controller) {
      return Scaffold(
        appBar: global.getPlatFrom()
            ? null
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
                  AppLocalizations.of(context).amazon_pay_redeem,
                  style: Get.theme.primaryTextTheme.titleSmall.copyWith(color: Colors.white),
                ),
              ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                Container(
                  height: 120,
                  width: Get.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    gradient: LinearGradient(
                      colors: [
                        Colors.green[800],
                        Colors.green[800],
                        Colors.green.withOpacity(0.85),
                      ],
                    ),
                  ),
                  child: Card(
                    margin: EdgeInsets.symmetric(horizontal: 90, vertical: 30),
                    semanticContainer: false,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Image.asset(
                        Images.Amazon_pay,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            AppLocalizations.of(context).account_details,
                            style: Get.theme.primaryTextTheme.titleMedium.copyWith(fontWeight: FontWeight.w600),
                          ),
                          InkWell(
                            onTap: () {
                              if (paymentController.amazonDetails != null) {
                                contactNo.text = paymentController.amazonDetails.amazonNo;
                              }

                              Get.dialog(
                                Dialog(
                                  child: StatefulBuilder(
                                    builder: (BuildContext context, StateSetter setState) => Container(
                                      width: global.getPlatFrom() ? 400 : null,
                                      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            AppLocalizations.of(context).add_amazon_account,
                                            style: Get.theme.primaryTextTheme.titleLarge.copyWith(fontWeight: FontWeight.w600),
                                          ),
                                          TextFormField(
                                            controller: contactNo,
                                            focusNode: fContactNo,
                                            scrollPadding: EdgeInsets.zero,
                                            cursorColor: Get.theme.primaryColor,
                                            keyboardType: TextInputType.number,
                                            inputFormatters: [
                                              FilteringTextInputFormatter.digitsOnly,
                                              LengthLimitingTextInputFormatter(10),
                                            ],
                                            decoration: InputDecoration(
                                              contentPadding: EdgeInsets.zero,
                                              hintText: 'Mobile Number',
                                              labelStyle: TextStyle(
                                                color: fContactNo.hasFocus ? Get.theme.primaryColor : Colors.grey,
                                              ),
                                              focusColor: Get.theme.primaryColor,
                                              focusedBorder: UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                color: fContactNo.hasFocus ? Get.theme.primaryColor : Colors.grey,
                                              )),
                                              border: UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                color: fContactNo.hasFocus ? Get.theme.primaryColor : Colors.grey,
                                              )),
                                              enabledBorder: UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                color: fContactNo.hasFocus ? Get.theme.primaryColor : Colors.grey,
                                              )),
                                            ),
                                            onTap: () {
                                              FocusScope.of(context).requestFocus(fContactNo);
                                              setState(() {});
                                            },
                                          ),
                                          InkWell(
                                            onTap: () {
                                              if (contactNo.text.isNotEmpty) {
                                                Get.back();
                                                paymentController.addAmazonPayDetails(contactNo.text.trim());
                                              } else {
                                                showCustomSnackBar('Please add Number.');
                                              }
                                            },
                                            child: Container(
                                              height: 45,
                                              width: Get.width / 3,
                                              margin: EdgeInsets.only(top: 30),
                                              padding: EdgeInsets.symmetric(horizontal: 7, vertical: 8),
                                              decoration: BoxDecoration(
                                                color: Get.theme.secondaryHeaderColor,
                                                borderRadius: BorderRadius.circular(5),
                                              ),
                                              alignment: Alignment.center,
                                              child: Text(
                                                paymentController.amazonDetails != null ? AppLocalizations.of(context).edit.toString().toUpperCase() : '${AppLocalizations.of(context).add.toString().toUpperCase()} +',
                                                style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w600),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              height: 45,
                              padding: EdgeInsets.symmetric(horizontal: 7, vertical: 8),
                              decoration: BoxDecoration(
                                color: Get.theme.secondaryHeaderColor,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                paymentController.amazonDetails != null ? AppLocalizations.of(context).edit.toString().toUpperCase() : '${AppLocalizations.of(context).add.toString().toUpperCase()} +',
                                style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                        ],
                      ),
                      paymentController.amazonDetails != null
                          ? RichText(
                              text: TextSpan(
                                text: AppLocalizations.of(context).phone_no,
                                style: Get.theme.primaryTextTheme.titleSmall.copyWith(
                                  letterSpacing: -0.2,
                                  fontWeight: FontWeight.w500,
                                ),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: paymentController.amazonDetails.amazonNo,
                                    style: Get.theme.primaryTextTheme.bodySmall.copyWith(
                                      letterSpacing: -0.2,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : SizedBox(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: paymentController.amazonDetails != null
            ? InkWell(
                onTap: () {
                  paymentController.sendWithdrawalRequest('amazon');
                },
                child: Container(
                  width: Get.width,
                  height: 45,
                  margin: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  padding: EdgeInsets.symmetric(horizontal: 7, vertical: 8),
                  decoration: BoxDecoration(
                    color: Get.theme.secondaryHeaderColor,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    AppLocalizations.of(context).send_withdrawal_request,
                    style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w600),
                  ),
                ),
              )
            : SizedBox(),
      );
    });
  }
}
