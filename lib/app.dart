import "package:flutter/cupertino.dart";
import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:flutter_localizations/flutter_localizations.dart";
import "package:get/get.dart";
import "package:responsive_framework/responsive_framework.dart";
import 'package:water_shader/core/app/strings.dart';
import 'package:water_shader/core/theme/index.dart';
import 'package:water_shader/core/utils/index.dart';
import 'package:water_shader/routes/index.dart';
import 'package:water_shader/ui/widgets/custom_widgets/index.dart';

class WaterShaderApp extends StatelessWidget {
  const WaterShaderApp({super.key});

  static GlobalKey waterShaderAppKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        KeyboardUtil.hideKeyboard(context);
      },
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        key: waterShaderAppKey,
        title: AppStrings.appName,
        theme: Style.lightTheme,
        darkTheme: Style.darkTheme,
        themeMode: ThemeMode.light,
        translations: TranslationUtil.instance,
        locale: TranslationUtil.locale,
        fallbackLocale: TranslationUtil.fallbackLocale,
        localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
          GlobalMaterialLocalizations.delegate,
          DefaultMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          DefaultCupertinoLocalizations.delegate,
        ],
        supportedLocales: const <Locale>[
          Locale("tr"),
          Locale("en"),
        ],
        getPages: AppPages.routes,
        initialRoute: AppRoutes.SPLASH,
        builder: (BuildContext context, Widget? widget) {
          ErrorWidget.builder = (FlutterErrorDetails errorDetails) {
            return CustomErrorScreen(errorDetails: errorDetails);
          };
          final MediaQueryData mediaQueryData = MediaQuery.of(context);
          return MediaQuery(
            data: mediaQueryData.copyWith(
              platformBrightness: Brightness.light,
              alwaysUse24HourFormat: true,
              textScaler: TextScaler.noScaling,
              boldText: false,
            ),
            child: ResponsiveWrapper.builder(
              ClampingScrollWrapper.builder(context, widget!),
              maxWidth: 2460,
              minWidth: 450,
              defaultScale: true,
              breakpoints: const <ResponsiveBreakpoint>[
                ResponsiveBreakpoint.resize(450, name: MOBILE),
                ResponsiveBreakpoint.autoScale(800, name: TABLET),
                ResponsiveBreakpoint.autoScale(1000, name: TABLET),
                ResponsiveBreakpoint.resize(1200, name: DESKTOP),
                ResponsiveBreakpoint.autoScale(2460, name: "4K"),
              ],
              background: Container(
                color: ThemeColors.backgroundColor,
              ),
            ),
          );
        },
        enableLog: kDebugMode,
        logWriterCallback: (String text, {bool isError = false}) {
          debugPrint("GetXLog: $text");
        },
        navigatorObservers: <NavigatorObserver>[
          GetObserver(),
        ],
      ),
    );
  }
}
