import 'package:get/get.dart';
import 'package:random_quote_generator/core/connectivity/network_controller.dart';


class DependencyInjection {

  static void init() {
    Get.put<NetworkController>(NetworkController(),permanent:true);
  }
}