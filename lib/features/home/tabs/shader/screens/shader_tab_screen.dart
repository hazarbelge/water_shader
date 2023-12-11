import 'dart:async';
import 'dart:ui' as ui;

import 'package:flame/game.dart';
import "package:flutter/material.dart";
import 'package:flutter_shaders/flutter_shaders.dart';
import "package:get/get.dart";
import 'package:water_shader/core/theme/index.dart';
import 'package:water_shader/features/home/tabs/shader/index.dart';
import 'package:water_shader/generated/shaders.dart';
import 'package:water_shader/ui/widgets/index.dart';

class ShaderTabScreen extends GetView<ShaderTabController> {
  const ShaderTabScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const CustomScaffold(
      key: Key("shader_tab_screen_scaffold"),
      padding: EdgeInsets.zero,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(vertical: 15.0),
            child: ShaderTabAppBar(),
          ),
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
    return Container(
      key: const Key("shader_tab_app_bar"),
      child: Row(
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
      ),
    );
  }
}

class ShaderTabBody extends GetView<ShaderTabController> {
  const ShaderTabBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final double _width = MediaQuery.of(context).size.width;
    final double _height = MediaQuery.of(context).size.height;

    final RxInt shaderIndex = RxInt(0);

    return SizedBox(
      height: _height,
      width: _width,
      child: Stack(
        children: <Widget>[
          SizedBox(
            height: _height,
            width: _width,
            child: Obx(
              () {
                switch (shaderIndex.value) {
                  case 0:
                    return const Snow();
                  case 1:
                    return const Water();
                  default:
                    return const Snow();
                }
              },
            ),
          ),
          Positioned(
            bottom: 30,
            right: 20,
            child: Container(
              height: 60,
              width: 120,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(30)),
                color: Colors.black.withOpacity(0.8),
              ),
              child: Center(
                child: Obx(
                  () => CustomElevatedButton(
                    key: const Key("shader_tab_body_button"),
                    colors: const <Color>[Colors.transparent],
                    paddings: EdgeInsets.zero,
                    onPressed: () => shaderIndex.value = shaderIndex.value == 0 ? 1 : 0,
                    child: Icon(
                      shaderIndex.value == 0 ? Icons.water : Icons.ac_unit,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Snow extends StatefulWidget {
  const Snow({super.key});

  static PageRoute<void> route() {
    return MaterialPageRoute<void>(
      builder: (_) => const Snow(),
    );
  }

  @override
  State<Snow> createState() => _SnowState();
}

class _SnowState extends State<Snow> {
  double time = 0;

  Timer? timer;

  @override
  void initState() {
    super.initState();

    timer = Timer.periodic(const Duration(milliseconds: 16), (Timer timer) {
      setState(() {
        time += 0.016;
      });
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ShaderBuilder(
      assetKey: Shaders.shadersSnow,
      (BuildContext context, ui.FragmentShader shader, Widget? child) {
        return AnimatedSampler(
          (ui.Image image, ui.Size size, ui.Canvas canvas) {
            final double devicePixelRatio = MediaQuery.of(context).devicePixelRatio;
            shader
              ..setFloat(0, image.width.toDouble() / devicePixelRatio)
              ..setFloat(1, image.height.toDouble() / devicePixelRatio)
              ..setFloat(2, time)
              ..setImageSampler(0, image);

            canvas
              ..save()
              ..drawRect(
                Offset.zero & size,
                Paint()..shader = shader,
              )
              ..restore();
          },
          child: child!,
        );
      },
      child: const CustomScaffold(
        colors: <Color>[
          ThemeColors.secondaryColor,
          ThemeColors.primaryColor,
        ],
        child: SizedBox(
          height: double.infinity,
          width: double.infinity,
        ),
      ),
    );
  }
}

class Water extends StatefulWidget {
  const Water({super.key});

  static PageRoute<void> route() {
    return MaterialPageRoute<void>(
      builder: (_) => const Water(),
    );
  }

  @override
  State<Water> createState() => _WaterState();
}

class _WaterState extends State<Water> {
  double seaHeight = 0.6;

  double time = 0;

  Timer? timer;

  @override
  void initState() {
    super.initState();

    timer = Timer.periodic(const Duration(milliseconds: 16), (Timer timer) {
      setState(() {
        time += 0.016;
      });
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ShaderBuilder(
      assetKey: Shaders.shadersWater,
      (BuildContext context, ui.FragmentShader shader, Widget? child) {
        return AnimatedSampler(
          (ui.Image image, ui.Size size, ui.Canvas canvas) {
            final double devicePixelRatio = MediaQuery.of(context).devicePixelRatio;
            shader
              ..setFloat(0, image.width.toDouble() / devicePixelRatio)
              ..setFloat(1, image.height.toDouble() / devicePixelRatio)
              ..setFloat(2, time)
              ..setFloat(3, seaHeight.clamp(0.0, 1.0));

            canvas
              ..save()
              ..translate(size.width, size.height)
              ..rotate(180 * degrees2Radians)
              ..drawRect(
                Offset.zero & size,
                Paint()..shader = shader,
              )
              ..restore();
          },
          child: child!,
        );
      },
      child: const CustomScaffold(
        colors: <Color>[
          ThemeColors.secondaryColor,
          ThemeColors.primaryColor,
        ],
        child: SizedBox(
          height: double.infinity,
          width: double.infinity,
        ),
      ),
    );
  }
}
