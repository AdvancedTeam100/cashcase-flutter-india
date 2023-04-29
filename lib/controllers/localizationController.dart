import 'package:get/get.dart';
import 'package:cashfuse/controllers/networkController.dart';

class LocalizationController extends GetxController {
  NetworkController networkController = Get.put(NetworkController());

  @override
  void onInit() async {
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
