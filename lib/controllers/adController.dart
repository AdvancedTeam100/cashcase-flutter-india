import 'dart:async';

import 'package:cashfuse/constants/appConstant.dart';
import 'package:cashfuse/controllers/networkController.dart';
import 'package:cashfuse/services/apiHelper.dart';
import 'package:cashfuse/utils/global.dart' as global;
import 'package:cashfuse/widget/customSnackbar.dart';
import 'package:facebook_audience_network/facebook_audience_network.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdController extends GetxController {
  APIHelper apiHelper = new APIHelper();
  NetworkController networkController = Get.find<NetworkController>();

  FacebookBannerAd fbBannerAd1;
  FacebookBannerAd fbBannerAd2;
  FacebookBannerAd fbBannerAd3;

  bool isfbBannerAdLoaed1 = false;
  bool isfbBannerAdLoaed2 = false;
  bool isfbBannerAdLoaed3 = false;

  List<BannerAd> bannerAdList = [];

  InterstitialAd interstitialAd;
  int _numInterstitialLoadAttempts = 0;
  int maxFailedLoadAttempts = 3;

  StreamSubscription _subscription;
  double adheight = 0;

  bool admobNativeAdLoaded = false;
  NativeAd myNative;

  bool fbBannerAdLoaded = false;
  FacebookBannerAd fbBannerAd;

  FacebookNativeAd facebookNativeAd;
  bool isFbNativeAdLoaded = false;

  bool isAdmobBannerAd1Exist = false;
  bool isAdmobBannerAd2Exist = false;
  bool isAdmobBannerAd3Exist = false;

  bool isFbBannerAd1Exist = false;
  bool isFbBannerAd2Exist = false;
  bool isFbBannerAd3Exist = false;

  bool isAdmobNativeAd1Exist = false;
  bool isAdmobNativeAd2Exist = false;

  bool isfbNativeAd1Exist = false;
  bool isfbNativeAd2Exist = false;

  bool isAdmobInterstitialAdExist = false;

  bool isFbInterstitialAdExist = false;

  void setNativeAdLoaded(bool val) {
    admobNativeAdLoaded = val;
    update();
  }

  @override
  void onInit() async {
    if (!GetPlatform.isWeb) {
      try {
        FacebookAudienceNetwork.init(
          //testingId: '468FD9C0CF496815189B2FE63C8EFA31',
          iOSAdvertiserTrackingEnabled: true,
        );
      } catch (e) {
        print("Exception - main.dart - main():" + e.toString());
      }
      if (global.appInfo.admob == "1") {
        await getAdmobSettings();

        await createInterstitialAd();
      }
      if (global.appInfo.facebookAd == "1") {
        await getFaceBookAdSetting();

        await loadFacebookInterstitialAd();
      }
    }

    super.onInit();
  }

  String currentPlatform() {
    if (GetPlatform.isAndroid) {
      return 'android';
    } else if (GetPlatform.isIOS) {
      return 'ios';
    }
    return '';
  }

  Future getAdmobSettings() async {
    try {
      if (networkController.connectionStatus.value == 1 || networkController.connectionStatus.value == 2) {
        await apiHelper.getAdmobSettings().then((response) async {
          if (response.statusCode == 200) {
            global.admobSetting = response.data;

            if (!GetPlatform.isWeb && global.admobSetting.bannerAdList != null && global.admobSetting.bannerAdList.length > 0) {
              if (global.admobSetting.bannerAdList[0] != null && global.admobSetting.bannerAdList[0].status == 1 && global.admobSetting.bannerAdList[0].platform == currentPlatform()) {
                isAdmobBannerAd1Exist = true;
              }
              if (global.admobSetting.bannerAdList[1] != null && global.admobSetting.bannerAdList[1].status == 1 && global.admobSetting.bannerAdList[1].platform == currentPlatform()) {
                isAdmobBannerAd2Exist = true;
              }
              if (global.admobSetting.bannerAdList[2] != null && global.admobSetting.bannerAdList[2].status == 1 && global.admobSetting.bannerAdList[2].platform == currentPlatform()) {
                isAdmobBannerAd3Exist = true;
              }
              if (global.admobSetting.nativeAdList[0] != null && global.admobSetting.nativeAdList[0].status == 1 && global.admobSetting.nativeAdList[0].platform == currentPlatform()) {
                isAdmobNativeAd1Exist = true;
              }

              if (global.admobSetting.nativeAdList[1] != null && global.admobSetting.nativeAdList[1].status == 1 && global.admobSetting.nativeAdList[1].platform == currentPlatform()) {
                isAdmobNativeAd2Exist = true;
              }
              if (global.admobSetting.interstitialAdList[0] != null && global.admobSetting.interstitialAdList[0].status == 1 && global.admobSetting.interstitialAdList[0].platform == currentPlatform()) {
                isAdmobInterstitialAdExist = true;
              }
            }

            update();
          } else {
            showCustomSnackBar(response.message);
          }
        });
      } else {
        showCustomSnackBar(AppConstants.NO_INTERNET);
      }
    } catch (e) {
      print("Exception - SplashController.dart - getAdmobSettings():" + e.toString());
    }
  }

  Future getFaceBookAdSetting() async {
    try {
      if (networkController.connectionStatus.value == 1 || networkController.connectionStatus.value == 2) {
        await apiHelper.getFaceBookAdSetting().then((response) async {
          if (response.statusCode == 200) {
            global.facebookAdSetting = response.data;

            if (!GetPlatform.isWeb && global.facebookAdSetting.bannerAdList != null && global.facebookAdSetting.bannerAdList.length > 0) {
              if (global.facebookAdSetting.bannerAdList[0] != null && global.facebookAdSetting.bannerAdList[0].status == 1 && global.facebookAdSetting.bannerAdList[0].platform == currentPlatform()) {
                isfbBannerAdLoaed1 = true;
              }
              if (global.facebookAdSetting.bannerAdList[1] != null && global.facebookAdSetting.bannerAdList[1].status == 1 && global.facebookAdSetting.bannerAdList[1].platform == currentPlatform()) {
                isfbBannerAdLoaed2 = true;
              }
              if (global.facebookAdSetting.bannerAdList[2] != null && global.facebookAdSetting.bannerAdList[2].status == 1 && global.facebookAdSetting.bannerAdList[2].platform == currentPlatform()) {
                isfbBannerAdLoaed3 = true;
              }
              if (global.facebookAdSetting.nativeAdList[0] != null && global.facebookAdSetting.nativeAdList[0].status == 1 && global.facebookAdSetting.nativeAdList[0].platform == currentPlatform()) {
                isfbNativeAd1Exist = true;
              }

              if (global.facebookAdSetting.nativeAdList[1] != null && global.facebookAdSetting.nativeAdList[1].status == 1 && global.facebookAdSetting.nativeAdList[1].platform == currentPlatform()) {
                isfbNativeAd2Exist = true;
              }
              if (global.facebookAdSetting.interstitialAdList[0] != null && global.facebookAdSetting.interstitialAdList[0].status == 1 && global.facebookAdSetting.interstitialAdList[0].platform == currentPlatform()) {
                isFbInterstitialAdExist = true;
              }
            }
            update();
          } else {
            showCustomSnackBar(response.message);
          }
        });
      } else {
        showCustomSnackBar(AppConstants.NO_INTERNET);
      }
    } catch (e) {
      print("Exception - SplashController.dart - getFaceBookAdSetting():" + e.toString());
    }
  }

  @override
  void dispose() {
    _subscription.cancel();
    myNative.dispose();
    super.dispose();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future createInterstitialAd() async {
    try {
      if (isAdmobInterstitialAdExist) {
        InterstitialAd.load(
            adUnitId: "ca-app-pub-3940256099942544/1033173712",
            request: AdRequest(),
            adLoadCallback: InterstitialAdLoadCallback(
              onAdLoaded: (InterstitialAd ad) {
                print('$ad loaded');
                interstitialAd = ad;
                _numInterstitialLoadAttempts = 0;
                interstitialAd.setImmersiveMode(true);
              },
              onAdFailedToLoad: (LoadAdError error) {
                print('InterstitialAd failed to load: $error.');
                _numInterstitialLoadAttempts += 1;
                interstitialAd = null;
                if (_numInterstitialLoadAttempts <= maxFailedLoadAttempts) {
                  createInterstitialAd();
                }
              },
            ));
      }
    } catch (e) {
      print("Exception - AdController.dart - createInterstitialAd():" + e.toString());
    }
  }

  void showInterstitialAd() {
    try {
      if (interstitialAd != null) {
        interstitialAd.fullScreenContentCallback = FullScreenContentCallback(
          onAdShowedFullScreenContent: (InterstitialAd ad) => print('ad onAdShowedFullScreenContent.'),
          onAdDismissedFullScreenContent: (InterstitialAd ad) {
            ad.dispose();
            createInterstitialAd();
            global.admobclickCount = 0;
            update();
          },
          onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
            ad.dispose();
            createInterstitialAd();
            global.admobclickCount = 0;
            update();
          },
        );
        interstitialAd.show();
      }
    } catch (e) {
      print("Exception - AdController.dart - showInterstitialAd():" + e.toString());
    }
  }

  Future loadFacebookInterstitialAd() async {
    if (isFbInterstitialAdExist) {
      FacebookInterstitialAd.loadInterstitialAd(
        placementId: "IMG_16_9_APP_INSTALL#536153035214384_536898488473172",
        listener: (result, value) {
          if (result == InterstitialAdResult.LOADED) {}
          if (result == InterstitialAdResult.DISMISSED) {
            loadFacebookInterstitialAd();
            global.fbclickCount = 0;
            update();
          }
          if (result == InterstitialAdResult.LOGGING_IMPRESSION) {
            loadFacebookInterstitialAd();
            global.fbclickCount = 0;
            update();
          }
          if (result == InterstitialAdResult.ERROR) {
            global.fbclickCount = 0;
            update();
          }
        },
      );
    }
  }
}
