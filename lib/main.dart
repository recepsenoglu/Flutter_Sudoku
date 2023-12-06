import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'services/routes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sudoku',
      theme: ThemeData(primarySwatch: Colors.blue),
      navigatorKey: Routes.navigatorKey,
      onGenerateRoute: Routes.generateRoute,
      initialRoute: Routes.navigationBar,
    );
  }
}
