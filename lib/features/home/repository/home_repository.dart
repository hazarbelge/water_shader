import 'package:water_shader/core/base/index.dart';

abstract class IHomeProvider {}

class HomeProvider extends BaseProvider implements IHomeProvider {}

abstract class IHomeRepository {}

class HomeRepository extends BaseRepository<HomeProvider> implements IHomeRepository {
  HomeRepository() : super(provider: HomeProvider());
}
