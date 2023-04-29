import 'package:aligned_dialog/aligned_dialog.dart';
import 'package:cashfuse/constants/appConstant.dart';
import 'package:cashfuse/utils/images.dart';
import 'package:cashfuse/views/bottomNavigationBarScreen.dart';
import 'package:cashfuse/views/getHelpScreen.dart';
import 'package:cashfuse/views/myOrdersScreen.dart';
import 'package:cashfuse/views/requestPaymentScreen.dart';
import 'package:cashfuse/widget/drawerWidget.dart';
import 'package:cashfuse/widget/web/webTopBarWidget.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:cashfuse/utils/global.dart' as global;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MyEarningSceen extends StatelessWidget {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: global.getPlatFrom() ? Colors.white : Colors.grey[200],
      drawer: global.getPlatFrom() ? DrawerWidget() : null,
      appBar: global.getPlatFrom()
          ? WebTopBarWidget(
              scaffoldKey: scaffoldKey,
            )
          : AppBar(
              elevation: 0,
              leading: InkWell(
                onTap: () {
                  Get.back();
                },
                child: Icon(
                  Icons.arrow_back,
                ),
              ),
              title: Text(
                AppLocalizations.of(context).my_earnings,
                style: Get.theme.primaryTextTheme.titleSmall.copyWith(color: Colors.white),
              ),
            ),
      body: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                height: global.getPlatFrom() ? 120 : 80,
                width: Get.width,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFFBC53E1),
                      Color(0xFF6285E3),
                    ],
                  ),
                ),
              ),
              Center(
                child: SizedBox(
                  width: AppConstants.WEB_MAX_WIDTH / 3,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    margin: EdgeInsets.only(top: 40, left: 20, right: 20),
                    child: Column(
                      children: [
                        ListTile(
                          title: Row(
                            children: [
                              Text(
                                AppLocalizations.of(context).total_earning,
                              ),
                              InkWell(
                                onTap: () {
                                  showAlignedDialog(
                                    context: context,
                                    builder: _localDialogBuilder,
                                    followerAnchor: Alignment.topCenter,
                                    targetAnchor: Alignment.topCenter,
                                    barrierColor: Colors.black54,
                                    avoidOverflow: true,
                                    duration: Duration.zero,
                                  );
                                },
                                child: Icon(
                                  Icons.help,
                                  size: 22,
                                  color: Colors.teal.withOpacity(0.5),
                                ),
                              )
                            ],
                          ),
                          subtitle: Text(
                            global.currentUser.earning != null ? '${global.appInfo.currency} ${global.currentUser.earning.totalEarnings}' : '${global.appInfo.currency} 0.00',
                            style: Get.theme.primaryTextTheme.headlineSmall.copyWith(fontWeight: FontWeight.w600),
                          ),
                          trailing: Card(
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: ShaderMask(
                                blendMode: BlendMode.srcIn,
                                shaderCallback: (Rect bounds) {
                                  return LinearGradient(
                                    colors: [
                                      Color(0xFFBC53E1),
                                      Color(0xFF6285E3),
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ).createShader(bounds);
                                },
                                child: Image.asset(
                                  Images.wallet,
                                  height: 20,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: DottedLine(
                            dashLength: 3,
                            dashColor: Colors.grey[350],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                          child: Text(
                            '${AppLocalizations.of(context).my_earnings_subtitile} ${global.appName}.',
                            style: Get.theme.primaryTextTheme.bodyLarge.copyWith(
                              color: Colors.grey[600],
                              fontWeight: FontWeight.w400,
                              letterSpacing: -0.5,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: Align(
              alignment: Alignment.center,
              child: SizedBox(
                width: AppConstants.WEB_MAX_WIDTH / 2,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () {
                          Get.to(
                            () => MyOrdersScreen(),
                            routeName: 'myorders',
                          );
                        },
                        child: Card(
                          margin: EdgeInsets.only(top: 40, left: 20, right: 20),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              gradient: LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  Color(0xFF0FCBF9),
                                  Color(0xFFA0F7FE),
                                ],
                              ),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          AppLocalizations.of(context).my_order_details,
                                          style: Get.theme.primaryTextTheme.titleSmall.copyWith(
                                            color: Colors.white,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 10),
                                          child: DottedLine(
                                            dashLength: 1,
                                            lineThickness: 1.5,
                                            dashGapLength: 1.5,
                                            dashColor: Colors.white,
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              '${AppLocalizations.of(context).view_more} ',
                                              style: Get.theme.primaryTextTheme.titleSmall.copyWith(
                                                color: Colors.white,
                                              ),
                                            ),
                                            CircleAvatar(
                                              radius: 6,
                                              backgroundColor: Colors.white,
                                              child: Icon(
                                                Icons.arrow_forward_ios_rounded,
                                                size: 8,
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Card(
                                  margin: EdgeInsets.symmetric(horizontal: 30),
                                  elevation: 5,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: ShaderMask(
                                      blendMode: BlendMode.srcIn,
                                      shaderCallback: (Rect bounds) {
                                        return LinearGradient(
                                          colors: [
                                            Color(0xFFBC53E1),
                                            Color(0xFF6285E3),
                                          ],
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                        ).createShader(bounds);
                                      },
                                      child: Icon(
                                        Icons.date_range,
                                        color: Colors.white,
                                        size: 25,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Get.back();
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => BottomNavigationBarScreen(
                                pageIndex: 3,
                              ),
                            ),
                          );
                        },
                        child: Card(
                          margin: EdgeInsets.only(top: 20, left: 20, right: 20),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              gradient: LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  Color(0xFF0FCBF9),
                                  Color(0xFFA0F7FE),
                                ],
                              ),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          AppLocalizations.of(context).recents_clicks,
                                          style: Get.theme.primaryTextTheme.titleSmall.copyWith(
                                            color: Colors.white,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 10),
                                          child: DottedLine(
                                            dashLength: 1,
                                            lineThickness: 1.5,
                                            dashGapLength: 1.5,
                                            dashColor: Colors.white,
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              '${AppLocalizations.of(context).view_more} ',
                                              style: Get.theme.primaryTextTheme.titleSmall.copyWith(
                                                color: Colors.white,
                                              ),
                                            ),
                                            CircleAvatar(
                                              radius: 6,
                                              backgroundColor: Colors.white,
                                              child: Icon(
                                                Icons.arrow_forward_ios_rounded,
                                                size: 8,
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Card(
                                  margin: EdgeInsets.symmetric(horizontal: 30),
                                  elevation: 5,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: ShaderMask(
                                      blendMode: BlendMode.srcIn,
                                      shaderCallback: (Rect bounds) {
                                        return LinearGradient(
                                          colors: [
                                            Color(0xFFBC53E1),
                                            Color(0xFF6285E3),
                                          ],
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                        ).createShader(bounds);
                                      },
                                      child: Icon(
                                        MdiIcons.gestureTap,
                                        color: Colors.white,
                                        size: 25,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Get.to(() => RequestPaymentScreen(), routeName: 'request-payment');
                        },
                        child: Card(
                          margin: EdgeInsets.only(top: 20, left: 20, right: 20),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              gradient: LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  Color(0xFF0FCBF9),
                                  Color(0xFFA0F7FE),
                                ],
                              ),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          AppLocalizations.of(context).request_paymets,
                                          style: Get.theme.primaryTextTheme.titleSmall.copyWith(
                                            color: Colors.white,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 10),
                                          child: DottedLine(
                                            dashLength: 1,
                                            lineThickness: 1.5,
                                            dashGapLength: 1.5,
                                            dashColor: Colors.white,
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              '${AppLocalizations.of(context).view_more} ',
                                              style: Get.theme.primaryTextTheme.titleSmall.copyWith(
                                                color: Colors.white,
                                              ),
                                            ),
                                            CircleAvatar(
                                              radius: 6,
                                              backgroundColor: Colors.white,
                                              child: Icon(
                                                Icons.arrow_forward_ios_outlined,
                                                size: 8,
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Card(
                                  margin: EdgeInsets.symmetric(horizontal: 30),
                                  elevation: 5,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: ShaderMask(
                                      blendMode: BlendMode.srcIn,
                                      shaderCallback: (Rect bounds) {
                                        return LinearGradient(
                                          colors: [
                                            Color(0xFFBC53E1),
                                            Color(0xFF6285E3),
                                          ],
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                        ).createShader(bounds);
                                      },
                                      child: Icon(
                                        Icons.currency_rupee_rounded,
                                        size: 25,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Get.to(
                            () => GetHelpScreen(),
                            routeName: 'faq',
                          );
                        },
                        child: Card(
                          margin: EdgeInsets.all(20),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              gradient: LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  Color(0xFF0FCBF9),
                                  Color(0xFFA0F7FE),
                                ],
                              ),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          AppLocalizations.of(context).get_help,
                                          style: Get.theme.primaryTextTheme.titleSmall.copyWith(
                                            color: Colors.white,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 10),
                                          child: DottedLine(
                                            dashLength: 1,
                                            lineThickness: 1.5,
                                            dashGapLength: 1.5,
                                            dashColor: Colors.white,
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              '${AppLocalizations.of(context).view_more} ',
                                              style: Get.theme.primaryTextTheme.titleSmall.copyWith(
                                                color: Colors.white,
                                              ),
                                            ),
                                            CircleAvatar(
                                              radius: 6,
                                              backgroundColor: Colors.white,
                                              child: Icon(
                                                Icons.arrow_forward_ios_rounded,
                                                size: 8,
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Card(
                                  margin: EdgeInsets.symmetric(horizontal: 30),
                                  elevation: 5,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: ShaderMask(
                                      blendMode: BlendMode.srcIn,
                                      shaderCallback: (Rect bounds) {
                                        return LinearGradient(
                                          colors: [
                                            Color(0xFFBC53E1),
                                            Color(0xFF6285E3),
                                          ],
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                        ).createShader(bounds);
                                      },
                                      child: Icon(
                                        Icons.headset_mic,
                                        size: 25,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  WidgetBuilder get _localDialogBuilder {
    return (BuildContext context) {
      return GestureDetector(
        onTap: () {
          Navigator.of(context).pop();
        },
        child: Container(
          margin: EdgeInsets.only(top: 130, left: 20, right: 20),
          child: DefaultTextStyle(
            style: TextStyle(fontSize: 18, color: Colors.black87),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                    margin: EdgeInsets.only(right: 45),
                    child: CustomPaint(
                      painter: TrianglePainter(
                        strokeColor: Colors.white,
                        strokeWidth: 20,
                        paintingStyle: PaintingStyle.fill,
                      ),
                      child: Container(
                        height: 10,
                        width: 15,
                      ),
                    )),
                Container(
                  margin: EdgeInsets.only(left: 20),
                  padding: EdgeInsets.all(8),
                  color: Colors.white,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: Align(
                          alignment: Alignment.topRight,
                          child: Icon(
                            Icons.close,
                            size: 20,
                          ),
                        ),
                      ),
                      Text(
                        'Your total eanings and amount includes your Cashback + Rewards + Refferal amount.',
                        style: Get.theme.primaryTextTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    };
  }
}

class TrianglePainter extends CustomPainter {
  final Color strokeColor;
  final PaintingStyle paintingStyle;
  final double strokeWidth;

  TrianglePainter({this.strokeColor = Colors.black, this.strokeWidth = 3, this.paintingStyle = PaintingStyle.stroke});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = strokeColor
      ..strokeWidth = strokeWidth
      ..style = paintingStyle;

    canvas.drawPath(getTrianglePath(size.width, size.height), paint);
  }

  Path getTrianglePath(double x, double y) {
    return Path()
      ..moveTo(0, y)
      ..lineTo(x / 2, 0)
      ..lineTo(x, y)
      ..lineTo(0, y);
  }

  @override
  bool shouldRepaint(TrianglePainter oldDelegate) {
    return oldDelegate.strokeColor != strokeColor || oldDelegate.paintingStyle != paintingStyle || oldDelegate.strokeWidth != strokeWidth;
  }
}
