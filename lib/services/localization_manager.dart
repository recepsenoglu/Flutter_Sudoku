import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sudoku/utils/game_routes.dart';

class LocalizationManager {
  static const List<Locale> supportedLocales = [
    Locale('en', 'US'),
    Locale('tr', 'TR'),
  ];

  static get path => 'assets/translations';
  static get fallbackLocale => supportedLocales.first;
  static get currentLocale => GameRoutes.navigatorKey.currentContext!.locale;
  static get currentLanguageName => currentLocale.languageCode == 'en'
      ? 'English'
      : currentLocale.languageCode == 'tr'
          ? 'Türkçe'
          : 'Unknown';

  static void changeLocale(BuildContext context, Locale locale) {
    context.setLocale(locale);
  }
}
