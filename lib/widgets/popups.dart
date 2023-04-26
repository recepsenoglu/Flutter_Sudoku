import 'package:flutter/material.dart';
import 'package:flutter_sudoku/constant/app_strings.dart';
import 'package:flutter_sudoku/constant/enums.dart';
import 'package:flutter_sudoku/services/navigation_service.dart';
import 'package:flutter_sudoku/utils/extensions.dart';
import 'package:flutter_sudoku/utils/text_styles.dart';
import 'package:flutter_sudoku/widgets/game_info/game_info_widget.dart';
import 'package:flutter_sudoku/widgets/popup/useful_tip_divider.dart';
import 'package:flutter_sudoku/widgets/popup/useful_tip_widget.dart';

class Popup {
  static void gamePaused({
    required int time,
    required int mistakes,
    required Difficulty difficulty,
  }) {
    const String title = Strings.pause;

    Widget content = Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 22),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GameInfoWidget(
                title: Strings.time,
                value: time.toTimeString(),
                forPopup: true,
              ),
              GameInfoWidget(
                title: Strings.mistakes,
                value: '$mistakes/3',
                forPopup: true,
              ),
              GameInfoWidget(
                title: Strings.difficulty,
                value: difficulty.name,
                forPopup: true,
              ),
            ],
          ),
        ),
        const SizedBox(height: 28),
        const UsefulTipDivider(),
        const SizedBox(height: 18),
        const UsefulTipWidget(),
      ],
    );

    List<Widget> actions = [];

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
    bool barrierDismissible = true,
  }) async {
    return showDialog<void>(
      context: NavigationService.navigatorKey.currentContext!,
      barrierDismissible: barrierDismissible,
      builder: (BuildContext context) {
        return Dialog(
          insetPadding: const EdgeInsets.symmetric(horizontal: 28),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(24))),
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 26),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 12),
                Center(
                  child: Text(
                    title,
                    style: AppTextStyles.popupTitle,
                  ),
                ),
                const SizedBox(height: 32),
                content,
                // const SizedBox(height: 32),
                Column(children: actions),
              ],
            ),
          ),
        );
      },
    );
  }
}
