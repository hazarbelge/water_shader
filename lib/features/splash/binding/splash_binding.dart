import "package:get/get.dart";
import 'package:water_shader/features/splash/index.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(
      SplashController(),
    );
  }
}
