import 'package:app_caixinha/app/modules/home/home_module.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'core/routes/app_routes.dart';

class AppModule extends Module {
  @override
  void binds(Injector i) {}

  @override
  void routes(RouteManager r) {
    r.module(
      AppRoutes.initialRoute,
      module: HomeModule(),
    );
  }
}
