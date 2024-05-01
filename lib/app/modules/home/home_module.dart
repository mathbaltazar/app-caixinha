import 'package:app_caixinha/app/core/routes/app_routes.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'data/repository/annual_savings_scheme_repository.dart';
import 'data/repository/month_payment_repository.dart';
import 'data/repository/participant_repository.dart';
import 'presentation/controllers/annual_savings_scheme_form_controller.dart';
import 'presentation/controllers/details_participant_controller.dart';
import 'presentation/controllers/home_controller.dart';
import 'presentation/pages/annual_savings_scheme_form_page.dart';
import 'presentation/pages/home_page.dart';
import 'presentation/pages/participant_details_page.dart';

class HomeModule extends Module {
  @override
  void binds(Injector i) {
    i.addSingleton(ParticipantRepository.new);
    i.addSingleton(AnnualSavingsSchemeRepository.new);
    i.addSingleton(MonthPaymentRepository.new);
    i.add(HomeController.new);
    i.add(DetailsParticipantController.new);
    i.add(AnnualSavingsSchemeFormController.new);
  }

  @override
  void routes(RouteManager r) {
    r.child(
      AppRoutes.initialRoute,
      child: (_) => HomePage(),
    );
    r.child(AppRoutes.participantDetails,
        child: (_) => ParticipantDetailsPage(
              participantId: r.args.data['participantId'],
            ),
        transition: TransitionType.rightToLeft,
        duration: const Duration(milliseconds: 700));
    r.child(AppRoutes.savingsSchemeForm,
        child: (_) => AnnualSavingsSchemeFormPage(
              schemeId: r.args.data['schemeId'],
            ),
        transition: TransitionType.rightToLeft,
        duration: const Duration(milliseconds: 700));
  }
}
