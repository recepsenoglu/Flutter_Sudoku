import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'utils/game_routes.dart';
import 'utils/game_sizes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    GameSizes.init(context);

    return MaterialApp(
      title: 'Sudoku',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true),
      navigatorKey: GameRoutes.navigatorKey,
      onGenerateRoute: GameRoutes.generateRoute,
      initialRoute: GameRoutes.navigationBar,
    );
  }
}
