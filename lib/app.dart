import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:travel/core/bindings/main_bindings.dart';
import 'package:travel/core/theme/theme.dart';
import 'package:travel/routes/pages.dart';
import 'package:travel/routes/routes.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Travel extends StatelessWidget {
  const Travel({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Travel',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      initialBinding: MainBinding(),
      getPages: Pages.pages,
      initialRoute: Routes.initial,
      fallbackLocale: const Locale('en'),
      locale: const Locale('sw'),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      onUnknownRoute: (settings) {
        return MaterialPageRoute(
          builder: (context) => Container(),
        );
      },
      defaultTransition: Transition.fadeIn,
    );
  }
}
