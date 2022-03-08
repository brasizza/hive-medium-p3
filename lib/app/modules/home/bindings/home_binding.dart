import 'package:get/get.dart';
import 'package:hive_tutorial/app/modules/home/controllers/hive_controller.dart';

import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
    Get.lazyPut<HiveController>(
      () => HiveController(),
    );
  }
}
