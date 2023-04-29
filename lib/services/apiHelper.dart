import 'dart:developer';
import 'dart:io';

import 'package:cashfuse/constants/appConstant.dart';
import 'package:cashfuse/models/admitedoffersModal.dart';
import 'package:cashfuse/models/admobSettingModel.dart';
import 'package:cashfuse/models/adsModel.dart';
import 'package:cashfuse/models/allInOneSearchDataModel.dart';
import 'package:cashfuse/models/appInfoModel.dart';
import 'package:cashfuse/models/bankDetailsModel.dart';
import 'package:cashfuse/models/bannerModel.dart';
import 'package:cashfuse/models/campaignModel.dart';
import 'package:cashfuse/models/categoryModel.dart';
import 'package:cashfuse/models/clickModel.dart';
import 'package:cashfuse/models/complainModel.dart';
import 'package:cashfuse/models/couponModel.dart';
import 'package:cashfuse/models/faqModel.dart';
import 'package:cashfuse/models/offerModel.dart';
import 'package:cashfuse/models/orderModel.dart';
import 'package:cashfuse/models/paymentHistoryModel.dart';
import 'package:cashfuse/models/productModel.dart';
import 'package:cashfuse/models/referralUserModel.dart';
import 'package:cashfuse/models/searchDataModel.dart';
import 'package:cashfuse/models/searchKeyWordModel.dart';
import 'package:cashfuse/models/userModel.dart';
import 'package:cashfuse/services/dioResult.dart';
import 'package:cashfuse/utils/global.dart' as global;
import 'package:dio/dio.dart';
import 'package:get/get.dart' as getx;
import 'package:http_parser/http_parser.dart';

class APIHelper {
  dynamic getDioResult<T>(final response, T recordList) {
    try {
      dynamic result;
      result = DioResult.fromJson(response, recordList);
      return result;
    } catch (e) {
      print("Exception - getDioResult():" + e.toString());
    }
  }

  Future<dynamic> getAppInfo() async {
    try {
      Response response;
      var dio = Dio();
      response = await dio.get('${global.baseUrl}${AppConstants.APP_INFO_URI}',
          options: Options(
            headers: await global.getApiHeaders(false),
          ));

      dynamic recordList;
      if (response.statusCode == 200) {
        recordList = AppInfo.fromJson(response.data);
      } else {
        recordList = null;
      }
      print(
          '====> API Response: [${response.statusCode}] ${global.baseUrl}${AppConstants.APP_INFO_URI}\n${response.data}');
      return getDioResult(response, recordList);
    } catch (e) {
      print("Exception -  apiHelper.dart - getAppInfo():" + e.toString());
    }
  }

  Future<dynamic> getAdmobSettings() async {
    try {
      Response response;
      var dio = Dio();
      response =
          await dio.get('${global.baseUrl}${AppConstants.ADMOB_SETTING_URI}',
              options: Options(
                headers: await global.getApiHeaders(false),
              ));

      dynamic recordList;
      if (response.statusCode == 200) {
        recordList = AdmobSettingModel.fromJson(response.data['data']);
      } else {
        recordList = null;
      }
      print(
          '====> API Response: [${response.statusCode}] ${global.baseUrl}${AppConstants.ADMOB_SETTING_URI}\n${response.data}');
      return getDioResult(response, recordList);
    } catch (e) {
      print("Exception -  apiHelper.dart - getAdmobSettings():" + e.toString());
    }
  }

  Future<dynamic> getFaceBookAdSetting() async {
    try {
      Response response;
      var dio = Dio();
      response = await dio.get(
          '${global.baseUrl}${AppConstants.FACEBOOK_ADS_SETTING_URI}',
          options: Options(
            headers: await global.getApiHeaders(false),
          ));

      dynamic recordList;
      if (response.statusCode == 200) {
        recordList = AdmobSettingModel.fromJson(response.data['data']);
      } else {
        recordList = null;
      }
      print(
          '====> API Response: [${response.statusCode}] ${global.baseUrl}${AppConstants.FACEBOOK_ADS_SETTING_URI}\n${response.data}');
      return getDioResult(response, recordList);
    } catch (e) {
      print("Exception -  apiHelper.dart - getFaceBookAdSetting():" +
          e.toString());
    }
  }

  Future<dynamic> socialLogin(UserModel user) async {
    try {
      Response response;
      var dio = Dio();
      var formData = FormData.fromMap({
        'device_id': global.appDeviceId,
        'name': user.name,
        'email': user.email,
        'image': user.userImage,
        'type': user.loginType,
        'social_id': user.socialId,
      });
      response =
          await dio.post('${global.baseUrl}${AppConstants.SOCIAL_LOGIN_URI}',
              data: formData,
              options: Options(
                headers: await global.getApiHeaders(false),
              ));

      dynamic recordList;
      if (response.statusCode == 200) {
        recordList = UserModel.fromJson(response.data['user']);
        recordList.token = response.data["token"];
      } else {
        recordList = null;
      }
      print(
          '====> API Response: [${response.statusCode}] ${global.baseUrl}${AppConstants.SOCIAL_LOGIN_URI}\n${response.data}');
      return getDioResult(response, recordList);
    } catch (e) {
      print("Exception -  apiHelper.dart - socialLogin():" + e.toString());
    }
  }

  Future<dynamic> loginOrRegister(String phone) async {
    try {
      Response response;
      var dio = Dio();
      var formData = FormData.fromMap({
        'phone': phone,
        'device_id': global.appDeviceId,
      });

      response =
          await dio.post('${global.baseUrl}${AppConstants.LOGIN_RESGISTER}',
              data: formData,
              options: Options(
                headers: await global.getApiHeaders(false),
              ));

      dynamic recordList;
      if (response.statusCode == 200) {
      } else {
        recordList = null;
      }
      print(
          '====> API Response: [${response.statusCode}] ${global.baseUrl}${AppConstants.LOGIN_RESGISTER}\n${response.data}');
      return getDioResult(response, recordList);
    } catch (e) {
      print("Exception -  apiHelper.dart - loginOrRegister():" + e.toString());
    }
  }

