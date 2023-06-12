import 'package:flutter/material.dart';
import 'package:flutter_sudoku/utils/app_strings.dart';
import 'package:flutter_sudoku/constant/enums.dart';
import 'package:flutter_sudoku/services/routes.dart';
import 'package:flutter_sudoku/utils/app_colors.dart';
import 'package:flutter_sudoku/utils/app_text_styles.dart';
import 'package:flutter_sudoku/widgets/button/rounded_button/rounded_button.dart';
import 'package:flutter_sudoku/widgets/popup/popup_game_stats.dart';
import 'package:flutter_sudoku/widgets/popup/useful_tip_divider.dart';
import 'package:flutter_sudoku/widgets/popup/useful_tip_widget.dart';

class Popup {
  static Future<void> gameOver({
    required Function() onNewGame,
  }) {
    const String title = AppStrings.gameOver;
    const String contentText = AppStrings.gameOverDescription;

    Widget content = Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
      child: Text(
        contentText,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: AppColors.popupContentText,
          fontSize: 16,
        ),
      ),
    );

    List<Widget> actions = [
      RoundedButton(
          buttonText: AppStrings.secondChance,
          disabled: true,
          icon: Icons.movie_filter,
          onPressed: () {
            Navigator.pop(Routes.navigatorKey.currentContext!);
          }),
      RoundedButton(
          whiteButton: true,
          buttonText: AppStrings.newGame,
          onPressed: () {
            Navigator.pop(Routes.navigatorKey.currentContext!);
            onNewGame();
          }),
    ];

    return _showDialog(
      title: title,
      content: content,
      actions: actions,
    );
  }

  static void gamePaused({
    required int time,
    required int mistakes,
    required Difficulty difficulty,
    required Function() onResume,
  }) {
    const String title = AppStrings.pause;

    Widget content = Column(
      children: [
        PopupGameStats(time: time, mistakes: mistakes, difficulty: difficulty),
        const SizedBox(height: 28),
        const UsefulTipDivider(),
        const SizedBox(height: 18),
        const UsefulTipWidget(),
      ],
    );

    List<Widget> actions = [
      RoundedButton(
          buttonText: AppStrings.resumeGame,
          onPressed: () {
            onResume();
            Navigator.pop(Routes.navigatorKey.currentContext!);
          })
    ];

    _showDialog(
      title: title,
      content: content,
      actions: actions,
    );
  }

  static Future<void> _showDialog({
    required String title,
    required Widget content,
    required List<Widget> actions,
    bool barrierDismissible = false,
  }) async {
    return showDialog<void>(
      context: Routes.navigatorKey.currentContext!,
      barrierDismissible: barrierDismissible,
      builder: (BuildContext context) {
        return Dialog(
          insetPadding: const EdgeInsets.symmetric(horizontal: 28),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(24))),
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 16),
                Center(
                  child: Text(
                    title,
                    style: AppTextStyles.popupTitle,
                  ),
                ),
                const SizedBox(height: 32),
                content,
                const SizedBox(height: 22),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 2),
                  child: Column(
                      children: List<Widget>.generate(
                          actions.length,
                          (index) => Padding(
                                padding: index < actions.length - 1
                                    ? const EdgeInsets.only(bottom: 12)
                                    : EdgeInsets.zero,
                                child: actions[index],
                              ))),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
