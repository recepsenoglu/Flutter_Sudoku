import 'package:flutter/material.dart';
import 'package:flutter_sudoku/constant/enums.dart';
import 'package:flutter_sudoku/screens/game_screen/game_screen.dart';
import 'package:flutter_sudoku/screens/navigation_bar/navigation_bar_screen.dart';
import 'package:flutter_sudoku/screens/statistics_screen/statistics_screen.dart';

class Routes {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static const String navigationBar = '/navigation_bar';
  static const String gameScreen = '/game_screen';
  static const String statisticsScreen = '/statistics_screen';

  static Route<dynamic>? generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case navigationBar:
        return MaterialPageRoute(builder: (_) => const NavigationBarScreen());

      case gameScreen:
        return MaterialPageRoute(
            builder: (_) => GameScreen(difficulty: args as Difficulty));

      case statisticsScreen:
        return MaterialPageRoute(builder: (_) => const StatisticsScreen());

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

  static void goTo(String route, {bool enableBack = false, args}) {
    debugPrint('GO TO $route');
    Navigator.of(Routes.navigatorKey.currentContext!).pushNamedAndRemoveUntil(
      route,
      arguments: args,
      (route) => enableBack,
    );
  }

  static void back({bool returnDialog = false}) {
    debugPrint('GO BACK <- ${returnDialog ? 'return $returnDialog' : ''}');
    if (Navigator.canPop(Routes.navigatorKey.currentContext!)) {
      Navigator.pop(Routes.navigatorKey.currentContext!, returnDialog);
    }
  }
}
