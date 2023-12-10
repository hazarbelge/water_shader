import "package:flutter/material.dart";
import "package:flutter_svg/flutter_svg.dart";
import "package:get/get.dart";
import 'package:water_shader/core/theme/index.dart';
import 'package:water_shader/core/utils/index.dart';
import 'package:water_shader/features/splash/index.dart';
import 'package:water_shader/ui/widgets/custom_widgets/index.dart';

class SplashScreen extends GetView<SplashController> {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const CustomScaffold(
      key: Key("splash_screen_scaffold"),
      colors: <Color>[
        ThemeColors.secondaryColor,
        ThemeColors.primaryColor,
      ],
      child: Center(
        key: Key("splash_screen_center_widget"),
        child: SplashScreenLogo(
          key: Key("splash_screen_logo_widget"),
        ),
      ),
    );
  }
}

class SplashScreenLogo extends StatelessWidget {
  const SplashScreenLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Center(
        child: Builder(
          builder: (BuildContext context) {
            return SizedBox(
              height: 225,
              width: 250,
              child: SvgPicture.asset(GlobalVariables.media.appIconPath),
            );
          },
        ),
      ),
    );
  }
}
