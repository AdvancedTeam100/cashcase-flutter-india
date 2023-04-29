import 'package:cashfuse/constants/appConstant.dart';
import 'package:cashfuse/controllers/networkController.dart';
import 'package:cashfuse/models/faqModel.dart';
import 'package:cashfuse/services/apiHelper.dart';
import 'package:cashfuse/widget/customSnackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CommonController extends GetxController with GetTickerProviderStateMixin {
  APIHelper apiHelper = new APIHelper();
  NetworkController networkController = Get.find<NetworkController>();
  List<FaqModel> _faqList = [];
  List<FaqModel> _mainFaqList = [];
  List<FaqModel> get faqList => _faqList;
  String aboutUs = '';
  String privacyPolicy = '';

  TabController tabController;

  var searchString = TextEditingController();

  bool isfaqLoaded = false;
  bool isSearch = false;

  @override
  void onInit() async {
    tabController = TabController(length: 2, vsync: this);
    await getFaqs();
    await getAboutUs();
    await getPrivacyPolicy();
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }

  setTabIndex(int index) {
    tabController.index = index;
    update();
  }

  Future getFaqs() async {
    try {
      if (networkController.connectionStatus.value == 1 || networkController.connectionStatus.value == 2) {
        await apiHelper.getFaqs().then((response) {
          if (response.status == "1") {
            _faqList = response.data;
            _mainFaqList = response.data;
            update();
          } else {
            showCustomSnackBar(response.message);
          }
        });
      } else {
        showCustomSnackBar(AppConstants.NO_INTERNET);
      }
      isfaqLoaded = true;
      update();
    } catch (e) {
      print("Exception - CommonController.dart - getFaqs():" + e.toString());
    }
  }

  void searchShow(bool val) {
    try {
      isSearch = val;
      update();
      if (isSearch) {
        faqLocalSearch();
      } else {
        searchString.clear();
      }
    } catch (e) {
      print("Exception - CommonController.dart - searchShow():" + e.toString());
    }
  }

  void faqLocalSearch() {
    try {
      isfaqLoaded = false;
      update();
      if (searchString.text.trim().isEmpty) {
        _faqList = List.from(_mainFaqList);
      } else {
        if (_mainFaqList.length > 0) {
          _faqList = List.from(
            _mainFaqList
                .where((e) => ((e.ques.isNotEmpty &&
                        e.ques.toLowerCase().split(' ').toString().split('?').toString().contains(
                              searchString.text.trim().toLowerCase(),
                            )) ||
                    (e.ans.isNotEmpty &&
                        e.ans.toLowerCase().split(' ').toString().split('?').toString().contains(
                              searchString.text.trim().toLowerCase(),
                            ))))
                .toList(),
          );
        }
      }
      isfaqLoaded = true;
      update();
    } catch (e) {
      print("Exception - CommonController.dart - faqLocalSearch():" + e.toString());
    }
  }

  Future getAboutUs() async {
    try {
      if (networkController.connectionStatus.value == 1 || networkController.connectionStatus.value == 2) {
        await apiHelper.getAboutUs().then((response) {
          if (response.status == "1") {
            aboutUs = response.data;
            update();
          } else {
            showCustomSnackBar(response.message);
          }
        });
      } else {
        showCustomSnackBar(AppConstants.NO_INTERNET);
      }
    } catch (e) {
      print("Exception - CommonController.dart - getAboutUs():" + e.toString());
    }
  }

  Future getPrivacyPolicy() async {
    try {
      if (networkController.connectionStatus.value == 1 || networkController.connectionStatus.value == 2) {
        await apiHelper.getPrivacyPolicy().then((response) {
          if (response.status == "1") {
            privacyPolicy = response.data;
            update();
          } else {
            showCustomSnackBar(response.message);
          }
        });
      } else {
        showCustomSnackBar(AppConstants.NO_INTERNET);
      }
    } catch (e) {
      print("Exception - CommonController.dart - getPrivacyPolicy():" + e.toString());
    }
  }
}
