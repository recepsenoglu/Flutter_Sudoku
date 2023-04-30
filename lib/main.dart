import 'package:flutter/material.dart';
import 'package:flutter_sudoku/services/navigation_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Sudoku',
      theme: ThemeData(primarySwatch: Colors.blue),
      navigatorKey: Routes.navigatorKey,
      onGenerateRoute: Routes.generateRoute,
      initialRoute: Routes.navigationBar,
    );
  }
}