  Future<dynamic> loginWithEmail(String email) async {
    try {
      Response response;
      var dio = Dio();
      var formData = FormData.fromMap({
        'email': email,
        'device_id': global.appDeviceId,
      });

      response = await dio.post(
          '${global.baseUrl}${AppConstants.LOGIN_WITH_EMAIL_URI}',
          data: formData,
          options: Options(
            headers: await global.getApiHeaders(false),
          ));

      dynamic recordList;
      if (response.statusCode == 200) {
      } else {
        recordList = null;
      }
      print(
          '====> API Response: [${response.statusCode}] ${global.baseUrl}${AppConstants.LOGIN_RESGISTER}\n${response.data}');
      return getDioResult(response, recordList);
    } catch (e) {
      print("Exception -  apiHelper.dart - loginWithEmail():" + e.toString());
    }
  }

  Future<dynamic> verifyOtp(String phone, String status) async {
    try {
      Response response;
      var dio = Dio();

      var formData = FormData.fromMap({
        'phone': phone,
        'otp': status,
        'device_id': global.appDeviceId,
        if (global.referralUserId.isNotEmpty)
          'referral_user_id': global.referralUserId,
      });
      response = await dio.post('${global.baseUrl}${AppConstants.VERIFY_OTP}',
          data: formData,
          options: Options(
            headers: await global.getApiHeaders(false),
          ));

      dynamic recordList;
      if (response.statusCode == 200) {
        recordList = UserModel.fromJson(response.data['user']);
        recordList.token = response.data["token"];
      } else {
        recordList = null;
      }
      print(
          '====> API Response: [${response.statusCode}] ${global.baseUrl}${AppConstants.VERIFY_OTP}\n${response.data}');
      return getDioResult(response, recordList);
    } catch (e) {
      print("Exception -  apiHelper.dart - verifyOtp():" + e.toString());
    }
  }

  Future<dynamic> verifyEmail(String email, String otp) async {
    try {
      Response response;
      var dio = Dio();

      var formData = FormData.fromMap({
        'email': email,
        'otp': otp,
        'device_id': global.appDeviceId,
        if (global.referralUserId.isNotEmpty)
          'referral_user_id': global.referralUserId,
      });
      response = await dio.post('${global.baseUrl}${AppConstants.VERIFY_EMAIL}',
          data: formData,
          options: Options(
            headers: await global.getApiHeaders(false),
          ));

      dynamic recordList;
      if (response.statusCode == 200) {
        recordList = UserModel.fromJson(response.data['user']);
        recordList.token = response.data["token"];
      } else {
        recordList = null;
      }
      print(
          '====> API Response: [${response.statusCode}] ${global.baseUrl}${AppConstants.VERIFY_EMAIL}\n${response.data}');
      return getDioResult(response, recordList);
    } catch (e) {
      print("Exception -  apiHelper.dart - verifyEmail():" + e.toString());
    }
  }

  Future<dynamic> getTopCategories(int page) async {
    try {
      Response response;
      var dio = Dio();
      response = await dio.get(
          '${global.baseUrl}${AppConstants.CAEGORY_URI}?page=$page',
          options: Options(
            headers: await global.getApiHeaders(false),
          ));

      dynamic recordList;
      if (response.statusCode == 200) {
        recordList = List<CategoryModel>.from(
            response.data['data'].map((x) => CategoryModel.fromJson(x)));
      } else {
        recordList = null;
      }
      print(
          '====> API Response: [${response.statusCode}] ${global.baseUrl}${AppConstants.CAEGORY_URI}\n${response.data}');
      return getDioResult(response, recordList);
    } catch (e) {
      print("Exception -  apiHelper.dart - getTopCategories():" + e.toString());
    }
  }

  Future<dynamic> getTopCashBack(int page) async {
    try {
      Response response;
      var dio = Dio();
      response = await dio.get(
          '${global.baseUrl}${AppConstants.CASHBACK_URI}?page=$page',
          options: Options(
            headers: await global.getApiHeaders(false),
          ));

      dynamic recordList;
      if (response.statusCode == 200) {
        recordList = List<CategoryModel>.from(
            response.data['data'].map((x) => CategoryModel.fromJson(x)));
      } else {
        recordList = null;
      }
      print(
          '====> API Response: [${response.statusCode}] ${global.baseUrl}${AppConstants.CASHBACK_URI}\n${response.data}');
      return getDioResult(response, recordList);
    } catch (e) {
      print("Exception -  apiHelper.dart - getTopCashBack():" + e.toString());
    }
  }

  Future<dynamic> getHomeAdv() async {
    try {
      Response response;
      var dio = Dio();
      response = await dio.get('${global.baseUrl}${AppConstants.HOME_ADV_URI}',
          options: Options(
            headers: await global.getApiHeaders(false),
          ));

      dynamic recordList;
      if (response.statusCode == 200) {
        recordList = List<CategoryModel>.from(
            response.data['data'].map((x) => CategoryModel.fromJson(x)));
      } else {
        recordList = null;
      }
      print(
          '====> API Response: [${response.statusCode}] ${global.baseUrl}${AppConstants.HOME_ADV_URI}\n${response.data}');
      return getDioResult(response, recordList);
    } catch (e) {
      print("Exception -  apiHelper.dart - getHomeAdv():" + e.toString());
    }
  }

