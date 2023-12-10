import "package:get/get.dart";
import 'package:water_shader/core/base/index.dart';
import 'package:water_shader/features/home/index.dart';
import 'package:water_shader/features/home/tabs/shader/index.dart';
import 'package:water_shader/features/home/tabs/view/index.dart';

enum BottomNavigationIndexRoutes {
  SHADER_TAB,
  VIEW_TAB,
}

class HomeController extends BaseRepositoryController<HomeRepository, HomeProvider, dynamic> {
  HomeController() : super(repository: HomeRepository());

  final RxInt bottomNavigationIndex = 0.obs;

  void onTapBottomNavigation(int? tappedIndex) {
    if (tappedIndex == null || bottomNavigationIndex.value == tappedIndex) {
      return;
    }

    bottomNavigationIndex.value = tappedIndex;

    switch (BottomNavigationIndexRoutes.values[bottomNavigationIndex.value]) {
      case BottomNavigationIndexRoutes.SHADER_TAB:
        final ShaderTabController _shaderTabController = Get.find<ShaderTabController>();
        _shaderTabController.appendInitData();
        break;
      case BottomNavigationIndexRoutes.VIEW_TAB:
        final ViewTabController _viewTabController = Get.find<ViewTabController>();
        _viewTabController.appendInitData();
        break;
      default:
        break;
    }
  }

  @override
  Future<void> onInit() async {
    super.onInit();

    final ShaderTabController _shaderTabController = Get.find<ShaderTabController>();
    _shaderTabController.appendInitData();
    final ViewTabController _viewTabController = Get.find<ViewTabController>();
    _viewTabController.appendInitData();
  }

  @override
  Future<void> onReady() async {
    super.onReady();

    final BottomNavigationIndexRoutes? _changeTabRoute = Get.arguments?["change-tab"] as BottomNavigationIndexRoutes?;
    if (_changeTabRoute != null) {
      onTapBottomNavigation(_changeTabRoute.index);
    }
  }
}
