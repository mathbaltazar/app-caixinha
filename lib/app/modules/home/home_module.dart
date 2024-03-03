import 'package:app_caixinha/app/core/routes/app_routes.dart';
import 'package:app_caixinha/app/modules/home/presentation/controllers/details_participant_controller.dart';
import 'package:app_caixinha/app/modules/home/presentation/controllers/home_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'presentation/pages/details_participant_page.dart';
import 'presentation/pages/home_page.dart';

class HomeModule extends Module {
  @override
  void binds(Injector i) {
    // todo i.addSingleton(ParticipantRepository.new);
    i.add(HomeController.new);
    i.add(DetailsParticipantController.new);
  }

  @override
  void routes(RouteManager r) {
    r.child(
      AppRoutes.initialRoute,
      child: (_) => HomePage(),
    );
    r.child(AppRoutes.detailsParticipant,
        child: (_) => DetailsParticipantPage(
              participantId: r.args.data['participantId'],
            ),
        transition: TransitionType.rightToLeft,
        duration: const Duration(milliseconds: 700));
  }
}
