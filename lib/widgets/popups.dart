import 'package:flutter/material.dart';

import '../constant/enums.dart';
import '../constant/useful_tips.dart';
import '../models/useful_tip_model.dart';
import '../utils/game_routes.dart';
import '../utils/exports.dart';
import 'button/rounded_button/rounded_button.dart';
import 'popup/popup_game_stats.dart';
import 'popup/useful_tip_widget.dart';

class Popup {
  static Future<void> gameOver(
      {required Function() onNewGame, required Function() onExit}) {
    Widget content = Padding(
      padding: GameSizes.getSymmetricPadding(0.05, 0.02)
          .copyWith(bottom: GameSizes.getHeight(0.02)),
      child: Text(
        GameStrings.gameOverDescription,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: GameColors.popupContentText,
          fontSize: GameSizes.getWidth(0.04),
        ),
      ),
    );

    List<Widget> actions = [
      RoundedButton(
          whiteButton: true,
          buttonText: GameStrings.exit,
          icon: Icons.exit_to_app,
          onPressed: () {
            onExit();
            Navigator.pop(GameRoutes.navigatorKey.currentContext!);
          }),
      RoundedButton(
          buttonText: GameStrings.newGame,
          onPressed: () {
            Navigator.pop(GameRoutes.navigatorKey.currentContext!);
            onNewGame();
          }),
    ];

    return _showDialog(
      title: GameStrings.gameOver,
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
    const String title = GameStrings.pause;
    final UsefulTipModel usefulTipModel = UsefulTips.getRandomUsefulTip();

    Widget content = Column(
      children: [
        PopupGameStats(time: time, mistakes: mistakes, difficulty: difficulty),
        UsefulTipWidget(usefulTipModel: usefulTipModel),
      ],
    );

    List<Widget> actions = [
      RoundedButton(
        buttonText: GameStrings.resumeGame,
        onPressed: () {
          onResume();
          Navigator.pop(GameRoutes.navigatorKey.currentContext!);
        },
      )
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
      context: GameRoutes.navigatorKey.currentContext!,
      barrierDismissible: barrierDismissible,

      builder: (BuildContext context) {
        return PopScope(
          canPop: false,
          child: Dialog(
            insetPadding: GameSizes.getHorizontalPadding(0.05),
            shape: RoundedRectangleBorder(borderRadius: GameSizes.getRadius(22)),
            alignment: Alignment.center,
            backgroundColor: Colors.white,
            child: Padding(
              padding: GameSizes.getVerticalPadding(0.02),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: GameSizes.getHeight(0.01)),
                  Center(
                    child: Text(title,
                        style: GameTextStyles.popupTitle
                            .copyWith(fontSize: GameSizes.getWidth(0.065))),
                  ),
                  SizedBox(height: GameSizes.getHeight(0.01)),
                  content,
                  SizedBox(height: GameSizes.getHeight(0.01)),
                  Padding(
                    padding: GameSizes.getSymmetricPadding(0.05, 0.005),
                    child: Column(
                        children: List<Widget>.generate(
                            actions.length,
                            (index) => Padding(
                                  padding: index < actions.length - 1
                                      ? EdgeInsets.only(
                                          bottom: GameSizes.getHeight(0.015))
                                      : EdgeInsets.zero,
                                  child: actions[index],
                                ))),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
