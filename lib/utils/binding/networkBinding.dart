import 'package:cashfuse/controllers/adController.dart';
import 'package:cashfuse/controllers/authController.dart';
import 'package:cashfuse/controllers/commonController.dart';
import 'package:cashfuse/controllers/couponController.dart';
import 'package:cashfuse/controllers/homeController.dart';
import 'package:cashfuse/controllers/imageController.dart';
import 'package:cashfuse/controllers/localizationController.dart';
import 'package:cashfuse/controllers/networkController.dart';
import 'package:cashfuse/controllers/orderController.dart';
import 'package:cashfuse/controllers/paymentController.dart';
import 'package:cashfuse/controllers/referEarnController.dart';
import 'package:cashfuse/controllers/searchController.dart';
import 'package:cashfuse/controllers/splashController.dart';
import 'package:cashfuse/controllers/themeController.dart';
import 'package:get/get.dart';

class NetworkBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ThemeController());
    Get.lazyPut<NetworkController>(() => NetworkController(), fenix: true);
    Get.put(SplashController());
    Get.lazyPut<HomeController>(() => HomeController(), fenix: true);
    Get.lazyPut<AuthController>(() => AuthController(), fenix: true);

    Get.lazyPut<CommonController>(() => CommonController(), fenix: true);
    Get.lazyPut<CouponController>(() => CouponController(), fenix: true);
    Get.lazyPut<PaymentController>(() => PaymentController(), fenix: true);
    Get.lazyPut<SearchController>(() => SearchController(), fenix: true);
    Get.lazyPut<ImageControlller>(() => ImageControlller(), fenix: true);
    Get.lazyPut<OrderController>(() => OrderController(), fenix: true);
    Get.lazyPut<ReferEarnController>(() => ReferEarnController(), fenix: true);
    Get.lazyPut<LocalizationController>(() => LocalizationController(), fenix: true);
    Get.lazyPut<AdController>(() => AdController(), fenix: true);
  }
}