  Future<dynamic> getAllAdv(int page) async {
    try {
      Response response;
      var dio = Dio();
      response =
          await dio.get('${global.baseUrl}${AppConstants.ALL_ADV}?page=$page',
              options: Options(
                headers: await global.getApiHeaders(false),
              ));

      dynamic recordList;
      if (response.statusCode == 200) {
        recordList = List<CategoryModel>.from(
            response.data['data'].map((x) => CategoryModel.fromJson(x)));
      } else {
        recordList = null;
      }
      print(
          '====> API Response: [${response.statusCode}] ${global.baseUrl}${AppConstants.ALL_ADV}\n${response.data}');
      return getDioResult(response, recordList);
    } catch (e) {
      print("Exception -  apiHelper.dart - getAllAdv():" + e.toString());
    }
  }

  Future<dynamic> getExclusiveOffers() async {
    try {
      Response response;
      var dio = Dio();
      response =
          await dio.get('${global.baseUrl}${AppConstants.EXCLUSIVE_OFFER_URI}',
              options: Options(
                headers: await global.getApiHeaders(false),
              ));

      dynamic recordList;
      if (response.statusCode == 200) {
        recordList = List<OfferModel>.from(
            response.data['data'].map((x) => OfferModel.fromJson(x)));
      } else {
        recordList = null;
      }
      print(
          '====> API Response: [${response.statusCode}] ${global.baseUrl}${AppConstants.EXCLUSIVE_OFFER_URI}\n${response.data}');
      return getDioResult(response, recordList);
    } catch (e) {
      print(
          "Exception -  apiHelper.dart - getExclusiveOffers():" + e.toString());
    }
  }

  Future<dynamic> getNewFlashOffers() async {
    try {
      Response response;
      var dio = Dio();
      response =
          await dio.get('${global.baseUrl}${AppConstants.NEW_FLASH_OFFER_URI}',
              options: Options(
                headers: await global.getApiHeaders(false),
              ));

      dynamic recordList;
      if (response.statusCode == 200) {
        recordList = List<OfferModel>.from(
            response.data['data'].map((x) => OfferModel.fromJson(x)));
      } else {
        recordList = null;
      }
      print(
          '====> API Response: [${response.statusCode}] ${global.baseUrl}${AppConstants.NEW_FLASH_OFFER_URI}\n${response.data}');
      return getDioResult(response, recordList);
    } catch (e) {
      print(
          "Exception -  apiHelper.dart - getNewFlashOffers():" + e.toString());
    }
  }

  Future<dynamic> getTopBanners() async {
    try {
      Response response;
      var dio = Dio();
      response = await dio.get('${global.baseUrl}${AppConstants.BANNER_URI}',
          options: Options(
            headers: await global.getApiHeaders(false),
          ));

      dynamic recordList;
      if (response.statusCode == 200) {
        recordList = List<BannerModel>.from(
            response.data['data'].map((x) => BannerModel.fromJson(x)));
      } else {
        recordList = null;
      }
      print(
          '====> API Response: [${response.statusCode}] ${global.baseUrl}${AppConstants.BANNER_URI}\n${response.data}');
      return getDioResult(response, recordList);
    } catch (e) {
      print("Exception -  apiHelper.dart - getTopBanners():" + e.toString());
    }
  }

  Future<dynamic> getAdDetails(String adId) async {
    try {
      Response response;
      var dio = Dio();
      response = await dio.get(
          '${global.baseUrl}${AppConstants.AD_DETAIL_URI}?ad_id=$adId',
          options: Options(
            headers: await global.getApiHeaders(false),
          ));

      dynamic recordList;
      if (response.statusCode == 200) {
        recordList = AdsModel.fromJson(response.data);
      } else {
        recordList = null;
      }
      print(
          '====> API Response: [${response.statusCode}] ${global.baseUrl}${AppConstants.AD_DETAIL_URI}\n${response.data}');
      return getDioResult(response, recordList);
    } catch (e) {
      print("Exception -  apiHelper.dart - getAdDetails():" + e.toString());
    }
  }

  Future<dynamic> getOfferDetails(String offerId) async {
    try {
      Response response;
      var dio = Dio();
      response = await dio.get(
          '${global.baseUrl}${AppConstants.OFEFER_DETAIL_URI}?offer_id=$offerId',
          options: Options(
            headers: await global.getApiHeaders(false),
          ));

      dynamic recordList;
      if (response.statusCode == 200) {
        recordList = OfferModel.fromJson(response.data);
      } else {
        recordList = null;
      }
      print(
          '====> API Response: [${response.statusCode}] ${global.baseUrl}${AppConstants.OFEFER_DETAIL_URI}\n${response.data}');
      return getDioResult(response, recordList);
    } catch (e) {
      print("Exception -  apiHelper.dart - getOfferDetails():" + e.toString());
    }
  }

  Future<dynamic> getCampignDetails(String campaignId) async {
    try {
      Response response;
      var dio = Dio();
      response = await dio.get(
          '${global.baseUrl}${AppConstants.CAMPAIGN_DETAIL_URI}?campaign_id=$campaignId',
          options: Options(
            headers: await global.getApiHeaders(false),
          ));

      dynamic recordList;
      if (response.statusCode == 200) {
        recordList = CampaignModel.fromJson(response.data);
      } else {
        recordList = null;
      }
      print(
          '====> API Response: [${response.statusCode}] ${global.baseUrl}${AppConstants.CAMPAIGN_DETAIL_URI}\n${response.data}');
      return getDioResult(response, recordList);
    } catch (e) {
      print(
          "Exception -  apiHelper.dart - getCampignDetails():" + e.toString());
    }
  }

  Future<dynamic> getCoupons() async {
    try {
      Response response;
      var dio = Dio();
      response = await dio.get('${global.baseUrl}${AppConstants.COUPON_URI}',
          options: Options(
            headers: await global.getApiHeaders(false),
          ));

      dynamic recordList;
      if (response.statusCode == 200) {
        recordList = List<Coupon>.from(
            response.data['data'].map((x) => Coupon.fromJson(x)));
      } else {
        recordList = null;
      }
      print(
          '====> API Response: [${response.statusCode}] ${global.baseUrl}${AppConstants.COUPON_URI}\n${response.data}');
      return getDioResult(response, recordList);
    } catch (e) {
      print("Exception -  apiHelper.dart - getCoupons():" + e.toString());
    }
  }

