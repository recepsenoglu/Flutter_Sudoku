import 'package:flutter/widgets.dart';
import 'package:flutter_sudoku/constant/enums.dart';
import 'package:flutter_sudoku/constant/game_constants.dart';
import 'package:flutter_sudoku/models/game_model.dart';
import 'package:flutter_sudoku/services/routes.dart';

class DailyChallengesScreenProvider with ChangeNotifier {
  int selectedDay = -1;
  late DateTime selectedDate;
  late final DateTime now;
  bool get daySelected => selectedDay != -1;

  DailyChallengesScreenProvider() {
    now = DateTime.now();
    selectedDate = DateTime(now.year, now.month, now.day);
  }

  void play() {
    if (daySelected) {
      _createGame();
    }
  }

  void selectDay(int day) {
    if (day > 0 && now.day >= day) {
      selectedDay = day;
      notifyListeners();
    }
  }

  void _createGame() {
    final List<Difficulty> difficulties = List<Difficulty>.from(
        GameSettings.getDifficulties.where((e) => e.index < 3));

    difficulties.shuffle();

    final GameModel gameModel = GameModel(
      sudokuBoard: GameSettings.createSudokuBoard(),
      difficulty: difficulties[0],
      dailyChallenge: true,
    );

    Routes.goTo(Routes.gameScreen, args: gameModel);
  }
}
