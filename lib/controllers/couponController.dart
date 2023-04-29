import 'package:cashfuse/constants/appConstant.dart';
import 'package:cashfuse/controllers/networkController.dart';
import 'package:cashfuse/models/couponModel.dart';
import 'package:cashfuse/services/apiHelper.dart';
import 'package:cashfuse/widget/customSnackbar.dart';
import 'package:get/get.dart';

class CouponController extends GetxController {
  APIHelper apiHelper = new APIHelper();
  NetworkController networkController = Get.find<NetworkController>();
  List<Coupon> _couponList = [];
  List<Coupon> get couponList => _couponList;

  bool isDataLoaded = false;

  @override
  void onInit() async {
    await getCouponList();
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future getCouponList() async {
    try {
      isDataLoaded = false;
      if (networkController.connectionStatus.value == 1 || networkController.connectionStatus.value == 2) {
        await apiHelper.getCoupons().then((response) {
          if (response.status == "1") {
            _couponList = response.data;
            if (_couponList != null && _couponList.length > 0) {
              for (var i = 0; i < _couponList.length; i++) {
                int diff;
                if (_couponList[i].endDate != null) {
                  diff = _couponList[i].endDate.difference(DateTime.now()).inDays;
                  print(diff);
                  _couponList[i].dayDifference = diff;
                }
              }
            }
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
      print("Exception - CouponController.dart - getCouponList():" + e.toString());
    }
  }
}
