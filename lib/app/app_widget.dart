import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'core/presentation/global_message.dart';
import 'core/theme/color_schemes.g.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      scaffoldMessengerKey: GlobalMessage.instance(context),
      routeInformationParser: Modular.routeInformationParser,
      routerDelegate: Modular.routerDelegate,
      title: 'Caixinha',
      theme: ThemeData(
          useMaterial3: true,
          colorScheme: AppColors.lightColorScheme,
          // todo textTheme: GoogleFonts.ralewayTextTheme()
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: AppColors.darkColorScheme,
      ),
    );
  }
}