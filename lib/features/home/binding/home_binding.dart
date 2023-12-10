import "package:get/get.dart";
import 'package:water_shader/features/home/index.dart';
import 'package:water_shader/features/home/tabs/shader/index.dart';
import 'package:water_shader/features/home/tabs/view/index.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => HomeController(),
    );
    Get.lazyPut(
      () => ShaderTabController(),
    );
    Get.lazyPut(
      () => ViewTabController(),
    );
  }
}
