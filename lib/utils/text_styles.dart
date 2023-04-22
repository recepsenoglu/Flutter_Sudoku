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

  static TextStyle get gameInfoTitle => _gameInfoTitle;
  static TextStyle get gameInfoValue => _gameInfoValue;
}