  Future<dynamic> getFaqs() async {
    try {
      Response response;
      var dio = Dio();
      response = await dio.get('${global.baseUrl}${AppConstants.FAQ_URI}',
          options: Options(
            headers: await global.getApiHeaders(false),
          ));

      dynamic recordList;
      if (response.statusCode == 200) {
        recordList = List<FaqModel>.from(
            response.data['data'].map((x) => FaqModel.fromJson(x)));
      } else {
        recordList = null;
      }
      print(
          '====> API Response: [${response.statusCode}] ${global.baseUrl}${AppConstants.FAQ_URI}\n${response.data}');
      return getDioResult(response, recordList);
    } catch (e) {
      print("Exception -  apiHelper.dart - getFaqs():" + e.toString());
    }
  }

  Future<dynamic> getAboutUs() async {
    try {
      Response response;
      var dio = Dio();
      response = await dio.get('${global.baseUrl}${AppConstants.ABOUT_US_URI}',
          options: Options(
            headers: await global.getApiHeaders(false),
          ));

      dynamic recordList;
      if (response.statusCode == 200) {
        recordList = response.data['data'];
      } else {
        recordList = null;
      }
      print(
          '====> API Response: [${response.statusCode}] ${global.baseUrl}${AppConstants.ABOUT_US_URI}\n${response.data}');
      return getDioResult(response, recordList);
    } catch (e) {
      print("Exception -  apiHelper.dart - getAboutUs():" + e.toString());
    }
  }

  Future<dynamic> getPrivacyPolicy() async {
    try {
      Response response;
      var dio = Dio();
      response =
          await dio.get('${global.baseUrl}${AppConstants.PRIVACY_POLICY_URI}',
              options: Options(
                headers: await global.getApiHeaders(false),
              ));

      dynamic recordList;
      if (response.statusCode == 200) {
        recordList = response.data['data'];
      } else {
        recordList = null;
      }
      print(
          '====> API Response: [${response.statusCode}] ${global.baseUrl}${AppConstants.PRIVACY_POLICY_URI}\n${response.data}');
      return getDioResult(response, recordList);
    } catch (e) {
      print("Exception -  apiHelper.dart - getPrivacyPolicy():" + e.toString());
    }
  }

  Future<dynamic> getAccountDetails() async {
    try {
      Response response;
      var dio = Dio();
      response = await dio.get(
          '${global.baseUrl}${AppConstants.ACCOUNT_DETAILS_URI}?user_id=${global.currentUser.id}',
          options: Options(
            headers: await global.getApiHeaders(true),
          ));

      dynamic recordList;
      if (response.statusCode == 200) {
        recordList = BankDetailsModel.fromJson(response.data['data']);
      } else {
        recordList = null;
      }
      print(
          '====> API Response: [${response.statusCode}] ${global.baseUrl}${AppConstants.ACCOUNT_DETAILS_URI}\n${response.data}');
      return getDioResult(response, recordList);
    } catch (e) {
      print(
          "Exception -  apiHelper.dart - getAccountDetails():" + e.toString());
    }
  }

  Future<dynamic> addBankDetails(String acHolderName, String accountNo,
      String bankName, String ifscCode) async {
    try {
      Response response;
      var dio = Dio();
      var data = FormData.fromMap({
        'user_id': global.currentUser.id,
        'holder_name': acHolderName,
        'ac_no': accountNo,
        'bank_name': bankName,
        'ifsc': ifscCode,
      });
      response = await dio.post(
          '${global.baseUrl}${AppConstants.ADD_BANK_DETAILS_URI}',
          data: data,
          options: Options(
            headers: await global.getApiHeaders(true),
          ));

      dynamic recordList;
      if (response.statusCode == 200) {
        recordList = BankDetailsModel.fromJson(response.data['data']);
      } else {
        recordList = null;
      }
      print(
          '====> API Response: [${response.statusCode}] ${global.baseUrl}${AppConstants.ADD_BANK_DETAILS_URI}\n${response.data}');
      return getDioResult(response, recordList);
    } catch (e) {
      print("Exception -  apiHelper.dart - addBankDetails():" + e.toString());
    }
  }

  Future<dynamic> addAmazonPayDetails(String amazonNo) async {
    try {
      Response response;
      var dio = Dio();
      var data = FormData.fromMap({
        'user_id': global.currentUser.id,
        'amazon_no': amazonNo,
      });
      response = await dio.post(
          '${global.baseUrl}${AppConstants.ADD_AMAZON_DETAILS_URI}',
          data: data,
          options: Options(
            headers: await global.getApiHeaders(true),
          ));

      dynamic recordList;
      if (response.statusCode == 200) {
        recordList = BankDetailsModel.fromJson(response.data['data']);
      } else {
        recordList = null;
      }
      print(
          '====> API Response: [${response.statusCode}] ${global.baseUrl}${AppConstants.ADD_AMAZON_DETAILS_URI}\n${response.data}');
      return getDioResult(response, recordList);
    } catch (e) {
      print("Exception -  apiHelper.dart - addAmazonPayDetails():" +
          e.toString());
    }
  }

  Future<dynamic> addPayTMDetails(String paytmNo) async {
    try {
      Response response;
      var dio = Dio();
      var data = FormData.fromMap({
        'user_id': global.currentUser.id,
        'paytm_no': paytmNo,
      });
      response = await dio.post(
          '${global.baseUrl}${AppConstants.ADD_PAYTM_DETAILS_URI}',
          data: data,
          options: Options(
            headers: await global.getApiHeaders(true),
          ));

      dynamic recordList;
      if (response.statusCode == 200) {
        recordList = BankDetailsModel.fromJson(response.data['data']);
      } else {
        recordList = null;
      }
      print(
          '====> API Response: [${response.statusCode}] ${global.baseUrl}${AppConstants.ADD_PAYTM_DETAILS_URI}\n${response.data}');
      return getDioResult(response, recordList);
    } catch (e) {
      print("Exception -  apiHelper.dart - addPayTMDetails():" + e.toString());
    }
  }

