import 'package:flutter/material.dart';

import '../../constant/enums.dart';
import '../../utils/game_strings.dart';
import '../../utils/extensions.dart';
import '../game_info/game_info_widget.dart';

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
            title: GameStrings.time,
            value: time.toTimeString(),
            forPopup: true,
          ),
          GameInfoWidget(
            title: GameStrings.mistakes,
            value: '$mistakes/3',
            forPopup: true,
          ),
          GameInfoWidget(
            title: GameStrings.difficulty,
            value: difficulty.name,
            forPopup: true,
          ),
        ],
      ),
    );
  }
}
