import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sudoku/constant/app_strings.dart';
import 'package:flutter_sudoku/constant/difficulty.dart';
import 'package:flutter_sudoku/utils/app_colors.dart';
import 'package:flutter_sudoku/widgets/appBar_action_button.dart';
import 'package:flutter_sudoku/widgets/game_info_widget.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const GameAppBar(),
      body: Column(
        children: const [
          GameInfo(
            difficulty: Difficulty.Easy,
            mistakes: 1,
            score: 100,
            time: 149,
          ),
        ],
      ),
    );
  }
}

class GameInfo extends StatelessWidget {
  const GameInfo({
    required this.difficulty,
    required this.mistakes,
    required this.score,
    required this.time,
    super.key,
  });

  final Difficulty difficulty;
  final int mistakes;
  final int score;
  final int time;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          Expanded(
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GameInfoWidget(
                  value: difficulty.name,
                  title: Strings.difficulty,
                  crossAxisAlignment: CrossAxisAlignment.start,
                ),
                GameInfoWidget(
                  value: '$mistakes/3',
                  title: Strings.mistakes,
                ),
                GameInfoWidget(
                  value: '$score',
                  title: Strings.score,
                ),
                GameInfoWidget(
                  value: '$time',
                  title: Strings.time,
                  crossAxisAlignment: CrossAxisAlignment.end,
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          PauseButton(isPaused: false, onPressed: () {}),
        ],
      ),
    );
  }
}

class PauseButton extends StatelessWidget {
  const PauseButton({
    required this.isPaused,
    required this.onPressed,
    super.key,
  });

  final bool isPaused;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 32,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          shape: const CircleBorder(),
          padding: EdgeInsets.zero,
          backgroundColor: AppColors.pauseButton,
        ),
        child: Icon(
          isPaused ? Icons.play_arrow : Icons.pause_outlined,
          color: AppColors.pauseIcon,
          size: 24,
        ),
      ),
    );
  }
}

class GameAppBar extends StatelessWidget with PreferredSizeWidget {
  const GameAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.appBarBackground,
      systemOverlayStyle: SystemUiOverlayStyle.dark,
      centerTitle: true,
      elevation: 0,
      title: Text(
        Strings.appBarTitle,
        style: TextStyle(
          color: AppColors.appBarTitle,
          fontWeight: FontWeight.bold,
        ),
      ),
      leading:
          AppBarActionButton(icon: Icons.arrow_back_ios_new, onPressed: () {}),
      actions: [
        AppBarActionButton(
          icon: Icons.palette_outlined,
          onPressed: () {},
        ),
        AppBarActionButton(
          icon: Icons.settings_outlined,
          onPressed: () {},
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
