// ignore_for_file: must_be_immutable

import 'dart:async';

import 'package:cashfuse/utils/global.dart' as global;
import 'package:cashfuse/views/allInOneSearchScreen.dart';
import 'package:cashfuse/views/homeScreen.dart';
import 'package:cashfuse/views/profileScreen.dart';
import 'package:cashfuse/views/recentClicksScreen.dart';
import 'package:cashfuse/views/searchScreen.dart';
import 'package:circular_bottom_navigation/circular_bottom_navigation.dart';
import 'package:circular_bottom_navigation/tab_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';

class BottomNavigationBarScreen extends StatefulWidget {
  int pageIndex;
  BottomNavigationBarScreen({this.pageIndex}) : super();
  @override
  _BottomNavigationBarScreenState createState() =>
      new _BottomNavigationBarScreenState();
}

class _BottomNavigationBarScreenState extends State<BottomNavigationBarScreen> {
  bool _canExit = global.getPlatFrom() ? true : false;
  int bottomNavIndex;

  CircularBottomNavigationController navigationController;

  List<IconData> iconList = [
    Icons.home,
    Icons.search,
    Icons.screen_search_desktop_outlined,
    Icons.light_mode_outlined,
    Icons.person,
  ];

  List<Color> colorList = [
    Color(0xFF138DF5),
    Color(0xFFFF9600),
    Color(0xFFBCCBD9),
    Color(0xFFFE5030),
    Color(0xFF00A8D5),
  ];

  List<Widget> _screens() => [
        HomeScreen(
          bgColor: colorList[bottomNavIndex],
        ),
        SearchScreen(
          bgColor: colorList[bottomNavIndex],
        ),
        AllInOneSearchScreen(
          bgColor: colorList[bottomNavIndex],
        ),
        RecentClickScreen(
          bgColor: colorList[bottomNavIndex],
        ),
        ProfileScreen(
          bgColor: colorList[bottomNavIndex],
        ),
      ];

  @override
  void initState() {
    _init();
    super.initState();
  }

  Future _init() async {
    try {
      if (widget.pageIndex != null) {
        bottomNavIndex = widget.pageIndex;
      } else {
        bottomNavIndex = 0;
      }
      setState(() {});
      navigationController = CircularBottomNavigationController(bottomNavIndex);
      setState(() {});
    } catch (e) {
      print("Exception - BottomNavigationBarScreen.dart - _init():" +
          e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    List<String> tabList = [
      AppLocalizations.of(context).home,
      AppLocalizations.of(context).search,
      AppLocalizations.of(context).bottom_allInOne,
      AppLocalizations.of(context).recents_clicks,
      AppLocalizations.of(context).profile,
    ];

    return WillPopScope(
      onWillPop: () async {
        if (bottomNavIndex != 0) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => BottomNavigationBarScreen(
                pageIndex: 0,
              ),
            ),
          );
          return false;
        } else {
          if (_canExit) {
            SystemNavigator.pop();
            return true;
          } else {
            !GetPlatform.isWeb
                ? ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('Back press again to exit from app',
                        style: TextStyle(color: Colors.white)),
                    behavior: SnackBarBehavior.floating,
                    backgroundColor: Colors.green,
                    duration: Duration(seconds: 2),
                    margin: EdgeInsets.all(10),
                  ))
                : SizedBox();
            _canExit = true;

            Timer(Duration(seconds: 2), () {
              _canExit = false;
            });
            return false;
          }
        }
      },
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 0,
          elevation: 0,
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: colorList[bottomNavIndex],
          ),
        ),
        bottomNavigationBar: global.getPlatFrom()
            ? SizedBox()
            : Container(
                color: Colors.grey[200],
                child: CircularBottomNavigation(
                    List.generate(iconList.length, (index) {
                      return TabItem(
                        iconList[index],
                        tabList[index],
                        colorList[index],
                        labelStyle: TextStyle(
                          color: colorList[index],
                          height: 1.2,
                          fontSize: 12,
                        ),
                      );
                    }),
                    circleSize: 50,
                    iconsSize: 25,
                    barHeight: 50,
                    normalIconColor: Colors.grey,
                    selectedIconColor: Colors.white,
                    controller: navigationController,
                    selectedPos: bottomNavIndex,
                    barBackgroundColor: Colors.white,
                    animationDuration: Duration(milliseconds: 300),
                    selectedCallback: (int selectedPos) async {
                  bottomNavIndex = selectedPos;
                  setState(() {});
                  global.showInterstitialAd();
                }),
              ),
        body: _screens().elementAt(bottomNavIndex),
      ),
    );
  }
}