  Future<dynamic> addUpiDetails(String upi) async {
    try {
      Response response;
      var dio = Dio();
      var data = FormData.fromMap({
        'user_id': global.currentUser.id,
        'upi': upi,
      });
      response =
          await dio.post('${global.baseUrl}${AppConstants.ADD_UPI_DETAILS_URI}',
              data: data,
              options: Options(
                headers: await global.getApiHeaders(true),
              ));

      dynamic recordList;
      if (response.statusCode == 200) {
        recordList = BankDetailsModel.fromJson(response.data['data']);
      } else {
        recordList = null;
      }
      print(
          '====> API Response: [${response.statusCode}] ${global.baseUrl}${AppConstants.ADD_UPI_DETAILS_URI}\n${response.data}');
      return getDioResult(response, recordList);
    } catch (e) {
      print("Exception -  apiHelper.dart - addUpiDetails():" + e.toString());
    }
  }

  Future<dynamic> addPayPalDetails(String payPalEmail) async {
    try {
      Response response;
      var dio = Dio();
      var data = FormData.fromMap({
        'user_id': global.currentUser.id,
        'paypal_email': payPalEmail,
      });
      response = await dio.post(
          '${global.baseUrl}${AppConstants.ADD_PAYPAL_DETAILS_URI}',
          data: data,
          options: Options(
            headers: await global.getApiHeaders(true),
          ));

      dynamic recordList;
      if (response.statusCode == 200) {
        recordList = BankDetailsModel.fromJson(response.data['data']);
      } else {
        recordList = null;
      }
      print(
          '====> API Response: [${response.statusCode}] ${global.baseUrl}${AppConstants.ADD_PAYPAL_DETAILS_URI}\n${response.data}');
      return getDioResult(response, recordList);
    } catch (e) {
      print("Exception -  apiHelper.dart - addPayPalDetails():" + e.toString());
    }
  }

  Future<dynamic> getTrackingLink(String url, String type, {String cId}) async {
    try {
      Response response;
      var dio = Dio();

      response = await dio.get(
        cId != null
            ? '${global.baseUrl}${AppConstants.TRACKING_LINK_URI}?user_id=${global.currentUser.id}&url=$url&type=$type&c_id=$cId'
            : '${global.baseUrl}${AppConstants.TRACKING_LINK_URI}?user_id=${global.currentUser.id}&url=$url&type=$type',
        options: Options(
          headers: await global.getApiHeaders(true),
        ),
      );

      log('${global.baseUrl}${AppConstants.TRACKING_LINK_URI}?user_id=${global.currentUser.id}&url=$url&type=$type&c_id=$cId +++++'
          '${global.baseUrl}${AppConstants.TRACKING_LINK_URI}?user_id=${global.currentUser.id}&url=$url&type=$type');

      dynamic recordList;
      if (response.statusCode == 200) {
        recordList = response.data['tracking_link'];
      } else {
        recordList = null;
      }
      print(
          '====> API Response: [${response.statusCode}] ${global.baseUrl}${AppConstants.TRACKING_LINK_URI}\n${response.data}');
      return getDioResult(response, recordList);
    } catch (e) {
      print("Exception -  apiHelper.dart - getTrackingLink():" + e.toString());
    }
  }

  Future<dynamic> search(String keyword) async {
    try {
      Response response;
      var dio = Dio();
      var formData = FormData.fromMap({'keyword': keyword});
      response = await dio.post(
        '${global.baseUrl}${AppConstants.SEARCH_URI}',
        data: formData,
        options: Options(headers: await global.getApiHeaders(false)),
      );

      dynamic recordList;
      if (response.statusCode == 200) {
        recordList = SearchDataModel.fromJson(response.data);
      } else {
        recordList = null;
      }
      print(
          '====> API Response: [${response.statusCode}] ${global.baseUrl}${AppConstants.SEARCH_URI}\n${response.data}');
      return getDioResult(response, recordList);
    } catch (e) {
      print("Exception -  apiHelper.dart - search():" + e.toString());
    }
  }

  Future<dynamic> addClick(
      String name, String image, String trackingLink) async {
    try {
      Response response;
      var dio = Dio();
      var formData = FormData.fromMap({
        'user_id': global.currentUser.id,
        'name': name,
        'image': image,
        'tracking_link': trackingLink,
      });
      response = await dio.post(
        '${global.baseUrl}${AppConstants.ADD_CLICK_URI}',
        data: formData,
        options: Options(headers: await global.getApiHeaders(true)),
      );

      dynamic recordList;
      if (response.statusCode == 200) {
      } else {
        recordList = null;
      }
      print(
          '====> API Response: [${response.statusCode}] ${global.baseUrl}${AppConstants.ADD_CLICK_URI}\n${response.data}');
      return getDioResult(response, recordList);
    } catch (e) {
      print("Exception -  apiHelper.dart - search():" + e.toString());
    }
  }

  Future<dynamic> getClick() async {
    try {
      Response response;
      var dio = Dio();

      response = await dio.get(
        '${global.baseUrl}${AppConstants.GET_CLICK_URI}?user_id=${global.currentUser.id}',
        options: Options(headers: await global.getApiHeaders(true)),
      );

      dynamic recordList;
      if (response.statusCode == 200) {
        recordList = List<ClickModel>.from(
            response.data['data'].map((x) => ClickModel.fromJson(x)));
      } else {
        recordList = null;
      }
      print(
          '====> API Response: [${response.statusCode}] ${global.baseUrl}${AppConstants.GET_CLICK_URI}\n${response.data}');
      return getDioResult(response, recordList);
    } catch (e) {
      print("Exception -  apiHelper.dart - getClick():" + e.toString());
    }
  }

