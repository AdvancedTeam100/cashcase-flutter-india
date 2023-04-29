import 'package:cashfuse/controllers/authController.dart';
import 'package:cashfuse/utils/global.dart' as global;
import 'package:cashfuse/utils/images.dart';
import 'package:cashfuse/views/aboutUsScreen.dart';
import 'package:cashfuse/views/accountSettingScreen.dart';
import 'package:cashfuse/views/bottomNavigationBarScreen.dart';
import 'package:cashfuse/views/colorPicker.dart';
import 'package:cashfuse/views/getHelpScreen.dart';
import 'package:cashfuse/views/getStartedScreen.dart';
import 'package:cashfuse/views/languageScreen.dart';
import 'package:cashfuse/views/myEarningScreen.dart';
import 'package:cashfuse/views/paymentHistoryScreen.dart';
import 'package:cashfuse/views/paymentScreen.dart';
import 'package:cashfuse/views/privacyPolicyScreen.dart';
import 'package:cashfuse/views/referralNetworkScreen.dart';
import 'package:cashfuse/widget/confirmationDialog.dart';
import 'package:cashfuse/widget/customImage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:store_redirect/store_redirect.dart';

class ProfileScreen extends StatefulWidget {
  final Color bgColor;
  ProfileScreen({this.bgColor});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String userToken;
  SharedPreferences sharedPreferences;
  Future userDetails() async {
    sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      userToken = sharedPreferences.getString("user_token");
    });
  }

  @override
  void initState() {
    userDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(
      builder: (authController) {
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            leading: InkWell(
              onTap: () async {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => BottomNavigationBarScreen(
                      pageIndex: 0,
                    ),
                  ),
                );
              },
              child: Icon(
                Icons.arrow_back,
              ),
            ),
            title: Text(
              global.currentUser.id != null
                  ? AppLocalizations.of(context).profile
                  : '',
              style: Get.theme.primaryTextTheme.titleSmall
                  .copyWith(color: Colors.white),
            ),
          ),
          body: global.currentUser.id != null
              ? SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                          padding: EdgeInsets.only(left: 10, right: 10),
                          color: Get.theme.primaryColor,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ListTile(
                                contentPadding: EdgeInsets.zero,
                                leading: CircleAvatar(
                                  radius: 25,
                                  backgroundColor: Colors.white,
                                  child: global.currentUser.userImage.isNotEmpty
                                      ? ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(25),
                                          child: CustomImage(
                                            image: global.appInfo.baseUrls
                                                    .userImageUrl +
                                                '/' +
                                                global.currentUser.userImage,
                                            // height: 30,
                                            // width: 30,
                                            fit: BoxFit.cover,
                                          ),
                                        )
                                      : ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(25),
                                          child: Image.asset(
                                            Images.user,
                                            //height: 30,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                ),
                                title: Text(
                                  global.currentUser.name,
                                  style: Get.theme.primaryTextTheme.titleMedium
                                      .copyWith(color: Colors.white),
                                ),
                                subtitle: Text(
                                  global.currentUser.email.isNotEmpty
                                      ? global.currentUser.email
                                      : global.currentUser.phone,
                                  style: Get.theme.primaryTextTheme.bodySmall
                                      .copyWith(color: Colors.white),
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        AppLocalizations.of(context).pending,
                                        style: Get
                                            .theme.primaryTextTheme.bodySmall
                                            .copyWith(
                                          color: Colors.white,
                                          fontSize: 11,
                                          letterSpacing: 0,
                                        ),
                                      ),
                                      Text(
                                        global.currentUser.earning != null
                                            ? '${global.appInfo.currency}${global.currentUser.earning.pendingEarning}'
                                            : '${global.appInfo.currency}0.00',
                                        textAlign: TextAlign.center,
                                        style: Get
                                            .theme.primaryTextTheme.titleSmall
                                            .copyWith(color: Colors.white),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 50,
                                    child: VerticalDivider(
                                      // width: 2,
                                      // thickness: 2,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        AppLocalizations.of(context).approved,
                                        style: Get
                                            .theme.primaryTextTheme.bodySmall
                                            .copyWith(
                                          color: Colors.white,
                                          letterSpacing: 0,
                                          fontSize: 11,
                                        ),
                                      ),
                                      Text(
                                        global.currentUser.earning != null
                                            ? '${global.appInfo.currency}${global.currentUser.earning.remEarning}'
                                            : '${global.appInfo.currency}0.00',
                                        textAlign: TextAlign.center,
                                        style: Get
                                            .theme.primaryTextTheme.titleSmall
                                            .copyWith(color: Colors.white),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 50,
                                    child: VerticalDivider(
                                      // width: 2,
                                      // thickness: 2,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        AppLocalizations.of(context).redeemed,
                                        style: Get
                                            .theme.primaryTextTheme.bodySmall
                                            .copyWith(
                                          color: Colors.white,
                                          letterSpacing: 0,
                                          fontSize: 11,
                                        ),
                                      ),
                                      Text(
                                        global.currentUser.earning != null
                                            ? '${global.appInfo.currency}${global.currentUser.earning.withdrawal}'
                                            : '${global.appInfo.currency}0.00',
                                        textAlign: TextAlign.center,
                                        style: Get
                                            .theme.primaryTextTheme.titleSmall
                                            .copyWith(color: Colors.white),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 50,
                                    child: VerticalDivider(
                                      // width: 2,
                                      // thickness: 2,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        AppLocalizations.of(context).rewards,
                                        style: Get
                                            .theme.primaryTextTheme.bodySmall
                                            .copyWith(
                                          color: Colors.white,
                                          letterSpacing: 0,
                                          fontSize: 11,
                                        ),
                                      ),
                                      Text(
                                        global.currentUser.earning != null
                                            ? '${global.appInfo.currency}${global.currentUser.earning.rewardEarning}'
                                            : '${global.appInfo.currency}0.00',
                                        textAlign: TextAlign.center,
                                        style: Get
                                            .theme.primaryTextTheme.titleSmall
                                            .copyWith(color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          )
                          //: Text('Welcome!'),
                          ),
                      // Container(
                      //   color: Get.theme.primaryColor,
                      //   padding: EdgeInsets.only(left: 20, top: 5, right: 20),
                      //   child: Column(
                      //     crossAxisAlignment: CrossAxisAlignment.start,
                      //     children: [
                      //       Text(
                      //         'Hello ' + global.currentUser.name,
                      //         style: Get.theme.primaryTextTheme.titleSmall.copyWith(color: Colors.white),
                      //       ),
                      //       SizedBox(
                      //         height: 10,
                      //       ),
                      //       Divider(
                      //         color: Colors.white.withOpacity(0.2),
                      //         height: 0,
                      //         thickness: 1.2,
                      //       ),
                      //       SizedBox(
                      //         height: 10,
                      //       ),
                      //       Row(
                      //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //         children: [
                      //           Column(
                      //             crossAxisAlignment: CrossAxisAlignment.start,
                      //             children: [
                      //               Text(
                      //                 'Total Cashback:',
                      //                 style: Get.theme.primaryTextTheme.bodySmall.copyWith(
                      //                   color: Colors.white,
                      //                   fontSize: 11,
                      //                 ),
                      //               ),
                      //               Text(
                      //                 global.currentUser.earning != null ? '${global.appInfo.currency}${global.currentUser.earning.totalEarnings}' : '${global.appInfo.currency}0.00',
                      //                 style: Get.theme.primaryTextTheme.titleSmall.copyWith(color: Colors.white),
                      //               ),
                      //             ],
                      //           ),
                      //           // Column(
                      //           //   crossAxisAlignment: CrossAxisAlignment.start,
                      //           //   children: [
                      //           //     Text(
                      //           //       'Total Rewards:',
                      //           //       style: Get.theme.primaryTextTheme.bodySmall.copyWith(
                      //           //         color: Colors.white,
                      //           //         fontSize: 11,
                      //           //       ),
                      //           //     ),
                      //           //     Text(
                      //           //       '${global.appInfo.currency}0.00',
                      //           //       style: Get.theme.primaryTextTheme.titleSmall.copyWith(color: Colors.white),
                      //           //     ),
                      //           //   ],
                      //           // )
                      //         ],
                      //       ),
                      //       SizedBox(
                      //         height: 10,
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      InkWell(
                        onTap: () {
                          global.showInterstitialAd();

                          authController.name.text = global.currentUser.name;
                          authController.email.text = global.currentUser.email;
                          authController.contactNo.text =
                              global.currentUser.phone;
                          Get.to(
                            () => AccountSettingScreen(),
                            routeName: 'account',
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: Row(
                            children: [
                              // Icon(
                              //   Icons.settings,
                              //   color: Get.theme.iconTheme.color,
                              // ),
                              Image.asset(
                                Images.settings,
                                height: 20,
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Text(
                                AppLocalizations.of(context).account_settings,
                                style: Get.theme.primaryTextTheme.bodySmall
                                    .copyWith(
                                  letterSpacing: 0,
                                  color: Colors.black.withOpacity(0.75),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          global.showInterstitialAd();
                          Get.to(
                            () => MyEarningSceen(),
                            routeName: 'earning',
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: Row(
                            children: [
                              // Icon(
                              //   Icons.currency_rupee,
                              //   color: Get.theme.iconTheme.color,
                              // ),
                              Image.asset(
                                Images.earnings,
                                height: 20,
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Text(
                                AppLocalizations.of(context).my_earnings,
                                style: Get.theme.primaryTextTheme.bodySmall
                                    .copyWith(
                                  letterSpacing: 0,
                                  color: Colors.black.withOpacity(0.75),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          global.showInterstitialAd();
                          Get.to(
                            () => PaymentScreen(),
                            routeName: 'payment',
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: Row(
                            children: [
                              Image.asset(
                                Images.payments,
                                height: 20,
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Text(
                                AppLocalizations.of(context).payments,
                                style: Get.theme.primaryTextTheme.bodySmall
                                    .copyWith(
                                  letterSpacing: 0,
                                  color: Colors.black.withOpacity(0.75),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          global.showInterstitialAd();
                          Get.to(
                            () => PaymentHistoryScreen(),
                            routeName: 'payment-history',
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: Row(
                            children: [
                              // Icon(
                              //   Icons.history,
                              //   color: Get.theme.iconTheme.color,
                              // ),
                              Image.asset(
                                Images.pay_history,
                                height: 20,
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Text(
                                AppLocalizations.of(context).payment_history,
                                style: Get.theme.primaryTextTheme.bodySmall
                                    .copyWith(
                                  letterSpacing: 0,
                                  color: Colors.black.withOpacity(0.75),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      InkWell(
                        onTap: () {
                          global.showInterstitialAd();
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => BottomNavigationBarScreen(
                                pageIndex: 3,
                              ),
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: Row(
                            children: [
                              Image.asset(
                                Images.recent_clicks,
                                height: 20,
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Text(
                                AppLocalizations.of(context).recents_clicks,
                                style: Get.theme.primaryTextTheme.bodySmall
                                    .copyWith(
                                  letterSpacing: 0,
                                  color: Colors.black.withOpacity(0.75),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          global.showInterstitialAd();
                          Get.to(
                            () => ReferralNetworkScreen(),
                            routeName: 'referral-network',
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: Row(
                            children: [
                              Image.asset(
                                Images.refer,
                                height: 20,
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Text(
                                'Referral Network',
                                style: Get.theme.primaryTextTheme.bodySmall
                                    .copyWith(
                                  letterSpacing: 0,
                                  color: Colors.black.withOpacity(0.75),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          global.showInterstitialAd();
                          Get.to(
                            () => GetHelpScreen(),
                            routeName: 'faq',
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: Row(
                            children: [
                              // Icon(
                              //   Icons.live_help_outlined,
                              //   color: Get.theme.iconTheme.color,
                              // ),
                              Image.asset(
                                Images.gethelp,
                                height: 20,
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Text(
                                AppLocalizations.of(context).get_help,
                                style: Get.theme.primaryTextTheme.bodySmall
                                    .copyWith(
                                  letterSpacing: 0,
                                  color: Colors.black.withOpacity(0.75),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          global.showInterstitialAd();
                          Get.to(
                            () => ColorPickerPage(),
                            routeName: 'theme',
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: Row(
                            children: [
                              // Icon(
                              //   Icons.color_lens,
                              //   color: Get.theme.iconTheme.color,
                              // ),
                              Image.asset(
                                Images.theme_color,
                                height: 20,
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Text(
                                AppLocalizations.of(context).theme,
                                style: Get.theme.primaryTextTheme.bodySmall
                                    .copyWith(
                                  letterSpacing: 0,
                                  color: Colors.black.withOpacity(0.75),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          global.showInterstitialAd();
                          Get.to(
                            () => LanguageScreen(),
                            routeName: 'language',
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: Row(
                            children: [
                              // Icon(
                              //   Icons.,
                              //   color: Get.theme.iconTheme.color,
                              // ),
                              Image.asset(
                                Images.languages,
                                height: 20,
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Text(
                                AppLocalizations.of(context).language,
                                style: Get.theme.primaryTextTheme.bodySmall
                                    .copyWith(
                                  letterSpacing: 0,
                                  color: Colors.black.withOpacity(0.75),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      Divider(
                        height: 0,
                      ),
                      !GetPlatform.isWeb
                          ? InkWell(
                              onTap: () {
                                //Get.to(() => RateUsScreen());
                                StoreRedirect.redirect(
                                  androidAppId: 'com.cashfuse.app',
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                child: Row(
                                  children: [
                                    Image.asset(
                                      Images.rateus,
                                      height: 20,
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Text(
                                      AppLocalizations.of(context).rate_us,
                                      style: Get
                                          .theme.primaryTextTheme.bodySmall
                                          .copyWith(
                                        letterSpacing: 0,
                                        color: Colors.black.withOpacity(0.75),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : SizedBox(),
                      Divider(
                        height: 0,
                      ),
                      InkWell(
                        onTap: () {
                          global.showInterstitialAd();
                          Get.to(
                            () => AboutUsScreen(),
                            routeName: 'about',
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: Row(
                            children: [
                              // Icon(
                              //   Icons.info_outline,
                              //   color: Get.theme.iconTheme.color,
                              // ),
                              Image.asset(
                                Images.aboutus,
                                height: 20,
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Text(
                                AppLocalizations.of(context).about_us,
                                style: Get.theme.primaryTextTheme.bodySmall
                                    .copyWith(
                                  letterSpacing: 0,
                                  color: Colors.black.withOpacity(0.75),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          global.showInterstitialAd();
                          Get.to(
                            () => PrivacyPolicyScreen(),
                            routeName: 'privacy',
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: Row(
                            children: [
                              // Icon(
                              //   Icons.lock_open,
                              //   color: Get.theme.iconTheme.color,
                              // ),
                              Image.asset(
                                Images.privacy_policy,
                                height: 20,
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Text(
                                AppLocalizations.of(context).privacy_policy,
                                style: Get.theme.primaryTextTheme.bodySmall
                                    .copyWith(
                                  letterSpacing: 0,
                                  color: Colors.black.withOpacity(0.75),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          showConfirmationDialog(
                            context,
                            AppLocalizations.of(context).logout,
                            AppLocalizations.of(context).logout_desc,
                            [
                              CupertinoDialogAction(
                                child: Text(
                                  AppLocalizations.of(context).yes,
                                  style: Get.theme.primaryTextTheme.titleSmall
                                      .copyWith(color: Colors.red),
                                ),
                                onPressed: () {
                                  authController.logout();

                                  Get.back();
                                },
                              ),
                              CupertinoDialogAction(
                                child: Text(
                                  AppLocalizations.of(context).no,
                                  style: Get.theme.primaryTextTheme.titleSmall
                                      .copyWith(color: Colors.blue),
                                ),
                                onPressed: () {
                                  Get.back();
                                },
                              ),
                            ],
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: Row(
                            children: [
                              Icon(
                                Icons.power_settings_new_rounded,
                                color: Get.theme.iconTheme.color,
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Text(
                                AppLocalizations.of(context).logout,
                                style: Get.theme.primaryTextTheme.bodyMedium
                                    .copyWith(
                                  letterSpacing: -0.5,
                                  color: Colors.red,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              : Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        AppLocalizations.of(context).login,
                        style: Get.theme.primaryTextTheme.displaySmall.copyWith(
                          letterSpacing: -1,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Text(
                          AppLocalizations.of(context).profile_desc,
                          textAlign: TextAlign.center,
                          style: Get.theme.primaryTextTheme.titleSmall.copyWith(
                            letterSpacing: -0.2,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () async {
                          if (global.getPlatFrom()) {
                            Get.dialog(Dialog(
                              child: SizedBox(
                                  width: Get.width / 3,
                                  child: GetStartedScreen(
                                    fromMenu: true,
                                  )
                                  // LoginOrSignUpScreen(
                                  //   fromMenu: true,
                                  // ),
                                  ),
                            ));
                          } else {
                            Get.to(
                              () =>
                                  //  LoginScreen(),
                                  //     LoginOrSignUpScreen(
                                  //   fromMenu: true,
                                  // ),
                                  GetStartedScreen(
                                fromMenu: true,
                              ),
                              routeName: 'login',
                            );
                          }
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 45,
                          margin: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 25),
                          padding:
                              EdgeInsets.symmetric(horizontal: 7, vertical: 8),
                          decoration: BoxDecoration(
                            color: Get.theme.secondaryHeaderColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            AppLocalizations.of(context).conti.toUpperCase(),
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
        );
      },
    );
  }
}
