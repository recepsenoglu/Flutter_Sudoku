import 'package:flutter/material.dart';
import 'package:flutter_sudoku/utils/game_strings.dart';
import 'package:flutter_sudoku/utils/game_colors.dart';

class NotesSwitchWidget extends StatelessWidget {
  const NotesSwitchWidget({
    required this.notesOn,
    super.key,
  });

  final bool notesOn;

  @override
  Widget build(BuildContext context) {
    final String text = notesOn ? GameStrings.notesOn : GameStrings.notesOff;
    final Color bgColor =
        notesOn ? GameColors.actionInfoBg : GameColors.actionInfoBgDeactive;

    return Positioned(
      right: 0,
      top: 0,
      child: Container(
        width: 36,
        padding: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 3),
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                color: GameColors.actionInfoText,
                fontWeight: FontWeight.w700,
                fontSize: 12,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
