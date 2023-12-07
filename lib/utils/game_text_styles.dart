import 'package:flutter/material.dart';
import 'package:flutter_sudoku/utils/game_colors.dart';

class GameTextStyles {
  static final _appBarTitle = TextStyle(
    color: GameColors.appBarTitle,
    fontWeight: FontWeight.bold,
  );

  static final _gameInfoTitle = TextStyle(
    fontSize: 13,
    color: GameColors.gameInfoTitle,
  );
  static final _gameInfoValue = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.bold,
    color: GameColors.gameInfoValue,
  );

  static final _givenNumber = TextStyle(
    color: GameColors.givenNumber,
    fontSize: 30,
  );
  static final _enteredNumber = TextStyle(
    color: GameColors.enteredNumber,
    fontSize: 30,
  );
  static final _wrongNumber = TextStyle(
    color: GameColors.wrongNumber,
    fontSize: 30,
  );
  static final _noteNumber = TextStyle(
    color: GameColors.noteNumber,
    fontWeight: FontWeight.w600,
    fontSize: 14,
  );
  static final _highlightedNoteNumber = TextStyle(
    color: GameColors.highlightedNoteNumber,
    fontWeight: FontWeight.w900,
    fontSize: 12,
  );

  static final _actionButton = TextStyle(
    color: GameColors.actionButton,
    fontSize: 13,
  );

  static final _numberButton = TextStyle(
    color: GameColors.numberButton,
    fontWeight: FontWeight.w500,
    fontSize: 34,
  );

  static final _noteButton = TextStyle(
    color: GameColors.noteButton,
    fontWeight: FontWeight.w500,
    fontSize: 34,
  );

  static final _popupTitle = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w800,
    color: GameColors.popupTitle,
  );

  static final _popupInfoTitle =
      _gameInfoTitle.copyWith(fontSize: 13.5, fontWeight: FontWeight.w500);

  static final _popupInfoValue = _gameInfoValue.copyWith(
    fontSize: 18,
    color: GameColors.popupInfoValue,
    fontWeight: FontWeight.w700,
  );

  static final _dividerText =
      _gameInfoTitle.copyWith(fontWeight: FontWeight.w600);

  static final _buttonText = TextStyle(
    color: GameColors.buttonText,
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );

  static final _buttonSubText = _buttonText.copyWith(
    fontSize: 14,
    fontWeight: FontWeight.w400,
  );

  static final _disabledButtonText =
      _buttonText.copyWith(color: GameColors.buttonDisabledText);

  static final _whiteButtonText =
      _buttonText.copyWith(color: GameColors.roundedButton);

  static const _navigationBarItemLabel = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.bold,
  );

  static const _mainScreenTitle = TextStyle(
    fontSize: 64,
    fontWeight: FontWeight.bold,
  );

  static final _statisticsTitle = TextStyle(
    color: GameColors.statisticsTitle,
    fontWeight: FontWeight.bold,
  );

  static const _statisticsGroupTitle =
      TextStyle(fontSize: 24, fontWeight: FontWeight.w800);

  static const _statisticsCardValue =
      TextStyle(fontSize: 22, fontWeight: FontWeight.w800);

  static const _statisticsCardTitle =
      TextStyle(fontSize: 15, fontWeight: FontWeight.bold);

  static const _optionsScreenAppBarTitle = TextStyle(
    fontSize: 18,
    color: Colors.black,
    fontWeight: FontWeight.bold,
  );
  static final _doneButtonText = TextStyle(
    fontWeight: FontWeight.w700,
    fontSize: 16,
    color: GameColors.roundedButton,
  );
  static const _optionButtonTitle = TextStyle(
    color: Colors.black,
    fontWeight: FontWeight.w500,
    fontSize: 15.5,
  );
  static const _settingButtonTitle = TextStyle(
    color: Colors.black,
    fontWeight: FontWeight.w500,
    fontSize: 16.5,
  );
  static final _optionGroupDescription = TextStyle(
    fontSize: 13,
    color: GameColors.greyColor,
    fontWeight: FontWeight.w500,
  );

  static const _dailyChallengesTitle = TextStyle(
    fontSize: 16,
    color: Colors.white,
    fontWeight: FontWeight.w500,
  );
  static const _calendarDateTitle =
      TextStyle(fontWeight: FontWeight.bold, fontSize: 17);

  static const _calendarDays = TextStyle(
    fontSize: 13,
    color: Colors.grey,
  );

  static const _calendarDate =
      TextStyle(fontSize: 15, fontWeight: FontWeight.bold);
  static const _calendarDateSelected =
      TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white);

  static const _calendarFutureDate = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.bold,
    color: Colors.grey,
  );
  static const _winScreenHeader = TextStyle(
    color: Colors.white,
    fontSize: 34,
    fontWeight: FontWeight.w600,
  );
  static const _mainTextButton = TextStyle(
    color: Colors.white,
    fontSize: 18,
    fontWeight: FontWeight.w600,
  );
  static const _levelStatisticsTitle = TextStyle(
    fontSize: 15.5,
    color: Colors.white,
  );

  static const _seeAll = TextStyle(
    fontSize: 16,
    color: Colors.white,
    fontWeight: FontWeight.bold,
  );

  static const _promotionText = TextStyle(
    fontSize: 14,
    color: Colors.white,
    fontWeight: FontWeight.w600,
  );

  static final _promotionTextGold = TextStyle(
    fontSize: 14,
    color: GameColors.gold,
    fontWeight: FontWeight.w600,
  );

  static const _statRowText = TextStyle(
    fontSize: 16,
    color: Colors.white,
    fontWeight: FontWeight.w500,
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

  static TextStyle get popupTitle => _popupTitle;
  static TextStyle get popupInfoTitle => _popupInfoTitle;
  static TextStyle get popupInfoValue => _popupInfoValue;

  static TextStyle get dividerText => _dividerText;

  static TextStyle get buttonText => _buttonText;
  static TextStyle get buttonSubText => _buttonSubText;
  static TextStyle get disabledButtonText => _disabledButtonText;
  static TextStyle get whiteButtonText => _whiteButtonText;

  static TextStyle get navigationBarItemLabel => _navigationBarItemLabel;

  static TextStyle get mainScreenTitle => _mainScreenTitle;

  static TextStyle get statisticsTitle => _statisticsTitle;
  static TextStyle get statisticsGroupTitle => _statisticsGroupTitle;
  static TextStyle get statisticsCardValue => _statisticsCardValue;
  static TextStyle get statisticsCardTitle => _statisticsCardTitle;

  static TextStyle get optionsScreenAppBarTitle => _optionsScreenAppBarTitle;
  static TextStyle get doneButtonText => _doneButtonText;

  static TextStyle get optionButtonTitle => _optionButtonTitle;
  static TextStyle get settingButtonTitle => _settingButtonTitle;
  static TextStyle get optionGroupDescription => _optionGroupDescription;

  static TextStyle get dailyChallengesTitle => _dailyChallengesTitle;
  static TextStyle get calendarDateTitle => _calendarDateTitle;
  static TextStyle get calendarDays => _calendarDays;
  static TextStyle get calendarDate => _calendarDate;
  static TextStyle get calendarDateSelected => _calendarDateSelected;
  static TextStyle get calendarFutureDate => _calendarFutureDate;

  static TextStyle get winScreenHeader => _winScreenHeader;
  static TextStyle get mainTextButton => _mainTextButton;
  static TextStyle get levelStatisticsTitle => _levelStatisticsTitle;
  static TextStyle get seeAll => _seeAll;

  static TextStyle get promotionText => _promotionText;
  static TextStyle get promotionTextGold => _promotionTextGold;
  static TextStyle get statRowText => _statRowText;
}
