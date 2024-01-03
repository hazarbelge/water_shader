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
  double seaSpeed = 2.0; // Added
  double seaChoppy = 3.0; // Added

  bool isTouching = false;

  @override
  void initState() {
    super.initState();

    timer = Timer.periodic(const Duration(milliseconds: 16), (Timer timer) {
      if (!isTouching) {
        setState(() {
          time += 0.015;
        });
      }
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  void increaseSeaHeight() {
    setState(() {
      seaHeight += 0.1;
      if (seaHeight > 1.0) {
        seaHeight = 1.0;
      }
    });
  }

  void decreaseSeaHeight() {
    setState(() {
      seaHeight -= 0.1;
      if (seaHeight < 0.1) {
        seaHeight = 0.1;
      }
    });
  }

  void increaseSeaSpeed() {
    setState(() {
      seaSpeed += 0.25;
    });
  }

  void decreaseSeaSpeed() {
    setState(() {
      seaSpeed -= 0.25;
      if (seaSpeed < 0.0) {
        seaSpeed = 0.0;
      }
    });
  }

  void increaseSeaChoppy() {
    setState(() {
      seaChoppy += 0.25;
    });
  }

  void decreaseSeaChoppy() {
    setState(() {
      seaChoppy -= 0.25;
      if (seaChoppy < 0.0) {
        seaChoppy = 0.0;
      }
    });
  }

  void handlePanUpdate(DragUpdateDetails details) {
    setState(() {
      rotation += details.delta.dx * 0.01;
      isTouching = true;
    });
  }

  void handlePanEnd(DragEndDetails details) {
    setState(() {
      isTouching = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        GestureDetector(
          onPanUpdate: handlePanUpdate,
          onPanEnd: handlePanEnd,
          child: ShaderBuilder(
            assetKey: Shaders.shadersWater,
            (BuildContext context, ui.FragmentShader shader, Widget? child) {
              return AnimatedSampler(
                (ui.Image image, ui.Size size, ui.Canvas canvas) {
                  final double devicePixelRatio = MediaQuery.of(context).devicePixelRatio;
                  shader
                    ..setFloat(0, image.width.toDouble() / devicePixelRatio)
                    ..setFloat(1, image.height.toDouble() / devicePixelRatio)
                    ..setFloat(2, time)
                    ..setFloat(3, rotation)
                    ..setFloat(4, seaHeight.clamp(0.0, 1.0))
                    ..setFloat(5, seaSpeed)
                    ..setFloat(6, seaChoppy);

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
          ),
        ),
        Container(
          height: 180,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.4),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  const Spacer(),
                  ElevatedButton(
                    onPressed: decreaseSeaHeight,
                    child: const Text('-', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20)),
                  ),
                  SizedBox(
                    width: 220,
                    child: Center(
                      child: Text(
                        '${"shader.tab.sea.height".tr}: ${seaHeight.toStringAsFixed(2)}',
                        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: increaseSeaHeight,
                    child: const Text('+', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20)),
                  ),
                  const Spacer(),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  const Spacer(),
                  ElevatedButton(
                    onPressed: decreaseSeaSpeed,
                    child: const Text('-', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20)),
                  ),
                  SizedBox(
                    width: 220,
                    child: Center(
                      child: Text(
                        '${"shader.tab.sea.speed".tr}: ${seaSpeed.toStringAsFixed(2)}',
                        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: increaseSeaSpeed,
                    child: const Text('+', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20)),
                  ),
                  const Spacer(),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  const Spacer(),
                  ElevatedButton(
                    onPressed: decreaseSeaChoppy,
                    child: const Text('-', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20)),
                  ),
                  SizedBox(
                    width: 220,
                    child: Center(
                      child: Text(
                        '${"shader.tab.sea.choppy".tr}: ${seaChoppy.toStringAsFixed(2)}',
                        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: increaseSeaChoppy,
                    child: const Text('+', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20)),
                  ),
                  const Spacer(),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
