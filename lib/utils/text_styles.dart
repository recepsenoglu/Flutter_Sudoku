import 'package:flutter/material.dart';
import 'package:flutter_sudoku/utils/app_colors.dart';

class AppTextStyles {
  static final _gameInfoTitle =
      TextStyle(fontSize: 13, color: AppColors.gameInfoTitle);

  static final _gameInfoValue = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.bold,
    color: AppColors.gameInfoValue,
  );

  static final _givenNumber = TextStyle(
    color: AppColors.givenNumber,
    fontSize: 30,
  );

  static final _enteredNumber = TextStyle(
    color: AppColors.enteredNumber,
    fontSize: 30,
  );

  static final _wrongNumber = TextStyle(
    color: AppColors.wrongNumber,
    fontSize: 30,
  );

  static TextStyle get gameInfoTitle => _gameInfoTitle;
  static TextStyle get gameInfoValue => _gameInfoValue;
  static TextStyle get givenNumber => _givenNumber;
  static TextStyle get enteredNumber => _enteredNumber;
  static TextStyle get wrongNumber => _wrongNumber;
}
