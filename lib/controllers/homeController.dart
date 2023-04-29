import 'dart:async';

import 'package:cashfuse/constants/appConstant.dart';
import 'package:cashfuse/controllers/authController.dart';
import 'package:cashfuse/controllers/networkController.dart';
import 'package:cashfuse/controllers/searchController.dart';
import 'package:cashfuse/models/admitedoffersModal.dart';
import 'package:cashfuse/models/adsModel.dart';
import 'package:cashfuse/models/bannerModel.dart';
import 'package:cashfuse/models/campaignModel.dart';
import 'package:cashfuse/models/categoryModel.dart';
import 'package:cashfuse/models/clickModel.dart';
import 'package:cashfuse/models/commonModel.dart';
import 'package:cashfuse/models/offerModel.dart';
import 'package:cashfuse/models/productModel.dart';
import 'package:cashfuse/services/apiHelper.dart';
import 'package:cashfuse/utils/global.dart' as global;
import 'package:cashfuse/widget/customLoader.dart';
import 'package:cashfuse/widget/customSnackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  APIHelper apiHelper = new APIHelper();
  NetworkController networkController = Get.put(NetworkController());
  List<CategoryModel> _topCategoryList = [];
  List<CategoryModel> get topCategoryList => _topCategoryList;

  List<CategoryModel> _topCashbackList = [];
  List<CategoryModel> get topCashbackList => _topCashbackList;

  List<CategoryModel> _homeAdvList = [];
  List<CategoryModel> get homeAdvList => _homeAdvList;

  List<CategoryModel> _allAdvList = [];
  List<CategoryModel> get allAdvList => _allAdvList;

  List<OfferModel> _exclusiveOfferList = [];
  List<OfferModel> get exclusiveOfferList => _exclusiveOfferList;

  List<OfferModel> _newFlashOfferList = [];
  List<OfferModel> get newFlashOfferList => _newFlashOfferList;

  List<BannerModel> _topBannerList = [];
  List<BannerModel> get topBannerList => _topBannerList;

  List<ClickModel> _recentClickList = [];
  List<ClickModel> get recentClickList => _recentClickList;

  List<CampaignModel> _seeMoreCampaignList = [];
  List<CampaignModel> get seeMoreCampaignList => _seeMoreCampaignList;

  List<AdmitedOffersModal> _seeMoreAdmitedList = [];
  List<AdmitedOffersModal> get seeMoreAdmitedList => _seeMoreAdmitedList;

  List<OfferModel> _seeMoreOfferList = [];
  List<OfferModel> get seeMoreOfferList => _seeMoreOfferList;

  List<AdsModel> _seeMoreAdsList = [];
  List<AdsModel> get seeMoreAdsList => _seeMoreAdsList;

  OfferModel _offer = new OfferModel();
  OfferModel get offer => _offer;

  AdsModel _ads = new AdsModel();
  AdsModel get ads => _ads;

  CampaignModel _campaign = new CampaignModel();
  CampaignModel get campaign => _campaign;

  AdmitedOffersModal _admitedOffer = new AdmitedOffersModal();
  AdmitedOffersModal get admitedOffer => _admitedOffer;

  List<ProductModel> _productList = [];
  List<ProductModel> get productList => _productList;

  List<ProductModel> _trendingProductList = [];
  List<ProductModel> get trendingProductList => _trendingProductList;

  bool isCategoryLoaded = false;
  bool isBannerLoaded = false;
  bool isTopCashbackLoaded = false;
  bool isOfferLoaded = false;
  bool isHomeAdvLoaded = false;
  bool isFlashOffersLoaded = false;
  bool isProductsLoaded = false;
  bool isTrendingProductsLoaded = false;

  bool isCategoryExpand = false;
  bool isRoted = true;
  bool isOffer = false;
  int webBottomIndex = 0;
  int bannerIndex = 0;
  int page = 1;
  var isMoreDataAvailable = true.obs;
  var isAllDataLoaded = false.obs;
  var isClickDataLoaded = false.obs;

  String createdLink = '';
  ScrollController catScrollController = ScrollController();
  ScrollController topCashBackScrollController = ScrollController();

  int catPageListIndex = 0;

  @override
  void onInit() async {
    init();

    super.onInit();
  }

  void setcatListIndex(int val) {
    catPageListIndex = val;
    update();
  }

  bool isExist = false;

  // void setValue(bool val) {
  //   isExist = val;
  //   update();
  // }

  Future addAdCategory(int index) async {
    try {
      topCategoryList[index]
          .commonList
          .removeWhere((element) => element.name == 'Ad');

      for (var i = 0; i < topCategoryList[index].commonList.length; i++) {
        if (((i * 4) + 4) < topCategoryList[index].commonList.length) {
          topCategoryList[index].commonList.insert(
                (i * 4) + 4,
                CommonModel(name: 'Ad', isExist: true),
              );
        }
      }
      update();
    } catch (e) {
      print(
          "Exception - HomeController.dart - addAdCategory():" + e.toString());
    }
  }

  init() async {
    try {
      if (global.appInfo.baseUrls == null) {
        await apiHelper.getAppInfo().then((response) {
          if (response.statusCode == 200) {
            global.appInfo = response.data;
            update();
          }
        });
      }
      await getTopBanners();

      await getTopCategories();
      await getTopCashBack(page);
      await getProducts();
      await getTrendingProducts();

      await getExclusiveOffers();

      await getNewFlashOffers();
      await getHomeAdv();

      await getAllAdv();
      if (global.currentUser.id != null) {
        await getClick();
        await Get.find<AuthController>().getProfile();
        await Get.find<SearchController>().allInOneSearch();
      }
    } catch (e) {
      print("Exception - HomeController.dart - _init():" + e.toString());
    }
  }

  @override
  void onClose() {
    super.onClose();
  }

  void setCategoryExpand(bool val) {
    isCategoryExpand = val;
    update();
  }

  void setIsOffer(bool val) {
    isOffer = val;
    update();
  }

  void setWebBottomIndex(int val) {
    webBottomIndex = val;
    update();
  }

  void updtaeRotate(bool val) async {
    isRoted = val;
    update();
  }

  void setBannerIndex(int val) {
    bannerIndex = val;
    update();
  }

  Future getTopCategories() async {
    try {
      isCategoryLoaded = false;
      if (networkController.connectionStatus.value == 1 ||
          networkController.connectionStatus.value == 2) {
        if (_topCategoryList.length > 0) {
          page++;
        } else {
          page = 1;
        }
        await apiHelper.getTopCategories(page).then((response) {
          if (response.status == "1") {
            List<CategoryModel> _tList = response.data;
            if (_tList.isEmpty) {
              isMoreDataAvailable.value = false;
              isAllDataLoaded.value = true;
            }
            _topCategoryList.addAll(_tList);

            update();

            if (_topCategoryList != []) {
              for (var i = 0; i < _topCategoryList.length; i++) {
                // _topCategoryList[i].commonList = [];
                if (_topCategoryList[i].ads != []) {
                  List<AdsModel> _tList = _topCategoryList[i]
                      .ads
                      .where((element) => element.status == 1)
                      .toList();
                  if (_tList != null && _tList.length > 0) {
                    for (var j = 0; j < _tList.length; j++) {
                      _topCategoryList[i].commonList.add(
                            CommonModel(
                                name: _tList[j].name,
                                image:
                                    '${global.appInfo.baseUrls.offerImageUrl}/${_tList[j].image}',
                                buttonText: _tList[j].buttonText,
                                trackingLink: _tList[j].landingPage,
                                adId: _tList[j].id.toString(),
                                from: "ads"),
                          );
                    }
                  }
                }

                // if (_topCategoryList[i].commonList.length > 0) {
                //   for (var t = 0; t < _topCategoryList[i].commonList.length; t++) {
                //     _topCategoryList[i].commonList.insert((t * 3) + 3, CommonModel(name: 'Ad'));
                //   }
                // }
              }
              for (var n = 0; n < _topCategoryList.length; n++) {
                // _topCategoryList[n].commonList = [];
                if (_topCategoryList[n].cuecampaigns != []) {
                  List<CampaignModel> _tList = _topCategoryList[n]
                      .cuecampaigns
                      .where((element) => element.status == 1)
                      .toList();

                  if (_tList != null && _tList.length > 0) {
                    for (var k = 0; k < _tList.length; k++) {
                      _topCategoryList[n].commonList.add(
                            CommonModel(
                                name: _tList[k].name,
                                image:
                                    '${global.appInfo.baseUrls.offerImageUrl}/${_tList[k].image}',
                                buttonText: _tList[k].buttonText,
                                trackingLink: _tList[k].url,
                                campaignId: _tList[k].id,
                                from: "cue"),
                          );
                    }
                  }
                }
                if (_topCategoryList[n].admitedoffers != []) {
                  List<AdmitedOffersModal> _tList = _topCategoryList[n]
                      .admitedoffers
                      .where((element) => element.status == 1)
                      .toList();
                  if (_tList != null && _tList.length > 0) {
                    for (var k = 0; k < _tList.length; k++) {
                      _topCategoryList[n].commonList.add(
                            CommonModel(
                                name: _tList[k].name,
                                image:
                                    '${global.appInfo.baseUrls.offerImageUrl}/${_tList[k].image}',
                                buttonText:
                                    "Grab Now", // _topCategoryList[n].admitedoffers[k].buttonText,
                                trackingLink: _tList[k].gotourl,
                                campaignId: _tList[k].id,
                                from: "admit"),
                          );
                    }
                  }
                }
                // if (_topCategoryList[n].commonList.length > 0) {
                //   for (var t = 0; t < _topCategoryList[n].commonList.length; n++) {
                //     _topCategoryList[n].commonList.insert((t * 3) + 3, CommonModel(name: 'Ad'));
                //   }
                // }
              }
            }
          } else {
            showCustomSnackBar(response.message);
          }
        });
        isCategoryLoaded = true;
        update();
      } else {
        isCategoryLoaded = true;
        update();
        showCustomSnackBar(AppConstants.NO_INTERNET);
      }
    } catch (e) {
      isCategoryLoaded = true;
      update();
      print("Exception - HomeController.dart - getTopCategories():" +
          e.toString());
    }
  }

  Future getTopCashBack(int page) async {
    try {
      isTopCashbackLoaded = false;

      if (networkController.connectionStatus.value == 1 ||
          networkController.connectionStatus.value == 2) {
        if (_topCashbackList.length > 0) {
          page = page++;
        }
        await apiHelper.getTopCashBack(page).then((response) {
          if (response.status == "1") {
            List<CategoryModel> _tList = response.data;
            if (_tList.isEmpty) {
              isMoreDataAvailable.value = false;
            }
            _topCashbackList.addAll(_tList);

            update();
            if (_topCashbackList != []) {
              for (var i = 0; i < _topCashbackList.length; i++) {
                // _topCashbackList[i].commonList = [];
                if (_topCashbackList[i].ads != []) {
                  List<AdsModel> _tList = _topCashbackList[i]
                      .ads
                      .where((element) => element.status == 1)
                      .toList();
                  if (_tList != null && _tList.length > 0) {
                    for (var j = 0; j < _tList.length; j++) {
                      _topCashbackList[i].commonList.add(
                            CommonModel(
                                name: _tList[j].name,
                                image:
                                    '${global.appInfo.baseUrls.offerImageUrl}/${_tList[j].image}',
                                buttonText: _tList[j].buttonText,
                                trackingLink: _tList[j].landingPage,
                                adId: _tList[j].id.toString(),
                                from: "ads"),
                          );
                    }
                  }
                }

                // if (_topCashbackList[i].commonList.length > 0) {
                //   for (var t = 0; t < _topCashbackList[i].commonList.length; t++) {
                //     _topCashbackList[i].commonList.insert((t * 3) + 3, CommonModel(name: 'Ad'));
                //   }
                // }
              }
              for (var n = 0; n < _topCashbackList.length; n++) {
                // _topCashbackList[n].commonList = [];
                if (_topCashbackList[n].cuecampaigns != []) {
                  List<CampaignModel> _tList = _topCashbackList[n]
                      .cuecampaigns
                      .where((element) => element.status == 1)
                      .toList();
                  if (_tList != null && _tList.length > 0) {
                    for (var k = 0; k < _tList.length; k++) {
                      _topCashbackList[n].commonList.add(
                            CommonModel(
                                name: _tList[k].name,
                                image:
                                    '${global.appInfo.baseUrls.offerImageUrl}/${_tList[k].image}',
                                buttonText: _tList[k].buttonText,
                                trackingLink: _tList[k].url,
                                campaignId: _tList[k].id,
                                from: "cue"),
                          );
                    }
                  }
                }
                // if (_topCashbackList[n].commonList.length > 0) {
                //   for (var t = 0; t < _topCashbackList[n].commonList.length; t++) {
                //     _topCashbackList[n].commonList.insert((t * 3) + 3, CommonModel(name: 'Ad'));
                //   }
                // }
              }
              for (var m = 0; m < _topCashbackList.length; m++) {
                // _topCashbackList[m].commonList = [];
                if (_topCashbackList[m].admitedoffers != []) {
                  List<AdmitedOffersModal> _tList = _topCashbackList[m]
                      .admitedoffers
                      .where((element) => element.status == 1)
                      .toList();

                  if (_tList != null && _tList.length > 0) {
                    for (var p = 0; p < _tList.length; p++) {
                      _topCashbackList[m].commonList.add(
                            CommonModel(
                                name: _tList[p].name,
                                image:
                                    '${global.appInfo.baseUrls.offerImageUrl}/${_tList[p].image}',
                                buttonText: 'Grab Now',
                                trackingLink: _tList[p].gotourl,
                                campaignId: _tList[p].id,
                                from: "admit"),
                          );
                    }
                  }
                }
                // if (_topCashbackList[n].commonList.length > 0) {
                //   for (var t = 0; t < _topCashbackList[n].commonList.length; t++) {
                //     _topCashbackList[n].commonList.insert((t * 3) + 3, CommonModel(name: 'Ad'));
                //   }
                // }
              }
            }
          } else {
            showCustomSnackBar(response.message);
          }
        });
        isTopCashbackLoaded = true;
        update();
      } else {
        showCustomSnackBar(AppConstants.NO_INTERNET);
      }
    } catch (e) {
      isTopCashbackLoaded = true;
      update();
      print(
          "Exception - HomeController.dart - getTopCashBack():" + e.toString());
    }
  }

  Future getHomeAdv() async {
    try {
      if (networkController.connectionStatus.value == 1 ||
          networkController.connectionStatus.value == 2) {
        await apiHelper.getHomeAdv().then((response) {
          if (response.status == "1") {
            _homeAdvList = response.data;

            if (_homeAdvList != []) {
              for (var i = 0; i < _homeAdvList.length; i++) {
                if (_homeAdvList[i].ads != []) {
                  List<AdsModel> _tList = _homeAdvList[i]
                      .ads
                      .where((element) => element.status == 1)
                      .toList();
                  if (_tList != null && _tList.length > 0) {
                    for (var j = 0; j < _tList.length; j++) {
                      _homeAdvList[i].commonList.add(
                            CommonModel(
                              name: _tList[j].name,
                              image: _tList[j].image,
                              buttonText: _tList[j].buttonText,
                              trackingLink: _tList[j].landingPage,
                              adId: _tList[j].id.toString(),
                            ),
                          );
                    }
                  }

                  // if (_homeAdvList[i].commonList.length > 0) {
                  //   for (var t = 0; t < _homeAdvList[i].commonList.length; t++) {
                  //     _homeAdvList[i].commonList.insert((t * 3) + 3, CommonModel(name: 'Ad'));
                  //   }
                  // }
                }
              }
              for (var n = 0; n < _homeAdvList.length; n++) {
                if (_homeAdvList[n].cuecampaigns != []) {
                  List<CampaignModel> _tList = _homeAdvList[n]
                      .cuecampaigns
                      .where((element) => element.status == 1)
                      .toList();
                  if (_tList != null && _tList.length > 0) {
                    for (var k = 0; k < _tList.length; k++) {
                      _homeAdvList[n].commonList.add(
                            CommonModel(
                              name: _tList[k].name,
                              image: _tList[k].image,
                              buttonText: _tList[k].buttonText,
                              trackingLink: _tList[k].url,
                              campaignId: _tList[k].id,
                            ),
                          );
                    }
                  }

                  // if (_homeAdvList[n].commonList.length > 0) {
                  //   for (var t = 0; t < _homeAdvList[n].commonList.length; t++) {
                  //     _homeAdvList[n].commonList.insert((t * 3) + 3, CommonModel(name: 'Ad'));
                  //   }
                  // }
                }
              }
              for (var m = 0; m < _homeAdvList.length; m++) {
                // _homeAdvList[m].commonList = [];
                if (_homeAdvList[m].admitedoffers != []) {
                  List<AdmitedOffersModal> _tList = _homeAdvList[m]
                      .admitedoffers
                      .where((element) => element.status == 1)
                      .toList();
                  if (_tList != null && _tList.length > 0) {
                    for (var p = 0; p < _tList.length; p++) {
                      _homeAdvList[m].commonList.add(
                            CommonModel(
                                name: _tList[p].name,
                                image:
                                    '${global.appInfo.baseUrls.offerImageUrl}/${_tList[p].image}',
                                buttonText: 'Grab Now',
                                trackingLink: _tList[p].gotourl,
                                campaignId: _tList[p].id,
                                from: "admit"),
                          );
                    }
                  }
                }
              }
            }
          } else {
            showCustomSnackBar(response.message);
          }
        });
        isHomeAdvLoaded = true;
        update();
      } else {
        showCustomSnackBar(AppConstants.NO_INTERNET);
      }
    } catch (e) {
      isHomeAdvLoaded = true;
      update();
      print("Exception - HomeController.dart - getHomeAdv():" + e.toString());
    }
  }

  Future getAllAdv() async {
    try {
      if (networkController.connectionStatus.value == 1 ||
          networkController.connectionStatus.value == 2) {
        if (_allAdvList.length > 0) {
          page++;
        } else {
          page = 1;
        }
        await apiHelper.getAllAdv(page).then((response) {
          if (response.status == "1") {
            List<CategoryModel> _tList = response.data;
            if (_tList.isEmpty) {
              isMoreDataAvailable.value = false;
            }
            _allAdvList.addAll(_tList);

            update();
            if (_allAdvList != []) {
              for (var i = 0; i < _allAdvList.length; i++) {
                _allAdvList[i].commonList = [];
                if (_allAdvList[i].ads != []) {
                  List<AdsModel> _tList = _allAdvList[i]
                      .ads
                      .where((element) => element.status == 1)
                      .toList();
                  if (_tList != null && _tList.length > 0) {
                    for (var j = 0; j < _tList.length; j++) {
                      _allAdvList[i].commonList.add(
                            CommonModel(
                              name: _tList[j].name,
                              image:
                                  '${global.appInfo.baseUrls.offerImageUrl}/${_tList[j].image}',
                              buttonText: _tList[j].buttonText,
                              trackingLink: _tList[j].landingPage,
                              adId: _tList[j].id.toString(),
                            ),
                          );
                    }
                  }
                }
              }
              for (var n = 0; n < _allAdvList.length; n++) {
                _allAdvList[n].commonList = [];
                if (_allAdvList[n].cuecampaigns != []) {
                  List<CampaignModel> _tList = _allAdvList[n]
                      .cuecampaigns
                      .where((element) => element.status == 1)
                      .toList();
                  if (_tList != null && _tList.length > 0) {
                    for (var k = 0; k < _tList.length; k++) {
                      _allAdvList[n].commonList.add(
                            CommonModel(
                              name: _tList[k].name,
                              image:
                                  '${global.appInfo.baseUrls.offerImageUrl}/${_tList[k].image}',
                              buttonText: _tList[k].buttonText,
                              trackingLink: _tList[k].url,
                              campaignId: _tList[k].id,
                            ),
                          );
                    }
                  }
                }
              }
              for (var m = 0; m < _allAdvList.length; m++) {
                _allAdvList[m].commonList = [];
                if (_allAdvList[m].admitedoffers != []) {
                  List<AdmitedOffersModal> _tList = _allAdvList[m]
                      .admitedoffers
                      .where((element) => element.status == 1)
                      .toList();
                  if (_tList != null && _tList.length > 0) {
                    for (var p = 0;
                        p < _tList.length;
                        p++) {
                      _allAdvList[m].commonList.add(
                            CommonModel(
                                name: _tList[p].name,
                                image:
                                    '${global.appInfo.baseUrls.offerImageUrl}/${_tList[p].image}',
                                buttonText: 'Grab Now',
                                trackingLink:
                                    _tList[p].gotourl,
                                campaignId: _tList[p].id,
                                from: "admit"),
                          );
                    }
                  }
                }
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
      print("Exception - HomeController.dart - getAllAdv():" + e.toString());
    }
  }

  Future getExclusiveOffers() async {
    try {
      isOfferLoaded = false;
      if (networkController.connectionStatus.value == 1 ||
          networkController.connectionStatus.value == 2) {
        await apiHelper.getExclusiveOffers().then((response) {
          if (response.status == "1") {
            _exclusiveOfferList = response.data;
            if (_exclusiveOfferList != null && _exclusiveOfferList.length > 0) {
              for (var i = 0; i < _exclusiveOfferList.length; i++) {
                int diff;
                if (_exclusiveOfferList[i].endDate != null) {
                  diff = _exclusiveOfferList[i]
                      .endDate
                      .difference(DateTime.now())
                      .inDays;
                  print(diff);
                  _exclusiveOfferList[i].dayDifference = diff;
                }
              }
            }
          }
        });
      } else {
        showCustomSnackBar(AppConstants.NO_INTERNET);
      }
      isOfferLoaded = true;
      update();
    } catch (e) {
      isOfferLoaded = true;
      update();
      print("Exception - HomeController.dart - getExclusiveOffers():" +
          e.toString());
    }
  }

  Future getNewFlashOffers() async {
    try {
      isFlashOffersLoaded = false;
      if (networkController.connectionStatus.value == 1 ||
          networkController.connectionStatus.value == 2) {
        await apiHelper.getNewFlashOffers().then((response) {
          if (response.status == "1") {
            _newFlashOfferList = response.data;
            if (_newFlashOfferList != null && _newFlashOfferList.length > 0) {
              for (var i = 0; i < _newFlashOfferList.length; i++) {
                int diff;
                if (_newFlashOfferList[i].endDate != null) {
                  diff = _newFlashOfferList[i]
                      .endDate
                      .difference(DateTime.now())
                      .inDays;
                  print(diff);
                  _newFlashOfferList[i].dayDifference = diff;
                }
              }
            }
          }
        });
      } else {
        showCustomSnackBar(AppConstants.NO_INTERNET);
      }
      isFlashOffersLoaded = true;
      update();
    } catch (e) {
      isFlashOffersLoaded = true;
      update();
      print("Exception - HomeController.dart - getNewFlashOffers():" +
          e.toString());
    }
  }

  Future getTopBanners() async {
    try {
      isBannerLoaded = false;
      if (networkController.connectionStatus.value == 1 ||
          networkController.connectionStatus.value == 2) {
        await apiHelper.getTopBanners().then((response) {
          if (response.status == "1") {
            _topBannerList = response.data;

            // if (_topBannerList.length > 0) {
            //   for (var i = 0; i < _topBannerList.length; i++) {
            //     //if (i == _topBannerList.length / 3) {
            //     _topBannerList.insert(
            //       (i * 3) + 3,
            //       BannerModel(name: 'Ad'),
            //     );
            //     //}
            //   }
            // }
            update();
          } else {
            showCustomSnackBar(response.message);
          }
        });
        isBannerLoaded = true;
        update();
      } else {
        showCustomSnackBar(AppConstants.NO_INTERNET);
      }
    } catch (e) {
      isBannerLoaded = true;
      update();
      print(
          "Exception - HomeController.dart - getTopBanners():" + e.toString());
    }
  }

  // int countTimer(DateTime startTime, DateTime endTime) {
  //   try {
  //     int diff;
  //     if (startTime != null && endTime != null) {
  //       diff = endTime.difference(startTime).inDays;
  //       print(diff);
  //     }
  //     return diff > 0 ? diff : null;
  //   } catch (e) {
  //     print("Exception - HomeController.dart - countTimer():" + e.toString());
  //     return null;
  //   }
  // }

  Future getOfferDetails(String offerId) async {
    try {
      if (networkController.connectionStatus.value == 1 ||
          networkController.connectionStatus.value == 2) {
        Get.dialog(CustomLoader(), barrierDismissible: false);
        await apiHelper.getOfferDetails(offerId).then((response) {
          Get.back();
          if (response.status == "1") {
            _offer = response.data;
            update();
          } else {
            showCustomSnackBar(response.message);
          }
          getMoreOffers(offerId);
        });
      } else {
        showCustomSnackBar(AppConstants.NO_INTERNET);
      }
    } catch (e) {
      print("Exception - HomeController.dart - getOfferDetails():" +
          e.toString());
    }
  }

  Future getAdDetails(String adId) async {
    try {
      if (networkController.connectionStatus.value == 1 ||
          networkController.connectionStatus.value == 2) {
        Get.dialog(CustomLoader(), barrierDismissible: false);
        await apiHelper.getAdDetails(adId).then((response) {
          Get.back();
          if (response.statusCode == 200) {
            _ads = response.data;
            update();
          } else {
            showCustomSnackBar(response.message);
          }
          getMoreAds(adId);
        });
      } else {
        showCustomSnackBar(AppConstants.NO_INTERNET);
      }
    } catch (e) {
      print("Exception - HomeController.dart - getAdDetails():" + e.toString());
    }
  }

  Future getCampignDetails(String campaignId) async {
    try {
      if (networkController.connectionStatus.value == 1 ||
          networkController.connectionStatus.value == 2) {
        Get.dialog(CustomLoader(), barrierDismissible: false);
        await apiHelper.getCampignDetails(campaignId).then((response) {
          Get.back();
          if (response.statusCode == 200) {
            _campaign = response.data;

            update();
          } else {
            showCustomSnackBar(response.message);
          }
          getMoreCampaign(campaignId);
        });
      } else {
        showCustomSnackBar(AppConstants.NO_INTERNET);
      }
    } catch (e) {
      print("Exception - HomeController.dart - getCampignDetails():" +
          e.toString());
    }
  }

  Future getAdmitedDetails(int admitedId) async {
    try {
      if (networkController.connectionStatus.value == 1 ||
          networkController.connectionStatus.value == 2) {
        Get.dialog(CustomLoader(), barrierDismissible: false);
        await apiHelper.getAdmitedOfferDetails(admitedId).then((response) {
          Get.back();
          if (response.statusCode == 200) {
            _admitedOffer = response.data;

            // update();
          } else {
            showCustomSnackBar(response.message);
          }
          getMoreAdmited(admitedId.toString());
        });
      } else {
        showCustomSnackBar(AppConstants.NO_INTERNET);
      }
      update();
    } catch (e) {
      print("Exception - HomeController.dart - getAdmitedDetails():" +
          e.toString());
    }
  }

  Future getTrackingLink(String url, String type, {String cId}) async {
    try {
      createdLink = '';
      if (networkController.connectionStatus.value == 1 ||
          networkController.connectionStatus.value == 2) {
        Get.dialog(CustomLoader(), barrierDismissible: false);
        await apiHelper.getTrackingLink(url, type, cId: cId).then((response) {
          Get.back();
          if (response.status == "1") {
            createdLink = response.data;
            update();
          } else {
            showCustomSnackBar(response.message);
          }
        });
        update();
      } else {
        showCustomSnackBar(AppConstants.NO_INTERNET);
      }
    } catch (e) {
      print("Exception - HomeController.dart - getTrackingLink():" +
          e.toString());
    }
  }

  Future addClick(String name, String image, String trackingLink) async {
    try {
      if (networkController.connectionStatus.value == 1 ||
          networkController.connectionStatus.value == 2) {
        await apiHelper.addClick(name, image, trackingLink).then((response) {
          if (response.status == "1") {
            getClick();
            update();
          } else {
            showCustomSnackBar(response.message);
          }
        });
        update();
      } else {
        showCustomSnackBar(AppConstants.NO_INTERNET);
      }
    } catch (e) {
      print("Exception - HomeController.dart - addClick():" + e.toString());
    }
  }

  Future getClick() async {
    try {
      if (networkController.connectionStatus.value == 1 ||
          networkController.connectionStatus.value == 2) {
        isClickDataLoaded.value = false;
        await apiHelper.getClick().then((response) {
          if (response.status == "1") {
            _recentClickList = response.data;
            update();
          } else {
            showCustomSnackBar(response.message);
          }
        });
        isClickDataLoaded.value = true;
        update();
      } else {
        showCustomSnackBar(AppConstants.NO_INTERNET);
      }
    } catch (e) {
      print("Exception - HomeController.dart - getClick():" + e.toString());
    }
  }

  Future deleteClicks() async {
    try {
      if (networkController.connectionStatus.value == 1 ||
          networkController.connectionStatus.value == 2) {
        Get.dialog(CustomLoader(), barrierDismissible: false);
        await apiHelper.deleteClicks().then((response) {
          Get.back();
          if (response.status == "1") {
            //_recentClickList = response.data;
            showCustomSnackBar(response.message);
            getClick();
          } else {
            showCustomSnackBar(response.message);
          }
        });
        update();
      } else {
        showCustomSnackBar(AppConstants.NO_INTERNET);
      }
    } catch (e) {
      print("Exception - HomeController.dart - deleteClicks():" + e.toString());
    }
  }

  String clickDialogText(ClickModel click) {
    try {
      String value = '';
      if (DateTime.now().difference(click.createdAt).inDays == 0) {
        value =
            'All is Well\nit will take upto 72 hours to track your rewards till then keep shopping so #yougetmore ';
      } else if (DateTime.now().difference(click.createdAt).inDays == 1) {
        value =
            'All is Well\nit will take upto 36 hours to track your rewards till then keep shopping so #yougetmore ';
      } else if (DateTime.now().difference(click.createdAt).inDays == 2) {
        value =
            'All is Well\nit will take upto 24 hours to track your rewards till then keep shopping so #yougetmore';
      } else {
        value =
            "your earnings will show on My Orders Details.\nif you don't see your earnings there , please click below.";
      }
      return value;
    } catch (e) {
      print("Exception - HomeController.dart - clickDialogText():" +
          e.toString());
      return '';
    }
  }

  String clickTime(ClickModel click) {
    try {
      String value = '';
      if (DateTime.now().difference(click.createdAt).inDays > 0) {
        value = '${DateTime.now().difference(click.createdAt).inDays} day ago';
      } else if (DateTime.now().difference(click.createdAt).inHours > 0) {
        value =
            '${DateTime.now().difference(click.createdAt).inHours} hour ago';
      } else if (DateTime.now().difference(click.createdAt).inMinutes > 0) {
        value =
            '${DateTime.now().difference(click.createdAt).inMinutes} min ago';
      } else if (DateTime.now().difference(click.createdAt).inSeconds > 0) {
        value = 'Just Now';
      }

      return value;
    } catch (e) {
      print("Exception - HomeController.dart - clickTime():" + e.toString());
      return '';
    }
  }

  Future getMoreCampaign(String campaignId) async {
    try {
      if (networkController.connectionStatus.value == 1 ||
          networkController.connectionStatus.value == 2) {
        //Get.dialog(CustomLoader(), barrierDismissible: false);
        await apiHelper.getMoreCampaign(campaignId).then((response) {
          //Get.back();
          if (response.status == "1") {
            _seeMoreCampaignList = response.data;
          } else {
            showCustomSnackBar(response.message);
          }
        });
      } else {
        showCustomSnackBar(AppConstants.NO_INTERNET);
      }
      update();
    } catch (e) {
      print("Exception - HomeController.dart - getMoreCampaign():" +
          e.toString());
    }
  }

  Future getMoreOffers(String offerId) async {
    try {
      if (networkController.connectionStatus.value == 1 ||
          networkController.connectionStatus.value == 2) {
        // Get.dialog(CustomLoader(), barrierDismissible: false);
        await apiHelper.getMoreOffers(offerId).then((response) {
          //Get.back();
          if (response.status == "1") {
            _seeMoreOfferList = response.data;
          } else {
            showCustomSnackBar(response.message);
          }
        });
      } else {
        showCustomSnackBar(AppConstants.NO_INTERNET);
      }
      update();
    } catch (e) {
      print(
          "Exception - HomeController.dart - getMoreOffers():" + e.toString());
    }
  }

  Future getMoreAds(String adId) async {
    try {
      if (networkController.connectionStatus.value == 1 ||
          networkController.connectionStatus.value == 2) {
        //Get.dialog(CustomLoader(), barrierDismissible: false);
        await apiHelper.getMoreAds(adId).then((response) {
          //Get.back();
          if (response.status == "1") {
            _seeMoreAdsList = response.data;
          } else {
            showCustomSnackBar(response.message);
          }
        });
      } else {
        showCustomSnackBar(AppConstants.NO_INTERNET);
      }
      update();
    } catch (e) {
      print("Exception - HomeController.dart - getMoreAds():" + e.toString());
    }
  }

  Future getMoreAdmited(String campaignId) async {
    try {
      if (networkController.connectionStatus.value == 1 ||
          networkController.connectionStatus.value == 2) {
        //Get.dialog(CustomLoader(), barrierDismissible: false);
        await apiHelper.getMoreAmited(campaignId).then((response) {
          //Get.back();
          if (response.status == "1") {
            _seeMoreAdmitedList = response.data;
          } else {
            showCustomSnackBar(response.message);
          }
        });
      } else {
        showCustomSnackBar(AppConstants.NO_INTERNET);
      }
      update();
    } catch (e) {
      print(
          "Exception - HomeController.dart - getMoreAdmited():" + e.toString());
    }
  }

  Future getProducts() async {
    try {
      isProductsLoaded = false;
      if (networkController.connectionStatus.value == 1 ||
          networkController.connectionStatus.value == 2) {
        //Get.dialog(CustomLoader(), barrierDismissible: false);
        await apiHelper.getProducts().then((response) {
          //Get.back();
          if (response.status == "1") {
            _productList = response.data;
          } else {
            showCustomSnackBar(response.message);
          }
        });
      } else {
        showCustomSnackBar(AppConstants.NO_INTERNET);
      }
      isProductsLoaded = true;
      update();
    } catch (e) {
      print("Exception - HomeController.dart - getProducts():" + e.toString());
    }
  }

  Future getTrendingProducts() async {
    try {
      if (networkController.connectionStatus.value == 1 ||
          networkController.connectionStatus.value == 2) {
        //Get.dialog(CustomLoader(), barrierDismissible: false);
        await apiHelper.getTrendingProducts().then((response) {
          //Get.back();
          if (response.status == "1") {
            _trendingProductList = response.data;
          } else {
            showCustomSnackBar(response.message);
          }
        });
      } else {
        showCustomSnackBar(AppConstants.NO_INTERNET);
      }
      isTrendingProductsLoaded = true;
      update();
    } catch (e) {
      print("Exception - HomeController.dart - getTrendingProducts():" +
          e.toString());
    }
  }
}
