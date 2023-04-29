import 'package:flutter/material.dart';
import 'package:flutter_sudoku/screens/navigaton_bar/navigaton_bar_screen.dart';
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
      navigatorKey: NavigationService.navigatorKey,
      home: const NavigationBarScreen(),
    );
  }
}
