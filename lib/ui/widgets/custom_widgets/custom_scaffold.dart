import 'package:flutter/material.dart';
import 'package:water_shader/core/theme/index.dart';

class CustomScaffold extends StatelessWidget {
  const CustomScaffold({
    super.key,
    this.resizeToAvoidBottomInset = true,
    required this.child,
    this.icon,
    this.iconTop = 50,
    this.iconRight = 0,
    this.colors,
    this.padding,
    this.gradient,
  });

  final bool resizeToAvoidBottomInset;
  final Widget child;
  final Widget? icon;
  final double iconTop;
  final double iconRight;
  final EdgeInsets? padding;
  final List<Color>? colors;
  final Gradient? gradient;

  @override
  Widget build(BuildContext context) {
    final double _height = MediaQuery.of(context).size.height;
    final double _width = MediaQuery.of(context).size.width;

    final bool isGradient = (colors != null && colors!.length >= 2) || gradient != null;

    return Scaffold(
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      backgroundColor: isGradient ? null : colors?.first ?? ThemeColors.scaffoldBackgroundColor,
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            gradient: !isGradient
                ? null
                : gradient ??
                    LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: colors!,
                    ),
          ),
          child: SafeArea(
            child: icon != null
                ? Stack(
                    children: <Widget>[
                      Positioned(
                        top: iconTop,
                        right: iconRight,
                        child: icon!,
                      ),
                      Padding(
                        padding: padding ?? EdgeInsets.symmetric(horizontal: _width * 0.075, vertical: _height * 0.04),
                        child: child,
                      ),
                    ],
                  )
                : Padding(
                    padding: padding ?? EdgeInsets.symmetric(horizontal: _width * 0.075, vertical: _height * 0.04),
                    child: child,
                  ),
          ),
        ),
      ),
    );
  }
}
