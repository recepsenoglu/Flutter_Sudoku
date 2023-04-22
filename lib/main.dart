import 'package:flutter/material.dart';
import 'package:flutter_sudoku/screens/game_screen/game_screen.dart';

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
      home: const GameScreen(),
    );
  }
}
