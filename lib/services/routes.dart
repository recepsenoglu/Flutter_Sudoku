import 'package:flutter/material.dart';
import 'package:flutter_sudoku/models/game_model.dart';
import 'package:flutter_sudoku/screens/game_screen/game_screen.dart';
import 'package:flutter_sudoku/screens/navigation_bar/navigation_bar_screen.dart';
import 'package:flutter_sudoku/screens/options_screen/options_screen.dart';
import 'package:flutter_sudoku/screens/options_screen/settings_screen/settings_screen.dart';
import 'package:flutter_sudoku/screens/statistics_screen/statistics_screen.dart';
import 'package:flutter_sudoku/screens/win_screen/win_screen.dart';

class Routes {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static const String navigationBar = '/navigation_bar';
  static const String gameScreen = '/game_screen';
  static const String statisticsScreen = '/statistics_screen';
  static const String optionsScreen = '/options_screen';
  static const String settingsScreen = '/settings_screen';
  static const String winScreen = '/win_screen';

  static Route<dynamic>? generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case navigationBar:
        return MaterialPageRoute(
          builder: (_) => args != null
              ? NavigationBarScreen(
                  pageIndex: (args as List)[0] as int,
                  savedGame: args.length > 1 ? args[1] as GameModel? : null)
              : const NavigationBarScreen(),
        );
      case gameScreen:
        return MaterialPageRoute(
            builder: (_) => GameScreen(gameModel: args as GameModel));
      case statisticsScreen:
        return MaterialPageRoute(builder: (_) => const StatisticsScreen());
      case optionsScreen:
        return MaterialPageRoute(builder: (_) => const OptionsScreen());
      case settingsScreen:
        return MaterialPageRoute(builder: (_) => const SettingsScreen());
      case winScreen:
        return MaterialPageRoute(
            builder: (_) => WinScreen(gameModel: args as GameModel));

      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: const Center(
          child: Text('ERROR'),
        ),
      );
    });
  }

  static Future<void> goTo(
    String route, {
    args,
    bool enableBack = false,
    Function()? callBackAfter,
  }) async {
    debugPrint('GO TO $route');
    await Navigator.of(Routes.navigatorKey.currentContext!)
        .pushNamedAndRemoveUntil(
      route,
      arguments: args,
      (route) => enableBack,
    );
    if (callBackAfter != null) {
      callBackAfter();
    }
  }

  // static Future<void> goTo(
  //   String route, {
  //   args,
  //   bool enableBack = false,
  // }) async {
  //   debugPrint('GO TO $route');
  //   await Navigator.of(Routes.navigatorKey.currentContext!)
  //       .pushNamedAndRemoveUntil(
  //     route,
  //     arguments: args,
  //     (route) => enableBack,
  //   );
  // }

  static void goToPageThenCallFunction(Function() function) {}

  static void back({int backTimes = 1, bool returnDialog = false}) {
    debugPrint('GO BACK <- ${returnDialog ? 'return $returnDialog' : ''}');
    for (var i = 0; i < backTimes; i++) {
      if (Navigator.canPop(Routes.navigatorKey.currentContext!)) {
        Navigator.pop(Routes.navigatorKey.currentContext!, returnDialog);
      }
    }
  }
}
