import 'package:get/get.dart';
import 'package:water_shader/core/base/index.dart';
import 'package:water_shader/core/utils/index.dart';
import 'package:water_shader/routes/index.dart';

class SplashController extends BaseSuperController<dynamic> {
  SplashController() : super();

  @override
  Future<void> onReady() async {
    super.onReady();
    TranslationUtil.setLocale();
    Get.offAllNamed(AppRoutes.HOME);
  }
}
