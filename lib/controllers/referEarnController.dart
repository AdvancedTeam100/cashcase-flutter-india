import 'package:cashfuse/constants/appConstant.dart';
import 'package:cashfuse/controllers/networkController.dart';
import 'package:cashfuse/models/referralUserModel.dart';
import 'package:cashfuse/services/apiHelper.dart';
import 'package:cashfuse/widget/customSnackbar.dart';
import 'package:get/get.dart';
import 'package:cashfuse/utils/global.dart' as global;

class ReferEarnController extends GetxController {
  APIHelper apiHelper = new APIHelper();
  NetworkController networkController = Get.find<NetworkController>();

  List<ReferralUserModel> _referralUserList = [];
  List<ReferralUserModel> get referralUserList => _referralUserList;

  bool isDataLoaded = false;

  @override
  void onInit() async {
    if (!GetPlatform.isWeb) {
      await global.referAndEarn();
    }

    await getReferralUsers();
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future getReferralUsers() async {
    try {
      isDataLoaded = false;
      if (networkController.connectionStatus.value == 1 || networkController.connectionStatus.value == 2) {
        await apiHelper.getReferralUsers().then((response) {
          if (response.statusCode == 200) {
            _referralUserList = response.data;
          } else {
            showCustomSnackBar(response.message);
          }
        });
      } else {
        showCustomSnackBar(AppConstants.NO_INTERNET);
      }
      isDataLoaded = true;
      update();
    } catch (e) {
      print("Exception - referEarnController.dart - getReferralUsers():" + e.toString());
    }
  }
}
