//package
//flutter
// ignore_for_file: must_be_immutable

import 'dart:io';

import 'package:cashfuse/controllers/couponController.dart';
import 'package:cashfuse/controllers/homeController.dart';
import 'package:cashfuse/controllers/networkController.dart';
import 'package:cashfuse/controllers/splashController.dart';
import 'package:cashfuse/controllers/themeController.dart';
import 'package:cashfuse/l10n/l10n.dart';
import 'package:cashfuse/provider/local_provider.dart';
import 'package:cashfuse/theme/nativeTheme.dart';
import 'package:cashfuse/utils/binding/networkBinding.dart';
import 'package:cashfuse/utils/firebaseoption.dart';
import 'package:cashfuse/utils/global.dart' as global;
import 'package:cashfuse/utils/notificationHelper.dart';
import 'package:cashfuse/views/bottomNavigationBarScreen.dart';
import 'package:cashfuse/views/homeScreen.dart';
import 'package:cashfuse/views/splashScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:url_strategy/url_strategy.dart';

FirebaseDynamicLinks dynamicLinks = FirebaseDynamicLinks.instance;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setPathUrlStrategy();
  HttpOverrides.global = new MyHttpOverrides();
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {}

  if (!GetPlatform.isWeb) {
    await NotificationHelper.initialize();
    //MobileAds.instance.initialize();

    MobileAds.instance.initialize();
  }

  if (!GetPlatform.isWeb) {
    await fetchLinkData();
  }

  if (GetPlatform.isWeb) {
    Get.put(NetworkController());
    Get.put(SplashController());
    Get.put(HomeController());

    Get.put(CouponController());
  }

  runApp(MyApp());
}

Future fetchLinkData() async {
  var link = await FirebaseDynamicLinks.instance.getInitialLink();

  handleLinkData(link);

  dynamicLinks.onLink.listen((dynamicLinkData) {
    handleLinkData(dynamicLinkData);
  }).onError((error) {
    print('onLink error');
    print(error.message);
  });
}

void handleLinkData(PendingDynamicLinkData data) {
  final Uri uri = data?.link;
  if (uri != null) {
    final queryParams = uri.queryParameters;
    if (queryParams.length > 0) {
      global.referralUserId = queryParams["userId"];
      print("My user id is: ${global.referralUserId}");
    }
  }
}

class MyApp extends StatelessWidget {
  ThemeController themeController = Get.put(ThemeController());

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => LocaleProvider(),
        builder: (context, child) {
          final provider = Provider.of<LocaleProvider>(context);
          return GetBuilder<ThemeController>(builder: (themeController) {
            return GetMaterialApp(
              navigatorKey: Get.key,
              debugShowCheckedModeBanner: false,
              enableLog: true,
              theme: nativeTheme(),
              initialBinding: NetworkBinding(),
              title: global.appName,
              locale: provider.locale,
              supportedLocales: L10n.all,
              localizationsDelegates: [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
              ],
              home: global.getPlatFrom()
                  ? BottomNavigationBarScreen()
                  : GetPlatform.isWeb
                      ? HomeScreen()
                      : SplashScreen(),
            );
          });
        });
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
