import "package:flutter/material.dart";
import 'package:flutter_svg/flutter_svg.dart';
import "package:get/get.dart";
import 'package:water_shader/core/theme/index.dart';
import "package:water_shader/features/home/index.dart";
import 'package:water_shader/features/home/tabs/shader/index.dart';
import 'package:water_shader/features/home/tabs/view/index.dart';
import 'package:water_shader/generated/assets.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  Color _getTabIconColor(BottomNavigationIndexRoutes _route) {
    return BottomNavigationIndexRoutes.values[controller.bottomNavigationIndex.value] == _route ? ThemeColors.secondaryColor : ThemeColors.secondaryColor.withOpacity(0.2);
  }

  @override
  Widget build(BuildContext context) {
    const double _iconSize = 36;

    const List<Widget> _homeTabs = <Widget>[
      ShaderTabScreen(),
      ViewTabScreen(),
    ];

    return PopScope(
      canPop: false,
      child: Obx(
        () => Scaffold(
          key: const Key("home_screen_scaffold"),
          bottomNavigationBar: SafeArea(
            child: SizedBox(
              height: 80,
              child: BottomNavigationBar(
                key: const Key("home_screen_scaffold_bottom_navigation_bar"),
                elevation: 0,
                showSelectedLabels: false,
                showUnselectedLabels: false,
                onTap: controller.onTapBottomNavigation,
                currentIndex: controller.bottomNavigationIndex.value,
                items: <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                    icon: SvgPicture.asset(
                      Assets.shaderTabShaderTabIcon,
                      colorFilter: ColorFilter.mode(_getTabIconColor(BottomNavigationIndexRoutes.SHADER_TAB), BlendMode.srcIn),
                      height: _iconSize,
                      width: _iconSize,
                    ),
                    label: "",
                  ),
                  BottomNavigationBarItem(
                    icon: SvgPicture.asset(
                      Assets.viewTabViewTabIcon,
                      colorFilter: ColorFilter.mode(_getTabIconColor(BottomNavigationIndexRoutes.VIEW_TAB), BlendMode.srcIn),
                      height: _iconSize,
                      width: _iconSize,
                    ),
                    label: "",
                  ),
                ],
              ),
            ),
          ),
          body: _homeTabs[controller.bottomNavigationIndex.value],
        ),
      ),
    );
  }
}