  Future<dynamic> updateProfile(
      String name, String phone, String email, File userImage) async {
    try {
      Response response;
      var dio = Dio();
      var formData = FormData.fromMap({
        'user_id': global.currentUser.id,
        'name': name,
        'phone': phone,
        'email': email,
        if (userImage != null && userImage.path.isNotEmpty)
          "user_profile": getx.GetPlatform.isWeb
              ? MultipartFile.fromString(userImage.path)
              : await MultipartFile.fromFile(
                  userImage.path,
                  contentType: new MediaType("image", "jpeg"),
                ),
      });
      response = await dio.post(
        '${global.baseUrl}${AppConstants.UPDATE_PROFILE_URI}',
        data: formData,
        options: Options(headers: await global.getApiHeaders(true)),
      );

      dynamic recordList;
      if (response.statusCode == 200) {
        recordList = UserModel.fromJson(response.data['data']);
      } else {
        recordList = null;
      }
      print(
          '====> API Response: [${response.statusCode}] ${global.baseUrl}${AppConstants.UPDATE_PROFILE_URI}\n${response.data}');
      return getDioResult(response, recordList);
    } catch (e) {
      print("Exception -  apiHelper.dart - updateProfile():" + e.toString());
    }
  }

  Future<dynamic> allInOneSearch() async {
    try {
      Response response;
      var dio = Dio();
      response = await dio.get(
          global.currentUser.id != null
              ? '${global.baseUrl}${AppConstants.ALL_IN_ONE_URI}?user_id=${global.currentUser.id}'
              : '${global.baseUrl}${AppConstants.ALL_IN_ONE_URI}',
          options: Options(
            headers: await global.getApiHeaders(false),
          ));

      dynamic recordList;
      if (response.statusCode == 200) {
        recordList = List<AllInOneSearchDataModel>.from(response.data['data']
            .map((x) => AllInOneSearchDataModel.fromJson(x)));
      } else {
        recordList = null;
      }
      print(
          '====> API Response: [${response.statusCode}] ${global.baseUrl}${AppConstants.ALL_IN_ONE_URI}\n${response.data}');
      return getDioResult(response, recordList);
    } catch (e) {
      print("Exception -  apiHelper.dart - allInOneSearch():" + e.toString());
    }
  }

  Future<dynamic> getMoreCampaign(String campaignId) async {
    try {
      Response response;
      var dio = Dio();
      response = await dio.get(
          '${global.baseUrl}${AppConstants.MORE_CAMAPIGN_URI}?campaign_id=$campaignId',
          options: Options(
            headers: await global.getApiHeaders(false),
          ));

      dynamic recordList;
      if (response.statusCode == 200) {
        recordList = List<CampaignModel>.from(
            response.data['data'].map((x) => CampaignModel.fromJson(x)));
      } else {
        recordList = null;
      }
      print(
          '====> API Response: [${response.statusCode}] ${global.baseUrl}${AppConstants.MORE_CAMAPIGN_URI}\n${response.data}');
      return getDioResult(response, recordList);
    } catch (e) {
      print("Exception -  apiHelper.dart - getMoreCampaign():" + e.toString());
    }
  }

  Future<dynamic> getMoreOffers(String offerId) async {
    try {
      Response response;
      var dio = Dio();
      response = await dio.get(
          '${global.baseUrl}${AppConstants.MORE_OFFERS_URI}?offer_id=$offerId',
          options: Options(
            headers: await global.getApiHeaders(false),
          ));

      dynamic recordList;
      if (response.statusCode == 200) {
        recordList = List<OfferModel>.from(
            response.data['data'].map((x) => OfferModel.fromJson(x)));
      } else {
        recordList = null;
      }
      print(
          '====> API Response: [${response.statusCode}] ${global.baseUrl}${AppConstants.MORE_OFFERS_URI}\n${response.data}');
      return getDioResult(response, recordList);
    } catch (e) {
      print("Exception -  apiHelper.dart - getMoreOffers():" + e.toString());
    }
  }

  Future<dynamic> getMoreAds(String adsId) async {
    try {
      Response response;
      var dio = Dio();
      response = await dio.get(
          '${global.baseUrl}${AppConstants.MORE_ADS_URI}?ad_id=$adsId',
          options: Options(
            headers: await global.getApiHeaders(false),
          ));

      dynamic recordList;
      if (response.statusCode == 200) {
        recordList = List<AdsModel>.from(
            response.data['data'].map((x) => AdsModel.fromJson(x)));
      } else {
        recordList = null;
      }
      print(
          '====> API Response: [${response.statusCode}] ${global.baseUrl}${AppConstants.MORE_ADS_URI}\n${response.data}');
      return getDioResult(response, recordList);
    } catch (e) {
      print("Exception -  apiHelper.dart - getMoreAds():" + e.toString());
    }
  }

  Future<dynamic> myProfile() async {
    try {
      Response response;
      var dio = Dio();

      response = await dio.get(
        '${global.baseUrl}${AppConstants.MY_PROFILE_URI}?user_id=${global.currentUser.id}',
        options: Options(headers: await global.getApiHeaders(true)),
      );

      dynamic recordList;
      if (response.statusCode == 200) {
        recordList = UserModel.fromJson(response.data['data']);
      } else {
        recordList = null;
      }
      print(
          '====> API Response: [${response.statusCode}] ${global.baseUrl}${AppConstants.MY_PROFILE_URI}\n${response.data}');
      return getDioResult(response, recordList);
    } catch (e) {
      print("Exception -  apiHelper.dart - myProfile():" + e.toString());
    }
  }

