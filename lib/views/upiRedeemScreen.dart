// ignore_for_file: must_be_immutable

import 'package:cashfuse/controllers/paymentController.dart';
import 'package:cashfuse/utils/images.dart';
import 'package:cashfuse/widget/customSnackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:cashfuse/utils/global.dart' as global;

class UpiRedeemScreen extends StatelessWidget {
  final fContactNo = new FocusNode();
  final fUpiId = new FocusNode();
  var upiId = TextEditingController();

  PaymentController paymentController = Get.find<PaymentController>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PaymentController>(builder: (controller) {
      return Scaffold(
        appBar: AppBar(
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
            AppLocalizations.of(context).upi_redeem,
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
                  //padding: EdgeInsets.symmetric(horizontal: 70, vertical: 28),
                  decoration: BoxDecoration(
                    // image: DecorationImage(
                    //   image: AssetImage(
                    //     Images.Amazon_pay,
                    //   ),
                    //   fit: BoxFit.contain,
                    //   scale: 20,
                    // ),
                    borderRadius: BorderRadius.circular(5),
                    gradient: LinearGradient(
                      colors: [
                        Colors.deepOrange,
                        Colors.yellow,
                        //Color(0xFF6285E3),
                      ],
                    ),
                  ),
                  child: Card(
                    margin: EdgeInsets.symmetric(horizontal: 90, vertical: 30),
                    semanticContainer: false,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Image.asset(
                        Images.upi,
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
                              if (paymentController.upiDetails != null) {
                                upiId.text = paymentController.upiDetails.upi;
                              }
                              Get.dialog(
                                Dialog(
                                  child: Container(
                                    height: 210,
                                    width: global.getPlatFrom() ? 400 : null,
                                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: Column(
                                      children: [
                                        Text(
                                          AppLocalizations.of(context).upi_account_add,
                                          style: Get.theme.primaryTextTheme.titleLarge.copyWith(fontWeight: FontWeight.w600),
                                        ),
                                        TextFormField(
                                          focusNode: fUpiId,
                                          controller: upiId,
                                          scrollPadding: EdgeInsets.zero,
                                          cursorColor: Get.theme.primaryColor,
                                          keyboardType: TextInputType.emailAddress,
                                          decoration: InputDecoration(
                                            contentPadding: EdgeInsets.zero,
                                            hintText: 'UPI address',
                                            labelStyle: TextStyle(
                                              color: fUpiId.hasFocus ? Get.theme.primaryColor : Colors.grey,
                                            ),
                                            focusColor: Get.theme.primaryColor,
                                            focusedBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(
                                              color: fUpiId.hasFocus ? Get.theme.primaryColor : Colors.grey,
                                            )),
                                            border: UnderlineInputBorder(
                                                borderSide: BorderSide(
                                              color: fUpiId.hasFocus ? Get.theme.primaryColor : Colors.grey,
                                            )),
                                            enabledBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(
                                              color: fUpiId.hasFocus ? Get.theme.primaryColor : Colors.grey,
                                            )),
                                          ),
                                          onTap: () {
                                            //FocusScope.of(context).unfocus(disposition: UnfocusDisposition.previouslyFocusedChild);
                                            FocusScope.of(context).requestFocus(fUpiId);
                                          },
                                        ),
                                        InkWell(
                                          onTap: () {
                                            if (upiId.text.isNotEmpty) {
                                              Get.back();
                                              paymentController.addUpiDetails(upiId.text.trim());
                                            } else {
                                              showCustomSnackBar('Please enter UPI address.');
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
                                              paymentController.upiDetails != null ? AppLocalizations.of(context).edit.toString().toUpperCase() : '${AppLocalizations.of(context).add.toString().toUpperCase()} +',
                                              style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w600),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              height: 45,
                              //margin: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                              padding: EdgeInsets.symmetric(horizontal: 7, vertical: 8),
                              decoration: BoxDecoration(
                                color: Get.theme.secondaryHeaderColor,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                paymentController.upiDetails != null ? AppLocalizations.of(context).edit.toString().toUpperCase() : '${AppLocalizations.of(context).add.toString().toUpperCase()} +',
                                style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                        ],
                      ),
                      paymentController.upiDetails != null
                          ? RichText(
                              text: TextSpan(
                                text: "${AppLocalizations.of(context).upi_address} ",
                                style: Get.theme.primaryTextTheme.titleSmall.copyWith(
                                  letterSpacing: -0.2,
                                  fontWeight: FontWeight.w500,
                                ),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: paymentController.upiDetails.upi,
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
        bottomNavigationBar: paymentController.upiDetails != null
            ? InkWell(
                onTap: () {
                  paymentController.sendWithdrawalRequest('upi');
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
