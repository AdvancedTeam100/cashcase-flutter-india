import 'package:cashfuse/constants/appConstant.dart';
import 'package:cashfuse/controllers/networkController.dart';
import 'package:cashfuse/models/complainModel.dart';
import 'package:cashfuse/models/orderModel.dart';
import 'package:cashfuse/services/apiHelper.dart';
import 'package:cashfuse/widget/customSnackbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class OrderController extends GetxController {
  APIHelper apiHelper = new APIHelper();
  NetworkController networkController = Get.find<NetworkController>();

  List<OrderModel> _orderList = [];
  List<OrderModel> get orderList => _orderList;

  List<ComplainModel> _complainList = [];
  List<ComplainModel> get complainList => _complainList;

  bool isDataLoaded = false;

  var complain = TextEditingController();

  @override
  void onInit() async {
    await getOrders();
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future getOrders() async {
    try {
      isDataLoaded = false;
      if (networkController.connectionStatus.value == 1 || networkController.connectionStatus.value == 2) {
        await apiHelper.getOrders().then((response) {
          if (response.status == "1") {
            _orderList = response.data;
            update();
          } else {
            showCustomSnackBar(response.message);
          }
        });
      } else {
        showCustomSnackBar(AppConstants.NO_INTERNET);
      }
      isDataLoaded = true;
      update();
    } catch (e) {
      isDataLoaded = true;
      update();
      print("Exception - OrderController.dart - getOrders():" + e.toString());
    }
  }

  Future getOrderComplains(int orderId) async {
    try {
      if (networkController.connectionStatus.value == 1 || networkController.connectionStatus.value == 2) {
        await apiHelper.getOrderComplains(orderId).then((response) {
          if (response.status == "1") {
            _complainList = response.data;
            update();
          } else {
            showCustomSnackBar(response.message);
          }
        });
      } else {
        showCustomSnackBar(AppConstants.NO_INTERNET);
      }
      update();
    } catch (e) {
      update();
      print("Exception - OrderController.dart - getOrderComplains():" + e.toString());
    }
  }

  Future addOrderComplain(int orderId, String camplian) async {
    try {
      if (networkController.connectionStatus.value == 1 || networkController.connectionStatus.value == 2) {
        await apiHelper.addOrderComplain(orderId, camplian).then((response) {
          if (response.status == "1") {
            getOrderComplains(orderId);
            Get.back();
            complain.clear();
          } else if (response.status == "0") {
            showCustomSnackBar(response.data);
          } else {
            showCustomSnackBar(response.message);
          }
        });
      } else {
        showCustomSnackBar(AppConstants.NO_INTERNET);
      }
      update();
    } catch (e) {
      update();
      print("Exception - OrderController.dart - addOrderComplain():" + e.toString());
    }
  }
}
