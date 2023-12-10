import "package:get/get.dart";
import 'package:water_shader/features/home/index.dart';
import 'package:water_shader/features/splash/index.dart';
import 'package:water_shader/routes/index.dart';

class AppPages {
  static final List<GetPage<dynamic>> routes = <GetPage<dynamic>>[
    GetPage<SplashScreen>(
      name: AppRoutes.SPLASH,
      page: () => const SplashScreen(),
      binding: SplashBinding(),
      preventDuplicates: true,
    ),
    GetPage<HomeScreen>(
      name: AppRoutes.HOME,
      page: () => const HomeScreen(),
      binding: HomeBinding(),
      preventDuplicates: true,
    ),
  ];
}