  Future<dynamic> sendWithdrawalRequest(String medium) async {
    try {
      Response response;
      var dio = Dio();
      var formData = FormData.fromMap({
        'user_id': global.currentUser.id,
        'medium': medium,
      });
      response = await dio.post(
          '${global.baseUrl}${AppConstants.SEND_WITHDRAWAL_REQUEST_URI}',
          data: formData,
          options: Options(
            headers: await global.getApiHeaders(true),
          ));

      dynamic recordList;
      if (response.statusCode == 200) {
        recordList = response.data['data'];
      } else {
        recordList = null;
      }
      print(
          '====> API Response: [${response.statusCode}] ${global.baseUrl}${AppConstants.SEND_WITHDRAWAL_REQUEST_URI}\n${response.data}');
      return getDioResult(response, recordList);
    } catch (e) {
      print("Exception -  apiHelper.dart - sendWithdrawalRequest():" +
          e.toString());
    }
  }

  Future<dynamic> getPaymentHistory() async {
    try {
      Response response;
      var dio = Dio();

      response = await dio.get(
          '${global.baseUrl}${AppConstants.Payment_HISTORY_URI}?user_id=${global.currentUser.id}',
          options: Options(
            headers: await global.getApiHeaders(true),
          ));

      dynamic recordList;
      if (response.statusCode == 200) {
        recordList = List<PaymentHistoryModel>.from(
            response.data['data'].map((x) => PaymentHistoryModel.fromJson(x)));
      } else {
        recordList = null;
      }
      print(
          '====> API Response: [${response.statusCode}] ${global.baseUrl}${AppConstants.Payment_HISTORY_URI}\n${response.data}');
      return getDioResult(response, recordList);
    } catch (e) {
      print(
          "Exception -  apiHelper.dart - getPaymentHistory():" + e.toString());
    }
  }

  Future<dynamic> getOrders() async {
    try {
      Response response;
      var dio = Dio();
      response = await dio.get(
          '${global.baseUrl}${AppConstants.ORDER_HISTORY_URI}?user_id=${global.currentUser.id}',
          options: Options(
            headers: await global.getApiHeaders(true),
          ));

      dynamic recordList;
      if (response.statusCode == 200) {
        recordList = List<OrderModel>.from(
            response.data['data'].map((x) => OrderModel.fromJson(x)));
      } else {
        recordList = null;
      }
      print(
          '====> API Response: [${response.statusCode}] ${global.baseUrl}${AppConstants.ORDER_HISTORY_URI}\n${response.data}');
      return getDioResult(response, recordList);
    } catch (e) {
      print("Exception -  apiHelper.dart - getOrders():" + e.toString());
    }
  }

  Future<dynamic> getOrderComplains(int orderId) async {
    try {
      Response response;
      var dio = Dio();
      response = await dio.get(
          '${global.baseUrl}${AppConstants.GET_ORDER_COMPLAIN_URI}?order_id=$orderId',
          options: Options(
            headers: await global.getApiHeaders(true),
          ));

      dynamic recordList;
      if (response.statusCode == 200) {
        recordList = List<ComplainModel>.from(
            response.data['data'].map((x) => ComplainModel.fromJson(x)));
      } else {
        recordList = null;
      }
      print(
          '====> API Response: [${response.statusCode}] ${global.baseUrl}${AppConstants.GET_ORDER_COMPLAIN_URI}\n${response.data}');
      return getDioResult(response, recordList);
    } catch (e) {
      print(
          "Exception -  apiHelper.dart - getOrderComplains():" + e.toString());
    }
  }

  Future<dynamic> addOrderComplain(int orderId, String complain) async {
    try {
      Response response;
      var dio = Dio();
      var formData = FormData.fromMap({
        'user_id': global.currentUser.id,
        'order_id': orderId,
        'complain': complain,
      });
      response =
          await dio.post('${global.baseUrl}${AppConstants.ADD_COMPLAIN_URI}',
              data: formData,
              options: Options(
                headers: await global.getApiHeaders(true),
              ));

      dynamic recordList;
      if (response.statusCode == 200 && response.data['status'] == 1) {
        recordList = ComplainModel.fromJson(response.data['data']);
      } else if (response.statusCode == 200 && response.data['status'] == 0) {
        recordList = response.data['data'];
      } else {
        recordList = null;
      }
      print(
          '====> API Response: [${response.statusCode}] ${global.baseUrl}${AppConstants.ADD_COMPLAIN_URI}\n${response.data}');
      return getDioResult(response, recordList);
    } catch (e) {
      print("Exception -  apiHelper.dart - addOrderComplain():" + e.toString());
    }
  }

  Future<dynamic> getBannerNotification() async {
    try {
      Response response;
      var dio = Dio();
      response = await dio.get(
          '${global.baseUrl}${AppConstants.BANNER_NOTIFICATION_URI}',
          options: Options(
            headers: await global.getApiHeaders(false),
          ));

      dynamic recordList;
      if (response.statusCode == 200) {
        recordList = response.data['data'];
      } else {
        recordList = null;
      }
      print(
          '====> API Response: [${response.statusCode}] ${global.baseUrl}${AppConstants.BANNER_NOTIFICATION_URI}\n${response.data}');
      return getDioResult(response, recordList);
    } catch (e) {
      print("Exception -  apiHelper.dart - getBannerNotification():" +
          e.toString());
    }
  }

  Future<dynamic> deleteClicks() async {
    try {
      Response response;
      var dio = Dio();
      response = await dio.get(
          '${global.baseUrl}${AppConstants.DELETE_CLICK_URI}?user_id=${global.currentUser.id}',
          options: Options(
            headers: await global.getApiHeaders(true),
          ));

      dynamic recordList;
      if (response.statusCode == 200) {
        recordList = response.data['data'];
      } else {
        recordList = null;
      }
      print(
          '====> API Response: [${response.statusCode}] ${global.baseUrl}${AppConstants.DELETE_CLICK_URI}\n${response.data}');
      return getDioResult(response, recordList);
    } catch (e) {
      print("Exception -  apiHelper.dart - deleteClicks():" + e.toString());
    }
  }

