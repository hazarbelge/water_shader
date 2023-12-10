import "package:flutter/material.dart";
import 'package:water_shader/core/base/index.dart';

abstract class BaseRepositoryController<R extends BaseRepository<P>, P extends BaseProvider, T extends Object?> extends BaseSuperController<T> {
  BaseRepositoryController({
    required this.repository,
  });

  final R repository;

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

class BaseController<T extends Object?> extends BaseSuperController<T> {
  BaseController();

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
