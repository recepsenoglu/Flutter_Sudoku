import 'package:flutter/material.dart';
import 'package:flutter_sudoku/utils/app_colors.dart';

class AppTextStyles {
  static final _appBarTitle = TextStyle(
    color: AppColors.appBarTitle,
    fontWeight: FontWeight.bold,
  );

  static final _gameInfoTitle = TextStyle(
    fontSize: 13,
    color: AppColors.gameInfoTitle,
  );
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
  static final _noteNumber = TextStyle(
    color: AppColors.noteNumber,
    fontWeight: FontWeight.w600,
    fontSize: 14,
  );
  static final _highlightedNoteNumber = TextStyle(
    color: AppColors.highlightedNoteNumber,
    fontWeight: FontWeight.bold,
    fontSize: 12,
  );

  static final _actionButton = TextStyle(
    color: AppColors.actionButton,
    fontSize: 13,
  );

  static final _numberButton = TextStyle(
    color: AppColors.numberButton,
    fontWeight: FontWeight.w500,
    fontSize: 34,
  );

  static final _noteButton = TextStyle(
    color: AppColors.noteButton,
    fontWeight: FontWeight.w500,
    fontSize: 34,
  );

  static TextStyle get appBarTitle => _appBarTitle;

  static TextStyle get gameInfoTitle => _gameInfoTitle;
  static TextStyle get gameInfoValue => _gameInfoValue;

  static TextStyle get givenNumber => _givenNumber;
  static TextStyle get enteredNumber => _enteredNumber;
  static TextStyle get wrongNumber => _wrongNumber;
  static TextStyle get noteNumber => _noteNumber;
  static TextStyle get highlightedNoteNumber => _highlightedNoteNumber;

  static TextStyle get actionButton => _actionButton;

  static TextStyle get numberButton => _numberButton;
  static TextStyle get noteButton => _noteButton;
}