  Future<dynamic> getReferralUsers() async {
    try {
      Response response;
      var dio = Dio();
      response = await dio.get(
          '${global.baseUrl}${AppConstants.REFERRAL_USERS_URI}?user_id=${global.currentUser.id}',
          options: Options(
            headers: await global.getApiHeaders(true),
          ));

      dynamic recordList;
      if (response.statusCode == 200) {
        recordList = List<ReferralUserModel>.from(
            response.data['data'].map((x) => ReferralUserModel.fromJson(x)));
        global.totalJoinedCount = response.data['count'];
      } else {
        recordList = null;
      }
      print(
          '====> API Response: [${response.statusCode}] ${global.baseUrl}${AppConstants.REFERRAL_USERS_URI}\n${response.data}');
      return getDioResult(response, recordList);
    } catch (e) {
      print("Exception -  apiHelper.dart - getReferralUsers():" + e.toString());
    }
  }

  Future<dynamic> getTrendingKeywords() async {
    try {
      Response response;
      var dio = Dio();
      response =
          await dio.get('${global.baseUrl}${AppConstants.TRENDING_KEYWORD}',
              options: Options(
                headers: await global.getApiHeaders(false),
              ));

      dynamic recordList;
      if (response.statusCode == 200) {
        recordList = List<SearchKeyWordModel>.from(
            response.data['data'].map((x) => SearchKeyWordModel.fromJson(x)));
      } else {
        recordList = null;
      }
      print(
          '====> API Response: [${response.statusCode}] ${global.baseUrl}${AppConstants.TRENDING_KEYWORD}\n${response.data}');
      return getDioResult(response, recordList);
    } catch (e) {
      print("Exception -  apiHelper.dart - getTrendingKeywords():" +
          e.toString());
    }
  }

  Future<dynamic> removeUserfromDb() async {
    try {
      Response response;
      var dio = Dio();
      response = await dio.get(
          '${global.baseUrl}${AppConstants.REMOVE_USER_FROM_DB_URI}',
          options: Options(
            headers: await global.getApiHeaders(true,
                userId: global.currentUser.id.toString()),
          ));

      dynamic recordList;
      if (response.statusCode == 200) {
        recordList = response.data['data'];
      } else {
        recordList = null;
      }
      print(
          '====> API Response: [${response.statusCode}] ${global.baseUrl}${AppConstants.REMOVE_USER_FROM_DB_URI}\n${response.data}');
      return getDioResult(response, recordList);
    } catch (e) {
      print("Exception -  apiHelper.dart - removeUserfromDb():" + e.toString());
    }
  }

  Future<dynamic> getAdmitedOfferDetails(int admitedId) async {
    try {
      Response response;
      var dio = Dio();
      response = await dio.get(
          '${global.baseUrl}${AppConstants.ADMITEDOFFERS_DETAIL}?id=$admitedId',
          options: Options(
            headers: await global.getApiHeaders(false),
          ));

      dynamic recordList;
      if (response.statusCode == 200) {
        recordList = AdmitedOffersModal.fromJson(response.data);
      } else {
        recordList = null;
      }
      print(
          '====> API Response: [${response.statusCode}] ${global.baseUrl}${AppConstants.ADMITEDOFFERS_DETAIL}\n${response.data}');
      return getDioResult(response, recordList);
    } catch (e) {
      print("Exception -  apiHelper.dart - getAdmitedOfferDetails():" +
          e.toString());
    }
  }

  Future<dynamic> getMoreAmited(String offerId) async {
    try {
      Response response;
      var dio = Dio();
      response = await dio.get(
          '${global.baseUrl}${AppConstants.MORE_ADMITED_OFFERS_URI}?id=$offerId',
          options: Options(
            headers: await global.getApiHeaders(false),
          ));

      dynamic recordList;
      if (response.statusCode == 200) {
        recordList = List<AdmitedOffersModal>.from(
            response.data['data'].map((x) => AdmitedOffersModal.fromJson(x)));
      } else {
        recordList = null;
      }
      print(
          '====> API Response: [${response.statusCode}] ${global.baseUrl}${AppConstants.MORE_ADMITED_OFFERS_URI}\n${response.data}');
      return getDioResult(response, recordList);
    } catch (e) {
      print("Exception -  apiHelper.dart - getMoreAmited():" + e.toString());
    }
  }

  Future<dynamic> getProducts() async {
    try {
      Response response;
      var dio = Dio();
      response =
          await dio.get('${global.baseUrl}${AppConstants.GET_PRODUCTS_URI}',
              options: Options(
                headers: await global.getApiHeaders(false),
              ));

      dynamic recordList;
      if (response.statusCode == 200) {
        recordList = List<ProductModel>.from(
            response.data['data'].map((x) => ProductModel.fromJson(x)));
      } else {
        recordList = null;
      }
      print(
          '====> API Response: [${response.statusCode}] ${global.baseUrl}${AppConstants.GET_PRODUCTS_URI}\n${response.data}');
      return getDioResult(response, recordList);
    } catch (e) {
      print("Exception -  apiHelper.dart - getProducts():" + e.toString());
    }
  }

  Future<dynamic> getTrendingProducts() async {
    try {
      Response response;
      var dio = Dio();
      response = await dio.get(
          '${global.baseUrl}${AppConstants.GET_TRENDING_PRODUCTS_URI}',
          options: Options(
            headers: await global.getApiHeaders(false),
          ));

      dynamic recordList;
      if (response.statusCode == 200) {
        recordList = List<ProductModel>.from(
            response.data['data'].map((x) => ProductModel.fromJson(x)));
      } else {
        recordList = null;
      }
      print(
          '====> API Response: [${response.statusCode}] ${global.baseUrl}${AppConstants.GET_TRENDING_PRODUCTS_URI}\n${response.data}');
      return getDioResult(response, recordList);
    } catch (e) {
      print("Exception -  apiHelper.dart - getTrendingProducts():" +
          e.toString());
    }
  }
}
