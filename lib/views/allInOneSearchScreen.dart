import 'dart:convert';
import 'dart:developer';

import 'package:cashfuse/constants/appConstant.dart';
import 'package:cashfuse/controllers/searchController.dart';
import 'package:cashfuse/models/allInOneSearchDataModel.dart';
import 'package:cashfuse/utils/global.dart' as global;
import 'package:cashfuse/utils/images.dart';
import 'package:cashfuse/views/bottomNavigationBarScreen.dart';
import 'package:cashfuse/views/getStartedScreen.dart';
import 'package:cashfuse/widget/customSnackbar.dart';
import 'package:cashfuse/widget/web/webTopBarWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

class AllInOneSearchScreen extends StatefulWidget {
  final Color bgColor;
  AllInOneSearchScreen({this.bgColor}) : super();
  @override
  _AppTabinationScreenState createState() => new _AppTabinationScreenState();
}

class _AppTabinationScreenState extends State<AllInOneSearchScreen>
    with TickerProviderStateMixin {
  TabController _tabController;
  int _currentIndex = 0;
  bool _isDataLoaded = false;
  bool _isWebLoaded = false;

  WebViewController webViewController;
  TextEditingController _cSearch = new TextEditingController();
  var _fDismiss = new FocusNode();
  var searchNode = new FocusNode();

  SearchController searchController = Get.find<SearchController>();

  bool _isDuplicate = false;

  AllInOneSearchDataModel selectedValue;

  _AppTabinationScreenState() : super();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SearchController>(builder: (controller) {
      return WillPopScope(
        onWillPop: () async {
          if (GetPlatform.isWeb) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => BottomNavigationBarScreen(),
              ),
            );
            return false;
          } else {
            if (searchController.addNewTabList2 != null &&
                searchController.addNewTabList2.length > 0 &&
                searchController.addNewTabList2[_currentIndex].name !=
                    '+Add Tab') {
              if (await webViewController.canGoBack()) {
                webViewController.goBack();
                return false;
              } else {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => BottomNavigationBarScreen(
                      pageIndex: 0,
                    ),
                  ),
                );
                return true;
              }
            } else {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => BottomNavigationBarScreen(
                    pageIndex: 0,
                  ),
                ),
              );
              return true;
            }
          }
        },
        child: SafeArea(
          child: Scaffold(
            appBar: global.getPlatFrom()
                ? WebTopBarWidget()
                : AppBar(
                    elevation: 0,
                    bottomOpacity: 0.0,
                    shape: RoundedRectangleBorder(side: BorderSide.none),
                    backgroundColor: searchController.addNewTabList2 != null &&
                            searchController.addNewTabList2.length > 0 &&
                            searchController
                                    .addNewTabList2[_currentIndex].tabColor !=
                                null &&
                            searchController.addNewTabList2[_currentIndex]
                                .tabColor.isNotEmpty
                        ? _getColorFromHex(searchController
                            .addNewTabList2[_currentIndex].tabColor)
                        : Get.theme.primaryColor,
                    automaticallyImplyLeading: false,
                    leading: InkWell(
                      onTap: () async {
                        if (searchController.addNewTabList2 != null &&
                            searchController.addNewTabList2.length > 0 &&
                            searchController
                                    .addNewTabList2[_currentIndex].name !=
                                '+Add Tab') {
                          if (await webViewController.canGoBack()) {
                            webViewController.goBack();
                          } else {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => BottomNavigationBarScreen(
                                  pageIndex: 0,
                                ),
                              ),
                            );
                          }
                        } else {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => BottomNavigationBarScreen(
                                pageIndex: 0,
                              ),
                            ),
                          );
                        }
                      },
                      child: Icon(
                        Icons.arrow_back,
                      ),
                    ),
                    titleSpacing: 0,
                    title: Container(
                      margin: EdgeInsets.only(right: 10),
                      height: 37,
                      child: TextFormField(
                        controller: _cSearch,
                        cursorColor: Colors.white,
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.search,
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w300),
                        focusNode: searchNode,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          suffixIcon:
                              // _cSearch.text.trim() != null && _cSearch.text.trim().isNotEmpty
                              //     ? InkWell(
                              //         onTap: () async {
                              //           FocusScope.of(context).requestFocus(_fDismiss);
                              //           _cSearch.clear();
                              //           await webViewController.loadUrl(searchController.addNewTabList2[_currentIndex].trackingUrl);
                              //           setState(() {});
                              //         },
                              //         child: Icon(
                              //           Icons.close,
                              //           color: Colors.white,
                              //         ),
                              //       )
                              //     :

                              global.currentUser.id != null &&
                                      searchController.addNewTabList2 != null &&
                                      searchController.addNewTabList2.length > 0
                                  ? InkWell(
                                      onTap: () async {
                                        FocusScope.of(context)
                                            .requestFocus(searchNode);
                                        setState(() {});
                                        if (_cSearch.text.trim() != null &&
                                            _cSearch.text.trim().isNotEmpty &&
                                            searchController
                                                    .addNewTabList2[
                                                        _currentIndex]
                                                    .searchUrl !=
                                                null &&
                                            searchController
                                                .addNewTabList2[_currentIndex]
                                                .searchUrl
                                                .isNotEmpty) {
                                          await webViewController
                                              .loadUrl(searchController
                                                      .addNewTabList2[
                                                          _currentIndex]
                                                      .searchUrl +
                                                  _cSearch.text.trim())
                                              .then((value) {
                                            FocusScope.of(context)
                                                .requestFocus(_fDismiss);
                                          });
                                          _isWebLoaded = false;
                                          setState(() {});
                                        } else {}
                                      },
                                      child: Icon(
                                        Icons.search,
                                        color: Colors.white,
                                      ),
                                    )
                                  : SizedBox(),
                          hintText:
                              AppLocalizations.of(context).all_in_one_search,
                          hintStyle: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.w300),
                          contentPadding: EdgeInsets.only(left: 10),
                        ),
                        onFieldSubmitted: (String val) async {
                          _cSearch.text.trim() != null &&
                                  _cSearch.text.trim().isNotEmpty &&
                                  searchController.addNewTabList2[_currentIndex]
                                          .searchUrl !=
                                      null &&
                                  searchController.addNewTabList2[_currentIndex]
                                      .searchUrl.isNotEmpty
                              ? await webViewController.loadUrl(searchController
                                      .addNewTabList2[_currentIndex].searchUrl +
                                  _cSearch.text.trim())
                              : await webViewController.loadUrl(searchController
                                  .addNewTabList2[_currentIndex].trackingUrl);
                          _isWebLoaded = false;
                          setState(() {});
                        },
                      ),
                    ),
                    // actions: [
                    //   Icon(
                    //     Icons.more_vert,
                    //     color: Colors.white,
                    //   ),
                    // ],
                  ),
            body: Column(
              children: [
                global.getPlatFrom()
                    ? AppBar(
                        elevation: 0,
                        bottomOpacity: 0.0,
                        shape: RoundedRectangleBorder(side: BorderSide.none),
                        backgroundColor: searchController.addNewTabList2 !=
                                    null &&
                                searchController.addNewTabList2.length > 0 &&
                                searchController.addNewTabList2[_currentIndex]
                                        .tabColor !=
                                    null &&
                                searchController.addNewTabList2[_currentIndex]
                                    .tabColor.isNotEmpty
                            ? _getColorFromHex(searchController
                                .addNewTabList2[_currentIndex].tabColor)
                            : Get.theme.primaryColor,
                        automaticallyImplyLeading: false,

                        titleSpacing: 0,
                        title: Center(
                          child: Container(
                            margin: EdgeInsets.only(right: 10),
                            height: global.getPlatFrom() ? 40 : 37,
                            width: global.getPlatFrom()
                                ? AppConstants.WEB_MAX_WIDTH / 2
                                : AppConstants.WEB_MAX_WIDTH,
                            decoration: global.getPlatFrom()
                                ? BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(5))
                                : null,
                            child: TextFormField(
                              controller: _cSearch,
                              cursorColor: global.getPlatFrom()
                                  ? Colors.black
                                  : Colors.white,
                              keyboardType: TextInputType.text,
                              textInputAction: TextInputAction.search,
                              style: TextStyle(
                                  color: global.getPlatFrom()
                                      ? Colors.black
                                      : Colors.white,
                                  fontWeight: FontWeight.w300),
                              focusNode: searchNode,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                suffixIcon:
                                    // _cSearch.text.trim() != null && _cSearch.text.trim().isNotEmpty
                                    //     ? InkWell(
                                    //         onTap: () async {
                                    //           FocusScope.of(context).requestFocus(_fDismiss);
                                    //           _cSearch.clear();
                                    //           await webViewController.loadUrl(searchController.addNewTabList2[_currentIndex].trackingUrl);
                                    //           setState(() {});
                                    //         },
                                    //         child: Icon(
                                    //           Icons.close,
                                    //           color: Colors.white,
                                    //         ),
                                    //       )
                                    //     :
                                    InkWell(
                                  onTap: () async {
                                    FocusScope.of(context)
                                        .requestFocus(searchNode);
                                    setState(() {});
                                    if (_cSearch.text.trim() != null &&
                                        _cSearch.text.trim().isNotEmpty &&
                                        searchController
                                                .addNewTabList2[_currentIndex]
                                                .searchUrl !=
                                            null &&
                                        searchController
                                            .addNewTabList2[_currentIndex]
                                            .searchUrl
                                            .isNotEmpty) {
                                      await webViewController
                                          .loadUrl(searchController
                                                  .addNewTabList2[_currentIndex]
                                                  .searchUrl +
                                              _cSearch.text.trim())
                                          .then((value) {
                                        FocusScope.of(context)
                                            .requestFocus(_fDismiss);
                                      });
                                      _isWebLoaded = false;
                                      setState(() {});
                                    } else {}
                                  },
                                  child: Icon(
                                    Icons.search,
                                    color: global.getPlatFrom()
                                        ? Colors.black
                                        : Colors.white,
                                  ),
                                ),
                                hintText: AppLocalizations.of(context)
                                    .all_in_one_search,
                                hintStyle: TextStyle(
                                    color: global.getPlatFrom()
                                        ? Colors.black
                                        : Colors.white,
                                    fontWeight: FontWeight.w300),
                                contentPadding: EdgeInsets.only(
                                    left: 10,
                                    top: global.getPlatFrom() ? 10 : 0),
                              ),
                              onFieldSubmitted: (String val) async {
                                _cSearch.text.trim() != null &&
                                        _cSearch.text.trim().isNotEmpty &&
                                        searchController
                                                .addNewTabList2[_currentIndex]
                                                .searchUrl !=
                                            null &&
                                        searchController
                                            .addNewTabList2[_currentIndex]
                                            .searchUrl
                                            .isNotEmpty
                                    ? await webViewController.loadUrl(
                                        searchController
                                                .addNewTabList2[_currentIndex]
                                                .searchUrl +
                                            _cSearch.text.trim())
                                    : await webViewController.loadUrl(
                                        searchController
                                            .addNewTabList2[_currentIndex]
                                            .trackingUrl);
                                _isWebLoaded = false;
                                setState(() {});
                              },
                            ),
                          ),
                        ),
                        // actions: [
                        //   Icon(
                        //     Icons.more_vert,
                        //     color: Colors.white,
                        //   ),
                        // ],
                      )
                    : SizedBox(),
                global.currentUser.id != null
                    ? _isDataLoaded
                        ? searchController.addNewTabList2 != null &&
                                searchController.addNewTabList2.length > 0
                            ? Expanded(
                                child: SizedBox(
                                  child: tabCreate(),
                                ),
                              )
                            : Expanded(
                                child: Center(
                                  child: Text(
                                    'No data found.',
                                  ),
                                ),
                              )
                        : Expanded(
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          )
                    : Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              AppLocalizations.of(context).login,
                              style: Get.theme.primaryTextTheme.displaySmall
                                  .copyWith(
                                letterSpacing: -1,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              child: Text(
                                AppLocalizations.of(context).profile_desc,
                                textAlign: TextAlign.center,
                                style: Get.theme.primaryTextTheme.titleSmall
                                    .copyWith(
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
                                padding: EdgeInsets.symmetric(
                                    horizontal: 7, vertical: 8),
                                decoration: BoxDecoration(
                                  color: Get.theme.secondaryHeaderColor,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  AppLocalizations.of(context)
                                      .conti
                                      .toUpperCase(),
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
              ],
            ),
          ),
        ),
      );
    });
  }

  @override
  void initState() {
    super.initState();

    _init();
  }

  void _tabControllerListener() {
    setState(() {
      _currentIndex = _tabController.index;
      _isWebLoaded = false;
    });
  }

  _init() async {
    try {
      if (global.sp.getString('tabList') != null) {
        List<dynamic> list = await json.decode(global.sp.getString('tabList'));
        print(list);

        searchController.addNewTabList2 = List<AllInOneSearchDataModel>.from(
            list.map((x) => AllInOneSearchDataModel.fromJson(x)));
        _tabController = new TabController(
          length: searchController.addNewTabList2.length,
          vsync: this,
          initialIndex: _currentIndex,
        );
        if (searchController.addNewTabList != null) {
          searchController.addNewTabList.clear();
          searchController.addNewTabList.addAll(searchController.addNewTabList2
              .where((e) => e.id != null)
              .toList());
        }

        _tabController.addListener(_tabControllerListener);
      } else {
        if (searchController.addNewTabList2 != null &&
            searchController.addNewTabList2.length > 0) {
          // if (searchController.addNewTabList2.length >= 6) {
          //   searchController.addNewTabList2.addAll(searchController.allInOneList.sublist(0, 5));
          // }

          // if (searchController.addNewTabList2.length >= 6) {
          //   searchController.addNewTabList2.insert(
          //     5,
          //     AllInOneSearchDataModel(name: '+Add Tab'),
          //   );
          // }
          _tabController = new TabController(
            length: searchController.addNewTabList2.length,
            vsync: this,
            initialIndex: _currentIndex,
          );
          _tabController.addListener(_tabControllerListener);
        }
      }

      setState(() {
        _isDataLoaded = true;
      });
    } catch (e) {
      print("Exception - apptabinationScreen.dart - _init():" + e.toString());
    }
  }

  tabCreate() {
    return Scaffold(
        backgroundColor:
            searchController.addNewTabList2[_currentIndex].tabColor != null &&
                    searchController
                        .addNewTabList2[_currentIndex].tabColor.isNotEmpty
                ? _getColorFromHex(
                    searchController.addNewTabList2[_currentIndex].tabColor)
                : Get.theme.primaryColor,
        //smartAppList[_currentIndex].appHexCode != null ? _getColorFromHex(smartAppList[_currentIndex].appHexCode) : global.defaultColor,
        appBar: _isDataLoaded
            ? PreferredSize(
                preferredSize:
                    Size(AppConstants.WEB_MAX_WIDTH / 2, kToolbarHeight),
                child: Center(
                  child: TabBar(
                    isScrollable: true,
                    controller: _tabController,
                    indicatorWeight: 3,
                    indicatorColor: Colors.white,
                    labelColor: Theme.of(context).primaryColor,
                    unselectedLabelColor: Theme.of(context).primaryColorLight,
                    onTap: (int index) async {
                      global.showInterstitialAd();
                      _tabController.animateTo(index, curve: Curves.slowMiddle);
                      setState(() {
                        _isWebLoaded = false;
                      });
                    },
                    tabs: List<Widget>.generate(
                        searchController.addNewTabList2.length, (int index) {
                      return new Tab(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 4),
                              child: Text(
                                searchController.addNewTabList2[index].name,
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            // Padding(
                            //   padding: const EdgeInsets.only(left: 4),
                            //   child: Text(
                            //     'Upto 10% off',
                            //     style: TextStyle(color: Colors.amber, fontSize: 10, fontWeight: FontWeight.w300),
                            //   ),
                            // ),
                          ],
                        ),
                      );
                    }),
                  ),
                ))
            : PreferredSize(
                preferredSize: Size.zero,
                child: SizedBox(),
              ),
        body: GetPlatform.isWeb
            ? FutureBuilder(
                builder: (context1, snapshot) {
                  return SizedBox();
                },
                future: Future.delayed(Duration.zero).then((value) {
                  return Get.dialog(
                    Dialog(
                      backgroundColor: Colors.white,
                      insetPadding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      child: SizedBox(
                        width: AppConstants.WEB_MAX_WIDTH / 3,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            Image.asset(Images.access),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 20, horizontal: 15),
                              child: Text(
                                'To access this feature, download the app',
                                textAlign: TextAlign.center,
                                style: Get.theme.primaryTextTheme.titleLarge
                                    .copyWith(
                                        color: Colors.red,
                                        fontWeight: FontWeight.w600),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                launchUrl(
                                  Uri.parse(
                                      "https://play.google.com/store/apps/details?id=com.cashfuse.app"),
                                  webOnlyWindowName: 'blank',
                                );
                              },
                              child: Container(
                                height: 40,
                                margin: EdgeInsets.all(15),
                                width: AppConstants.WEB_MAX_WIDTH / 4,
                                color: Get.theme.secondaryHeaderColor,
                                alignment: Alignment.center,
                                child: Text(
                                  'Download The App',
                                  style: Get.theme.primaryTextTheme.titleSmall
                                      .copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    useSafeArea: true,
                    barrierDismissible: false,
                  );
                }))
            : TabBarView(
                controller: _tabController,
                physics: NeverScrollableScrollPhysics(),
                children: List.generate(searchController.addNewTabList2.length,
                    (index) {
                  return searchController.addNewTabList2[index].name ==
                          '+Add Tab'
                      ? Container(
                          color: Colors.white,
                          child: Column(
                            children: [
                              Expanded(
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount:
                                      searchController.addNewTabList.length,
                                  itemBuilder: (context, i) {
                                    //searchController.addNewTabList2.removeWhere((element) => element.id == null);
                                    return Card(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Text(
                                            'TAB ${i + 1}',
                                            style: Get.theme.primaryTextTheme
                                                .titleMedium
                                                .copyWith(
                                                    color: Colors.black54),
                                          ),
                                          DropdownButton(
                                            items: searchController.allInOneList
                                                .map<
                                                        DropdownMenuItem<
                                                            AllInOneSearchDataModel>>(
                                                    (AllInOneSearchDataModel
                                                        value) {
                                              return DropdownMenuItem<
                                                  AllInOneSearchDataModel>(
                                                value: value,
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      value.name,
                                                      style: Get
                                                          .theme
                                                          .primaryTextTheme
                                                          .titleMedium
                                                          .copyWith(
                                                              color: Colors
                                                                  .black54),
                                                    ),
                                                    Divider(
                                                      color: Colors.grey,
                                                    ),
                                                  ],
                                                ),
                                              );
                                            }).toList(),
                                            onChanged: (value) {
                                              //searchController.addNewTabList2.add(value);

                                              if (searchController.addNewTabList
                                                      .where((element) =>
                                                          element.name ==
                                                          value.name)
                                                      .toList()
                                                      .length >
                                                  0) {
                                                _isDuplicate = true;
                                                setState(() {});
                                              } else {
                                                _isDuplicate = false;
                                              }
                                              searchController
                                                  .addNewTabList[i] = value;

                                              setState(() {});
                                              print(
                                                  'searchController.addNewTabList @@@@@@@@@@@@@ ${searchController.addNewTabList.length.toString()}');
                                            },
                                            underline: SizedBox(),
                                            iconEnabledColor:
                                                Get.theme.primaryColor,
                                            iconDisabledColor:
                                                Get.theme.primaryColor,
                                            hint: Text(
                                              searchController
                                                  .addNewTabList[i].name,
                                              style: Get.theme.primaryTextTheme
                                                  .titleMedium
                                                  .copyWith(
                                                      color: Colors.black54),
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              if (searchController
                                                      .addNewTabList.length >=
                                                  6) {
                                                //searchController.addNewTabList2.removeWhere((element) => element.id == searchController.addNewTabList[i].id);
                                                searchController.addNewTabList
                                                    .removeAt(i);
                                                // searchController.addNewTabList2.addAll(searchController.addNewTabList);
                                                // searchController.addNewTabList2.insert(
                                                //   searchController.addNewTabList.length,
                                                //   AllInOneSearchDataModel(name: '+Add Tab'),
                                                // );
                                                setState(() {});
                                              } else {
                                                Fluttertoast.showToast(
                                                  msg:
                                                      'Minimum 5 tabs are reuired.',
                                                  toastLength:
                                                      Toast.LENGTH_SHORT,
                                                  gravity: ToastGravity.CENTER,
                                                  timeInSecForIosWeb: 1,
                                                  backgroundColor: Colors.black,
                                                  textColor: Colors.white,
                                                  fontSize: 16.0,
                                                );
                                              }
                                            },
                                            child: Icon(
                                              Icons.remove_circle,
                                              color: Colors.grey,
                                            ),
                                          )
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: InkWell(
                                        onTap: () async {
                                          if (_isDuplicate) {
                                            Fluttertoast.showToast(
                                              msg: 'Duplicate tab not allow',
                                              toastLength: Toast.LENGTH_SHORT,
                                              gravity: ToastGravity.CENTER,
                                              timeInSecForIosWeb: 1,
                                              backgroundColor: Colors.black,
                                              textColor: Colors.white,
                                              fontSize: 16.0,
                                            );
                                          } else if (searchController
                                                  .addNewTabList
                                                  .where((element) =>
                                                      element.id == null)
                                                  .toList()
                                                  .length >
                                              0) {
                                            Fluttertoast.showToast(
                                              msg: 'Empty tab not allow',
                                              toastLength: Toast.LENGTH_SHORT,
                                              gravity: ToastGravity.CENTER,
                                              timeInSecForIosWeb: 1,
                                              backgroundColor: Colors.black,
                                              textColor: Colors.white,
                                              fontSize: 16.0,
                                            );
                                          } else {
                                            //await searchController.saveTab();
                                            // Navigator.of(context).pushReplacement(
                                            //   MaterialPageRoute(
                                            //     builder: (context) => AllInOneSearchScreen(),
                                            //   ),
                                            // );
                                            searchController.addNewTabList2
                                                .removeWhere((element) =>
                                                    element.id == null);
                                            print(
                                                'addNewTabList2 ------------------ ${searchController.addNewTabList2.length.toString()}');
                                            searchController.addNewTabList2 =
                                                List.from(searchController
                                                    .addNewTabList);
                                            print(
                                                'addNewTabList +++++++++++++ ${searchController.addNewTabList.length.toString()}');
                                            print(
                                                'addNewTabList2 +++++++++++++ ${searchController.addNewTabList2.length.toString()}');
                                            //addNewTabList = List.from(addNewTabList2);
                                            // searchController.addNewTabList2.clear();
                                            // searchController.addNewTabList2.addAll(searchController.addNewTabList);
                                            // searchController.addNewTabList.clear();
                                            // searchController.addNewTabList.addAll(searchController.addNewTabList2);

                                            //global.sp.setString('tabList', searchController.addNewTabList.map((e) => e.toJson()).toString());

                                            searchController.addNewTabList2
                                                .insert(
                                              searchController
                                                  .addNewTabList2.length,
                                              AllInOneSearchDataModel(
                                                  name: '+Add Tab'),
                                            );

                                            global.sp.setString(
                                                'tabList',
                                                jsonEncode(searchController
                                                        .addNewTabList2
                                                        .map((i) => i.toJson())
                                                        .toList())
                                                    .toString());

                                            _currentIndex = 0;
                                            _tabController
                                                .animateTo(_currentIndex);
                                            setState(() {});
                                            await _init();
                                          }
                                        },
                                        child: Container(
                                          height: 45,
                                          //margin: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 7, vertical: 8),
                                          decoration: BoxDecoration(
                                            color:
                                                Get.theme.secondaryHeaderColor,
                                            //borderRadius: BorderRadius.circular(5),
                                          ),
                                          alignment: Alignment.center,
                                          child: Text(
                                            AppLocalizations.of(context).save,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Expanded(
                                      child: InkWell(
                                        onTap: () {
                                          searchController.addNewTab();
                                        },
                                        child: Container(
                                          height: 45,
                                          // margin: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 7, vertical: 8),
                                          decoration: BoxDecoration(
                                            color:
                                                Get.theme.secondaryHeaderColor,
                                            // borderRadius: BorderRadius.circular(5),
                                          ),
                                          alignment: Alignment.center,
                                          child: Text(
                                            AppLocalizations.of(context)
                                                .add_new_tab,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        )
                      : Stack(
                          alignment: Alignment.center,
                          children: [
                            searchController.addNewTabList2[index].searchUrl !=
                                        null &&
                                    searchController.addNewTabList2[index]
                                        .searchUrl.isNotEmpty &&
                                    _cSearch.text.trim() != null &&
                                    _cSearch.text.trim().isNotEmpty
                                ? WebView(
                                    initialUrl: searchController
                                            .addNewTabList2[index].searchUrl +
                                        _cSearch.text.trim(),
                                    javascriptMode: JavascriptMode.unrestricted,
                                    allowsInlineMediaPlayback: true,
                                    onWebViewCreated: (controller) {
                                      webViewController = controller;
                                      setState(() {});
                                    },
                                    onWebResourceError: (error) {
                                      showCustomSnackBar(error.description);
                                    },
                                    onProgress: (_) {
                                      setState(() {});
                                    },
                                    onPageFinished: (val) {
                                      _isWebLoaded = true;
                                      setState(() {});
                                    },
                                  )
                                : WebView(
                                    initialUrl: searchController
                                        .addNewTabList2[index].trackingUrl,
                                    userAgent:
                                        'Mozilla/5.0 (iPhone; CPU iPhone OS 9_3 like Mac OS X) AppleWebKit/601.1.46 (KHTML, like Gecko) Version/9.0 Mobile/13E233 Safari/601.1',
                                    javascriptMode: JavascriptMode.unrestricted,
                                    allowsInlineMediaPlayback: true,
                                    onWebViewCreated: (controller) {
                                      webViewController = controller;
                                      webViewController.clearCache();
                                      webViewController.loadUrl(
                                        searchController
                                            .addNewTabList2[index].trackingUrl,
                                      );

                                      setState(() {});
                                    },
                                    onWebResourceError: (error) {
                                      log(error.description);
                                    },
                                    onProgress: (_) {
                                      setState(() {});
                                    },
                                    onPageFinished: (val) {
                                      _isWebLoaded = true;
                                      setState(() {});
                                    },
                                  ),
                            _isWebLoaded == false
                                ? CircularProgressIndicator()
                                : SizedBox(),
                          ],
                        );
                }),
              ));
  }

  _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    if (hexColor.length == 8) {
      return Color(int.parse("0x$hexColor"));
    }
  }

  // Widget _shimmerWidget() {
  //   return Padding(
  //     padding: const EdgeInsets.all(10),
  //     child: Shimmer.fromColors(
  //       baseColor: Colors.grey[300],
  //       highlightColor: Colors.grey[100],
  //       child: Text(
  //         'Loading....',
  //         style: Theme.of(context).primaryTextTheme.caption.copyWith(fontWeight: FontWeight.w500),
  //       ),
  //     ),
  //   );
  // }
}
