import "package:flutter/material.dart";
import "package:get/get.dart";
import 'package:water_shader/core/theme/index.dart';
import 'package:water_shader/features/home/tabs/shader/index.dart';
import 'package:water_shader/ui/widgets/index.dart';

class ShaderTabScreen extends GetView<ShaderTabController> {
  const ShaderTabScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double _height = MediaQuery.of(context).size.height;
    final double _width = MediaQuery.of(context).size.width;

    return CustomScaffold(
      key: const Key("shader_tab_screen_scaffold"),
      padding: EdgeInsets.only(right: _width * 0.05, left: _width * 0.05, top: _height * 0.015),
      child: const Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          ShaderTabAppBar(),
          SizedBox(height: 20),
          Expanded(
            child: ShaderTabBody(),
          ),
        ],
      ),
    );
  }
}

class ShaderTabAppBar extends GetView<ShaderTabController> {
  const ShaderTabAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Expanded(
          child: Center(
            child: Text(
              "shader.tab.title".tr,
              style: TextStyles.description.copyWith(
                fontSize: 22,
                color: ThemeColors.primaryTextColor,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }
}

class ShaderTabBody extends GetView<ShaderTabController> {
  const ShaderTabBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: double.infinity,
      width: double.infinity,
    );
  }
}
