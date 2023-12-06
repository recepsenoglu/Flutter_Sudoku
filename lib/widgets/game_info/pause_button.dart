import 'package:flutter/material.dart';
import 'package:flutter_sudoku/utils/game_colors.dart';

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
          backgroundColor: GameColors.pauseButton,
        ),
        child: Icon(
          isPaused ? Icons.play_arrow : Icons.pause_outlined,
          color: GameColors.pauseIcon,
          size: 24,
        ),
      ),
    );
  }
}
