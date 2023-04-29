import 'package:cashfuse/utils/global.dart' as global;
import 'package:cashfuse/utils/images.dart';
import 'package:cashfuse/views/accountSettingScreen.dart';
import 'package:cashfuse/views/allInOneSearchScreen.dart';
import 'package:cashfuse/views/allcategoriesScreen.dart';
import 'package:cashfuse/views/getHelpScreen.dart';
import 'package:cashfuse/views/getStartedScreen.dart';
import 'package:cashfuse/views/requestPaymentScreen.dart';
import 'package:cashfuse/widget/customImage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:store_redirect/store_redirect.dart';

class DrawerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: global.getPlatFrom() ? Get.width / 5 : Get.width - 80,
      child: global.currentUser.id != null
          ? Column(
              children: [
                global.getPlatFrom()
                    ? Container(
                        padding: EdgeInsets.only(top: 30, left: 10, right: 10),
                        color: Get.theme.primaryColor,
                        width: Get.width,
                        height: 300,
                        child: Column(
                          children: [
                            CircleAvatar(
                              radius: 60,
                              backgroundColor: Colors.white,
                              child: global.currentUser.userImage.isNotEmpty
                                  ? ClipRRect(
                                      borderRadius: BorderRadius.circular(60),
                                      child: CustomImage(
                                        image: global
                                                .appInfo.baseUrls.userImageUrl +
                                            '/' +
                                            global.currentUser.userImage,
                                        // height: 30,
                                        // width: 30,
                                        fit: BoxFit.cover,
                                      ),
                                    )
                                  : ClipRRect(
                                      borderRadius: BorderRadius.circular(60),
                                      child: Image.asset(
                                        Images.user,
                                        //height: 30,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            global.currentUser.name.isNotEmpty
                                ? Text(
                                    global.currentUser.name,
                                    style: Get
                                        .theme.primaryTextTheme.titleMedium
                                        .copyWith(color: Colors.white),
                                  )
                                : SizedBox(),
                            Text(
                              global.currentUser.email.isNotEmpty
                                  ? global.currentUser.email
                                  : global.currentUser.phone,
                              style: Get.theme.primaryTextTheme.bodySmall
                                  .copyWith(color: Colors.white),
                            ),
                            Expanded(child: SizedBox()),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
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
                                          .copyWith(
                                        color: Colors.white,
                                        fontSize: 12,
                                      ),
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
                                  crossAxisAlignment: CrossAxisAlignment.center,
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
                                          .copyWith(
                                        color: Colors.white,
                                        fontSize: 12,
                                      ),
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
                                  crossAxisAlignment: CrossAxisAlignment.center,
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
                                          .copyWith(
                                        color: Colors.white,
                                        fontSize: 12,
                                      ),
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
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      AppLocalizations.of(context).rewards,
                                      textAlign: TextAlign.center,
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
                                          .copyWith(
                                        color: Colors.white,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    : Container(
                        padding: EdgeInsets.only(top: 30, left: 10, right: 10),
                        color: Get.theme.primaryColor,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ListTile(
                              contentPadding: EdgeInsets.zero,
                              dense: true,
                              leading: CircleAvatar(
                                radius: 25,
                                backgroundColor: Colors.white,
                                child: global.currentUser.userImage.isNotEmpty
                                    ? ClipRRect(
                                        borderRadius: BorderRadius.circular(25),
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
                                        borderRadius: BorderRadius.circular(25),
                                        child: Image.asset(
                                          Images.user,
                                          //height: 30,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                              ),
                              title: global.currentUser.name.isNotEmpty
                                  ? Text(
                                      global.currentUser.name,
                                      style: Get
                                          .theme.primaryTextTheme.titleMedium
                                          .copyWith(color: Colors.white),
                                    )
                                  : global.currentUser.phone.isNotEmpty
                                      ? Text(
                                          global.currentUser.phone,
                                          style: Get
                                              .theme.primaryTextTheme.bodySmall
                                              .copyWith(color: Colors.white),
                                        )
                                      : SizedBox(),
                              subtitle: global.currentUser.name.isEmpty
                                  ? SizedBox()
                                  : Text(
                                      global.currentUser.email.isNotEmpty
                                          ? global.currentUser.email
                                          : global.currentUser.phone,
                                      style: Get
                                          .theme.primaryTextTheme.bodySmall
                                          .copyWith(color: Colors.white),
                                    ),
                              trailing: global.currentUser.name.isNotEmpty
                                  ? SizedBox()
                                  : InkWell(
                                      onTap: () {
                                        Get.to(
                                          () => AccountSettingScreen(),
                                          routeName: 'account',
                                        );
                                      },
                                      child: Icon(
                                        Icons.edit,
                                        color: Colors.white,
                                      ),
                                    ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
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
                                          .copyWith(
                                        color: Colors.white,
                                        fontSize: 12,
                                      ),
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
                                  crossAxisAlignment: CrossAxisAlignment.center,
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
                                          .copyWith(
                                        color: Colors.white,
                                        fontSize: 12,
                                      ),
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
                                  crossAxisAlignment: CrossAxisAlignment.center,
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
                                          .copyWith(
                                        color: Colors.white,
                                        fontSize: 12,
                                      ),
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
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      AppLocalizations.of(context).rewards,
                                      textAlign: TextAlign.center,
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
                                          .copyWith(
                                        color: Colors.white,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        )
                        //: Text('Welcome!'),
                        ),
                // InkWell(
                //   onTap: () {},
                //   child: Padding(
                //     padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                //     child: Row(
                //       children: [
                //         Icon(
                //           Icons.home_outlined,
                //           color: Colors.black.withOpacity(0.5),
                //         ),
                //         SizedBox(
                //           width: 20,
                //         ),
                //         Text(
                //           'Home',
                //           style: Get.theme.primaryTextTheme.bodyLarge.copyWith(
                //             letterSpacing: 0,
                //             fontWeight: FontWeight.w300,
                //             color: Colors.black.withOpacity(0.6),
                //           ),
                //         ),
                //       ],
                //     ),
                //   ),
                // ),
                InkWell(
                  onTap: () {
                    Get.back();
                    Get.to(
                      () => AccountSettingScreen(),
                      routeName: 'account',
                    );
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: global.getPlatFrom() ? 25 : 20,
                      vertical: global.getPlatFrom() ? 20 : 10,
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.person,
                          color: Colors.black.withOpacity(0.5),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          AppLocalizations.of(context).my_account,
                          style: Get.theme.primaryTextTheme.bodyLarge.copyWith(
                            letterSpacing: 0,
                            fontWeight: FontWeight.w300,
                            color: Colors.black.withOpacity(0.6),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Get.back();
                    Get.to(
                      () => AllCategoriesScreen(),
                      routeName: 'allcategory',
                    );
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: global.getPlatFrom() ? 25 : 20,
                      vertical: global.getPlatFrom() ? 20 : 10,
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.store_outlined,
                          color: Colors.black.withOpacity(0.5),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          AppLocalizations.of(context).all_categories,
                          style: Get.theme.primaryTextTheme.bodyLarge.copyWith(
                            letterSpacing: 0,
                            fontWeight: FontWeight.w300,
                            color: Colors.black.withOpacity(0.6),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Get.back();
                    Get.to(
                      () => RequestPaymentScreen(),
                      routeName: 'request-payment',
                    );
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: global.getPlatFrom() ? 25 : 20,
                      vertical: global.getPlatFrom() ? 20 : 10,
                    ),
                    child: Row(
                      children: [
                        Icon(
                          MdiIcons.ticket,
                          color: Colors.black.withOpacity(0.5),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          AppLocalizations.of(context).redeem_cashback,
                          style: Get.theme.primaryTextTheme.bodyLarge.copyWith(
                            letterSpacing: 0,
                            fontWeight: FontWeight.w300,
                            color: Colors.black.withOpacity(0.6),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Get.back();
                    Get.to(
                      () => AllInOneSearchScreen(),
                      routeName: 'allinone',
                    );
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: global.getPlatFrom() ? 25 : 20,
                      vertical: global.getPlatFrom() ? 20 : 10,
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.search_rounded,
                          color: Colors.black.withOpacity(0.5),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          AppLocalizations.of(context).all_in_one_search,
                          style: Get.theme.primaryTextTheme.bodyLarge.copyWith(
                            letterSpacing: 0,
                            fontWeight: FontWeight.w300,
                            color: Colors.black.withOpacity(0.6),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // InkWell(
                //   onTap: () {
                //     Get.back();
                //     Get.to(
                //       () => GetStartedScreen(
                //         fromSplash: false,
                //       ),
                //       routeName: 'get-started',
                //     );
                //   },
                //   child: Padding(
                //     padding: EdgeInsets.symmetric(
                //       horizontal: global.getPlatFrom() ? 25 : 20,
                //       vertical: global.getPlatFrom() ? 20 : 10,
                //     ),
                //     child: Row(
                //       children: [
                //         Icon(
                //           Icons.info_outline,
                //           color: Colors.black.withOpacity(0.5),
                //         ),
                //         SizedBox(
                //           width: 20,
                //         ),
                //         Text(
                //           'How ${global.appName} works?',
                //           style: Get.theme.primaryTextTheme.bodyLarge.copyWith(
                //             letterSpacing: 0,
                //             fontWeight: FontWeight.w300,
                //             color: Colors.black.withOpacity(0.6),
                //           ),
                //         ),
                //       ],
                //     ),
                //   ),
                // ),
                Divider(),
                !GetPlatform.isWeb
                    ? InkWell(
                        onTap: () async {
                          Get.back();
                          if (global.appShareLink.isNotEmpty) {
                            await FlutterShare.share(
                              title: '${global.appName}',
                              text:
                                  'I recently tried ${global.appName} app & highly recommend it! You get extra Cashback on top of all retailer discounts.\n Try it out: ${global.appShareLink}',
                            ).then((value) {
                              if (value) {}
                            }).onError((error, stackTrace) {
                              return error;
                            });
                          }
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: global.getPlatFrom() ? 25 : 20,
                            vertical: global.getPlatFrom() ? 20 : 10,
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.share_outlined,
                                color: Colors.black.withOpacity(0.5),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Text(
                                AppLocalizations.of(context).share_the_app,
                                style: Get.theme.primaryTextTheme.bodyLarge
                                    .copyWith(
                                  letterSpacing: 0,
                                  fontWeight: FontWeight.w300,
                                  color: Colors.black.withOpacity(0.6),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    : SizedBox(),
                !GetPlatform.isWeb
                    ? InkWell(
                        onTap: () {
                          Get.back();
                          StoreRedirect.redirect(
                            androidAppId: 'com.cashfuse.app',
                            iOSAppId: 'com.cashfuse.app',
                          );
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: global.getPlatFrom() ? 25 : 20,
                            vertical: global.getPlatFrom() ? 20 : 10,
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.star_outline_outlined,
                                color: Colors.black.withOpacity(0.5),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Text(
                                AppLocalizations.of(context).rate_the_app,
                                style: Get.theme.primaryTextTheme.bodyLarge
                                    .copyWith(
                                  letterSpacing: 0,
                                  fontWeight: FontWeight.w300,
                                  color: Colors.black.withOpacity(0.6),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    : SizedBox(),
                InkWell(
                  onTap: () {
                    Get.back();
                    Get.to(
                      () => GetHelpScreen(),
                      routeName: 'faq',
                    );
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: global.getPlatFrom() ? 25 : 20,
                      vertical: global.getPlatFrom() ? 20 : 10,
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.help_outline_outlined,
                          color: Colors.black.withOpacity(0.5),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          AppLocalizations.of(context).get_help,
                          style: Get.theme.primaryTextTheme.bodyLarge.copyWith(
                            letterSpacing: 0,
                            fontWeight: FontWeight.w300,
                            color: Colors.black.withOpacity(0.6),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  AppLocalizations.of(context).login,
                  textAlign: TextAlign.center,
                  style: Get.theme.primaryTextTheme.headlineSmall.copyWith(
                    letterSpacing: -1,
                    height: 0.99,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: Text(
                    AppLocalizations.of(context).login_subtitle,
                    textAlign: TextAlign.center,
                    style: Get.theme.primaryTextTheme.titleSmall.copyWith(
                      letterSpacing: -0.2,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () async {
                    Get.back();
                    if (global.getPlatFrom()) {
                      Get.dialog(Dialog(
                        child: SizedBox(
                          width: Get.width / 3,
                          child: GetStartedScreen(
                            fromMenu: true,
                          ),
                        ),
                      ));
                    } else {
                      if (global.getPlatFrom()) {
                        Get.dialog(Dialog(
                          child: SizedBox(
                            width: Get.width / 3,
                            child: GetStartedScreen(
                              fromMenu: true,
                            ),
                            // LoginOrSignUpScreen(
                            //   fromMenu: true,
                            // ),
                          ),
                        ));
                      } else {
                        // Get.to(
                        //   () => LoginScreen(),
                        //   //     LoginOrSignUpScreen(
                        //   //   fromMenu: true,
                        //   // ),
                        //   routeName: 'login',
                        // );
                        Get.to(
                          () => GetStartedScreen(
                            fromMenu: true,
                          ),
                          routeName: 'login',
                        );
                      }
                    }
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 45,
                    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 25),
                    padding: EdgeInsets.symmetric(horizontal: 7, vertical: 8),
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
    );
  }
}
