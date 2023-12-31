import 'dart:async';
import 'dart:ui' as ui;

import 'package:flame/game.dart';
import "package:flutter/material.dart";
import 'package:flutter_shaders/flutter_shaders.dart';
import "package:get/get.dart";
import 'package:water_shader/core/theme/index.dart';
import 'package:water_shader/features/home/tabs/view/index.dart';
import 'package:water_shader/generated/shaders.dart';
import 'package:water_shader/ui/widgets/index.dart';

class ViewTabScreen extends GetView<ViewTabController> {
  const ViewTabScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Expanded(
          child: ViewTabBody(),
        ),
      ],
    );
  }
}

class ViewTabBody extends GetView<ViewTabController> {
  const ViewTabBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final double _width = MediaQuery.of(context).size.width;
    final double _height = MediaQuery.of(context).size.height;

    return SizedBox(
      height: _height,
      width: _width,
      child: const Water(),
    );
  }
}

class Water extends StatefulWidget {
  const Water({super.key});

  @override
  State<Water> createState() => _WaterState();
}

class _WaterState extends State<Water> {
  Timer? timer;
  double time = 0;
  double rotation = 0;
  double seaHeight = 0.5;
  double seaSpeed = 2.50; // Added
  double seaChoppy = 2.50; // Added

  @override
  void initState() {
    super.initState();

    timer = Timer.periodic(const Duration(milliseconds: 16), (Timer timer) {
      setState(() {
        time += 0.02;
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
      assetKey: Shaders.shadersWaterAndBeach,
      (BuildContext context, ui.FragmentShader shader, Widget? child) {
        return AnimatedSampler(
          (ui.Image image, ui.Size size, ui.Canvas canvas) {
            final double devicePixelRatio = MediaQuery.of(context).devicePixelRatio;
            shader
              ..setFloat(0, image.width.toDouble() / devicePixelRatio)
              ..setFloat(1, image.height.toDouble() / devicePixelRatio)
              ..setFloat(2, time);

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
