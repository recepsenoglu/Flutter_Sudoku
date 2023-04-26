import 'package:flutter/material.dart';
import 'package:flutter_sudoku/constant/app_strings.dart';
import 'package:flutter_sudoku/constant/enums.dart';
import 'package:flutter_sudoku/utils/extensions.dart';
import 'package:flutter_sudoku/widgets/game_info/game_info_widget.dart';

class PopupGameStats extends StatelessWidget {
  const PopupGameStats({
    required this.time,
    required this.mistakes,
    required this.difficulty,
    super.key,
  });

  final int time;
  final int mistakes;
  final Difficulty difficulty;

  @override
  Widget build(BuildContext context) {
    return Padding(
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
    );
  }
}
