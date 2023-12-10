import "package:flutter/material.dart";
import "package:flutter_svg/flutter_svg.dart";
import "package:get/get.dart";
import 'package:water_shader/core/utils/index.dart';

class CustomLoadingOverlay {
  static bool isShowing = false;

  static Future<void> closeLoadingOverlay() async {
    debugPrint("TryToCloseLoadingOverlay");
    if (CustomLoadingOverlay.isShowing) {
      debugPrint("ClosedLoadingOverlay");
      Navigator.of(Get.overlayContext ?? Get.context!).pop();
      CustomLoadingOverlay.isShowing = false;
      await Future<dynamic>.delayed(const Duration(microseconds: 200));
    }
  }

  static Future<void> openLoadingOverlay({final bool isLogoVisible = true}) async {
    debugPrint("TryToOpenLoadingOverlay");
    if (!CustomLoadingOverlay.isShowing) {
      debugPrint("OpenLoadingOverlay");
      // TODO(hazarbelge): currently trying without isSnackbarOpen
      CustomLoadingOverlay.isShowing = true;
      showDialog(
        context: Get.overlayContext ?? Get.context!,
        barrierDismissible: false,
        useSafeArea: false,
        builder: (_) => _CustomLoadingOverlayWidget(isLogoVisible: isLogoVisible),
      );
    }
  }

  static Widget getLoadingOverlay() => const _CustomLoadingOverlayWidget();
}

class _CustomLoadingOverlayWidget extends StatefulWidget {
  const _CustomLoadingOverlayWidget({
    this.isLogoVisible = true,
  });

  final bool isLogoVisible;

  @override
  _CustomLoadingOverlayWidgetState createState() => _CustomLoadingOverlayWidgetState();
}

class _CustomLoadingOverlayWidgetState extends State<_CustomLoadingOverlayWidget> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200000),
      lowerBound: 10,
      upperBound: 20,
      vsync: this,
    );
    _controller.forward();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;

    return PopScope(
      canPop: false,
      child: GestureDetector(
        onTap: () {},
        child: SizedBox(
          height: height,
          width: width,
          child: widget.isLogoVisible
              ? Center(
                  child: RotationTransition(
                    turns: Tween<double>(begin: 0.0, end: 10.0).animate(_controller),
                    child: Builder(
                      builder: (BuildContext context) {
                        if (width >= 700) {
                          return SizedBox(
                            height: 150,
                            width: 150,
                            child: SvgPicture.asset(GlobalVariables.media.appIconPath),
                          );
                        } else {
                          return SizedBox(
                            height: 120,
                            width: 120,
                            child: SvgPicture.asset(GlobalVariables.media.appIconPath),
                          );
                        }
                      },
                    ),
                  ),
                )
              : const SizedBox(),
        ),
      ),
    );
  }
}
