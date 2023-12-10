import "package:flutter/material.dart";
import "package:get/get.dart";

class BaseSuperController<T extends Object?> extends SuperController<T> {
  BaseSuperController();
  @override
  void onInit() {
    super.onInit();
    debugPrint("$runtimeType onInit called");
  }

  @override
  void onReady() {
    super.onReady();
    debugPrint("$runtimeType onReady called");
  }

  @override
  void onClose() {
    super.onClose();
    debugPrint("$runtimeType onClose called");
  }

  @override
  void onDetached() {
    debugPrint("$runtimeType onDetached called");
  }

  @override
  void onInactive() {
    debugPrint("$runtimeType onInactive called");
  }

  @override
  void onPaused() {
    debugPrint("$runtimeType onPaused called");
  }

  @override
  void onResumed() {
    debugPrint("$runtimeType onResumed called");
  }

  @override
  void onHidden() {
    debugPrint("$runtimeType onResumed called");
  }
}
