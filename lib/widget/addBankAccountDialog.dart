// ignore_for_file: must_be_immutable

import 'package:cashfuse/controllers/paymentController.dart';
import 'package:cashfuse/widget/customSnackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:cashfuse/utils/global.dart' as global;

class AddBankAccountDialog extends StatelessWidget {
  final fName = new FocusNode();
  final fAccountNo = new FocusNode();
  final fBankName = new FocusNode();
  final fIfscCode = new FocusNode();

  var name = new TextEditingController();
  var accountNo = new TextEditingController();
  var bankName = new TextEditingController();
  var ifscCode = new TextEditingController();

  PaymentController paymentController = Get.find<PaymentController>();

  @override
  Widget build(BuildContext context) {
    if (paymentController.bankDetails != null) {
      name.text = paymentController.bankDetails.acHolderName;
      accountNo.text = paymentController.bankDetails.acNo;
      bankName.text = paymentController.bankDetails.bankName;
      ifscCode.text = paymentController.bankDetails.ifsc;
    }
    return Container(
      height: 410,
      width: global.getPlatFrom() ? 400 : null,
      padding: EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          // SizedBox(
          //   height: 20,
          // ),
          Text(
            AppLocalizations.of(context).add_bank_account,
            style: Get.theme.primaryTextTheme.titleLarge.copyWith(fontWeight: FontWeight.w600),
          ),

          StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) => Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    focusNode: fName,
                    controller: name,
                    scrollPadding: EdgeInsets.zero,
                    cursorColor: Get.theme.primaryColor,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.zero,
                      hintText: 'Holder Name',
                      labelStyle: TextStyle(
                        color: fName.hasFocus ? Get.theme.primaryColor : Colors.grey,
                      ),
                      focusColor: Get.theme.primaryColor,
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                        color: fName.hasFocus ? Get.theme.primaryColor : Colors.grey,
                      )),
                      border: UnderlineInputBorder(
                          borderSide: BorderSide(
                        color: fName.hasFocus ? Get.theme.primaryColor : Colors.grey,
                      )),
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                        color: fName.hasFocus ? Get.theme.primaryColor : Colors.grey,
                      )),
                    ),
                    onTap: () {
                      //FocusScope.of(context).unfocus(disposition: UnfocusDisposition.previouslyFocusedChild);
                      FocusScope.of(context).requestFocus(fName);
                      setState(() {});
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: accountNo,
                    focusNode: fAccountNo,
                    scrollPadding: EdgeInsets.zero,
                    cursorColor: Get.theme.primaryColor,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.zero,
                      hintText: 'Account No.',
                      labelStyle: TextStyle(
                        color: fAccountNo.hasFocus ? Get.theme.primaryColor : Colors.grey,
                      ),
                      focusColor: Get.theme.primaryColor,
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                        color: fAccountNo.hasFocus ? Get.theme.primaryColor : Colors.grey,
                      )),
                      border: UnderlineInputBorder(
                          borderSide: BorderSide(
                        color: fAccountNo.hasFocus ? Get.theme.primaryColor : Colors.grey,
                      )),
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                        color: fAccountNo.hasFocus ? Get.theme.primaryColor : Colors.grey,
                      )),
                    ),
                    onTap: () {
                      FocusScope.of(context).requestFocus(fAccountNo);
                      setState(() {});
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    focusNode: fBankName,
                    controller: bankName,
                    scrollPadding: EdgeInsets.zero,
                    cursorColor: Get.theme.primaryColor,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.zero,
                      hintText: 'Bank Name',
                      labelStyle: TextStyle(
                        color: fBankName.hasFocus ? Get.theme.primaryColor : Colors.grey,
                      ),
                      focusColor: Get.theme.primaryColor,
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                        color: fBankName.hasFocus ? Get.theme.primaryColor : Colors.grey,
                      )),
                      border: UnderlineInputBorder(
                          borderSide: BorderSide(
                        color: fBankName.hasFocus ? Get.theme.primaryColor : Colors.grey,
                      )),
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                        color: fBankName.hasFocus ? Get.theme.primaryColor : Colors.grey,
                      )),
                    ),
                    onTap: () {
                      FocusScope.of(context).requestFocus(fBankName);
                      setState(() {});
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    focusNode: fIfscCode,
                    controller: ifscCode,
                    scrollPadding: EdgeInsets.zero,
                    cursorColor: Get.theme.primaryColor,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.zero,
                      hintText: 'IFSC Code',
                      labelStyle: TextStyle(
                        color: fIfscCode.hasFocus ? Get.theme.primaryColor : Colors.grey,
                      ),
                      focusColor: Get.theme.primaryColor,
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                        color: fIfscCode.hasFocus ? Get.theme.primaryColor : Colors.grey,
                      )),
                      border: UnderlineInputBorder(
                          borderSide: BorderSide(
                        color: fIfscCode.hasFocus ? Get.theme.primaryColor : Colors.grey,
                      )),
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                        color: fIfscCode.hasFocus ? Get.theme.primaryColor : Colors.grey,
                      )),
                    ),
                    onTap: () {
                      FocusScope.of(context).requestFocus(fIfscCode);
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () {
              if (name.text.isEmpty) {
                showCustomSnackBar('Please enter name.');
              } else if (accountNo.text.isEmpty) {
                showCustomSnackBar('Please enter account No.');
              } else if (bankName.text.isEmpty) {
                showCustomSnackBar('Please enter bank name.');
              } else if (ifscCode.text.isEmpty) {
                showCustomSnackBar('Please enter IFSC code.');
              } else {
                Get.back();
                paymentController.addBankDetails(
                  name.text.trim(),
                  accountNo.text.trim(),
                  bankName.text.trim(),
                  ifscCode.text.trim(),
                );
              }
            },
            child: Container(
              height: 45,
              width: Get.width / 3,
              margin: global.getPlatFrom() ? EdgeInsets.symmetric(horizontal: 15) : EdgeInsets.zero,
              padding: EdgeInsets.symmetric(horizontal: 7, vertical: 8),
              decoration: BoxDecoration(
                color: Get.theme.secondaryHeaderColor,
                borderRadius: BorderRadius.circular(5),
              ),
              alignment: Alignment.center,
              child: Text(
                '${AppLocalizations.of(context).add.toString().toUpperCase()} +',
                style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
