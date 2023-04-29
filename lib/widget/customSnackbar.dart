import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showCustomSnackBar(String message, {bool isError = true}) {
  if (message != null && message.isNotEmpty) {
    Get.showSnackbar(GetSnackBar(
      snackPosition: SnackPosition.TOP,
      backgroundColor: isError ? Colors.red : Colors.green,
      message: message,
      duration: Duration(seconds: 3),
      snackStyle: SnackStyle.FLOATING,
      margin: EdgeInsets.only(top: 40, left: 10, right: 10),
      isDismissible: true,
      animationDuration: Duration(seconds: 2),
      dismissDirection: DismissDirection.horizontal,
      borderRadius: 10,
    ));
  }
}
