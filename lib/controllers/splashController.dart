import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:cashfuse/constants/appConstant.dart';
import 'package:cashfuse/controllers/authController.dart';
import 'package:cashfuse/controllers/networkController.dart';
import 'package:cashfuse/controllers/referEarnController.dart';
import 'package:cashfuse/controllers/searchController.dart';
import 'package:cashfuse/models/userModel.dart';
import 'package:cashfuse/services/apiHelper.dart';
import 'package:cashfuse/utils/date_converter.dart';
import 'package:cashfuse/utils/global.dart' as global;
import 'package:cashfuse/views/bottomNavigationBarScreen.dart';
import 'package:cashfuse/views/getStartedScreen.dart';
import 'package:cashfuse/views/homeScreen.dart';
import 'package:cashfuse/widget/customSnackbar.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashController extends GetxController {
  APIHelper apiHelper = new APIHelper();
  NetworkController networkController = Get.find<NetworkController>();

  @override
  void onInit() async {
    try {
      if (GetPlatform.isWeb) {
        global.appDeviceId = await FirebaseMessaging.instance.getToken(
          vapidKey: global.webConfigurationKey,
        );
      } else {
        global.appDeviceId = await FirebaseMessaging.instance.getToken();
      }
    } catch (e) {
      print("Exception - SplashController.dart - onInit():" + e.toString());
    }

    if (GetPlatform.isWeb) {
      await webInit();
      Get.put(SearchController());
      Get.put(ReferEarnController());
    } else {
      await init();
    }

    super.onInit();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future webInit() async {
    try {
      global.sp = await SharedPreferences.getInstance();

      log(global.appDeviceId);
      if (networkController.connectionStatus.value == 1 ||
          networkController.connectionStatus.value == 2) {
        await apiHelper.getAppInfo().then((response) async {
          if (response.statusCode == 200) {
            global.appInfo = response.data;
            if (global.sp.getString('currentUser') != null) {
              global.currentUser = UserModel.fromJson(
                  json.decode(global.sp.getString("currentUser")));
              await Get.find<AuthController>().getProfile();

              if (global.getPlatFrom()) {
                Get.to(() => HomeScreen(), routeName: 'home');
              } else {
                Get.to(() => BottomNavigationBarScreen(), routeName: 'initial');
              }
            } else {
              if (global.getPlatFrom()) {
                Get.to(() => HomeScreen(), routeName: 'home');
              } else {
                Get.to(() => BottomNavigationBarScreen(), routeName: 'initial');
              }
            }
            await apiHelper.getBannerNotification().then((result) {
              if (result.statusCode == 200) {
                if (result.data != null) {
                  global.bannerImage = result.data['image'];
                }
              }
            });
            await bannerShow();
          } else {
            showCustomSnackBar(response.message);
          }
        });
      } else {
        showCustomSnackBar(AppConstants.NO_INTERNET);
      }
    } catch (e) {
      print("Exception - SplashController.dart - webInit():" + e.toString());
    }
  }

  Future init() async {
    try {
      Timer(Duration.zero, () async {
        global.sp = await SharedPreferences.getInstance();

        log(global.appDeviceId);
        if (networkController.connectionStatus.value == 1 ||
            networkController.connectionStatus.value == 2) {
          await apiHelper.getAppInfo().then((response) async {
            if (response.statusCode == 200) {
              global.appInfo = response.data;
              if (global.sp.getString('currentUser') != null) {
                global.currentUser = UserModel.fromJson(
                    json.decode(global.sp.getString("currentUser")));
                await Get.find<AuthController>().getProfile();
                await global.referAndEarn();
                Get.off(
                  () => BottomNavigationBarScreen(
                    pageIndex: 0,
                  ),
                  routeName: 'home',
                );
              } else {
                if (GetPlatform.isWeb) {
                  Get.to(
                    () => BottomNavigationBarScreen(
                      pageIndex: 0,
                    ),
                    routeName: 'home',
                  );
                } else {
                  Get.off(
                    () => GetStartedScreen(
                      fromMenu: false,
                    ),
                    routeName: 'get-started',
                  );
                }
              }

              await apiHelper.getBannerNotification().then((result) {
                if (result.statusCode == 200) {
                  if (result.data != null) {
                    global.bannerImage = result.data['image'];
                  }
                }
              });
              await bannerShow();
            } else {
              showCustomSnackBar(response.message);
            }
          });
        } else {
          showCustomSnackBar(AppConstants.NO_INTERNET);
        }
      });
    } catch (e) {
      print("Exception - SplashController.dart - init():" + e.toString());
    }
  }

  Future bannerShow() async {
    try {
      if (global.sp.getString('isBannerDate') != null) {
        if (DateConverter.dateTimeToDateOnly(DateTime.now()) ==
            global.sp.getString('isBannerDate')) {
          global.isBannerShow = false;
          print('+++++ in bannerdate exist');
        } else {
          print('+++++ in bannerdate exist but not same');
          global.isBannerShow = true;
          global.isBannerDate =
              DateConverter.dateTimeToDateOnly(DateTime.now());
          global.sp.setString('isBannerDate', global.isBannerDate);
        }
      } else {
        print('+++++ in bannerdate not exist');
        global.isBannerShow = true;
        global.isBannerDate = DateConverter.dateTimeToDateOnly(DateTime.now());
        global.sp.setString('isBannerDate', global.isBannerDate);
      }
    } catch (e) {
      print("Exception - SplashController.dart - bannerShow():" + e.toString());
    }
  }
}
