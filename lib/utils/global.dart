import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:cashfuse/controllers/adController.dart';
import 'package:cashfuse/models/admobSettingModel.dart';
import 'package:cashfuse/models/appInfoModel.dart';
import 'package:cashfuse/models/userModel.dart';
import 'package:cashfuse/utils/date_converter.dart';
import 'package:cashfuse/widget/customSnackbar.dart';
import 'package:facebook_audience_network/facebook_audience_network.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:universal_html/html.dart' as html;

String appName = "Cashfuse";

String baseUrl = "https://cash.codefuse.org/admin/api";
// "https://cash.codefuse.org/admin/api";

String webConfigurationKey =
    "BGPWwFL-u-5K7CdmI7bW1Qav23aJxTUFtksG5SDigWG3M2J1-pqgwY-qB1fMQlRJepzlqq9Qv8rDUqk4v9Ph584";

SharedPreferences sp;
UserModel currentUser = new UserModel();
AppInfo appInfo = new AppInfo();
AdmobSettingModel admobSetting = new AdmobSettingModel();
AdmobSettingModel facebookAdSetting = new AdmobSettingModel();
String timeFormat = '12';
String appDeviceId;
bool isRTL = false;
List<String> clickedList = [];

String isBannerDate = DateConverter.dateTimeToDateOnly(DateTime.now());
bool isBannerShow = false;
String bannerImage = '';
String languageCode = 'en';
String referralUserId = '';
String appShareContent =
    "I recently tried $appName app & highly recommend it! You get extra Cashback on top of all retailer discounts. Download the app from below link.";
String appShareLink = '';
FirebaseDynamicLinks dynamicLinks = FirebaseDynamicLinks.instance;
int totalJoinedCount = 0;
int admobclickCount = 0;
int fbclickCount = 0;

//Api Header
Future<Map<String, String>> getApiHeaders(bool authorizationRequired,
    {String userId}) async {
  Map<String, String> apiHeader = new Map<String, String>();

  if (authorizationRequired) {
    sp = await SharedPreferences.getInstance();
    if (sp.getString("currentUser") != null) {
      UserModel currentUser =
          UserModel.fromJson(json.decode(sp.getString("currentUser")));
      log("Token  == Bearer " +
          currentUser.token +
          'id -- ' +
          currentUser.id.toString());
      apiHeader.addAll({"Authorization": "Bearer " + currentUser.token});
      if (userId != null && userId.isNotEmpty) {
        apiHeader.addAll({"userId": userId});
      }
    }
  }

  apiHeader.addAll({"Content-Type": "application/json"});
  apiHeader.addAll({"Accept": "*/*"});
  print(apiHeader);
  return apiHeader;
}

void showInterstitialAd() async {
  try {
    if (Get.find<AdController>().isAdmobInterstitialAdExist) {
      admobclickCount++;
      if (admobclickCount > admobSetting.interstitialAdList[0].clicks) {
        admobclickCount = 0;
      }
      if (admobclickCount == admobSetting.interstitialAdList[0].clicks) {
        Get.find<AdController>().showInterstitialAd();
      }
    }

    if (Get.find<AdController>().isFbInterstitialAdExist) {
      fbclickCount++;

      if (fbclickCount > facebookAdSetting.interstitialAdList[0].clicks) {
        fbclickCount = 0;
      }

      if (fbclickCount == facebookAdSetting.interstitialAdList[0].clicks) {
        FacebookInterstitialAd.showInterstitialAd();
      }
    }
  } catch (e) {
    print("Exception - global.dart - showInterstitialAd():" + e.toString());
  }
}

