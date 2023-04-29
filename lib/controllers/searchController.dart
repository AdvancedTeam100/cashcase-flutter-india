import 'dart:convert';

import 'package:cashfuse/constants/appConstant.dart';
import 'package:cashfuse/controllers/networkController.dart';
import 'package:cashfuse/models/allInOneSearchDataModel.dart';
import 'package:cashfuse/models/commonModel.dart';
import 'package:cashfuse/models/searchDataModel.dart';
import 'package:cashfuse/models/searchKeyWordModel.dart';
import 'package:cashfuse/services/apiHelper.dart';
import 'package:cashfuse/utils/global.dart' as global;
import 'package:cashfuse/widget/customLoader.dart';
import 'package:cashfuse/widget/customSnackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchController extends GetxController {
  APIHelper apiHelper = new APIHelper();
  NetworkController networkController = Get.find<NetworkController>();

  var searchString = new TextEditingController();

  List<AllInOneSearchDataModel> _allInOneList = [];
  List<AllInOneSearchDataModel> get allInOneList => _allInOneList;

  List<SearchKeyWordModel> _searchKeywordList = [];
  List<SearchKeyWordModel> get searchKeywordList => _searchKeywordList;

  List<AllInOneSearchDataModel> addNewTabList2;
  List<AllInOneSearchDataModel> addNewTabList;

  List<AllInOneSearchDataModel> selctedList = [];

  SearchDataModel searchData;

  @override
  void onInit() async {
    await getTrendingKeywords();
    // await allInOneSearch();
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future getSearchData(String keyword) async {
    try {
      searchString.text = keyword;
      if (networkController.connectionStatus.value == 1 || networkController.connectionStatus.value == 2) {
        Get.dialog(CustomLoader(), barrierDismissible: false);
        await apiHelper.search(keyword).then((response) {
          Get.back();
          if (response.status == "1") {
            searchData = response.data;
            if (searchData != null) {
              if (searchData.adsList != []) {
                for (var j = 0; j < searchData.adsList.length; j++) {
                  searchData.commonList.add(
                    CommonModel(
                      name: searchData.adsList[j].name,
                      image: '${global.appInfo.baseUrls.offerImageUrl}/${searchData.adsList[j].image}',
                      buttonText: searchData.adsList[j].buttonText,
                      trackingLink: searchData.adsList[j].landingPage,
                      adId: searchData.adsList[j].id.toString(),
                    ),
                  );
                }
              }

              if (searchData.campaignList != []) {
                for (var i = 0; i < searchData.campaignList.length; i++) {
                  searchData.commonList.add(
                    CommonModel(
                      name: searchData.campaignList[i].name,
                      image: '${global.appInfo.baseUrls.offerImageUrl}/${searchData.campaignList[i].image}',
                      buttonText: searchData.campaignList[i].buttonText,
                      trackingLink: searchData.campaignList[i].url,
                      campaignId: searchData.campaignList[i].id,
                    ),
                  );
                }
              }

              if (searchData.advertiserList != []) {
                for (var k = 0; k < searchData.advertiserList.length; k++) {
                  if (searchData.advertiserList[k].ads != []) {
                    for (var m = 0; m < searchData.advertiserList[k].ads.length; m++) {
                      searchData.advertiserList[k].commonList.add(
                        CommonModel(
                          name: searchData.advertiserList[k].ads[m].name,
                          image: '${global.appInfo.baseUrls.offerImageUrl}/${searchData.advertiserList[k].ads[m].image}',
                          buttonText: searchData.advertiserList[k].ads[m].buttonText,
                          trackingLink: searchData.advertiserList[k].ads[m].landingPage,
                          adId: searchData.advertiserList[k].ads[m].id.toString(),
                        ),
                      );
                    }
                  }

                  if (searchData.advertiserList[k].cuecampaigns != []) {
                    for (var n = 0; n < searchData.advertiserList[k].cuecampaigns.length; n++) {
                      searchData.advertiserList[k].commonList.add(
                        CommonModel(
                          name: searchData.advertiserList[k].cuecampaigns[n].name,
                          image: '${global.appInfo.baseUrls.offerImageUrl}/${searchData.advertiserList[k].cuecampaigns[n].image}',
                          buttonText: searchData.advertiserList[k].cuecampaigns[n].buttonText,
                          trackingLink: searchData.advertiserList[k].cuecampaigns[n].url,
                          campaignId: searchData.advertiserList[k].cuecampaigns[n].id,
                        ),
                      );
                    }
                  }
                }
              }

              // for (var n = 0; n < _topCategoryList.length; n++) {
              //   if (_topCategoryList[n].cuecampaigns != []) {
              //     for (var k = 0; k < _topCategoryList[n].cuecampaigns.length; k++) {
              //       _topCategoryList[n].commonList.add(
              //             CommonModel(
              //               name: _topCategoryList[n].cuecampaigns[k].name,
              //               image: _topCategoryList[n].cuecampaigns[k].image,
              //               buttonText: _topCategoryList[n].cuecampaigns[k].buttonText,
              //               trackingLink: _topCategoryList[n].cuecampaigns[k].url,
              //               campaignId: _topCategoryList[n].cuecampaigns[k].id,
              //             ),
              //           );
              //     }
              //   }
              // }
            }
          } else {
            showCustomSnackBar(response.message);
          }
        });
      } else {
        showCustomSnackBar(AppConstants.NO_INTERNET);
      }
      update();
    } catch (e) {
      print("Exception - SearchController.dart - getSearchData():" + e.toString());
    }
  }

  Future allInOneSearch() async {
    try {
      addNewTabList2 = [];
      addNewTabList = [];
      if (networkController.connectionStatus.value == 1 || networkController.connectionStatus.value == 2) {
        await apiHelper.allInOneSearch().then((response) {
          if (response.status == "1") {
            _allInOneList = response.data;
            //addNewTabList2.addAll(_allInOneList);
            if (_allInOneList.length >= 6) {
              addNewTabList.addAll(_allInOneList.sublist(0, 5));
              addNewTabList2.addAll(_allInOneList.sublist(0, 5));
              addNewTabList2.insert(
                5,
                AllInOneSearchDataModel(name: '+Add Tab'),
              );
            } else {
              addNewTabList.addAll(_allInOneList);
              addNewTabList2.addAll(_allInOneList);
            }

            // if (_allInOneList.length >= 6) {

            // }
            update();
          } else {
            showCustomSnackBar(response.message);
          }
        });
      } else {
        showCustomSnackBar(AppConstants.NO_INTERNET);
      }
      update();
    } catch (e) {
      print("Exception - SearchController.dart - allInOneSearch():" + e.toString());
    }
  }

  void addNewTab() {
    try {
      addNewTabList.add(AllInOneSearchDataModel(name: 'choose'));
      update();
    } catch (e) {
      print("Exception - SearchController.dart - addNewTab():" + e.toString());
    }
  }

  Future saveTab() async {
    try {
      addNewTabList2.removeWhere((element) => element.id == null);
      print('addNewTabList2 ------------------ ${addNewTabList2.length.toString()}');
      addNewTabList2 = List.from(addNewTabList);
      print('addNewTabList +++++++++++++ ${addNewTabList.length.toString()}');
      print('addNewTabList2 +++++++++++++ ${addNewTabList2.length.toString()}');
      //addNewTabList = List.from(addNewTabList2);
      // searchController.addNewTabList2.clear();
      // searchController.addNewTabList2.addAll(searchController.addNewTabList);
      // searchController.addNewTabList.clear();
      // searchController.addNewTabList.addAll(searchController.addNewTabList2);

      //global.sp.setString('tabList', searchController.addNewTabList.map((e) => e.toJson()).toString());

      addNewTabList2.insert(
        addNewTabList2.length,
        AllInOneSearchDataModel(name: '+Add Tab'),
      );

      global.sp.setString('tabList', jsonEncode(addNewTabList2.map((i) => i.toJson()).toList()).toString());
    } catch (e) {
      print("Exception - SearchController.dart - saveTab():" + e.toString());
    }
  }

  Future getTrendingKeywords() async {
    try {
      if (networkController.connectionStatus.value == 1 || networkController.connectionStatus.value == 2) {
        await apiHelper.getTrendingKeywords().then((response) {
          if (response.statusCode == 200) {
            _searchKeywordList = response.data;
          } else {
            showCustomSnackBar(response.message);
          }
        });
      } else {
        showCustomSnackBar(AppConstants.NO_INTERNET);
      }
      update();
    } catch (e) {
      print("Exception - SearchController.dart - getTrendingKeywords():" + e.toString());
    }
  }
}
