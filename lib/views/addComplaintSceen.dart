// ignore_for_file: must_be_immutable

import 'package:cashfuse/controllers/orderController.dart';
import 'package:cashfuse/models/orderModel.dart';
import 'package:cashfuse/widget/customSnackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AddComplaintSceen extends StatelessWidget {
  final OrderModel orderModel;
  AddComplaintSceen({this.orderModel});
  OrderController orderController = Get.find<OrderController>();

  @override
  Widget build(BuildContext context) {
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
          AppLocalizations.of(context).add_complaint,
          style: Get.theme.primaryTextTheme.titleSmall.copyWith(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
          child: Column(
            children: [
              Card(
                child: TextFormField(
                  cursorColor: Get.theme.primaryColor,
                  controller: orderController.complain,
                  maxLines: 5,
                  decoration: InputDecoration(
                    hintText: 'Add your Complaint here.....',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(8),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: InkWell(
        onTap: () {
          if (orderController.complain.text.trim().isNotEmpty) {
            orderController.addOrderComplain(orderModel.id, orderController.complain.text);
          } else {
            showCustomSnackBar('Please add Complaint.');
          }
        },
        child: Container(
          height: 50,
          width: Get.width,
          color: Get.theme.secondaryHeaderColor,
          alignment: Alignment.center,
          child: Text(
            AppLocalizations.of(context).submit,
            style: Get.theme.primaryTextTheme.titleSmall.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