Future<void> launchInBrowser(String url) async {
  if (GetPlatform.isWeb) {
    html.window.open(
      url,
      'name',
    );
  } else {
    FlutterWebBrowser.openWebPage(
      url: url,
      customTabsOptions: CustomTabsOptions(
        colorScheme: CustomTabsColorScheme.dark,
        darkColorSchemeParams: CustomTabsColorSchemeParams(
          toolbarColor: Get.theme.primaryColor,
          secondaryToolbarColor: Get.theme.primaryColor,
          navigationBarColor: Get.theme.primaryColor,
          navigationBarDividerColor: Get.theme.primaryColor,
        ),
        shareState: CustomTabsShareState.on,
        instantAppsEnabled: true,
        showTitle: true,
        urlBarHidingEnabled: true,
      ),
    );
  }
}

Future share(String link, String image, String title) async {
  try {
    if (image.isNotEmpty) {
      final uri = Uri.parse(image);
      final response = await http.get(uri);
      final bytes = response.bodyBytes;
      final temp = await getExternalStorageDirectory();
      final path = '${temp.path}/image.jpg';
      File(path).writeAsBytesSync(bytes);
      await FlutterShare.shareFile(
              filePath: path, title: '$appName', text: link)
          .then((value) {})
          .catchError((e) {
        showCustomSnackBar(e.toString());
      });
    } else if (title.isNotEmpty) {
      final DynamicLinkParameters parameters = DynamicLinkParameters(
        uriPrefix: 'https://cashfuse.page.link',
        link: Uri.parse(
            'https://cashfuse.page.link/?link=https://cashfuse.page.link&apn=com.cashfuse.app&ibi=com.cashfuse.app&isi=123456789'),
        androidParameters: AndroidParameters(
          packageName: 'com.cashfuse.app',
          minimumVersion: 1,
        ),
        iosParameters: IOSParameters(
          bundleId: 'com.cashfuse.app',
          minimumVersion: '1',
          appStoreId: '123456789',
          fallbackUrl:
              Uri.parse('https://apps.apple.com/in/app/cashfuse/id123456789'),
        ),
      );
      Uri url;
      final ShortDynamicLink shortLink = await dynamicLinks.buildShortLink(
          parameters,
          shortLinkType: ShortDynamicLinkType.short);
      url = shortLink.shortUrl;
      await FlutterShare.share(
              title: '$appName', text: title, linkUrl: url.toString())
          .then((value) {})
          .catchError((e) {
        showCustomSnackBar(e.toString());
      });
    } else {
      await FlutterShare.share(title: '$appName', linkUrl: link)
          .then((value) {})
          .catchError((e) {
        showCustomSnackBar(e.toString());
      });
    }
  } catch (e) {
    print("Exception - global.dart - share():" + e.toString());
  }
}

bool getPlatFrom() {
  if (GetPlatform.isWeb) {
    if (Get.width > 650) {
      return true;
    } else {
      return false;
    }
  } else {
    if (Platform.isAndroid || Platform.isIOS) {
      return false;
    } else {
      if (Get.width > 650) {
        return true;
      } else {
        return false;
      }
    }
  }
}

Future referAndEarn() async {
  try {
    final DynamicLinkParameters parameters = DynamicLinkParameters(
      uriPrefix: 'https://cashfuse.page.link',
      link: Uri.parse(
          'https://cashfuse.page.link/?link=https://cashfuse.page.link/referEarn&userId=${currentUser.id}&apn=com.cashfuse.app&ibi=com.cashfuse.app&isi=123456789'),
      androidParameters: AndroidParameters(
        packageName: 'com.cashfuse.app',
        minimumVersion: 1,
      ),
      iosParameters: IOSParameters(
        bundleId: 'com.cashfuse.app',
        minimumVersion: '1',
        appStoreId: '123456789',
        fallbackUrl:
            Uri.parse('https://apps.apple.com/in/app/cashfuse/id123456789'),
      ),
    );
    Uri url;
    final ShortDynamicLink shortLink = await dynamicLinks
        .buildShortLink(parameters, shortLinkType: ShortDynamicLinkType.short);
    url = shortLink.shortUrl;
    appShareLink = url.toString();
  } catch (e) {
    print("Exception - global.dart - referAndEarn():" + e.toString());
  }
}
